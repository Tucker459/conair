CREATE EXTERNAL TABLE ddb_features
    (origin STRING,
   dest STRING,
   carrier STRING,
   avg_arr_delay DOUBLE)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "top10_src_dest_carriers",
    "dynamodb.column.mapping"="origin:origin,dest:dest,carrier:carrier,avg_arr_delay:avg_arr_delay"
);

INSERT OVERWRITE TABLE ddb_features 
SELECT *
FROM top10_src_dest_carriers;