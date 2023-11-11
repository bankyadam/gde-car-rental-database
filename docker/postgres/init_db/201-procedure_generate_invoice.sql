CREATE PROCEDURE generate_invoices()
    LANGUAGE sql AS
$$
WITH rentals_without_invoice
AS (SELECT
        r.id,
        r.customer_id,
        r.car_vin
    FROM rentals r
             LEFT JOIN rental_events re ON r.id = re.rental_id AND re.event_type = 'rent_end'::rental_event_type
             LEFT JOIN invoices i ON i.rental_id = r.id
    WHERE i.rental_id IS NULL)
INSERT INTO
    invoices
    (vat, generation_date, rental_id, first_name, last_name, company_name, tax_number, address_country, address_state, address_zip, address_town, address_street)
    SELECT
        27 AS vat,
        CURRENT_TIMESTAMP AS generation_date,
        r.id AS rental_id,
        cu.first_name,
        cu.last_name,
        cu.company_name,
        cu.tax_number,
        cu.invoice_address_country AS address_country,
        cu.invoice_address_state AS address_state,
        cu.invoice_address_zip AS address_zip,
        cu.invoice_address_town AS address_town,
        cu.invoice_address_street AS address_street
    FROM rentals_without_invoice r
    INNER JOIN customers cu ON cu.id = r.customer_id;


WITH invoices_without_items
AS (
    SELECT
        i.*
    FROM invoices i
    LEFT JOIN invoice_items items
        ON i.id=items.invoice_id
    WHERE
        items.id IS NULL
)
INSERT INTO invoice_items
(invoice_id, description, unit_net_price, quantity)
SELECT
    i.id AS invoice_id,
    c.manufacturer||' '||c.model||' ('||EXTRACT(YEAR FROM c.model_year)||') - '||c.vin||'\n'||re_start.event_time::date||'—'||re_end.event_time::date AS description,
    c.net_price_daily AS unit_net_price,
    re_end.event_time::date - re_start.event_time::date AS quantity
FROM
    invoices_without_items i
INNER JOIN
    rentals r
        ON i.rental_id = r.id
INNER JOIN
    cars c
        ON r.car_vin = c.vin
INNER JOIN
    rental_events re_start
        ON re_start.rental_id = r.id
               AND re_start.event_type = 'rent_start'::rental_event_type
INNER JOIN
    rental_events re_end
        ON re_end.rental_id = r.id
               AND re_end.event_type = 'rent_end'::rental_event_type;

UPDATE
    invoices i
SET
    total_net_value = items.item_net_total
FROM
    (
        SELECT invoice_id, SUM(unit_net_price * quantity) AS item_net_total
        FROM invoice_items
        GROUP BY invoice_id
    ) items
WHERE
    i.id = items.invoice_id AND
    i.total_net_value IS NULL;
$$;
