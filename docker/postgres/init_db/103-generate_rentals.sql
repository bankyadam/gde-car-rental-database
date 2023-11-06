INSERT INTO
    rentals
    (customer_id, car_vin, start_date, end_date)
    SELECT
        customer_id,
        car_vin,
        start_date::date AS start_date,
        (start_date + RANDOM() * INTERVAL '30 days')::date AS end_date
    FROM (
        SELECT
            customers.id AS customer_id,
            cars.vin AS car_vin,
            CURRENT_DATE - INTERVAL '3 years' + RANDOM() * INTERVAL '3 years' AS start_date
        FROM (
            SELECT id, ROW_NUMBER() OVER(ORDER BY RANDOM()) rn FROM customers
        ) customers
        INNER JOIN (
            SELECT vin, ROW_NUMBER() OVER(ORDER BY RANDOM()) rn FROM cars
        ) cars ON cars.rn = customers.rn
        WHERE customers.rn <= 300
    ) rental_partial
