package main

import (
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
)

// Record represent one record in dynamoDB
type Record struct {
	BestFlight       string
	FirstCarrier     string
	FirstDepTime     string
	FirstDest        string
	FirstFlightDate  string
	FirstFlightNum   string
	FirstOrigin      string
	SecondCarrier    string
	SecondDepTime    string
	SecondDest       string
	SecondFlightDate string
	SecondFlightNum  string
	SecondOrigin     string
	FirstArrDelay    string
	SecondArrDelay   string
	OverallArrDelay  string
}

func main() {

	if len(os.Args) != 2 {
		log.Fatal("Please include src_dest_date! e.g. ./bestFlights ATL_JFK_04-03-2008")
	}
	flight := os.Args[1]
	svc := dynamodb.New(session.New(), aws.NewConfig().WithRegion("us-east-1"))
	input := &dynamodb.QueryInput{
		ExpressionAttributeValues: map[string]*dynamodb.AttributeValue{
			":f": {
				S: aws.String(flight),
			},
		},
		KeyConditionExpression: aws.String("best_flight = :f"),
		IndexName:              aws.String("bestflightindex"),
		TableName:              aws.String("bestflights_grp3.2"),
	}

	result, err := svc.Query(input)
	if err != nil {
		log.Fatal(err.Error())
	}

	var records []Record
	recs := []Record{}

	err = dynamodbattribute.UnmarshalListOfMaps(result.Items, &recs)
	if err != nil {
		log.Fatal("Failed to unmarshal DynamoDB Scan Items")
	}

	// Avg Delay is returning 0 when unmarshalling. Don't know why?
	// Workaround: Convert avg delay to string in Hive table push to
	// dynamodb as a string run the query and convert data type to
	// float64 after unmarshalling.
	records = append(records, recs...)

	fmt.Println(records)
	//fmt.Println(result)
}
