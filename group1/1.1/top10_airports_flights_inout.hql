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