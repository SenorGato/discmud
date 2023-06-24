CREATE SCHEMA IF NOT EXISTS discmud;
ALTER SCHEMA discmud OWNER TO discmud;
GRANT ALL PRIVILEGES ON DATABASE discmud to discmud;
SET search_path TO discmud;
REVOKE ALL ON SCHEMA discmud FROM public;
REVOKE ALL ON DATABASE discmud FROM public;

\i timers_table_init.sql
\i timer_functions.sql
