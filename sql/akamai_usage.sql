-- Create a regular table
CREATE TABLE akamai_traffic (
    date TIMESTAMPTZ NOT NULL,
    cpcode INT NOT NULL,
    edge BIGINT,
    midgress BIGINT,
    totalegress BIGINT,
    -- Add any additional fields you may need
    PRIMARY KEY (date)  -- Primary key constraint on the timestamp column
    FOREIGN KEY (cpcode) -- Foreign key from streamconfig table
);
-- Create streamconfig table
CREATE TABLE akamai_streamconfig (
    cpcode INT NOT NULL,
    streamname TEXT,
    PRIMARY KEY (cpcode)
);

-- Convert it into a hypertable 
SELECT create_hypertable('akamai_traffic', 'date');
-- Define time chunk (partition) interval daily
SELECT add_time_partition('akamai_traffic', 'timestamp', INTERVAL '1 day');
-- Define compression policy weekly
SELECT add_compression_policy('akamai_traffic', INTERVAL '1 week');

