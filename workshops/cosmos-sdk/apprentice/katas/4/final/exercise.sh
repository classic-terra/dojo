#!/bin/bash
#Create a new directory called kata3
mkdir kata4

#Change into the kata3 directory
cd kata4

#Initialize a new go module
go mod init queries
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12

#Implement a simple program
GO_CODE="package main

import (
    \"context\"
	\"fmt\"
	\"os\"

	\"github.com/cosmos/cosmos-sdk/client\"
	\"github.com/cosmos/cosmos-sdk/simapp\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
)

func main() {
	// Create a new background context
	_ = context.Background()

	//Set prefix for config
	sdk.GetConfig().SetBech32PrefixForAccount(\"terra\", \"terrapub\")

	//Get simapp encoding configuration
	encodingConfig := simapp.MakeTestEncodingConfig()

	// Create  node client
	nodeClient, err := client.NewClientFromNode(\"tcp://localhost:26657\")
	if err != nil {
		fmt.Printf(\"failed to create node client: %s\", err.Error())
		os.Exit(1)
	}

	// Create a new client context
	clientCtx := client.Context{}.
		WithInterfaceRegistry(encodingConfig.InterfaceRegistry).
		WithTxConfig(encodingConfig.TxConfig).
		WithLegacyAmino(encodingConfig.Amino).
		WithCodec(encodingConfig.Marshaler).
		WithClient(nodeClient).
		WithChainID(\"columbus-5\").
		WithSignModeStr(\"SIGN_MODE_UNSPECIFIED\").
		WithBroadcastMode(\"block\")

	// Create a address from a string
	queryAddr, err := sdk.AccAddressFromBech32(\"terra13vs2znvhdcy948ejsh7p8p22j8l4n4y07062qq\")
	if err != nil {
		fmt.Printf(\"failed to parse recipient address: %s\", err.Error())
		os.Exit(1)
	}

	// Query account information
	res, _, err := clientCtx.QueryWithData(fmt.Sprintf(\"custom/%s/%s/%s\", \"bank\", \"accounts\", queryAddr.String()), nil)
	if err != nil {
		fmt.Printf(\"failed to query account: %s\", err.Error())
		os.Exit(1)
	}

	// Unmarshal account information
	var account client.Account
	if err := encodingConfig.Marshaler.UnmarshalInterface(res, &account); err != nil {
		fmt.Printf(\"failed to unmarshal query: %s\", err.Error())
		os.Exit(1)
	}

	// Print account information
	fmt.Printf(\"Account address: %s\n\", account.GetAddress())
	
}"

#Save the programn to a file called main.go
echo "$GO_CODE" > main.go

#Clean up the go.mod file
go mod tidy

#Build the program
go build

#Run the program
./queries