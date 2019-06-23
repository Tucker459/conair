-- Each Airport (X), Rank Top-10 Carriers in Decreasing Order of On-Time-Departure-Performance from X
CREATE TABLE top10_carriers AS
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