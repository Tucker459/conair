-- Top 10 Airlines by On-Time-Performance

SELECT carrier, avg(dep_delay) as on_time_performance_metric
FROM airlinestats_par
GROUP BY carrier
SORT BY on_time_performance_metric ASC
LIMIT 10;