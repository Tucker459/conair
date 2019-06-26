-- Group 3.2 Question 
CREATE TABLE travel AS WITH d AS 
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
,
f AS 
(
   SELECT
      RANK() OVER (PARTITION BY a.origin, a.dest, a.flight_date, d.origin, d.dest, d.flight_date 
   ORDER BY
(d.arr_delay + a.arr_delay)) AS overall_rnk,
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
      (
         d.arr_delay + a.arr_delay 
      )
      AS total_arrival_delay 
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
      AND a.dep_time > 1200 
)
,
g AS 
(SELECT
   overall_rnk,
   first_origin,
   first_dest,
   first_flight_num,
   first_carrier,
   first_flight_date,
   first_dep_time,
   first_arr_delay,
   second_origin,
   second_dest,
   second_flight_num,
   second_carrier,
   second_flight_date,
   second_dep_time,
   second_arr_delay,
   total_arrival_delay 
FROM
   f 
WHERE
   overall_rnk = 1
)
,
h AS
(SELECT
   ROW_NUMBER() OVER () as row_num,
   overall_rnk,
   first_origin,
   first_dest,
   first_flight_num,
   first_carrier,
   first_flight_date,
   first_dep_time,
   first_arr_delay,
   second_origin,
   second_dest,
   second_flight_num,
   second_carrier,
   second_flight_date,
   second_dep_time,
   second_arr_delay,
   total_arrival_delay
FROM 
g)
SELECT
   concat_ws("_", first_origin, second_origin, second_dest, cast(first_flight_date AS string), cast(overall_rnk AS string), cast(row_num as string)) AS pkey,
   overall_rnk,
   first_origin,
   first_dest,
   first_flight_num,
   first_carrier,
   first_flight_date,
   first_dep_time,
   first_arr_delay,
   second_origin,
   second_dest,
   second_flight_num,
   second_carrier,
   second_flight_date,
   second_dep_time,
   second_arr_delay,
   total_arrival_delay
FROM
h;
