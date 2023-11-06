create type manufacturer as enum (
    'abarth', 'alfa romeo', 'aston martin', 'audi', 'bentley', 'bmw', 'cadillac',
    'chevrolet', 'chrysler', 'citroen', 'dacia', 'daewoo', 'daihatsu', 'dodge',
    'ferrari', 'fiat', 'ford', 'honda', 'hyundai', 'infiniti', 'jaguar', 'jeep',
    'kia', 'lada', 'lamborghini', 'lancia', 'land rover', 'lexus', 'maserati',
    'mazda', 'mclaren', 'mercedes-benz', 'mini', 'mitsubishi', 'nissan', 'opel',
    'peugeot', 'porsche', 'renault', 'rolls royce', 'rover', 'saab', 'seat',
    'skoda', 'smart', 'ssangyong', 'subaru', 'suzuki', 'tesla', 'toyota',
    'trabant', 'uaz', 'volkswagen', 'volvo'
);

create table if not exists cars
(
    id              serial,
    model           text         not null,
    production_date date         not null,
    color           text         not null,
    manufacturer    manufacturer not null,
    price           integer      not null,
    primary key (id)
);
