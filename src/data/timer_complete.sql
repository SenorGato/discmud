WITH deadletters AS (
    SELECT MAX(id) as max_id
    FROM timers
    WHERE mission_name ~ '^dl' AND xp IS NULL
) 

UPDATE timers
SET xp = CASE WHEN id = (SELECT max_id FROM deadletters) THEN :'xp'::integer ELSE 0 END,
    completed_on = NOW()
WHERE mission_name ~ '^dl' AND xp is NULL;
