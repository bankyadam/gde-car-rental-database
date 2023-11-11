CREATE TABLE IF NOT EXISTS invoices
(
    id              SERIAL,
    total_net_value REAL,
    vat             INTEGER                   NOT NULL,
    generation_date DATE DEFAULT CURRENT_DATE NOT NULL,
    rental_id       INTEGER                   NOT NULL,
    first_name      TEXT                      NOT NULL,
    last_name       TEXT                      NOT NULL,
    company_name    TEXT DEFAULT ''::TEXT,
    tax_number      TEXT                      NOT NULL,
    address_country TEXT                      NOT NULL,
    address_state   TEXT                      NOT NULL,
    address_zip     TEXT                      NOT NULL,
    address_town    TEXT                      NOT NULL,
    address_street  TEXT                      NOT NULL,
    CONSTRAINT invoices_pk PRIMARY KEY (id),
    CONSTRAINT invoices_unique_rental_id_key UNIQUE (rental_id),
    CONSTRAINT invoices_rental_id___rentals_id FOREIGN KEY (rental_id) REFERENCES rentals
);
