package main

import (
	"fmt"

	"encoding/hex"

	"github.com/cosmos/cosmos-sdk/codec"
	"github.com/cosmos/cosmos-sdk/crypto/keys/secp256k1"
	"github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/msgservice"
	"github.com/cosmos/cosmos-sdk/x/auth/types"
	"github.com/cosmos/cosmos-sdk/x/auth/types/tx"
	"github.com/tendermint/tendermint/crypto/ed25519"
)

func main() {
	// Set the necessary variables
	senderAddress := "terra..."
	recipientAddress := "terra..."
	senderPrivateKey := "..."
	senderPublicKey := "..."
	chainID := "columbus-5"

	// Create a new MsgSend object with the appropriate fields
	msgsend := &types.MsgSend{
		FromAddress: types.AccAddress(senderAddress),
		ToAddress:   types.AccAddress(recipientAddress),
		Amount:      types.NewCoins(types.NewCoin("uluna", types.NewInt(100))),
	}

	// Build the transaction with the message
	txBuilder := tx.NewTxBuilder(
		tx.DefaultTxEncoder(codec.New()),
		tx.DefaultTxDecoder(codec.New()),
	).WithChainID(chainID)
	txBuilder.SetMsgs(msgsend)
	txBuilder.SetFeeAmount(types.NewCoins(types.NewCoin("uluna", types.NewInt(500))))
	txBuilder.SetGasLimit(200000)
	txBuilder.SetMemo("Sample transaction")

	// Sign the transaction with the sender's private key
	privKeyBytes, _ := hex.DecodeString(senderPrivateKey)
	privKey := secp256k1.PrivKeySecp256k1(privKeyBytes)

	pubKeyBytes, _ := hex.DecodeString(senderPublicKey)
	pubKey := ed25519.PubKey(pubKeyBytes)

	signer := types.DefaultSigner(privKey, pubKey, "")
	sigBytes, _ := signer.Sign(txBuilder.ChainID(), txBuilder.GetTx())
	sig := &types.StdSignature{
		PubKey:    pubKey,
		Signature: sigBytes,
	}

	// Set the signature for the transaction and encode it
	txBytes, _ := txBuilder.SetSignatures(sig).BuildAndSign(senderAddress, privKey)
	_ = fmt.Sprintf("%X", txBytes)

	// Submit the transaction to the blockchain
	result := types.TxResponse{}
	resp, err := msgservice.NewMsgServiceClient(nil).BroadcastTxSync(nil, &types.Tx{
		Body: txBytes,
		AuthInfo: &types.AuthInfo{
			Fee: txBuilder.GetFee(),
		},
	})
	if err != nil {
		fmt.Printf("Error broadcasting transaction: %v\n", err)
		return
	}
	if err := result.Unmarshal(resp.GetTxResponse().GetTx()); err != nil {
		fmt.Printf("Error unmarshaling result: %v\n", err)
		return
	}

	// Check the result of the transaction submission to ensure it was successful
	if result.Code != 0 {
		fmt.Printf("Transaction failed with code %d: %s\n", result.Code, result.Log)
		return
	}
	fmt.Printf("Transaction succeeded with hash %s\n", result.TxHash)
}
