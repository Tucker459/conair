WITH d AS 
    (SELECT dest_city_name,
         count(dest_city_name) AS sum_of_dest_flights
    FROM airlinestats
    GROUP BY  dest_city_name), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest_city_name = o.origin) SORT BY sum_of_flights DESC LIMIT 10; 


WITH d AS 
    (SELECT dest_city_name,
         count(dest_city_name) AS sum_of_dest_flights
    FROM airlinestats_seq
    GROUP BY  dest_city_name), o AS 
    (SELECT origin,
         count(origin) AS sum_of_org_flights
    FROM airlinestats_seq
    GROUP BY  origin)
SELECT o.origin as airport,
         (d.sum_of_dest_flights + o.sum_of_org_flights) AS sum_of_flights
FROM d
JOIN o
    ON (d.dest_city_name = o.origin) SORT BY sum_of_flights DESC LIMIT 10; 

