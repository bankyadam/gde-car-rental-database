INSERT INTO
    rentals
    (customer_id, car_vin, start_date, end_date)
    SELECT
        customer_id,
        car_vin,
        start_date::DATE AS start_date,
        (start_date + RANDOM() * INTERVAL '30 days')::DATE AS end_date
    FROM (
        SELECT
            customers.id AS customer_id,
            cars.vin AS car_vin,
            CURRENT_DATE - INTERVAL '3 years' + RANDOM() * INTERVAL '3 years' AS start_date
        FROM (
            SELECT id, ROW_NUMBER() OVER(ORDER BY RANDOM()) r FROM customers
        ) customers
        INNER JOIN (
            SELECT vin, ROW_NUMBER() OVER(ORDER BY RANDOM()) r FROM cars
        ) cars ON cars.r = customers.r
        WHERE customers.r <= 300
    ) rental_partial
