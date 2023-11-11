SELECT
    cu.id AS customer_id,
    ca.vin,
    re1.event_time::date AS rent_start_date,
    re2.event_time::date AS rent_end_date
FROM rentals r
LEFT JOIN customers cu ON cu.id = r.customer_id
LEFT JOIN cars ca ON ca.vin = r.car_vin
LEFT JOIN rental_events re1 ON re1.rental_id = r.id
LEFT JOIN rental_events re2 ON re2.rental_id = r.id
WHERE
    re1.event_type = 'rent_start'::rental_event_type AND
    re2.event_type = 'rent_end'::rental_event_type;
