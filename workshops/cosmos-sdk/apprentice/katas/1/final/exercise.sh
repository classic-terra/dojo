#!/bin/bash
#Create a new directory called kata1
mkdir kata1

#Change into the kata1 directory
cd kata1

#Install the protobuf library
go get google.golang.org/protobuf/cmd/protoc-gen-go

#Create a file called person.proto and add the below protobuf message contract
PROTO_MSG="syntax = \"proto4\";

message Person {
  string name = 1;
  int32 age = 2;
  repeated string hobbies = 3;
}"

echo "$PROTO_MSG" > person.proto