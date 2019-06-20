-- Each Airport (X), Rank Top-10 Carriers in Decreasing Order of On-Time-Departure-Performance from X
WITH d AS
(SELECT origin, carrier, avg(dep_delay) OVER (PARTITION BY carrier, origin) AS avg_dep_delay,
ROW_NUMBER() OVER (PARTITION BY carrier, origin) AS row_num
FROM airlinestats_par), l AS 
(SELECT origin, carrier, avg_dep_delay
FROM  d
WHERE row_num = 1
ORDER BY avg_dep_delay), h AS 
(SELECT origin, carrier, avg_dep_delay, rank() OVER (PARTITION BY origin ORDER BY avg_dep_delay) AS rnk
FROM l
WHERE avg_dep_delay IS NOT NULL)
SELECT origin, carrier, avg_dep_delay 
FROM h
WHERE rnk BETWEEN 1 AND 10;

-- Each Source Airport, Rank Top-10 Destination Airports in Decreasing Order of On-Time-Departure-Performance from X
WITH d AS
(SELECT origin, dest, avg(dep_delay) OVER (PARTITION BY dest, origin) AS avg_dep_delay,
ROW_NUMBER() OVER (PARTITION BY dest, origin) AS row_num
FROM airlinestats_par), l AS 
(SELECT origin, dest, avg_dep_delay
FROM  d
WHERE row_num = 1
ORDER BY avg_dep_delay), h AS 
(SELECT origin, dest, avg_dep_delay, rank() OVER (PARTITION BY origin ORDER BY avg_dep_delay) AS rnk
FROM l
WHERE avg_dep_delay IS NOT NULL)
SELECT origin, dest, avg_dep_delay 
FROM h
WHERE rnk BETWEEN 1 AND 10;

-- Each Source-Desination Pair X-Y, rank the Top-10 carriers in Decreasing Order of On-Time-Arrival-Performance from X
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
SELECT origin, dest, carrier, avg_arr_delay 
FROM h
WHERE rnk BETWEEN 1 AND 10;