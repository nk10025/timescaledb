-- Create streamconfig table
CREATE TABLE akamai_streamconfig (
    cpcode INT NOT NULL,
    streamname TEXT,
    PRIMARY KEY (cpcode)
);
-- Create a akamai_traffic table
CREATE TABLE akamai_traffic (
    date TIMESTAMPTZ NOT NULL,
    cpcode INT NOT NULL,
    edge BIGINT,
    midgress BIGINT,
    totalegress BIGINT,
    -- Add any additional fields you may need
    PRIMARY KEY (date),  -- Primary key constraint on the date column
    FOREIGN KEY (cpcode) REFERENCES akamai_streamconfig(cpcode) -- Foreign key from streamconfig table
);

-- Convert akamai_traffic into a hypertable 
-- Define time chunk (partition) interval daily
SELECT create_hypertable('akamai_traffic', 'date', 
    chunk_time_interval => INTERVAL '1 day'
);

--SELECT create_hypertable('akamai_traffic', 'date');
-- Define time chunk (partition) interval daily
--SELECT add_time_partition('akamai_traffic', 'date', INTERVAL '1 day');
-- Define compression policy weekly
-- SELECT add_compression_policy('akamai_traffic', INTERVAL '1 week');

-- TEST SQL
-- SELECT * FROM timescaledb_information.hypertable WHERE hypertable_name = 'akamai_traffic';


