CREATE TABLE IF NOT EXISTS rentals
(
    id          SERIAL,
    customer_id INTEGER NOT NULL,
    car_vin     TEXT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT rentals_customer_id__customers_id
        FOREIGN KEY (customer_id) REFERENCES customers (id),
    CONSTRAINT rentals_car_vin__cars_vin
        FOREIGN KEY (car_vin) REFERENCES cars (vin)
);
