package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"log"
	"os"
	echo "temp/proto"
	"time"
)

func main() {
	args := os.Args[1:]
	if len(args) < 2 {
		fmt.Println("Usage client.go ADDRESS PAYLOAD")
		os.Exit(0)
	}
	address := args[0]
	payload := args[1]
	conn, err := grpc.Dial(address, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatal(err)
	}
	client := echo.NewEchoClient(conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()
	resp, err := client.Get(ctx, &echo.GetRequest{
		Payload: payload,
	})
	fmt.Println(resp.Payload)
}