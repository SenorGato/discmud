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

CREATE OR REPLACE FUNCTION create_timer(mission_name text, completed_on TIMESTAMPTZ)
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO timers (mission_name, end_time)
    VALUES (mission_name, completed_on + INTERVAL '60 minutes');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER mission_completed_trigger
AFTER UPDATE OF completed_on ON missions
FOR EACH ROW
WHEN (NEW.completed_on IS NOT NULL AND OLD.completed_on IS NULL AND NEW.xp > 0)
EXECUTE FUNCTION create_timer(NEW.mission_name, NEW.completed_on);

--Timer Worker Functions
CREATE OR REPLACE FUNCTION fetch_timers() 
  RETURNS TABLE (mission_name text, end_time TIMESTAMPTZ) AS
$$
DECLARE
  current_time TIMESTAMPTZ := NOW();
BEGIN
  DELETE FROM timers
  WHERE end_time <= current_time;

  RETURN QUERY
    SELECT mission_name, end_time
    FROM timers;
END;
$$
LANGUAGE plpgsql;

--Misc Table Functions
CREATE OR REPLACE FUNCTION truncate_completed_on() RETURNS TRIGGER AS $$
BEGIN
    NEW.completed_on := date_trunc('second', NEW.completed_on);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER truncate_completed_on_trigger
BEFORE INSERT OR UPDATE ON missions
FOR EACH ROW
    WHEN (NEW.completed_on IS NOT NULL)
        EXECUTE FUNCTION truncate_completed_on();
