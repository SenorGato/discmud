--Discworld Mud Timer Database Provisioning

CREATE SCHEMA IF NOT EXISTS discmud;
ALTER SCHEMA discmud OWNER TO discmud;
GRANT ALL PRIVILEGES ON DATABASE discmud to discmud;
SET search_path TO discmud;
REVOKE ALL ON SCHEMA discmud FROM public;
REVOKE ALL ON DATABASE discmud FROM public;

DO $$
BEGIN
    CREATE DOMAIN mission_tag AS TEXT
    CHECK (VALUE ~ '^[A-Za-z0-9]{3}$');
    EXCEPTION WHEN duplicate_object THEN 
        RAISE NOTICE 'domain mission_tag already exists';
END;
$$;

CREATE FUNCTION truncate_completed_on() RETURNS TRIGGER AS $$
BEGIN
    NEW.completed_on := date_trunc('second', NEW.completed_on);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
    
CREATE TABLE IF NOT EXISTS timers(
    id  SERIAL PRIMARY KEY,
    mission_name mission_tag,
    created_on  TIMESTAMPTZ NOT NULL DEFAULT date_trunc('second', NOW()),
    completed_on  TIMESTAMPTZ,
    xp int,
    money TEXT
);

CREATE TRIGGER truncate_completed_on_trigger
BEFORE INSERT OR UPDATE ON timers
FOR EACH ROW
    WHEN (NEW.completed_on IS NOT NULL)
        EXECUTE FUNCTION truncate_completed_on();
