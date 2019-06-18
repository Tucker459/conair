-- Group 3.2 Question 

-- First Leg
SELECT origin, dest, flight_number, carrier, flight_date, dep_time, arr_delay, rank() OVER (PARTITION BY origin, dest ORDER BY arr_delay) AS rnk
FROM airlinestats_par
WHERE dep_time < 1200 AND 
a_year = '2008';

-- Second Leg
WITH d AS
(SELECT origin, dest, flight_number, carrier, flight_date, dep_time, arr_delay, rank() OVER (PARTITION BY origin, dest ORDER BY arr_delay) AS rnk
FROM airlinestats_par
WHERE dep_time < 1200 AND 
a_year = '2008'
)
SELECT origin, dest, flight_number, carrier, flight_date, dep_time, arr_delay, rank() OVER (PARTITION BY origin, dest ORDER BY arr_delay) AS rnk1
FROM airlinestats_par
ON a.origin 
WHERE origin IN (SELECT distinct dest FROM d) AND
flight_date >= date_add(flight_date,2) AND 
a_year = '2008' AND
dep_time > 1200;
