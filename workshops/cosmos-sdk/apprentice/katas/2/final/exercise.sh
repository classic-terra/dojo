#!/bin/bash
#Create a new directory called kata2
mkdir kata2

#Change into the kata2 directory
cd kata2

#Initialize a new go module
go mod init transactions
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
	\"github.com/cosmos/cosmos-sdk/client/tx\"
	\"github.com/cosmos/cosmos-sdk/crypto/hd\"
	\"github.com/cosmos/cosmos-sdk/crypto/keyring\"
	\"github.com/cosmos/cosmos-sdk/testutil/testdata\"
	\"github.com/cosmos/cosmos-sdk/simapp\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
	\"github.com/cosmos/cosmos-sdk/types/tx/signing\"
	bankTypes \"github.com/cosmos/cosmos-sdk/x/bank/types\"
)

func main() {
	// Create a new background context
	_ = context.Background()

	//Set prefix for config
	sdk.GetConfig().SetBech32PrefixForAccount(\"terra\", \"terrapub\")

	//Get simapp encoding configuration
	encodingConfig := simapp.MakeTestEncodingConfig()

	// Create & configure a new InMemory keyring
	kr := keyring.NewInMemory()

	kr.NewAccount(\"localkey\", testdata.TestMnemonic, keyring.DefaultBIP39Passphrase, sdk.FullFundraiserPath, hd.Secp256k1)

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
		WithKeyring(kr).
		WithClient(nodeClient).
		WithChainID(\"columbus-5\").
		WithSignModeStr(\"SIGN_MODE_UNSPECIFIED\").
		WithBroadcastMode(\"block\")

	// Create a new transaction builder
	txBuilder := clientCtx.TxConfig.NewTxBuilder()
	txBuilder.SetFeeAmount(sdk.NewCoins(sdk.NewInt64Coin(\"uluna\", 100000)))
	txBuilder.SetGasLimit(200000)
	txBuilder.SetMemo(\"test transaction\")

	// Fetch the sender's account key
	senderKey, err := clientCtx.Keyring.Key(\"localkey\")

	clientCtx.WithFeeGranterAddress(senderKey.GetAddress())

	if err != nil {
		fmt.Printf(\"failed to get sender key: %s\", err.Error())
		os.Exit(1)
	}

	// Fetch sender & recipient addresses
	fromAddr := senderKey.GetAddress()
	toAddr, err := sdk.AccAddressFromBech32(\"terra13vs2znvhdcy948ejsh7p8p22j8l4n4y07062qq\")
	if err != nil {
		fmt.Printf(\"failed to parse recipient address: %s\", err.Error())
		os.Exit(1)
	}

	// Create a new message to send funds to the recipient
	msg := &bankTypes.MsgSend{
		FromAddress: fromAddr.String(),
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
	txf := tx.Factory{}.
		WithKeybase(clientCtx.Keyring).
		WithSignMode(signing.SignMode_SIGN_MODE_UNSPECIFIED).
		WithChainID(clientCtx.ChainID).
		WithTxConfig(clientCtx.TxConfig)

	err = tx.Sign(txf, senderKey.GetName(), txBuilder, true)
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

#Save the program to a file called main.go
echo "$GO_CODE" > main.go

#Clean up the go.mod file & fetch infered dependencies
go mod tidy

#Build the program
go build

#Run the program
./transactions