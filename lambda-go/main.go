package main

import (
	"fmt"
	"context"
	"github.com/aws/aws-lambda-go/lambda"
)


type MyEvent struct {
	// hello world will not be return here

}

func HandleRequest(ctx context.Context, name MyEvent) {
	return none

}

func main() {

	lambda.Start(HandleReqeust)

}
