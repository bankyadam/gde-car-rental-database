CREATE TABLE IF NOT EXISTS cars
(
    vin                        TEXT    NOT NULL,
    manufacturer               TEXT    NOT NULL,
    model                      TEXT    NOT NULL,
    model_year                 DATE    NOT NULL,
    color                      TEXT    NOT NULL,
    vehicle_inspection_duedate DATE    NOT NULL,
    price                      INTEGER NOT NULL,
    CONSTRAINT cars_vin_pk
        PRIMARY KEY (vin)
);
