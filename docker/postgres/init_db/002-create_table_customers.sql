CREATE TYPE id_card_type AS ENUM ('id', 'passport', 'drivers_licence');

CREATE TABLE IF NOT EXISTS customers
(
    id                      SERIAL,
    is_company              BOOLEAN      NOT NULL,
    company_name            TEXT,
    tax_number              TEXT,
    first_name              TEXT         NOT NULL,
    last_name               TEXT         NOT NULL,
    birthdate               DATE         NOT NULL,
    birthplace              TEXT         NOT NULL,
    mothers_name            TEXT         NOT NULL,
    id_card_type            id_card_type NOT NULL,
    id_card_number          TEXT         NOT NULL,
    email                   TEXT         NOT NULL,
    phone_number            TEXT         NOT NULL,
    home_address_country    TEXT         NOT NULL,
    home_address_zip        TEXT         NOT NULL,
    home_address_town       TEXT         NOT NULL,
    home_address_street     TEXT         NOT NULL,
    invoice_address_country TEXT         NOT NULL,
    invoice_address_zip     TEXT         NOT NULL,
    invoice_address_town    TEXT         NOT NULL,
    invoice_address_street  TEXT         NOT NULL,
    PRIMARY KEY (id)
);
