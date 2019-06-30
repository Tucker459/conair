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
	OriginDest string
	Carrier    string
	AvgDelay   float64
}

func main() {

	if len(os.Args) != 2 {
		log.Fatal("Please include source and destination airports! e.g. ./srcDestTop10Carriers ATL_JFK")
	}
	originDest := os.Args[1]
	svc := dynamodb.New(session.New(), aws.NewConfig().WithRegion("us-east-1"))
	input := &dynamodb.ScanInput{
		ExpressionAttributeValues: map[string]*dynamodb.AttributeValue{
			":od": {
				S: aws.String(originDest),
			},
		},
		FilterExpression: aws.String("origin_dest = :od"),
		TableName:        aws.String("top10_src_dest_carriers_grp2.3"),
	}

	result, err := svc.Scan(input)
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

	//fmt.Println(records)
	fmt.Println(result)
}
