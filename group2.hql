-- Each Airport (X), Rank Top-10 Carriers in Decreasing Order of On-Time-Performance from X
SELECT carrier, avg(dep_delay) as on_time_performance_metric
FROM airlinestats_par
GROUP BY carrier
SORT BY on_time_performance_metric ASC
LIMIT 10;

WITH d as 
(SELECT origin, carrier, avg(dep_delay) OVER (PARTITION BY carrier, origin) AS avg_dep_delay,
ROW_NUMBER() OVER (PARTITION BY carrier, origin) AS row_num
FROM airlinestats_par
WHERE origin = 'BWI')
SELECT origin, carrier, avg_dep_delay
FROM  d
WHERE row_num = 1 and avg_dep_delay <> NULL
ORDER BY avg_dep_delay asc
LIMIT 10;

WITH d as 
(SELECT origin, carrier, avg(dep_delay) OVER (PARTITION BY carrier, origin) AS avg_dep_delay,
ROW_NUMBER() OVER (PARTITION BY carrier, origin) AS row_num
FROM airlinestats_par
WHERE origin = 'BWI')
SELECT origin, carrier, avg_dep_delay
FROM  d
WHERE row_num = 1
ORDER BY avg_dep_delay
LIMIT 10;