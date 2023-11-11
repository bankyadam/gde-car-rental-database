CREATE TYPE car_status AS ENUM ('rentable', 'repairing', 'inactive', 'rented', 'cleaning');

CREATE TABLE IF NOT EXISTS cars
(
    vin                        TEXT                                      NOT NULL,
    manufacturer               TEXT                                      NOT NULL,
    model                      TEXT                                      NOT NULL,
    model_year                 DATE                                      NOT NULL,
    color                      TEXT                                      NOT NULL,
    vehicle_inspection_duedate DATE                                      NOT NULL,
    net_price_daily            INTEGER                                   NOT NULL,
    status                     car_status DEFAULT 'rentable'::car_status NOT NULL,
    CONSTRAINT cars_vin_pk PRIMARY KEY (vin)
);

