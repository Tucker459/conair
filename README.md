# Conair
<p align="center">
  <img src="/img/con-air.jpg" width="350">
</p>

## Description 
For my [CS598 Cloud Computing Capstone](https://cs.illinois.edu/sites/default/files/docs/syllabi/CS598_CloudComputingCapstone.pdf) we were tasked with creating data pipelines one using a batch-style of processing and another using stream-style processing. This is my batch style processing project Conair. I was tasked with architecing out a big data processing solution to answer a multitode of questions using airline data between the years of 1988 - 2008. 

I decided to use [Apache Hive](https://hive.apache.org/) on [AWS EMR](https://aws.amazon.com/emr/) as my main application. The benefits for me using hive was that I could use HQL their dialect for SQL which allows me to abstract away a lot of the finer details of map-reduce and focus on the core logic. 

The main applications that I used for this project was EMR, Hadoop, Hive, DynamoDB, S3, EMRFS, and AWS Datapipeline for orchestration. I talked about my entire process from extracting and cleaning of the data to optimizations that I used to speed up queries in my [report](/report/ConairCapstoneReport.pdf). 

[Read The Report](/report/ConairCapstoneReport.pdf)

[Watch The Video](https://mediaspace.illinois.edu/media/t/1_qo3gygt6)

For extracting and data cleaning please take a look at some of my [handyScripts](/handyScripts).

Follow along as I tried different optimizations and configurations in my [notes](notes.md) and [random commands](randomcmds.txt). I also took [screenshots](/img) as I tried out different optimizations in Hive when querying the tables. 

I also wrote go cli scripts to query the DynamoDB database for group 2 and 3.2 questions.
