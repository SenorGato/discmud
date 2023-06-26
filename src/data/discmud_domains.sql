DO $$
BEGIN
    CREATE DOMAIN mission_tag AS TEXT
    CHECK (VALUE ~ '^[A-Za-z0-9]{3}$');
    EXCEPTION WHEN duplicate_object THEN 
        RAISE NOTICE 'domain mission_tag already exists';
END;
$$;
