CREATE TABLE conditions ( 
    time TIMESTAMPTZ NOT NULL,
    location TEXT NOT NULL,
    temperature DOUBLE PRECISION NULL, -- in celsius
    humidity DOUBLE PRECISION NULL-- in percentage 
); 
SELECT create_hypertable('conditions', 'time');