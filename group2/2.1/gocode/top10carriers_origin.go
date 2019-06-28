package main

import (
	"os"
)

func main() {

	origin := os.Args[1]
	svc := dynamodb.New(session.New())
	input := &dynamodb.ScanInput{
		ExpressionAttributeValues: map[string]*dynamodb.AttributeValue{
			":o": {
				S: aws.String(origin),
			},
		},
	}
}
