SELECT origin, sum(flights) AS sum_flights
FROM airlinestats GROUP BY origin 
SORT BY sum_flights desc LIMIT 10;