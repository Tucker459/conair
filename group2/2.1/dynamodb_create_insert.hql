CREATE EXTERNAL TABLE ddb_features
    (origin STRING,
   carrier STRING,
   avg_dep_delay DOUBLE)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
    "dynamodb.table.name" = "top10_carriers_grp_2.1",
    "dynamodb.column.mapping"="origin:origin,carrier:carrier,avg_dep_delay:avg_dep_delay"
);

INSERT OVERWRITE TABLE ddb_features 
SELECT *
FROM top10_carriers;
