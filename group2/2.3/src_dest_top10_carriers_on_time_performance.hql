-- Each Source-Desination Pair X-Y, rank the Top-10 carriers in Decreasing Order of On-Time-Arrival-Performance from X
CREATE TABLE top10_src_dest_carriers AS
WITH d AS
(SELECT origin, dest, carrier, avg(arr_delay) OVER (PARTITION BY dest, origin, carrier) AS avg_arr_delay,
ROW_NUMBER() OVER (PARTITION BY dest, origin, carrier) AS row_num
FROM airlinestats_par), l AS 
(SELECT origin, dest, carrier, avg_arr_delay
FROM  d
WHERE row_num = 1
ORDER BY avg_arr_delay), h AS 
(SELECT origin, dest, carrier, avg_arr_delay, rank() OVER (PARTITION BY origin, dest, carrier ORDER BY avg_arr_delay) AS rnk
FROM l
WHERE avg_arr_delay IS NOT NULL)
SELECT concat_ws("_",origin,dest) as origin_dest, carrier, avg_arr_delay 
FROM h
WHERE rnk BETWEEN 1 AND 10;