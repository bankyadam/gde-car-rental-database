WITH
customers AS (
    SELECT
        c1.id,
        ROW_NUMBER() OVER(ORDER BY RANDOM()) rn
    FROM
        (
            SELECT
                FLOOR(RANDOM() * (SELECT COUNT(*) FROM customers) + 1)::int AS r
            FROM generate_series(1, 50)
        ) range
    INNER JOIN (
        SELECT id, ROW_NUMBER() OVER(ORDER BY RANDOM()) r FROM customers
    ) c1 ON (c1.r = range.r)
),
cars AS (
    SELECT
        c1.vin,
        ROW_NUMBER() OVER(ORDER BY RANDOM()) rn
    FROM
        (
            SELECT
                FLOOR(RANDOM() * (SELECT COUNT(*) FROM cars) + 1)::int AS r
            FROM generate_series(1, 50)
        ) range
    INNER JOIN (
        SELECT vin, ROW_NUMBER() OVER(ORDER BY RANDOM()) r FROM cars
    ) c1 ON (c1.r = range.r)
)
INSERT INTO
    rentals
    (customer_id, car_vin)
    (
        SELECT
            customers.id AS customer_id,
            cars.vin AS car_vin
        FROM
            customers
        INNER JOIN cars ON customers.rn = cars.rn
    );


ALTER TABLE rental_events DISABLE TRIGGER ALL;

INSERT INTO
    rental_events
    (rental_id, event_type, event_time)
    SELECT
        id,
        'rent_start'::rental_event_type,
        CURRENT_DATE - INTERVAL '3 years' + RANDOM() * INTERVAL '3 years'
    FROM rentals;

INSERT INTO
    rental_events
    (rental_id, event_type, event_time)
    SELECT
        rental_id,
        'rent_end'::rental_event_type,
        (event_time + INTERVAL '1 day' + RANDOM() * INTERVAL '30 days')::DATE
    FROM
        rental_events
    WHERE
        event_type = 'rent_start'::rental_event_type;

ALTER TABLE rental_events ENABLE TRIGGER ALL;
