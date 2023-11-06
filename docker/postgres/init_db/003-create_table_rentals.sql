create table if not exists rentals
(
    id          serial,
    customer_id integer not null,
    car_id      integer not null,
    start_date  date    not null,
    end_date    date    not null,
    primary key (id),
    constraint rentals_customer_id__customers_id
        foreign key (customer_id) references customers,
    constraint rentals_car_id__cars_id
        foreign key (car_id) references cars
);
