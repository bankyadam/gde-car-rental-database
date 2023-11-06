create type id_card_type as enum ('id', 'passport', 'drivers_licence');

create table if not exists customers
(
    id                      serial,
    tax_number              text,
    is_company              boolean      not null,
    company_name            text,
    first_name              text         not null,
    last_name               text         not null,
    birthdate               date         not null,
    birthplace              text         not null,
    mothers_name            text         not null,
    id_card_type            id_card_type not null,
    id_card_number          text         not null,
    email                   text         not null,
    phone_number            text         not null,
    home_address_country    text         not null,
    home_address_zip        text         not null,
    home_address_town       text         not null,
    home_address_street     text         not null,
    invoice_address_country text         not null,
    invoice_address_zip     text         not null,
    invoice_address_town    text         not null,
    invoice_address_street  text         not null,
    primary key (id)
);
