# Path of the Apprentice - Messages

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the exercise. If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Keybase](https://keybase.io/docs/the_app/install_linux)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Cosmos SDK is a framework for building blockchain applications. In the context of Cosmos SDK, a message is a piece of data that represents an action that a user wants to perform on the blockchain. Messages are used to interact with smart contracts, execute transactions, and update the state of the blockchain.

Messages in the Cosmos SDK are defined using a special message type, called a `sdk.Msg`. Each `sdk.Msg` object contains the following fields:

* `Type`: A string that identifies the type of message being sent. For example, a message to transfer tokens might have a type of `cosmos-sdk/MsgSend`.
* `FromAddress`: The address of the sender of the message.
* `ToAddress`: The address of the recipient of the message.
* `Amount`: The amount of tokens being sent in the message, if any.
* `Data`: Any additional data that is required to execute the message. This could include things like the ID of a contract being interacted with, or the parameters for a smart contract function.

Once a `sdk.Msg` object is created, it can be signed by the sender using their private key, and then submitted to the blockchain for processing. The blockchain will validate the message, ensure that the sender has enough funds to execute the transaction, and then update the state of the blockchain accordingly.

Overall, messages are a key component of Cosmos SDK, and are used to represent user actions on the blockchain. By using a standardized message format, Cosmos SDK allows developers to build flexible and interoperable blockchain applications that can interact with other blockchain applications in the Cosmos ecosystem.

## Exercise

This `training step` demonstrates how to create, sign, and submit a basic `MsgSend` message using Cosmos SDK in `Go`. You can modify the code to create and submit other types of messages as well, depending on the requirements of your application.


**Note**: this `training step` assumes that you have set up a working Cosmos SDK node and configured the SDK client accordingly. Additionally, you will need to import the appropriate SDK modules and define the token type and decimal places for your specific blockchain network in order for this to be used in production.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata3
cd kata3
```

### Step #2: Initialize `Go` module

Now we want to initialize a new `Go` module, add required `package redirects` and fetch `Cosmos SDK v0.45.12`:

```bash
go mod init messages
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12
```

Here is a step-by-step breakdown of what each command does:

`go mod init transactions` initializes a new Go module named `messages`. This command creates a `go.mod` file in the current directory that contains metadata about the module and its dependencies.

`go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0` adds a package redirect to the `go.mod` file. This command replaces any occurrence of the package `github.com/99designs/keyring` with `github.com/cosmos/keyring@v1.2.0`. Package redirects can be used to override the default version of a package that is fetched by `Go` modules.

`go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2` adds another package redirect to the `go.mod` file. This command replaces any occurrence of the package `github.com/dgrijalva/jwt-go` with `github.com/golang-jwt/jwt/v4@v4.4.2`.

`go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0` adds a package redirect for `github.com/gin-gonic/gin`. This command replaces any occurrence of the package `github.com/gin-gonic/gin` with `github.com/gin-gonic/gin@v1.7.0`.

`go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1` adds a package redirect for `github.com/gogo/`protobuf``. This command replaces any occurrence of the package `github.com/gogo/`protobuf`` with `github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1`.

`go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0` adds a package redirect for `github.com/jhump/protoreflect`. This command replaces any occurrence of the package `github.com/jhump/protoreflect` with `github.com/jhump/protoreflect@v1.9.0`.

`go get github.com/cosmos/cosmos-sdk@v0.45.12` fetches a specific version of the Cosmos SDK (v0.45.12) and adds it as a dependency to the `go.mod` file.

Overall, these commands are used to set up a Go module with the necessary dependencies, including package redirects that ensure that the correct version of each package is used.

### Step #3: Create a file called `main.go`

Then we have to create a file for our program:

```bash
cat > main.go
```

### Step #4: Import required `Go` packages

At the top of `main.go` add an import statement with the `Go` packages neccessary to complete this `training step`:

```go
package main

import (
	"context"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/client"
	"github.com/cosmos/cosmos-sdk/client/tx"
	"github.com/cosmos/cosmos-sdk/crypto/hd"
	"github.com/cosmos/cosmos-sdk/crypto/keyring"
	"github.com/cosmos/cosmos-sdk/testutil/testdata"
	"github.com/cosmos/cosmos-sdk/simapp"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/tx/signing"
	bankTypes "github.com/cosmos/cosmos-sdk/x/bank/types"
)
```

Our import section includes packages necessary to create and sign a transaction on the Cosmos SDK blockchain. Here's a brief explanation of each package:

- `context` is used for managing context across API boundaries.
- `fmt` is used for formatting and printing output.
- `os` provides a platform-independent interface for interacting with the operating system.
- `github.com/cosmos/cosmos-sdk/client` contains modules to create and sign transactions for Cosmos SDK-based blockchains.
- `github.com/cosmos/cosmos-sdk/client/tx` contains functions to build and broadcast transactions.
- `github.com/cosmos/cosmos-sdk/crypto/hd` contains functions to derive hierarchical deterministic (HD) keys.
- `github.com/cosmos/cosmos-sdk/crypto/keyring` provides a keyring for managing keys for signing transactions.
- `github.com/cosmos/cosmos-sdk/testutil/testdata` contains test data for unit tests.
- `github.com/cosmos/cosmos-sdk/simapp` contains an example Cosmos SDK application for simulation testing.
- `github.com/cosmos/cosmos-sdk/types` contains the core data types for the Cosmos SDK.
- `github.com/cosmos/cosmos-sdk/types/tx/signing` contains types and functions for transaction signing.
- `github.com/cosmos/cosmos-sdk/x/bank/types` contains types for the Cosmos SDK bank module.

### Step #5: Add empty main() method

Then create an empty method body below the import statement:

```go
func main() {
}
```

### Step #6: Set up Cosmos SDK

Inside the main method begin by setting up the SDK configuration used by our `training step`:

```go	
// Create a new background context
_ = context.Background()

//Set prefix for config
sdk.GetConfig().SetBech32PrefixForAccount("terra", "terrapub")

//Get simapp encoding configuration
encodingConfig := simapp.MakeTestEncodingConfig()
```

The first line of code creates a new background context, but does not save the context anywhere.

The second line sets the Bech32 prefix for account addresses and public keys. Bech32 is a format for encoding and decoding addresses in the Cosmos SDK.

The third line creates an encoding configuration for the simulation application (simapp) using the `MakeTestEncodingConfig()` function from the Cosmos SDK. The encoding configuration is used to encode and decode data structures in the simapp.

### Step #7: Configure an InMemory keyring

Once we have the SDK configuration in place we need to setup a new `InMemory` keyring which is convenient to use in testing and prototyping scenarios, but in general should not be done in production. To complete the configuration and register a `dummy account` for our `training step` we add the following code to `main.go`:

```go
// Create & configure a new InMemory keyring
kr := keyring.NewInMemory()

kr.NewAccount("localkey", testdata.TestMnemonic, keyring.DefaultBIP39Passphrase, sdk.FullFundraiserPath, hd.Secp256k1)
```

This code creates a new account in the keyring, which is a collection of keys that can be used to sign transactions. The account is created using the `NewAccount` method of a keyring object (kr) and the following parameters:

- `"localkey"`: The name of the account to create.

- `testdata.TestMnemonic`: The mnemonic phrase to use for generating the key.

- `keyring.DefaultBIP39Passphrase`: The passphrase to use for generating the key. This is the default passphrase used in the Cosmos SDK.

- `sdk.FullFundraiserPath`: The derivation path to use for generating the key. This path is used in the Cosmos SDK to generate keys for accounts in the fundraiser testnet.

- `hd.Secp256k1`: The cryptographic algorithm to use for generating the key. In this case, the key is generated using the secp256k1 elliptic curve.

### Step #8: Configure nodeClient & clientContext

Now that we have our basic configuration in place and the keyring is populated with a `dummy account` we can proceed to configure the client our `Go` program will use to communicate with the blockchain:

```go
// Create  node client
nodeClient, err := client.NewClientFromNode("tcp://localhost:26657")
if err != nil {
	fmt.Printf("failed to create node client: %s", err.Error())
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
	WithChainID("columbus-5").
	WithSignModeStr("SIGN_MODE_UNSPECIFIED").
	WithBroadcastMode("block")
```

This code creates a new client context that is used to interact with the Cosmos SDK node. The context is created using the `client.Context` struct and the following methods:

- `WithInterfaceRegistry(encodingConfig.InterfaceRegistry)`: Set the interface registry used for decoding `protobuf` messages.

- `WithTxConfig(encodingConfig.TxConfig)`: Set the transaction configuration used for building and signing transactions.

- `WithLegacyAmino(encodingConfig.Amino)`: Set the codec used for serializing and deserializing messages in the legacy amino format. The legacy amino codec is part of the EncodingConfig object created earlier.

- `WithCodec(encodingConfig.Marshaler)`: Set the codec used for serializing and deserializing messages in the new binary format. The new codec is part of the EncodingConfig object created earlier.

- `WithKeyring(kr)`: Set the keyring object that holds the accounts used for signing transactions.

- `WithClient(nodeClient)`: Set the node client object that is used to connect to the Cosmos SDK node.

- `WithChainID("columbus-5")`: Set the chain ID of the Cosmos SDK network that we are interacting with.

- `WithSignModeStr("SIGN_MODE_UNSPECIFIED")`: Set the signature mode used for signing transactions. In this case, we are using the default signature mode.

### Step #9: Initialize transaction builder

With the Cosmos SDK clientCtx fully configured and ready for use we can leverages its `TxConfig` property to initialize the `TxBuilder` we need to compose the transaction `message envelope` required for broadcasting our messages, including adding metadata such `fees`, `gaslimit` and a `memo`:

```go
// Create a new transaction builder
txBuilder := clientCtx.TxConfig.NewTxBuilder()
txBuilder.SetFeeAmount(sdk.NewCoins(sdk.NewInt64Coin("uluna", 100000)))
txBuilder.SetGasLimit(200000)
txBuilder.SetMemo("test transaction")
```

### Step #10: Create multiple messages for our transaction

Finally we have to create the messages that we want to put in our `message envelope` (transaction) and add metadata supported by the `bankTypes.MsgSend` struct, such as `sender`, `recipient` and `amount`:

```go
// Fetch the sender's account key
senderKey, err := clientCtx.Keyring.Key("localkey")

clientCtx.WithFeeGranterAddress(senderKey.GetAddress())

if err != nil {
	fmt.Printf("failed to get sender key: %s", err.Error())
	os.Exit(1)
}

// Fetch sender & recipient addresses
fromAddr := senderKey.GetAddress()
toAddr, err := sdk.AccAddressFromBech32("terra13vs2znvhdcy948ejsh7p8p22j8l4n4y07062qq")
if err != nil {
	fmt.Printf("failed to parse recipient address: %s", err.Error())
	os.Exit(1)
}

// Create new messages to send funds to the recipient
msgSend1 := &bankTypes.MsgSend{
	FromAddress: fromAddr.String(),
	ToAddress:   toAddr.String(),
	Amount:      sdk.NewCoins(sdk.NewInt64Coin("uluna", 50000000)),
}
if err := msgSend1.ValidateBasic(); err != nil {
	fmt.Printf("failed to validate message: %s", err.Error())
	os.Exit(1)
}

msgSend2 := &bankTypes.MsgSend{
	FromAddress: fromAddr.String(),
	ToAddress:   toAddr.String(),
	Amount:      sdk.NewCoins(sdk.NewInt64Coin("uluna", 50000000)),
}
if err := msgSend2.ValidateBasic(); err != nil {
	fmt.Printf("failed to validate message: %s", err.Error())
	os.Exit(1)
}

// Add the message to the transaction
err = txBuilder.SetMsgs(msgSend1, msgSend2)
if err != nil {
	fmt.Printf("failed to set message: %s", err.Error())
	os.Exit(1)
}
```

### Step #11: Sign & broadcast the transaction

With our transaction fully composed all that remains is for us to sign it with the senders private key and broadcast it to the blockchain:

```go
// Sign the transaction
txf := tx.Factory{}.
	WithKeybase(clientCtx.Keyring).
	WithSignMode(signing.SignMode_SIGN_MODE_UNSPECIFIED).
	WithChainID(clientCtx.ChainID).
	WithTxConfig(clientCtx.TxConfig)

err = tx.Sign(txf, senderKey.GetName(), txBuilder, true)
if err != nil {
	fmt.Printf("failed to sign transaction: %s", err.Error())
	os.Exit(1)
}

// Encode the transaction and broadcast it to the network
txBytes, err := clientCtx.TxConfig.TxEncoder()(txBuilder.GetTx())
if err != nil {
	fmt.Printf("failed to encode transaction: %s", err.Error())
	os.Exit(1)
}

res, err := clientCtx.BroadcastTx(txBytes)
if err != nil {
	fmt.Printf("failed to broadcast transaction: %s", err.Error())
	os.Exit(1)
}

fmt.Printf("transaction sent: %s", res.TxHash)
```

The above code signs the transaction using the private key of the sender, then encodes it and broadcasts it to the network using the client context.

`tx.Factory{}` is used to create a new transaction factory with the following methods chained to it:

-`WithKeybase(clientCtx.Keyring)`: sets the keybase used to sign the transaction to the one stored in the client context.

-`WithSignMode(signing.SignMode_SIGN_MODE_UNSPECIFIED)`: sets the sign mode to SIGN_MODE_UNSPECIFIED.

-`WithChainID(clientCtx.ChainID)`: sets the chain ID used to sign the transaction to the one stored in the client context.

-`WithTxConfig(clientCtx.TxConfig)`: sets the transaction config used to sign the transaction to the one stored in the client context.

After creating the transaction factory, `tx.Sign()` is called to sign the transaction using the private key of the sender. The true argument indicates that the transaction should be in "generate only" mode, meaning it should not be broadcasted yet.

Next, the encoded transaction is broadcasted to the network using `clientCtx.BroadcastTx()`. The resulting transaction hash is printed to the console if the broadcast was successful.

### Step #12: Run `go mod tidy`

To clean up our `dependency graph` and fetch any missing packages we have to run the `go mod tidy` command:

```bash
go mod tidy
```

### Step #13: Build executable

With our code kata finalized all that remains now is to build a new `Go` binary based on `main.go`:

```bash
go build
```

### Step #14: Run executable

Then we can run our new `Go` program with the following command:

```bash
./messages
```

## Conclusion

In conclusion, messages in the Cosmos SDK are the primary way for applications to interact with the blockchain. Messages contain the necessary data for a transaction, such as the sender and recipient addresses, the amount of tokens to be transferred, and any other relevant information. The SDK provides a variety of built-in message types, such as `MsgSend` for token transfers and `MsgVote` for governance voting. Developers can also create their own custom message types to meet the specific needs of their applications. With the help of the Cosmos SDK, developers can easily create, sign, and submit messages to the blockchain to perform various actions, such as transferring tokens, voting on proposals, and more.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
