CREATE EXTERNAL TABLE ddb_features
    (origin_dest STRING,
   carrier STRING,
   avg_arr_delay DOUBLE)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "top10_src_dest_carriers_grp2.3",
    "dynamodb.column.mapping"="origin_dest:origin_dest,carrier:carrier,avg_arr_delay:avg_arr_delay"
);

INSERT OVERWRITE TABLE ddb_features 
SELECT *
FROM top10_src_dest_carriers;