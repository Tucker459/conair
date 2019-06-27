CREATE EXTERNAL TABLE ddb_features
    (pkey STRING,
   overall_rnk BIGINT,
   first_origin STRING,
   first_dest STRING,
   first_flight_num BIGINT,
   first_carrier STRING,
   first_flight_date STRING,
   first_dep_time BIGINT,
   first_arr_delay DOUBLE,
   second_origin STRING,
   second_dest STRING,
   second_flight_num BIGINT,
   second_carrier STRING,
   second_flight_date STRING,
   second_dep_time BIGINT,
   second_arr_delay DOUBLE, 
   total_arrival_delay DOUBLE)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "travel_grp3.2",
    "dynamodb.column.mapping"="pkey:pkey,overall_rnk:overall_rnk,first_origin:first_origin,first_dest:first_dest,first_flight_num:first_flight_num,first_carrier:first_carrier,first_flight_date:first_flight_date,first_dep_time:first_dep_time,first_arr_delay:first_arr_delay,second_origin:second_origin,second_dest:second_dest,second_flight_num:second_flight_num,second_carrier:second_carrier,second_flight_date:second_flight_date,second_dep_time:second_dep_time,second_arr_delay:second_arr_delay,total_arrival_delay:total_arrival_delay"
);