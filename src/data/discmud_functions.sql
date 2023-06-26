CREATE OR REPLACE FUNCTION end_mission(xp_value integer, mission_completed text) RETURNS void AS $$
BEGIN
    UPDATE missions
    SET xp = CASE WHEN id = (SELECT MAX(id) FROM missions WHERE mission_name LIKE (mission_completed || '%') ) THEN xp_value ELSE 0 END,
        completed_on = NOW()
    WHERE mission_name LIKE (mission_completed || '%') AND xp IS NULL;
END;
$$ LANGUAGE plpgsql;

--Timer Creation Functions
CREATE OR REPLACE FUNCTION create_timer(mission_name text, completed_on TIMESTAMPTZ) RETURNS void AS $$
BEGIN
    INSERT INTO timers (mission_name, end_time)
    VALUES (mission_name, completed_on + INTERVAL '60 minutes');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fetch_timers() 
  RETURNS TABLE (mission_name text, end_time TIMESTAMPTZ) AS
$$
DECLARE
  current_time TIMESTAMPTZ := NOW();
BEGIN
  RETURN QUERY
    WITH deleted_rows AS (
      DELETE FROM timers
      WHERE end_time <= current_time
      RETURNING mission_name, end_time
    )
    SELECT mission_name, end_time
    FROM timers
    WHERE NOT EXISTS (
      SELECT 1
      FROM deleted_rows
      WHERE timers.mission_name = deleted_rows.mission_name
        AND timers.end_time = deleted_rows.end_time
    );
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER mission_completed_trigger
AFTER UPDATE OF completed_on ON missions
FOR EACH ROW
WHEN (NEW.completed_on IS NOT NULL AND OLD.completed_on IS NULL)
EXECUTE FUNCTION create_timer(NEW.mission_name, NEW.completed_on);

--Timer Worker Functions
CREATE OR REPLACE FUNCTION delete_expired_timers() RETURNS VOID AS $$
BEGIN
    DELETE FROM timers
    WHERE end_time <= NOW();
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION timer_cleanup_worker() RETURNS VOID AS $$
BEGIN
    LOOP
        PERFORM delete_expired_timers();

        PERFORM pg_sleep(5);  --In seconds 
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--Misc Table Functions
CREATE FUNCTION truncate_completed_on() RETURNS TRIGGER AS $$
BEGIN
    NEW.completed_on := date_trunc('second', NEW.completed_on);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER truncate_completed_on_trigger
BEFORE INSERT OR UPDATE ON timers
FOR EACH ROW
    WHEN (NEW.completed_on IS NOT NULL)
        EXECUTE FUNCTION truncate_completed_on();
