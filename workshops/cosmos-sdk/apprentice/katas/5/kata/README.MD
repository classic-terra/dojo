# Path of the Apprentice - Modules

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Cosmos SDK is a framework for building blockchain applications that enables developers to create custom modules to handle various functionalities of their blockchain. A module in Cosmos SDK is a self-contained unit of code that encapsulates a specific set of functionalities, such as handling account balances, executing transactions, or managing staking and governance.

Cosmos SDK provides several built-in modules that are commonly needed for building blockchain applications:

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

In addition to these built-in modules, Cosmos SDK also allows developers to create their own custom modules tailored to their specific use case. For example, a developer could create a module for a decentralized exchange, a prediction market, or a decentralized storage system.

Each module in Cosmos SDK defines a set of APIs that can be used by other modules or external applications to interact with its functionalities. These APIs are implemented using the Go programming language and are exposed through a gRPC interface, which enables communication between modules running on different nodes of the blockchain network.

Overall, modules in Cosmos SDK provide a modular and extensible architecture for building blockchain applications, allowing developers to easily add new functionalities or customize existing ones without compromising the overall system's security and reliability.

## Exercise

In this `training step` we will learn how to implement a simple Cosmos SDK module. The module will be responsible for managing the state of a fictitious supply chain, including adding new products and retrieving information about existing products as they move through the supply chain.

**Note**: this `training step` is the first exercise to use multiple package definitions in the code samples, abstractly the `Go` keyword `package` is just a "namespacing technique" that allow developers to partition their codebase, in order to manage applications as they grow in size. Its important to understand that co-located `*.go` files who share the same `package` will automatically be linked by the `Go` compiler, however if you want to use any other package you will need to reference them via an import statement, e.g. `modules/x/simple/types`.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata5
cd kata5
```

### Step 2: Create `protobuf` message contract

Before we can begin implementing our `Go` code program we first have to create the `protobuf` message contract we need for our `SimpleKeeper` to persist data to its underlying `KVStore`. One thing to keep in mind here is the Cosmos SDK uses a customized version of the `protobuf` tooling so we will need to go through a few "knee-jerk-exercises" to get our `Product` message contract off the ground. First we have to create a directory structure for our `*.proto` files:

```bash
mkdir proto && cd proto && mkdir modules && cd modules && mkdir simple && cd simple
```

Then we create a new file called `product.proto` inside the `simple` directory:

```bash
cat > product.proto
```

And proceed to fill in our `Product message contract`:

```text
syntax = "proto3";
package modules;

import "gogoproto/gogo.proto";

option go_package = "modules/x/simple/types";

message Product {
  string identifier = 1;
  string name = 2;
  string description = 3;
}
```

To prepare for the next step we return to the root of the `kata5` directory:

```bash
cd ../../../
```

### Step 3: Setup `Buf` configuration files

`Buf` is a tool for `protobuf` that simplifies the use of the complex `protoc` toolchain, along with other features that ensure adherence to the majority of the ecosystem's `protobuf` usage conventions. In this `training step` we will not go in-depth with how to use `Buf`, more information can be found [here](https://docs.cosmos.network/main/tooling/`protobuf`). For now we will simply proceed to add the required configuration files to our `toolchain` so we can get to the fun stuff, we start by creating a bunch of config files:

```bash
cat > buf.work.yaml
cat > proto/buf.yaml
cat > proto/buf.gen.gogo.yaml
cat > proto/buf.lock
```

Then we fill out `buf.work.yaml`:

```text
version: v1
directories:
  - proto
```

And `buf.yaml`:

```text
version: v1
plugins:
  - name: gocosmos
    out: ..
    opt: plugins=grpc,Mgoogle/`protobuf`/any.proto=github.com/cosmos/cosmos-sdk/codec/types
  - name: grpc-gateway
    out: ..
    opt: logtostderr=true,allow_colon_final_segments=true
```

And `buf.gen.gogo.yaml`:

```text
version: v1

deps:
    - buf.build/cosmos/cosmos-sdk
    - buf.build/cosmos/cosmos-proto
    - buf.build/cosmos/gogo-proto
    - buf.build/googleapis/googleapis
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
    - FILE_LOWER_SNAKE_CASE
    - MESSAGE_PASCAL_CASE
    - RPC_PASCAL_CASE
    - SERVICE_PASCAL_CASE
  except:
    - UNARY_RPC
    - SERVICE_SUFFIX
    - PACKAGE_VERSION_SUFFIX
    - RPC_REQUEST_STANDARD_NAME
    - RPC_RESPONSE_STANDARD_NAME
    - ENUM_ZERO_VALUE_SUFFIX
    - ENUM_VALUE_PREFIX
```

And finally `buf.lock`:

```text
version: v1
deps:
  - remote: buf.build
    owner: cosmos
    repository: cosmos-proto
    commit: 1935555c206d4afb9e94615dfd0fad31
  - remote: buf.build
    owner: cosmos
    repository: cosmos-sdk
    commit: 65ea24d045c846028b0c1b8d8723a29c
  - remote: buf.build
    owner: cosmos
    repository: gogo-proto
    commit: 34d970b699f84aa382f3c29773a60836
  - remote: buf.build
    owner: googleapis
    repository: googleapis
    commit: 75b4300737fb4efca0831636be94e517
```

### Step 4: Create `makefile` for Cosmos SDK docker tooling

For the last piece of plumbing in our `toolchain` we need to setup a simple `makefile` to run the Cosmos SDK docker tooling:

```text
DOCKER := $(shell which docker)
CONTAINER_PROTO_VER=v0.7
CONTAINER_PROTO_IMAGE=tendermintdev/sdk-proto-gen:$(CONTAINER_PROTO_VER)
CONTAINER_PROTO_FMT=cosmos-sdk-proto-fmt-$(CONTAINER_PROTO_VER)

proto-all: proto-gen

proto-gen:
	@echo "Generating `protobuf` files"
	"$(DOCKER)" run --rm -v $(CURDIR):/workspace --workdir /workspace $(CONTAINER_PROTO_IMAGE) sh ./scripts/protocgen.sh

.PHONY: proto-gen
```

Then we create a shell script to manage the code generation process, like so:

```bash
mkdir scripts && cat > scripts/protocgen.sh
```

And complete it with some "bash magic":

```bash
#!/usr/bin/env sh

set -eo pipefail

# get protoc executions
go get github.com/regen-network/cosmos-proto/protoc-gen-gocosmos 2>/dev/null

echo "Generating gogo proto code"
cd proto
proto_dirs=$(find modules -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)
for dir in $proto_dirs; do
  for file in $(find "${dir}" -maxdepth 1 -name '*.proto'); do
    if grep go_package "$file" ; then
      buf generate --template buf.gen.gogo.yaml "$file"
    fi
  done
done

cd ..

# move proto files to the right places
cp -r modules/* ./
rm -rf modules
```

And voila, now our `toolchain` is complete and ready for use!

### Step #5: Initialize `Go` module

With our `toolchain`  in place we can begin the real fun by initialize a new `Go` module, adding the required `package redirects` and fetching `Cosmos SDK v0.45.12`

```bash
go mod init modules
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

### Step #6: Create a file called `module.go`

Next we create `module.go` to hold our `AppModule` logic:

```bash
cat > module.go
```

### Step #7: Implement `simple` module

Then we implement a barebones AppModule, which we will extend upon in the `Path of the Journeyman`:

```go
package simple

import (
	"encoding/json"
	"math/rand"
	"modules/x/simple/keeper"
	"modules/x/simple/types"

	"github.com/grpc-ecosystem/grpc-gateway/runtime"

	"github.com/gorilla/mux"
	"github.com/spf13/cobra"

	abci "github.com/tendermint/tendermint/abci/types"

	"github.com/cosmos/cosmos-sdk/client"
	"github.com/cosmos/cosmos-sdk/codec"
	codectypes "github.com/cosmos/cosmos-sdk/codec/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/module"
	simtypes "github.com/cosmos/cosmos-sdk/types/simulation"
)

var (
	_ module.AppModule           = AppModule{}
	_ module.AppModuleBasic      = AppModuleBasic{}
	_ module.AppModuleSimulation = AppModule{}
)

// AppModuleBasic defines the basic application module used by the simple module.
type AppModuleBasic struct {
	cdc codec.Codec
}

// Name returns the simple module's name
func (AppModuleBasic) Name() string {
	return types.ModuleName
}

// RegisterLegacyAminoCodec registers the module's types on the given LegacyAmino codec.
func (AppModuleBasic) RegisterLegacyAminoCodec(cdc *codec.LegacyAmino) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// RegisterInterfaces registers the module's interface types
func (b AppModuleBasic) RegisterInterfaces(registry codectypes.InterfaceRegistry) {
	registry.RegisterInterface("types.Product",
		(*types.Product)(nil),
		&types.Product{},
	)
}

// DefaultGenesis returns default genesis state as raw bytes for the module.
func (AppModuleBasic) DefaultGenesis(cdc codec.JSONCodec) json.RawMessage {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ValidateGenesis performs genesis state validation for the module.
func (AppModuleBasic) ValidateGenesis(cdc codec.JSONCodec, config client.TxEncodingConfig, bz json.RawMessage) error {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterRESTRoutes registers the REST routes for the module.
func (AppModuleBasic) RegisterRESTRoutes(clientCtx client.Context, rtr *mux.Router) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// RegisterGRPCGatewayRoutes registers the gRPC Gateway routes for the module.
func (AppModuleBasic) RegisterGRPCGatewayRoutes(clientCtx client.Context, mux *runtime.ServeMux) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// GetTxCmd returns the root tx command for the module.
func (AppModuleBasic) GetTxCmd() *cobra.Command {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// GetQueryCmd returns no root query command for the module.
func (AppModuleBasic) GetQueryCmd() *cobra.Command {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// AppModule implements an application module for the simple module.
type AppModule struct {
	AppModuleBasic

	keeper keeper.SimpleKeeper
}

// NewAppModule creates a new AppModule given a Codec (for serialization) and a Keeper (for db access)
func NewAppModule(cdc codec.Codec, keeper keeper.SimpleKeeper) AppModule {
	return AppModule{
		AppModuleBasic: AppModuleBasic{cdc},
		keeper:         keeper,
	}
}

// Name returns the module's name.
func (am AppModule) Name() string { return types.ModuleName }

// RegisterInvariants registers the module invariants.
func (AppModule) RegisterInvariants(_ sdk.InvariantRegistry) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// Route returns the message routing key for the module.
func (am AppModule) Route() sdk.Route {
	//We will show how to implement this logic in the Path of the Journeyman
	return sdk.NewRoute(am.Name(), nil)
}

// NewHandler returns an sdk.Handler for the module.
func (am AppModule) NewHandler() sdk.Handler {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// QuerierRoute returns the module's querier route name.
func (am AppModule) QuerierRoute() string { return am.Name() }

// LegacyQuerierHandler returns the module sdk.Querier.
func (am AppModule) LegacyQuerierHandler(legacyQuerierCdc *codec.LegacyAmino) sdk.Querier {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterServices registers module services.
func (am AppModule) RegisterServices(cfg module.Configurator) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// InitGenesis performs genesis initialization for the module. It returns
// no validator updates.
func (am AppModule) InitGenesis(ctx sdk.Context, cdc codec.JSONCodec, data json.RawMessage) []abci.ValidatorUpdate {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ExportGenesis returns the exported genesis state as raw bytes for the
// module.
func (am AppModule) ExportGenesis(ctx sdk.Context, cdc codec.JSONCodec) json.RawMessage {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ConsensusVersion implements AppModule/ConsensusVersion.
func (AppModule) ConsensusVersion() uint64 { return 1 }

// BeginBlock returns the begin blocker for the module.
func (am AppModule) BeginBlock(ctx sdk.Context, req abci.RequestBeginBlock) {}

// EndBlock returns the end blocker for the module.
func (am AppModule) EndBlock(ctx sdk.Context, _ abci.RequestEndBlock) []abci.ValidatorUpdate {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

//____________________________________________________________________________

// AppModuleSimulation functions used by sim operations in Cosmos SDK

// GenerateGenesisState creates a randomized GenState of the module.
func (AppModule) GenerateGenesisState(simState *module.SimulationState) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// ProposalContents returns all the distribution content functions used to
// simulate governance proposals.
func (am AppModule) ProposalContents(_ module.SimulationState) []simtypes.WeightedProposalContent {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RandomizedParams creates randomized distribution param changes for the simulator.
func (AppModule) RandomizedParams(r *rand.Rand) []simtypes.ParamChange {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterStoreDecoder registers a decoder for distribution module's types
func (am AppModule) RegisterStoreDecoder(sdr sdk.StoreDecoderRegistry) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// WeightedOperations returns the all the gov module operations with their respective weights.
func (am AppModule) WeightedOperations(simState module.SimulationState) []simtypes.WeightedOperation {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}
```

### Step #8: Create a file called `types.go`

With the module implemented we can create a file for the `custom types` it needs:

```bash
mkdir types && cat > types/types.go
```

### Step #9: Implement `custom types`

In the newly created `types.go` file we add some basic `custom types` & `functions` for our module:

```go
package types

const (
	// ModuleName is the module name of the simple module
	ModuleName = "simple"

	// StoreKey is the KVStore identifier for the simple module
	StoreKey = ModuleName

	// RouterKey is the message route for the simple module
	RouterKey = ModuleName

	// QuerierRoute is the querier route for the simple module
	QuerierRoute = ModuleName
)

var (
	// Keys for store prefixes
	ProductKey = []byte{0x01} // a key for a product
)

// GetProductKey - stored by *identifier* is used to marshal and unmarshal product identifiers
func GetProductKey(identifier string) []byte {
	return append(ProductKey, []byte(identifier)...)
}
```

### Step #10: Create a file called `keeper.go`

Then we proceed to implement the most critical piece of our module puzzle, the `SimpleKeeper`. To prepare for its implementation we create a new file named `keeper.go`:

```bash
mkdir keeper && cat > keeper/keeper.go
```

### Step #11: Implement basic `SimpleKeeper`

A modules `keeper` is responsible for managing the modules `state`. For our simple module you might define a new struct called `SimpleKeeper` that includes functions for adding and retrieving `Product` instances from the underlying `KVStore` that is used to persist the modules `state`:

```go
package keeper

//Define required imports
import (
	types "modules/x/simple/types"

	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

// SimpleKeeper is the keeper for our simple module
type SimpleKeeper struct {
	storeKey sdk.StoreKey
	cdc      codec.BinaryCodec
}

// Constructor for SimpleKeeper
func NewSimpleKeeper(storeKey sdk.StoreKey, cdc codec.BinaryCodec) SimpleKeeper {
	return SimpleKeeper{
		storeKey: storeKey,
		cdc:      cdc,
	}
}

// Add a product to SimpleKeeper
func (sk SimpleKeeper) AddProduct(ctx sdk.Context, product types.Product) {
	store := ctx.KVStore(sk.storeKey)
	bz := sk.cdc.MustMarshal(&product)
	store.Set(types.GetProductKey(product.Identifier), bz)
}

// Get a product from SimpleKeeper
func (sk SimpleKeeper) GetProduct(ctx sdk.Context, identifier string) types.Product {
	store := ctx.KVStore(sk.storeKey)
	key := types.GetProductKey(identifier)
	if !store.Has(key) {
		return types.Product{}
	}

	var product types.Product
	bz := store.Get(key)
	sk.cdc.MustUnmarshal(bz, &product)

	return product
}
```

The above code snippet defines a `SimpleKeeper` struct that is defined in a `Go` package named `keeper`. The package imports types from another module called `modules/x/simple/types`, as well as the `codec` and `sdk` packages from Cosmos SDK.

The `SimpleKeeper` struct has two fields: `storeKey` of type `.StoreKey`, which represents the key for the `keeper's KVStore`, and `cdc` of type `codec.BinaryCodec`, which represents the binary codec used to marshal and unmarshal data.

The constructor function, `NewSimpleKeeper`, takes two parameters: `storeKey` of type `sdk.StoreKey` and `cdc` of type `codec.BinaryCodec`, and returns a new instance of `SimpleKeeper`.

The `AddProduct` method adds a product to the `keeper's KVStore` by serializing the product object with the binary codec and storing it under a key generated by the product's `Identifier`.

The `GetProduct` method retrieves a product from the `keeper's KVStore` by deserializing the stored byte array with the binary codec and returning the resulting `Product` object. If no product with the given `identifier` exists in the `KVStore`, an empty product object is returned.

### Step #12: Create a file called `main.go`

To round off our `Go` coding session we create a file called `main.go` to utilize our new module:

```bash
cat > main.go
```

### Step #13: Implement simple program

Then we implement the program logic required to initialize a new instance of the modules `SimpleKeeper`, add a products to its `KVStore`, fetch it again via its identifier and print the information to the `console`:

```go
package main

import (
	"fmt"
	"modules/x/simple/keeper"
	"modules/x/simple/types"

	"github.com/cosmos/cosmos-sdk/codec"
	codectypes "github.com/cosmos/cosmos-sdk/codec/types"
	"github.com/cosmos/cosmos-sdk/store/rootmulti"
	storeTypes "github.com/cosmos/cosmos-sdk/store/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/tendermint/tendermint/libs/log"
	tmproto "github.com/tendermint/tendermint/proto/tendermint/types"
)

func main() {
	//Initialize new LevelDB
	db, err := sdk.NewLevelDB("modules_store", "./")

	if err != nil {
		fmt.Printf("Error creating new LevelDB: %v", err)
	}

	//Initialize new root multi store
	ms := rootmulti.NewStore(db, log.NewNopLogger())

	//Initialize new store key
	storeKey := sdk.NewKVStoreKey(types.StoreKey)

	//Mount IAVL store to root multi store for store key
	ms.MountStoreWithDB(storeKey, storeTypes.StoreTypeIAVL, db)
	ms.LoadLatestVersion()

	//Initialize new context with multi store and header height of 1
	ctx := sdk.NewContext(ms, tmproto.Header{Height: 1}, false, log.NewNopLogger())

	//Create new interface registry
	ir := codectypes.NewInterfaceRegistry()

	//Create new proto codec
	cdc := codec.NewProtoCodec(ir)

	//Initialize new keeper with store key and codex
	keeper := keeper.NewSimpleKeeper(storeKey, cdc)

	//Create new product instance
	newProduct := types.Product{
		Identifier:  "123",
		Name:        "Test",
		Description: "Test",
	}

	//Add product to keeper
	keeper.AddProduct(ctx, newProduct)

	//Get product from keeper
	storeProduct := keeper.GetProduct(ctx, "123")

	//Print product information
	fmt.Printf("Product Identifier: %s\n", storeProduct.Identifier)
	fmt.Printf("Product Name: %s\n", storeProduct.Name)
	fmt.Printf("Product Description: %s\n", storeProduct.Description)
}
```

Our `main` function creates a new `LevelDB` database and initializes a new `root multi store`. Then it initializes a `store key`, mounts an `IAVL store` to the `root multi store` for the `store key`, and loads the latest version of the store.

We then create a new instance of the `Product` struct from the `types` package, add it to the `SimpleKeeper` using the `AddProduct` method, retriev it using the `GetProduct` method, and prints its information to the `console` using `fmt.Printf`.

### Step #14: Run `make proto-gen`

Now we just have to use our `toolchain` to let the Cosmos SDK docker tooling do its thing and produce a `Product` struct that is compatible with our chosen `codec`:

```bash
make proto-gen
```

### Step #15: Run `go mod tidy`

To clean up our `dependency graph` and fetch any missing packages we have to run the `go mod tidy` command:

```bash
go mod tidy
```

### Step #16: Build executable

Build a new `Go` binary based on our custom module logic:

```bash
go build
```

### Step #17: Run executable

Lastly we can run our new `Go` program with the following command:

```bash
./modules
```

## Conclusion

A Cosmos SDK module is a self-contained packages of code that provides a specific set of functionality within a blockchain application. Each module is designed to be independent and can be combined with other modules to create custom blockchain applications.

The structure of a Cosmos SDK module typically includes the following components:

* `types`: This package defines the types used by the module, such as message types and state types.

* `keeper`: This package defines the module keeper, which is responsible for managing the state of the module on the blockchain.

* `querier`: This package defines the module querier, which is responsible for responding to queries about the state of the module.

* `msgs`: This package defines the module messages, which are used to interact with the module by creating transactions.

* `codec`: This package defines the codec used to encode and decode messages and state.

* `params`: This package defines the module parameters, which are configurable options for the module.

* `module.go`: This file defines the module structure, including its name, route, and dependencies.

* `genesis.go`: This file defines the module's initial state, which is used to bootstrap the module when the blockchain is initialized.

* `app.go`: This file initializes and configures the module keeper, and includes the module keeper as a dependency of the main application.

Cosmos SDK modules are designed to be flexible and extensible, allowing developers to add additional packages as needed to implement the specific functionality of the module. By following this structure, modules can be easily combined and reused to create custom blockchain applications with a wide range of functionality.

This `training step` completes the `Path of the Apprentice`, congratulations are in order if you made it this fare! In the next `learning path`, `Path of the Journeyman`, we will dive deeper into some of the more advance concepts of Cosmos SDK and extend on the knowledge we have gained on our journey thus fare, to build our very own blockchain application.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
