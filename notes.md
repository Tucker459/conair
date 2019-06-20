# Random Notes

### Questions 

* Group 1 (Answer any 2):

  Rank the top 10 most popular airports by numbers of flights to/from the airport.  
  Rank the top 10 airlines by on-time arrival performance.  
  Rank the days of the week by on-time arrival performance.  
  Note: only the tables with information at the flight/day granularity are applicable for the Group 1 questions.

* Group 2 (Answer any 3):

  For Questions 1 and 2 below, we are asking you to find, for each airport, the top 10 carriers and destination airports from that airport with respect to on-time departure performance. We are not asking you to rank the overall top 10 carriers/airports. For specific queries, see the Task 1 Queries and Task 2 Queries.

  For each airport X, rank the top-10 carriers in decreasing order of on-time departure performance from X.  
  For each airport X, rank the top-10 airports in decreasing order of on-time departure performance from X.  
  For each source-destination pair X-Y, rank the top-10 carriers in decreasing order of on-time arrival performance at Y from X.  
  For each source-destination pair X-Y, determine the mean arrival delay (in minutes) for a flight from X to Y.

* Group 3 (Answer both questions using Hadoop. You may also use Spark Streaming to answer Question 2.):

  Does the popularity distribution of airports follow a Zipf distribution? If not, what distribution does it follow?

  Tom wants to travel from airport X to airport Z. However, Tom also wants to stop at airport Y for some sightseeing on the way. More concretely, Tom has the following requirements (for specific queries, see the Task 1 Queries and Task 2 Queries)

  a) The second leg of the journey (flight Y-Z) must depart two days after the first leg (flight X-Y). For example, if X-Y departs on January 5, 2008, Y-Z must depart on January 7, 2008.

  b) Tom wants his flights scheduled to depart airport X before 12:00 PM local time and to depart airport Y after 12:00 PM local time.

  c) Tom wants to arrive at each destination with as little delay as possible. You can assume you know the actual delay of each flight.

  Your mission (should you choose to accept it!) is to find, for each X-Y-Z and day/month (dd/mm) combination in the year 2008, the two flights (X-Y and Y-Z) that satisfy constraints (a) and (b) and have the best individual performance with respect to constraint (c), if such flights exist.

  For the queries in Group 2 and Question 3.2, you will need to compute the results for ALL input values (e.g., airport X, source-destination pair X-Y, etc.) for which the result is nonempty. These results should then be stored in Cassandra so that the results for an input value can be queried by a user. Then, closer to the grading deadline, we will give you sample queries (airports, flights, etc.) to include in your video demo and report.

  For example, after completing Question 2.2, a user should be able to provide an airport code (such as “ATL”) and receive the top 10 airports in decreasing order of on-time departure performance from ATL. Note that for questions such as 2.3, you do not need to compute the values for all possible combinations of X-Y, but rather only for those such that a flight from X to Y exists.

### Data Cleaning 
Grabbed the online airline ontime performance database - reporting carrier on-time performance as my datasource.   
Don't need the header for the file.  
Throw away 2008 Nov/Dec Data Corrupt.  
Got to use OpenRefine or something other tool within AWS to make sure data is clean.   Numbers are off slighty.   
Going to try to use AWS Glue using Go API.   
Decided to write my own program using Go to subset columns.   
OpenRefine is too slow with relatively small amount of data (1.5 - 2.1GB) to subset columns. Even on super expensive virtual machines. Went down the path of learning AWS Glue Go API only can be used to interact with the client not actually write the data transformations jobs which can only be written in Python or Scala. Didn't want to do that.  
Which is why I wrote my own Go Program to subset columns for GBs of data. Was super fast!   
Now I can use OpenRefine to check for data integrity issues since the size of the data is much smaller.   

### Optimizations 

* Optimizations for Hive:  
  Execution Engine = Tez  
  Intermediate Compression between Map & Reduce Jobs ; Snappy Compression Algo  
  Set Map Tasks Parallel Execution to True  
  Compression of Data File - GZip   
  Compression of Table - Sequence (Row Based), Parquet (Column Based), ORC (Column Based)

  Testing out queries based on Storage format of the table.  
  Parquet seemed to give the biggest leap in performance since it's column based and the 
  queries that I need to run only use a few of the columns. 

### Group 1 Tasks

Used common-table-expressions, aggregate, and group-by functions to answer the two questions. 

### Group 2 Tasks

Used common-table-expressions, aggregate functions, group-by, and window functions to answers the three questions. 

### Group 3 Tasks

Using common-table-expressions, aggregate functions, group-by, and window functions to 
answer one question. 

* Join optimizations:
  Hive also assumes that the last table is the *largest*. It attempts to buffer the other tables and then stream the last table through, while performing joins on individual records. Therefore you should put the largest table last in a join. 

### Prep for AWS Datapipeline

Breakout each individual questions sql answer into its own individual script. To be loaded to S3.   
For Group2 and 3.2 answers morph sql into CTAS (Create Table AS Select) statement for they can be loaded into DynamoDB tables. 
