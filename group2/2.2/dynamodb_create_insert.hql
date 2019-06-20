CREATE EXTERNAL TABLE ddb_features
    (origin STRING,
   dest STRING,
   avg_dep_delay DOUBLE)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "top10_dest_airports",
    "dynamodb.column.mapping"="origin:origin,dest:dest,avg_dep_delay:avg_dep_delay"
);

INSERT OVERWRITE TABLE ddb_features 
SELECT *
FROM top10_dest_airports;