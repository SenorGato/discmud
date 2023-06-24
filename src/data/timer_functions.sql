CREATE OR REPLACE FUNCTION update_mission(xp_value integer, mission_completed text) RETURNS void AS $$
BEGIN
    UPDATE timers
    SET xp = CASE WHEN id = (SELECT MAX(id) FROM timers WHERE mission_name LIKE (mission_completed || '%') ) THEN xp_value ELSE 0 END,
        completed_on = NOW()
    WHERE mission_name LIKE (mission_completed || '%') AND xp IS NULL;
END;
$$ LANGUAGE plpgsql;
