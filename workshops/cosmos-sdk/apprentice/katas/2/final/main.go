package main

import (
	"context"
	"fmt"

	sdk "github.com/cosmos/cosmos-sdk/types"
	auth "github.com/cosmos/cosmos-sdk/x/auth"
	bank "github.com/cosmos/cosmos-sdk/x/bank"
)

func main() {
	// Set up the SDK client
	ctx := context.Background()
	client := auth.NewCLIContext().WithCodec(sdk.MustSortJSONCodec())

	// Set up the sender and recipient addresses
	senderAddr := sdk.AccAddress([]byte("sender_address"))
	recipientAddr := sdk.AccAddress([]byte("recipient_address"))

	// Set up the transaction message
	amount := sdk.NewCoin("uluna", sdk.NewInt(100))
	msg := auth.NewStdMsg(
		[]sdk.Msg{bank.NewMsgSend(senderAddr, recipientAddr, sdk.NewCoins(amount))},
		auth.NewStdFee(100000, sdk.NewCoins(sdk.NewCoin("uluna", sdk.NewInt(10)))),
		[]auth.StdSignature{},
		"",
	)

	// Sign and broadcast the transaction
	txBytes, err := client.TxEncoder()(msg)
	if err != nil {
		panic(err)
	}
	res, err := client.BroadcastTx(txBytes)
	if err != nil {
		panic(err)
	}
	fmt.Println(res.String())
}
