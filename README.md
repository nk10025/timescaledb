# timescaledb
timescaledb and hasura

Add required passwords for
POSTGRES_PASSWORD
HASURA_GRAPHQL_ACCESS_KEY

Build and run service with
docker-compose up -d 

Browse localhost:8080 with the set access key

Run pSQL commands in hasura to create conditions table and convert to hypertable

CREATE TABLE conditions (
  time        TIMESTAMPTZ       NOT NULL,  
  location    TEXT              NOT NULL,  
  temperature DOUBLE PRECISION  NULL, 
  -- in celsius  
  humidity    DOUBLE PRECISION  NULL  
  -- in percentage
);
SELECT create_hypertable('conditions', 'time');

Ingest data to the conditons table with

python3.6 timescaledbingest.py

query Graphiql on Hasura console

{
  conditions {
    temperature
    location
    time
  }
  conditions_aggregate {
    aggregate {
      count(columns: humidity)
      avg {
        humidity
        temperature
      }
    }
  }
}
