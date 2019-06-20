-- Group 3.2 Question 
CREATE TABLE travel AS
WITH d AS 
(
   SELECT
      origin,
      dest,
      flight_number,
      carrier,
      flight_date,
      date_add(flight_date, 2) AS target_date,
      dep_time,
      arr_delay 
   FROM
      airlinestats_par 
   WHERE
      dep_time < 1200 
      AND a_year = '2008' 
)
SELECT
   d.origin AS first_origin,
   d.dest AS first_dest,
   d.flight_number AS first_flight_num,
   d.carrier AS first_carrier,
   d.flight_date AS first_flight_date,
   d.dep_time AS first_dep_time,
   d.arr_delay AS first_arr_delay,
   a.origin AS second_origin,
   a.dest AS second_dest,
   a.flight_number AS second_flight_num,
   a.carrier AS second_carrier,
   a.flight_date AS second_flight_date,
   a.dep_time AS second_dep_time,
   a.arr_delay AS second_arr_delay,
   RANK() OVER (PARTITION BY a.origin, a.dest, a.flight_date, d.origin, d.dest, d.flight_date 
ORDER BY
(d.arr_delay + a.arr_delay)) AS overall_rnk 
FROM
   airlinestats_par a 
   JOIN
      d 
      ON a.origin = d.dest 
      AND a.flight_date = d.target_date 
WHERE
   a.origin IN 
   (
      SELECT DISTINCT
         dest 
      FROM
         d
   )
   AND a.a_year = '2008' 
   AND a.dep_time > 1200;
