#!/bin/bash
#Create a new directory called kata1
mkdir kata1

#Change into the kata1 directory
cd kata1

#Initialize a new go module
go mod init proto

#Install package dependencies
go get google.golang.org/`protobuf`/proto
go get google.golang.org/`protobuf`/cmd/protoc-gen-go@latest
go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

#Create a file called person.proto and add the below `protobuf` message contract
PROTO_MSG="syntax = \"proto3\";
option go_package = \"example.com/proto/main\";

message Person {
  string name = 1;
  int32 age = 2;
  repeated string hobbies = 3;
}"

echo "$PROTO_MSG" > person.proto

#Generate the Go code from the `protobuf` contract
protoc --go_out=. person.proto --go_opt=paths=source_relative

#Implement a simple program
GO_CODE="package main

import (
    \"fmt\"
    \"log\"

    \"google.golang.org/`protobuf`/proto\"
)

func main() {
    p := &Person{
        Name:    \"Alice\",
        Age:     30,
        Hobbies: []string{\"reading\", \"hiking\"},
    }

    data, err := proto.Marshal(p)
    if err != nil {
        log.Fatal(\"error marshaling person:\", err)
    }

    var p2 Person
    err = proto.Unmarshal(data, &p2)
    if err != nil {
        log.Fatal(\"error unmarshaling person:\", err)
    }

    fmt.Printf(\"name: %s\n\", p2.Name)
    fmt.Printf(\"age: %d\n\", p2.Age)
    fmt.Printf(\"hobbies: %v\n\", p2.Hobbies)
}"

#Save the programn to a file called main.go
echo "$GO_CODE" > main.go

#Build the program
go build

#Run the program
./proto