# Path of the Apprentice - Modules

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

`Cosmos SDK` is a framework for building blockchain applications that enables developers to create custom modules to handle various functionalities of their blockchain. A module in `Cosmos SDK` is a self-contained unit of code that encapsulates a specific set of functionalities, such as handling account balances, executing transactions, or managing staking and governance.

`Cosmos SDK` provides several built-in modules that are commonly needed for building blockchain applications:

* `Auth`: This module is responsible for managing user authentication and authorization. It allows users to sign transactions and verify their identity, as well as manage access control to the blockchain's resources.

* `Bank`: This module handles the transfer of tokens between accounts within the blockchain. It manages the account balances and supports various types of transactions, such as sending tokens from one account to another or burning tokens.

* `Staking`: This module manages the delegation of tokens to validators, who participate in block production and earn rewards in return. It handles the staking process, including validator registration, delegation, and slashing.

* `Distribution`: This module distributes rewards to validators and delegators according to their contribution to the network. It calculates and distributes rewards based on the voting power of each stakeholder.

* `Governance`: This module enables users to propose and vote on changes to the blockchain's parameters, such as fees, block size, or validator set. It manages the proposal and voting process, including the submission of proposals, the voting period, and the execution of approved proposals.

* `Slashing`: This module is responsible for punishing validators who act maliciously or fail to follow the protocol. It detects and punishes validators who double-sign or miss blocks, reducing their staked tokens and removing them from the validator set.

* `Vesting`: This module allows users to vest their tokens over a period of time. It creates vesting accounts that release tokens gradually, according to a predetermined schedule.

* `Mint`: This module is responsible for issuing new tokens into circulation. It manages the creation of new tokens and distributes them to the appropriate accounts.

* `Crisis`: This module is designed to handle emergency situations, such as a network outage or a critical bug in the code. It provides a mechanism for halting the blockchain in the event of a crisis and triggering a recovery process.

* `Params`: This module manages the blockchain's global parameters, such as the block time, maximum transaction size, and minimum stake requirements. It provides a way for administrators to modify these parameters without requiring a hard fork.

* `Evidence`: This module is responsible for handling evidence of misbehavior by validators. It allows users to submit evidence of double-signing or other malicious behavior and triggers the slashing of the offending validator.

In addition to these built-in modules, `Cosmos SDK` also allows developers to create their own custom modules tailored to their specific use case. For example, a developer could create a module for a decentralized exchange, a prediction market, or a decentralized storage system.

Each module in `Cosmos SDK` defines a set of APIs that can be used by other modules or external applications to interact with its functionalities. These APIs are implemented using the Go programming language and are exposed through a gRPC interface, which enables communication between modules running on different nodes of the blockchain network.

Overall, modules in `Cosmos SDK` provide a modular and extensible architecture for building blockchain applications, allowing developers to easily add new functionalities or customize existing ones without compromising the overall system's security and reliability.

## Exercise

In this `training step` we will learn how to implement a simple supply chain module. This module is responsible for managing the state of our supply chain, including adding new products to the chain, retrieving information about existing products, and updating the status of products as they move through the supply chain.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata5
cd kata5
```

### Step #2: Initialize go module

Now we want to initialize a new `Go` module, add required `package redirects` and fetch `Cosmos SDK v0.45.12`

```bash
go mod init example.com/modules
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/protobuf=github.com/regen-network/protobuf@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12
```

### Step #3: Create a file called `types.go`

With our `Go` module initialized we can create a file for `custom types` used in our `module`:

```bash
cat > types.go
```

### Step 4: Implement a required `custom types`

In the newly created `types.go` file we define two new `custom types` named `Product` & `AddProductMsg`:

```go
package main

import (
    "github.com/cosmos/cosmos-sdk/types"
)

type Product struct {
    ID          uint64         `json:"id"`
    Name        string         `json:"name"`
    Description string         `json:"description"`
    Owner       types.AccAddress `json:"owner"`
    History     []string       `json:"history"`
}

type AddProductMsg struct {
    //TODO: Implement AddProductMsg
}
```

### Step #5: Create a file called `messagehandlers.go`

Next we have to create a file for the `message handler` named `SupplyChainHandler`, which handles `AddProductMsg` messages:

```bash
cat > messagehandlers.go
```

### Step 6: Implement `SupplyChainHandler` for `AddProductMsg` messages

Open up the new file and implement the `SupplyChainHandler` to handle `AddProductMsg` messages sent from clients to the `SupplyChainKeeper`:

```go
package main

import (
    "github.com/cosmos/cosmos-sdk/codec"
    "github.com/cosmos/cosmos-sdk/types"
)

// Message handler for SupplyChainKeeper
type SupplyChainHandler struct {
    keeper SupplyChainKeeper
}

// Constructor for SupplyChainHandler
func NewSupplyChainHandler(keeper SupplyChainKeeper) SupplyChainHandler {
    return SupplyChainHandler{keeper: keeper}
}

// Implement message handler for AddProductMsg messages
func (h SupplyChainHandler) AddProductMsg(ctx types.Context, msg AddProductMsg) (types.Result, error) {
    product := Product{
        Name: msg.Name,
        ID:   msg.ID,
    }

    h.keeper.AddProduct(ctx, product)

    return types.NewResult(types.CodeOK, "product added"), nil
}
```

### Step #7: Create a file called `keeper.go`

The last piece of our supply chain module is the `keeper`. To prepare for its implementation we create a new file named `keeper.go`:

```bash
cat > keeper.go
```


### Step #8: Implement basic `SupplyChainKeeper`

The module `keeper` is responsible for managing the module's state. For our supply chain module you might define a new struct called `SupplyChainKeeper` that includes functions for adding and retrieving `Product` instances, as follows:

```go
package main

import (
    "github.com/cosmos/cosmos-sdk/codec"
    "github.com/cosmos/cosmos-sdk/types"
)

// SupplyChainKeeper struct
type SupplyChainKeeper struct {
    storeKey types.StoreKey
    cdc      *codec.Codec
}

// Constructor for SupplyChainKeeper
func NewSupplyChainKeeper(storeKey types.StoreKey, cdc *codec.Codec) SupplyChainKeeper {
    return SupplyChainKeeper{
        storeKey: storeKey,
        cdc:      cdc,
    }
}

// Add product to our SupplyChainKeeper KVStore
func (sk SupplyChainKeeper) AddProduct(ctx types.Context, product Product) {
    store := ctx.KVStore(sk.storeKey)
    bz := sk.cdc.MustMarshalBinaryLengthPrefixed(product)
    store.Set(product.ID, bz)
}

// Get product from our SupplyChainKeeper KVStore
func (sk SupplyChainKeeper) GetProduct(ctx types.Context, id types.HexBytes) (Product, bool) {
    store := ctx.KVStore(sk.storeKey)
    if !store.Has(id) {
        return Product{}, false
    }

    var product Product
    bz := store.Get(id)
    sk.cdc.MustUnmarshalBinaryLengthPrefixed(bz, &product)

    return product, true
}
```

### Step #9: Create a file called `main.go`

Finally we can put the puzzle together by creating a simple program to consume our new module and enable us to try out the new `SupplyChainKeeper`:

```bash
cat > main.go
```

### Step 10: Implement simple program

Initialize a new instance of our SupplyChainKeeper in the `main.go` file, add a few products to its KVStore and fetch the `Product` with id `123`:

```go
package main

import (
    "fmt"
    "os"

    "github.com/cosmos/cosmos-sdk/codec"
    "github.com/cosmos/cosmos-sdk/server"
    "github.com/cosmos/cosmos-sdk/simapp"
)

func main() {
    //Get simapp encoding configuration
    encodingConfig := simapp.MakeTestEncodingConfig()

    //Initialize new supplychain keeper    
    var storeKey types.StoreKey = nil //TODO: Initalize storekey
    supplyChainKeeper := NewSupplyChainKeeper(storeKey, encodingConfig.Marshaler)
    
    app := simapp.NewSimApp(
        logger, db, nil, true, map[int64]bool{},
        simapp.DefaultNodeHome, supplyChainKeeper,
    )

    server.Main(app)

    //TODO: Add products

    product, err := supplyChainKeeper.GetProduct(ctx, "123")
    if err != nil {
	    fmt.Printf("failed to get Product: %s", err.Error())
	    os.Exit(1)
    }

	fmt.Printf("Product information: %s\n", product)
}
```
### Step #11: Run `go mod tidy`

To clean up our `dependency graph` and fetch any missing packages we have to run the `go mod tidy` command:

```bash
go mod tidy
```

### Step #12: Build executable

Build a new `Go` binary based on our custom module logic:

```bash
go build
```

### Step #13: Run executable

Lastly we can run our new `Go` program with the following command:

```bash
./modules
```

## Conclusion

A `Cosmos SDK` module is a self-contained packages of code that provides a specific set of functionality within a blockchain application. Each module is designed to be independent and can be combined with other modules to create custom blockchain applications.

The structure of a `Cosmos SDK` module typically includes the following components:

* `types`: This package defines the types used by the module, such as message types and state types.

* `keeper`: This package defines the module keeper, which is responsible for managing the state of the module on the blockchain.

* `querier`: This package defines the module querier, which is responsible for responding to queries about the state of the module.

* `msgs`: This package defines the module messages, which are used to interact with the module by creating transactions.

* `codec`: This package defines the codec used to encode and decode messages and state.

* `params`: This package defines the module parameters, which are configurable options for the module.

* `module.go`: This file defines the module structure, including its name, route, and dependencies.

* `genesis.go`: This file defines the module's initial state, which is used to bootstrap the module when the blockchain is initialized.

* `app.go`: This file initializes and configures the module keeper, and includes the module keeper as a dependency of the main application.

`Cosmos SDK` modules are designed to be flexible and extensible, allowing developers to add additional packages as needed to implement the specific functionality of the module. By following this structure, modules can be easily combined and reused to create custom blockchain applications with a wide range of functionality.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues)
