Path of the Apprentice - Messages
======================================

This training exercise is a **apprentice-level** course on `Cosmos SDK` that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started
These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the exercise. If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites
* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface
The `Cosmos SDK` is a framework for building blockchain applications. In the context of the `Cosmos SDK`, a "message" is a piece of data that represents an action that a user wants to perform on the blockchain. Messages are used to interact with smart contracts, execute transactions, and update the state of the blockchain.

Messages in the `Cosmos SDK` are defined using a special message type, called a `Msg`. Each `Msg` object contains the following fields:

- `Type`: A string that identifies the type of message being sent. For example, a message to transfer tokens might have a type of "cosmos-sdk/MsgSend".
- `FromAddress`: The address of the sender of the message.
- `ToAddress`: The address of the recipient of the message.
- `Amount`: The amount of tokens being sent in the message, if any.
- `Data`: Any additional data that is required to execute the message. This could include things like the ID of a contract being interacted with, or the parameters for a smart contract function.

Once a `Msg` object is created, it can be signed by the sender using their private key, and then submitted to the blockchain for processing. The blockchain will validate the message, ensure that the sender has enough funds to execute the transaction, and then update the state of the blockchain accordingly.

Overall, messages are a key component of `Cosmos SDK`, and are used to represent user actions on the blockchain. By using a standardized message format, the `Cosmos SDK` allows developers to build flexible and interoperable blockchain applications that can interact with other blockchain applications in the Cosmos ecosystem.

## Exercise
This `training step` demonstrates how to create, sign, and submit a basic `MsgSend` message using the `Cosmos SDK` in `Go`. You can modify the code to create and submit other types of messages as well, depending on the requirements of your application.

### Step #1: Create kata directory
First we setup a directory for our exercise files. It's pretty straight forward:

```
mkdir kata3
cd kata3
```

### Step #2: Create a file called `main.go`
Secondly we need to create a file for our code kata:

```
cat > main.go
```

### Step #3: Import the necessary packages
At the top of `main.go` add an import statements for the `Go` packages neccessary to work with the `Cosmos SDK` `MsgSend` type:

```
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
```

### Step #4: Initialize variables
Now we need to initialize some local variables used by our `training step`:

```
senderAddress := "terra..."
recipientAddress := "terra..."
senderPrivateKey := "..."
senderPublicKey := "..."
chainID := "columbus-5"
```

### Step #5: Create a new MsgSend object
Then initialize a pointer to a newly created `MsgSend` object with the appropriate fields:

```
msgsend := &types.MsgSend{
    FromAddress: types.AccAddress(senderAddress),
    ToAddress:   types.AccAddress(recipientAddress),
    Amount:      types.NewCoins(types.NewCoin("uluna", types.NewInt(100))),
}
```

### Step #6: Build the transaction
Once our `MsgSend` object is instantiated we can use it to build a transaction that acts as a `message envelope` once broadcasted:

```
txBuilder := tx.NewTxBuilder(
    tx.DefaultTxEncoder(codec.New()),
    tx.DefaultTxDecoder(codec.New()),
).WithChainID(chainID)

txBuilder.SetMsgs(msg)
txBuilder.SetFeeAmount(sdk.NewCoins(sdk.NewCoin("uluna", sdk.NewInt(500))))
txBuilder.SetGasLimit(200000)
txBuilder.SetMemo("Sample transaction")
```

### Step #7: Sign the transaction
Before we can broadcast our transaction we need to sign it with the sender's private key:

```
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

txBytes, _ := txBuilder.SetSignatures(sig).BuildAndSign(senderAddress, privKey)
tx := fmt.Sprintf("%X", txBytes)
```

### Step #8: Submit the transaction to the blockchain
Now we can create a new `message service client` and broadcast the transaction:

```
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

if result.Code != 0 {
    fmt.Printf("Transaction failed with code %d: %s\n", result.Code, result.Log)
    return
}

fmt.Printf("Transaction succeeded with hash %s\n", result.TxHash)
```

### Step #9: Build executable
Build a new `Go` binary based on `main.go`:

```
go build
```

### Step #10: Run executable
Lastly we can run our new `Go` program with the following command:

```
./main
```

## Conclusion
In conclusion, messages in the `Cosmos SDK` are the primary way for applications to interact with the blockchain. Messages contain the necessary data for a transaction, such as the sender and recipient addresses, the amount of tokens to be transferred, and any other relevant information. The SDK provides a variety of built-in message types, such as `MsgSend` for token transfers and MsgVote for governance voting. Developers can also create their own custom message types to meet the specific needs of their applications. With the help of the `Cosmos SDK`, developers can easily create, sign, and submit messages to the blockchain to perform various actions, such as transferring tokens, voting on proposals, and more.

## Want to help make our training material better?
 * Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
 