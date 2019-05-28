CREATE TABLE IF NOT EXISTS airlinestats (
    a_year INT,
    a_quarter INT, 
    a_month INT, 
    day_of_month INT, 
    day_of_week INT, 
    flight_date DATE, 
    unique_carrier STRING, 
    airline_id INT, 
    carrier STRING, 
    tail_num STRING, 
    flight_num STRING, 
    origin STRING, 
    origin_city_name STRING, 
    origin_state STRING, 
    origin_state_fips STRING, 
    origin_state_name STRING, 
    origin_wac STRING,
    dest STRING,
    dest_city_name STRING, 
    dest_state STRING, 
    dest_state_fips STRING, 
    dest_state_name STRING,
    dest_wac INT,
    crs_dept_time STRING,
    dep_time STRING,
    dep_delay DECIMAL(10,2), 
    dep_delay_mins DECIMAL(10,2),
    dep_delay_15 DECIMAL(10,2),
    dep_delay_groups INT,
    dep_time_blk STRING,
    taxi_out DECIMAL(10,2),
    wheels_off STRING,
    wheels_on STRING,
    taxi_in DECIMAL(10,2),
    crs_arr_time STRING,
    arr_time STRING,
    arr_delay DECIMAL(10,2),
    air_delay_mins DECIMAL(10,2),
    air_delay_15 DECIMAL(10,2),
    arr_delay_grps INT,
    arr_time_blk STRING,
    cancelled INT, 
    cancellation_code STRING,
    diverted DECIMAL(10,2),
    crs_elasped_time DECIMAL(10,2),
    actual_elasped_time DECIMAL(10,2),
    air_time DECIMAL(10,2),
    flights DECIMAL(10,2),
    distance DECIMAL(10,2),
    distance_grps INT,
    carrier_delay DECIMAL(10,2),
    weather_delay DECIMAL(10,2),
    nas_delay DECIMAL(10,2),
    sec_delay DECIMAL(10,2),
    late_aircraft_delay DECIMAL(10,2)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
)
-- ROW FORMAT DELIMITED 
--     FIELDS TERMINATED BY ','
--     LINES TERMINATED BY '\n'
-- STORED AS TEXTFILE
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA INPATH 'hdfs:///data/On_Time_On_Time_Performance_1988_2008.csv' 
OVERWRITE INTO TABLE airlinestats;
