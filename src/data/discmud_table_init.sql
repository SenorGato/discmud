--Discworld Mud Timer Table Provisioning

CREATE TABLE IF NOT EXISTS missions (
    id  SERIAL PRIMARY KEY,
    mission_name mission_tag,
    created_on  TIMESTAMPTZ NOT NULL DEFAULT date_trunc('second', NOW()),
    completed_on  TIMESTAMPTZ,
    xp int,
    money TEXT
);

CREATE TABLE IF NOT EXISTS timers (
  mission_name mission_tag PRIMARY KEY,
  done_time TIMESTAMPTZ NOT NULL
);
