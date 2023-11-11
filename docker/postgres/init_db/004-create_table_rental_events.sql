CREATE TYPE rental_event_type AS ENUM ('rent_start', 'rent_end', 'cleaning_done', 'repairing', 'repairing_done');

CREATE TABLE IF NOT EXISTS rental_events
(
    rental_id  INTEGER,
    event_type rental_event_type,
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT rental_events_rental_id__rentals_id_fk FOREIGN KEY (rental_id) REFERENCES rentals
);
