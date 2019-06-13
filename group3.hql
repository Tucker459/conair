-- Group 3.2 Question 
WITH d as 
(SELECT origin, dest, flight_number, a_month, day_of_month, flight_date, rank() (PARTITION BY origin, dest ORDER BY dep_delay) as rnk
FROM airlinestats_par
WHERE dep_time < '1200' AND 
a_year = '2008'
GROUP BY origin, dest
), WITH l
(SELECT origin, dest, flight_number, a_month, day_of_month, rank() (PARTITION BY origin, dest ORDER BY dep_delay) as rnk1
FROM d 
WHERE origin IN (SELECT distinct dest from d) AND
rnk = 1 AND
flight_date >= (flight_date + 2)
GROUP BY origin, dest)
SELECT origin, dest, flight_number, a_month, day_of_month
FROM l
WHERE dep_time > '1200'
GROUP BY origin, dest
