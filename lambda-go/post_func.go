// Lambda function to handle incoming calls for
// DynamoDB CRUDL operations

package main

import (
	"fmt"
	"context"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/events"
)


type MyEvent struct {


}

func Handler(ctx context.Context, name MyEvent) {
	
	
	return none

}

func main() {

	lambda.Start(Handler)

}
