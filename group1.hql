WITH d AS 
    (SELECT dest,
         count(dest) AS sum_of_dest_flights
    FROM airlinestats
    GROUP BY  dest), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest = o.origin) SORT BY sum_of_flights DESC LIMIT 10;  

-- Sequence Table Storage Format 

WITH d AS 
    (SELECT dest,
         count(dest) AS sum_of_dest_flights
    FROM airlinestats_seq
    GROUP BY  dest), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats_seq
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest = o.origin) SORT BY sum_of_flights DESC LIMIT 10; 

-- ORC Table Storage Format 

WITH d AS 
    (SELECT dest,
         count(dest) AS sum_of_dest_flights
    FROM airlinestats_orc
    GROUP BY  dest), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats_orc
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest = o.origin) SORT BY sum_of_flights DESC LIMIT 10;

-- Parquet Table Storage Format 
-- Top 10 Popular Airports by Flights In/Flights Out
WITH d AS 
    (SELECT dest,
         count(dest) AS sum_of_dest_flights
    FROM airlinestats_par
    GROUP BY  dest), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats_par
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest = o.origin) SORT BY sum_of_flights DESC LIMIT 10; 

-- Top 10 Airlines by On-Time-Performance

SELECT carrier, avg(dep_delay) as on_time_performance_metric
FROM airlinestats_par
GROUP BY carrier
SORT BY on_time_performance_metric ASC
LIMIT 10;
