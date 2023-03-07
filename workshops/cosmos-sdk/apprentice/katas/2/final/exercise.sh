#!/bin/bash
#Create a new directory called kata2
mkdir kata2

#Change into the kata2 directory
cd kata2

#Initialize a new go module
go mod init example.com/transactions
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/protobuf=github.com/regen-network/protobuf@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12

#Implement a simple program
GO_CODE="package main

import (
	\"context\"
	\"fmt\"

	\"github.com/cosmos/cosmos-sdk/client\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
	banktypes \"github.com/cosmos/cosmos-sdk/x/bank/types\"
)

func main() {
	
}"

#Save the programn to a file called main.go
echo "$GO_CODE" > main.go

#Clean up the go.mod file
go mod tidy

#Run the program
go run main.go