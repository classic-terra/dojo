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
	\"os\"

	\"github.com/cosmos/cosmos-sdk/client\"
	\"github.com/cosmos/cosmos-sdk/client/tx\"
	\"github.com/cosmos/cosmos-sdk/codec\"
	\"github.com/cosmos/cosmos-sdk/crypto/keyring\"
	\"github.com/cosmos/cosmos-sdk/crypto/hd\"
	\"github.com/cosmos/cosmos-sdk/simapp\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
	bankTypes \"github.com/cosmos/cosmos-sdk/x/bank/types\"
)

func main() {
	
	// Create a new context and client
	_ = context.Background()
	cdc := codec.NewProtoCodec(simapp.MakeTestEncodingConfig().InterfaceRegistry)

	// Create a new keyring
	kr := keyring.NewInMemory()
	kr.NewAccount(\"mykey\", \"mymnenomic\", \"mypassphrase\", hd.CreateHDPath(1, 2, 3).String(), hd.Secp256k1)

	// Create  node client
	nodeClient, err := client.NewClientFromNode(\"tcp://localhost:26657\")
	if err != nil {
		fmt.Printf(\"failed to create node client: %s\", err.Error())
		os.Exit(1)
	}

	// Create a new client context
	clientCtx := client.Context{}
	clientCtx = clientCtx.WithClient(nodeClient)
	clientCtx = clientCtx.WithChainID(\"columbus-5\")
	clientCtx = clientCtx.WithCodec(cdc)
	clientCtx = clientCtx.WithKeyring(kr)

	fmt.Printf(\"%+v\n\", clientCtx)

	txBuilder := clientCtx.TxConfig.NewTxBuilder()
	txBuilder.SetFeeAmount(sdk.NewCoins(sdk.NewInt64Coin(\"uluna\", 100000)))
	txBuilder.SetMemo(\"test transaction\")

	// Set up the sender's account information
	fromAddr, err := clientCtx.Keyring.Key(\"mykey\")
	if err != nil {
		fmt.Printf(\"failed to get sender address: %s\", err.Error())
		os.Exit(1)
	}
	txBuilder.SetGasLimit(200000)

	// Set up the recipient's address
	toAddrStr := \"terraexamplerecipientaddress\"
	toAddr, err := sdk.AccAddressFromBech32(toAddrStr)
	if err != nil {
		fmt.Printf(\"failed to parse recipient address: %s\", err.Error())
		os.Exit(1)
	}

	// Create a new message to send funds to the recipient
	msg := &bankTypes.MsgSend{
		FromAddress: fromAddr.GetAddress().String(),
		ToAddress:   toAddr.String(),
		Amount:      sdk.NewCoins(sdk.NewInt64Coin(\"uluna\", 50000000)),
	}
	if err := msg.ValidateBasic(); err != nil {
		fmt.Printf(\"failed to validate message: %s\", err.Error())
		os.Exit(1)
	}

	// Add the message to the transaction
	err = txBuilder.SetMsgs(msg)
	if err != nil {
		fmt.Printf(\"failed to set message: %s\", err.Error())
		os.Exit(1)
	}

	// Sign the transaction
	err = tx.Sign(tx.Factory{}, fromAddr.GetName(), txBuilder, true)
	if err != nil {
		fmt.Printf(\"failed to sign transaction: %s\", err.Error())
		os.Exit(1)
	}

	// Encode the transaction and broadcast it to the network
	txBytes, err := clientCtx.TxConfig.TxEncoder()(txBuilder.GetTx())
	if err != nil {
		fmt.Printf(\"failed to encode transaction: %s\", err.Error())
		os.Exit(1)
	}

	res, err := clientCtx.BroadcastTx(txBytes)
	if err != nil {
		fmt.Printf(\"failed to broadcast transaction: %s\", err.Error())
		os.Exit(1)
	}

	fmt.Printf(\"transaction sent: %s\", res.TxHash)
}"

#Save the programn to a file called main.go
echo "$GO_CODE" > main.go

#Clean up the go.mod file
go mod tidy

#Build the program
go build

#Run the program
./transactions