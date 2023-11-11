CREATE OR REPLACE FUNCTION car_status_update_on_event()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_car_vin            cars.vin%TYPE := NULL;
    v_current_car_status cars.status%TYPE;
    v_new_car_status     cars.status%TYPE;
BEGIN
    SELECT car_vin INTO v_car_vin FROM rentals WHERE id = new.rental_id;
    SELECT status INTO v_current_car_status FROM cars WHERE vin = v_car_vin;

    IF new.event_type = 'rent_start' THEN
        IF v_current_car_status = 'rentable' THEN
            v_new_car_status := 'rented'::car_status;
        END IF;
    ELSIF new.event_type = 'rent_end' THEN
        IF v_current_car_status = 'rented' THEN
            v_new_car_status := 'cleaning'::car_status;
        END IF;
    ELSIF new.event_type = 'cleaning_done' THEN
        IF v_current_car_status = 'cleaning' THEN
            v_new_car_status := 'rentable'::car_status;
        END IF;
    ELSIF new.event_type = 'repairing' THEN
        IF v_current_car_status = 'rentable' THEN
            v_new_car_status := 'repairing'::car_status;
        END IF;
    ELSIF new.event_type = 'repairing_done' THEN
        IF v_current_car_status = 'repairing' THEN
            v_new_car_status := 'rentable'::car_status;
        END IF;
    ELSE
        RAISE EXCEPTION 'Unhandled event type "%"', new.event_type;
    END IF;

    IF v_new_car_status IS NOT NULL THEN
        UPDATE cars SET status = v_new_car_status WHERE vin = v_car_vin;
    ELSE
        RAISE EXCEPTION 'Transition car status from "%" for event "%" is not possible', v_current_car_status, new.event_type;
    END IF;
    RETURN new;
END
$$;


CREATE TRIGGER rental_event__event_type__update_cars_status
    AFTER INSERT
    ON
        rental_events
    FOR EACH ROW
EXECUTE FUNCTION car_status_update_on_event();