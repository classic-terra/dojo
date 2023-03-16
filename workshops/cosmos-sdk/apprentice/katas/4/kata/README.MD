# Path of the Apprentice - Queries

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Cosmos SDK queries are a way to retrieve data from a blockchain network built using the Cosmos SDK. Cosmos SDK is a popular blockchain development framework that allows developers to build custom blockchain applications with their own set of rules and features.

In the context of Cosmos SDK, queries are used to fetch data from the blockchain's state. The blockchain state is a record of all the transactions that have taken place on the network, along with the current state of all the accounts and other data structures that are relevant to the network.

Queries in Cosmos SDK can be used to retrieve information about things like account balances, transaction history, and other data that is stored on the blockchain. Queries can be executed through various channels, including CLI commands, RESTful APIs, and web sockets.

There are several types of queries that can be executed using Cosmos SDK, including:

* `Account queries`: These queries allow you to retrieve information about a particular account on the blockchain, including the account balance, transaction history, and other details.

* `Validator queries`: These queries allow you to retrieve information about validators on the blockchain, including their voting power, commission rates, and other details.

* `Block queries`: These queries allow you to retrieve information about specific blocks on the blockchain, including the block height, hash, and other details.

* `Event queries`: These queries allow you to retrieve information about events that have taken place on the blockchain, including transaction events, validator events, and other types of events.

## Exercise

In this exercise we  will learn how to query the blockchain for specific Account using the `clientCtx.QueryWithData()` function and subsequently the `codec.UnmarshalInterface()` function to deserialize the query response to an instance of the `client.Account` interface.

**Note**: this `training step` assumes that you have set up a working Cosmos SDK node and configured the SDK client accordingly. Additionally, you will need to import the appropriate SDK modules and define the token type and decimal places for your specific blockchain network in order for this to be used in production.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata4
cd kata4
```

### Step #2: Initialize `Go` module

Now we want to initialize a new `Go` module, add required `package redirects` and fetch `Cosmos SDK v0.45.12`:

```bash
go mod init queries
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
	"github.com/cosmos/cosmos-sdk/simapp"
	sdk "github.com/cosmos/cosmos-sdk/types"
)
```

- `context` is used for managing context across API boundaries.
- `fmt` is used for formatting and printing output.
- `os` provides a platform-independent interface for interacting with the operating system.
- `github.com/cosmos/cosmos-sdk/client` contains modules to create and sign transactions for Cosmos SDK-based blockchains.
- `github.com/cosmos/cosmos-sdk/simapp` contains an example Cosmos SDK application for simulation testing.
- `github.com/cosmos/cosmos-sdk/types` contains the core data types for the Cosmos SDK.

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

### Step #7: Configure nodeClient & clientContext

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
	WithClient(nodeClient).
	WithChainID("columbus-5").
	WithSignModeStr("SIGN_MODE_UNSPECIFIED").
	WithBroadcastMode("block")
```

This code creates a new account in the keyring, which is a collection of keys that can be used to sign transactions. The account is created using the `NewAccount` method of a keyring object (kr) and the following parameters:

- `"localkey"`: The name of the account to create.

- `testdata.TestMnemonic`: The mnemonic phrase to use for generating the key.

- `keyring.DefaultBIP39Passphrase`: The passphrase to use for generating the key. This is the default passphrase used in the Cosmos SDK.

- `sdk.FullFundraiserPath`: The derivation path to use for generating the key. This path is used in the Cosmos SDK to generate keys for accounts in the fundraiser testnet.

- `hd.Secp256k1`: The cryptographic algorithm to use for generating the key. In this case, the key is generated using the secp256k1 elliptic curve.

### Step #8: QueryWithData and deserialize response

Finally we can prepare our query arguments and use the `clientCtx.QueryWithData()` function to query the blockchain for the address `terra13vs2znvhdcy948ejsh7p8p22j8l4n4y07062qq`, as follows:

```go
    // Create a address from a string
	queryAddr, err := sdk.AccAddressFromBech32("terra13vs2znvhdcy948ejsh7p8p22j8l4n4y07062qq")
	if err != nil {
		fmt.Printf("failed to parse recipient address: %s", err.Error())
		os.Exit(1)
	}

	// Query account information
	res, _, err := clientCtx.QueryWithData(fmt.Sprintf("custom/%s/%s/%s", "bank", "accounts", queryAddr.String()), nil)
	if err != nil {
		fmt.Printf("failed to query account: %s", err.Error())
		os.Exit(1)
	}

	// Unmarshal account information
	var account client.Account
	if err := encodingConfig.Marshaler.UnmarshalInterface(res, &account); err != nil {
		fmt.Printf("failed to unmarshal query: %s", err.Error())
		os.Exit(1)
	}

	// Print account information
	fmt.Printf("Account address: %s\n", account.GetAddress())
```

### Step #9: Run `go mod tidy`

To clean up our `dependency graph` and fetch any missing packages we have to run the `go mod tidy` command:

```bash
go mod tidy
```

### Step #10: Build executable

With our code kata finalized all that remains now is to build a new `Go` binary based on `main.go`:

```bash
go build
```

### Step #11: Run executable

Then we can run our new `Go` program with the following command:

```bash
./queries
```

## Conclusion

Queries are an important tool for blockchain developers who want to build applications that interact with the blockchain state. By using queries, developers can retrieve relevant data from the blockchain and use it to build powerful decentralized applications. The Cosmos SDK provides a variety of tools and APIs to make it easy to execute queries and retrieve data from the blockchain network.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
