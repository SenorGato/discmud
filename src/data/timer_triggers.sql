CREATE TRIGGER copy_mission_trigger
AFTER UPDATE ON ingest_table
FOR EACH ROW
WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION check_mission_complete();
