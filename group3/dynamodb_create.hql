CREATE EXTERNAL TABLE ddb_features
    (pkey STRING,
   best_flight STRING,
   first_origin STRING,
   first_dest STRING,
   first_flight_num STRING,
   first_carrier STRING,
   first_flight_date STRING,
   first_dep_time STRING,
   first_arr_delay STRING,
   second_origin STRING,
   second_dest STRING,
   second_flight_num STRING,
   second_carrier STRING,
   second_flight_date STRING,
   second_dep_time STRING,
   second_arr_delay STRING, 
   total_arrival_delay STRING)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "bestflights1_grp3.2",
    "dynamodb.column.mapping"="pkey:pkey,best_flight:best_flight,first_origin:first_origin,first_dest:first_dest,first_flight_num:first_flight_num,first_carrier:first_carrier,first_flight_date:first_flight_date,first_dep_time:first_dep_time,first_arr_delay:first_arr_delay,second_origin:second_origin,second_dest:second_dest,second_flight_num:second_flight_num,second_carrier:second_carrier,second_flight_date:second_flight_date,second_dep_time:second_dep_time,second_arr_delay:second_arr_delay,total_arrival_delay:total_arrival_delay"
);

INSERT OVERWRITE TABLE ddb_features 
SELECT *
FROM travel_x;