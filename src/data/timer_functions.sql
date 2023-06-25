CREATE OR REPLACE FUNCTION end_mission(xp_value integer, mission_completed text) RETURNS void AS $$
BEGIN
    UPDATE timers
    SET xp = CASE WHEN id = (SELECT MAX(id) FROM timers WHERE mission_name LIKE (mission_completed || '%') ) THEN xp_value ELSE 0 END,
        completed_on = NOW()
    WHERE mission_name LIKE (mission_completed || '%') AND xp IS NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_mission_complete() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO missions_table (column1, column2, column3, column4, column5)
    SELECT NEW.column1, NEW.column2, NEW.column3, NEW.column4, NEW.column5
    FROM ingress_table
    

END;
$$ LANGUAGE plpgsql;
