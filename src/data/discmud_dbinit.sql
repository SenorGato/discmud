CREATE SCHEMA IF NOT EXISTS discmud;
ALTER SCHEMA discmud OWNER TO discmud;
GRANT ALL PRIVILEGES ON DATABASE discmud to discmud;
SET search_path TO discmud;
REVOKE ALL ON SCHEMA discmud FROM public;
REVOKE ALL ON DATABASE discmud FROM public;

\i discmud_domains.sql
\i discmud_table_init.sql
\i discmud_functions.sql
SELECT pg_start_background_worker('timer_cleanup_worker');
