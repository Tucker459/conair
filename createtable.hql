CREATE EXTERNAL TABLE IF NOT EXISTS airlinestats (
    a_year INT,
    a_quarter INT, 
    a_month INT, 
    day_of_month INT, 
    day_of_week INT, 
    flight_date DATE, 
    carrier STRING,
    flight_number STRING, 
    origin STRING, 
    origin_state STRING, 
    dest STRING,
    dest_state STRING, 
    dep_time STRING,
    dep_delay DECIMAL(10,2), 
    dep_delay_mins DECIMAL(10,2),
    dep_delay_15 DECIMAL(10,2),
    arr_time STRING,
    arr_delay DECIMAL(10,2),
    air_delay_mins DECIMAL(10,2),
    air_delay_15 DECIMAL(10,2),
    cancelled INT, 
    actual_elasped_time DECIMAL(10,2),
    air_time DECIMAL(10,2)
)
ROW FORMAT DELIMITED 
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
LOCATION 's3://conairdatainput/'
TBLPROPERTIES ('has_encrypted_data'='false');


CREATE TABLE IF NOT EXISTS airlinestats_seq STORED AS SEQUENCEFILE
AS
SELECT * FROM airlinestats;

CREATE TABLE IF NOT EXISTS airlinestats_orc STORED AS ORC
AS
SELECT * FROM airlinestats;

CREATE TABLE IF NOT EXISTS airlinestats_par STORED AS PARQUET
AS
SELECT * FROM airlinestats;

