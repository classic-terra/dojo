# Path of the Apprentice - Transactions

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Keybase](https://keybase.io/docs/the_app/install_linux)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Cosmos SDK is a framework for building blockchain applications. Transactions are the basic building blocks of any blockchain system, and they play a crucial role in the functioning of Cosmos SDK.

In Cosmos SDK, a transaction is a message that is sent from one account to another account. A transaction can contain multiple messages, each of which specifies an action that is to be executed on the blockchain. For example, a message might instruct the blockchain to transfer tokens from one account to another account, or it might instruct the blockchain to create a new smart contract.

Each transaction is signed using the private key of the account that initiated the transaction. This ensures that only the owner of the account can authorize the transaction. When a transaction is received by the blockchain, it is validated to ensure that it meets certain criteria. For example, the transaction might be checked to ensure that the sender has sufficient funds to cover the transaction fee.

Once a transaction is validated, it is added to a pool of pending transactions. These transactions are then processed by validators who compete to add them to the next block in the blockchain. Validators are rewarded for adding transactions to the blockchain, which helps to incentivize them to participate in the network.

In summary, transactions in Cosmos SDK are messages that specify actions to be executed on the blockchain. They are signed by the sender's private key, validated by the network, and processed by validators who compete to add them to the blockchain. Transactions are an essential component of the Cosmos SDK architecture, as they enable a wide range of blockchain applications to be built on top of the framework.

## Exercise

This `training step` we will learn how to build a simple `Go` program to demonstrate how we can create a transactions to send tokens from one account to another using the Cosmos SDK.

**Note**: this `training step` assumes that you have set up a working Cosmos SDK node and configured the SDK client accordingly. Additionally, you will need to import the appropriate SDK modules and define the token type and decimal places for your specific blockchain network in order for this to be used in production.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata2
cd kata2
```

### Step #2: Initialize `Go` module

Then we want to initialize a new `Go` module, add required package redirects and fetch `Cosmos SDK v0.45.12`:

```bash
go mod init transactions
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12
```

Here is a step-by-step breakdown of what each command does:

`go mod init transactions` initializes a new Go module named `transactions`. This command creates a `go.mod` file in the current directory that contains metadata about the module and its dependencies.

`go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0` adds a package redirect to the `go.mod` file. This command replaces any occurrence of the package `github.com/99designs/keyring` with `github.com/cosmos/keyring@v1.2.0`. Package redirects can be used to override the default version of a package that is fetched by `Go` modules.

`go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2` adds another package redirect to the `go.mod` file. This command replaces any occurrence of the package `github.com/dgrijalva/jwt-go` with `github.com/golang-jwt/jwt/v4@v4.4.2`.

`go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0` adds a package redirect for `github.com/gin-gonic/gin`. This command replaces any occurrence of the package `github.com/gin-gonic/gin` with `github.com/gin-gonic/gin@v1.7.0`.

`go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1` adds a package redirect for `github.com/gogo/`protobuf``. This command replaces any occurrence of the package `github.com/gogo/`protobuf`` with `github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1`.

`go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0` adds a package redirect for `github.com/jhump/protoreflect`. This command replaces any occurrence of the package `github.com/jhump/protoreflect` with `github.com/jhump/protoreflect@v1.9.0`.

`go get github.com/cosmos/cosmos-sdk@v0.45.12` fetches a specific version of the Cosmos SDK (v0.45.12) and adds it as a dependency to the `go.mod` file.

Overall, these commands are used to set up a Go module with the necessary dependencies, including package redirects that ensure that the correct version of each package is used.

### Step #3: Create a file called `main.go`

Now we have to create a file for our program:

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

Here is a brief description of each package that is being imported:

- `context` is a standard Go package for working with context objects.

- `fmt` is a standard Go package for formatting and printing text.

- `os` is a standard Go package for working with the operating system.

- `github.com/cosmos/cosmos-sdk/client` provides functionality for creating and interacting with a Cosmos SDK client.

- `github.com/cosmos/cosmos-sdk/client/tx` provides functionality for constructing and sending transactions.

- `github.com/cosmos/cosmos-sdk/crypto/hd` provides functionality for working with hierarchical deterministic (HD) keys.

- `github.com/cosmos/cosmos-sdk/crypto/keyring` provides functionality for working with a keyring, which is a collection of keys that can be used to sign transactions.

- `github.com/cosmos/cosmos-sdk/testutil/testdata` provides test data for use in Cosmos SDK tests.

- `github.com/cosmos/cosmos-sdk/simapp` provides a simulated Cosmos SDK application for testing.

- `github.com/cosmos/cosmos-sdk/types` provides types and interfaces that are used throughout the Cosmos SDK.

- `github.com/cosmos/cosmos-sdk/types/tx/signing` provides functionality for signing transactions.

- `github.com/cosmos/cosmos-sdk/x/bank/types` provides types for working with the bank module in the Cosmos SDK.

By importing these packages, the `Go` program gains access to the necessary functionality to complete the training step.

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

- `WithBroadcastMode("block")`: Set the broadcast mode used for sending transactions to the node. In this case, we are waiting for the transaction to be included in a block before returning.

### Step #9: Initialize transaction builder

With the Cosmos SDK client context fully configured and ready for use we can leverages its `TxConfig` property to initialize the `TxBuilder` we need to compose the transaction `message envelope` required for broadcasting our messages, including adding metadata such `fees`, `gaslimit` and a `memo`:

```go
// Create a new transaction builder
txBuilder := clientCtx.TxConfig.NewTxBuilder()
txBuilder.SetFeeAmount(sdk.NewCoins(sdk.NewInt64Coin("uluna", 100000)))
txBuilder.SetGasLimit(200000)
txBuilder.SetMemo("test transaction")
```

### Step #10: Create message for transaction

Finally we have to create the message(s) that we want to put in our `message envelope` (transaction) and add metadata supported by the `bankTypes.MsgSend` struct, such as `sender`, `recipient` and `amount`:

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

// Create a new message to send funds to the recipient
msg := &bankTypes.MsgSend{
	FromAddress: fromAddr.String(),
	ToAddress:   toAddr.String(),
	Amount:      sdk.NewCoins(sdk.NewInt64Coin("uluna", 50000000)),
}
if err := msg.ValidateBasic(); err != nil {
	fmt.Printf("failed to validate message: %s", err.Error())
	os.Exit(1)
}

// Add the message to the transaction
err = txBuilder.SetMsgs(msg)
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
./transactions
```

## Conclusion

In this `training step`, we learned how to set up the SDK client and define the sender and recipient addresses. We then created a transaction and added a`bank.MsgSend` instance, which defines an amount to transfer from the sender to the recipient.

To wrap it all up we signed and broadcasted the transaction using the SDK client. We encoded the transaction message using the client's `TxEncoder` function, and then broadcasted the transaction using the clients `BroadcastTx` function.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
