# Path of the Journeyman - Keepers

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the Cosmos SDK, Keepers are modules that are responsible for maintaining the state of a blockchain network. They are essentially the operational logic behind the blockchain's functionality. Keepers are responsible for executing certain tasks that require access to the blockchain's state, such as validating transactions, updating account balances, and performing other system-level tasks.

Keepers are designed to be modular, meaning that developers can create custom Keepers to add new functionality to the blockchain network. For example, a developer might create a Keeper that performs automated market-making on a decentralized exchange, or a Keeper that verifies the identity of users on the network.

Keepers are implemented using the SDK's module architecture. Each module contains a set of Keepers that handle a specific aspect of the module's functionality. These Keepers are responsible for managing the state of the module and executing any necessary operations.

Overall, Keepers are an essential part of the Cosmos SDK's design, as they allow developers to easily extend the functionality of the network and customize it to meet their specific needs.

## Exercise

In this `training step`, we will learn how to implement a simple keeper that manages a list of string links, and provides a function for getting/adding new links to the list.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata4
cd kata4
```

### Step 2: Initialize new `Go` module

Now we have to initialize a new `Go` module for our keeper using the `go mod` command:

```bash
go mod init linkkeeper
```

### Step 3: Define keeper interface

Create a new file called `keeper.go` in your module directory with the following code:

```go
package linkkeeper

import (
    "github.com/cosmos/cosmos-sdk/codec"
    sdk "github.com/cosmos/cosmos-sdk/types"
    sdkerrors "github.com/cosmos/cosmos-sdk/types/errors"
)

type LinkKeeper interface {
    GetLink(ctx sdk.Context, key []byte) (Link, error)
    SetLink(ctx sdk.Context, key []byte, link Link) error
}
```

### Step 4: Define Link struct

With the new interface in place we then have to provide an `implementation` for the `Link` struct used in the `GetLink(ctx sdk.Context, key []byte) (string, error)` and `SetLink(ctx sdk.Context, key []byte, link string) error` methods:

```go
type Link struct {
    Link string `json:"link"`
}
```

### Step 5: Implement keeper interface

We can then commence to provide an `implementation` of `LinkKeeper` the the can be registered in our `LinkModule` module:

```go
type LinkKeeperImpl struct {
    storeKey  sdk.StoreKey
    cdc       codec.BinaryMarshaler
}

var _ LinkKeeper = LinkKeeperImpl{}       // Verify that LinkKeeperImpl implements LinkKeeper.
var _ LinkKeeper = (*LinkKeeperImpl)(nil) // Verify that *LinkKeeperImpl implements LinkKeeper.
```

### Step 5: Implement keeper methods

Once we have the basic plumbing for our new `LinkKeeperImpl` in place we can proceed to finalize the keeper by adding support for the `LinkKeeper` interface methods:

```go
func (k LinkKeeperImpl) GetLink(ctx sdk.Context, key []byte) (Link, error) {
    store := ctx.KVStore(k.storeKey)

    if !store.Has(key) {
        return Link{}, sdkerrors.ErrKeyNotFound
    }

    bz := store.Get(key)

    var link Link
    err := k.cdc.UnmarshalBinaryBare(bz, &link)
    if err != nil {
        return Link{}, err
    }

    return link, nil
}

func (k LinkKeeperImpl) SetLink(ctx sdk.Context, key []byte, link Link) error {
    store := ctx.KVStore(k.storeKey)

    bz := k.cdc.MustMarshalBinaryBare(&link)
    store.Set(key, bz)

    return nil
}
```

### Step 5: Register keeper in module

Create a new file called `module.go` in your module directory with the following code:

```go
package linkkeeper

import (
    "github.com/cosmos/cosmos-sdk/codec"
    sdk "github.com/cosmos/cosmos-sdk/types"
    sdkerrors "github.com/cosmos/cosmos-sdk/types/errors"
)

func NewKeeper(cdc codec.BinaryMarshaler, storeKey sdk.StoreKey) LinkKeeper {
    return LinkKeeperImpl{
        storeKey: storeKey,
        cdc:      cdc,
    }
}

type LinkModule struct {
    keeper LinkKeeper
}

func NewModule(keeper LinkKeeper) LinkModule {
    return LinkModule{
        keeper: keeper,
    }
}

func (m LinkModule) RegisterInvariants(ir sdk.InvariantRegistry) {
    // Register module invariants here
}

func (m LinkModule) Route() sdk.Route {
    // Define module routes here
}

func (m LinkModule) QuerierRoute() string {
    // Define module querier route here
}

func (m LinkModule) LegacyQuerierHandler() sdk.Querier {
    // Define legacy module querier handler here
}
```

This allows us to register our custom keeper in a way  that makes it easy to consume in the following step when we implement a simple `test app` to try it out!

### Step 6: Create simple `test app`

Implement a simple program to test out the functionality in our new custom keeper to verify that it works as intended:

```go
package linkkeeper

import (
    "fmt"

    "github.com/cosmos/cosmos-sdk/codec"
    "github.com/cosmos/cosmos-sdk/server"
    "github.com/cosmos/cosmos-sdk/simapp"
)

func main() {
    // Define your codec
    cdc := codec.New()

    // Define your store key
    storeKey := sdk.NewKVStoreKey("my-store")

    // Create a new store
    db, err := sdk.NewLevelDB("my-db", "/path/to/db")
    if err != nil {
        panic(err)
    }

    defer db.Close()

    store := store.NewCommitMultiStore(db)
    store.MountStoreWithDB(storeKey, sdk.StoreTypeIAVL, db)
    store.LoadLatestVersion()

    // Create a new keeper
    linkKeeper := NewKeeper(cdc, storeKey)

    // Create a new module
    linkModule := NewModule(linkKeeper)

    // Use the module methods as needed
    link := "www.link.com"

    key := []byte("my-key")

    err := linkModule.keeper.SetLink(ctx, key, link)
    if err != nil {
        panic(err)
    }

    result, err := linkModule.keeper.GetLink(ctx, key)
    if err != nil {
        panic(err)
    }

    fmt.Printf("Result: %+v\n", result)
}
```

### Step #7: Build executable

Build a new `Go` binary based on `main.go`:

```bash
go build
```

### Step #8: Run executable

Lastly we can run our new `Go` program with the following command:

```bash
./main
```

## Conclusion

In this `training step` we learned how to create a default codec and simple store key, which in turn allowed us to `mount` a store with `LevelDb` to enable us to persist data passed to our code. Then we created a new LinkKeeper instance using the codec and store key as parameters for the `NewKeeper(cdc codec.BinaryMarshaler, storeKey sdk.StoreKey) LinkKeeper` function, which acts like a `factory method`. With our newly minted LinkKeeper instance in hand we then proceed to use the SetLink and GetLink methods of the LinkKeeper instance to store and retrieve string data from `LevelDb`.

**Note**: in a real-world application, you would need to define additional methods and implement them in the `LinkKeeperImpl` struct. Including definining additional routes, queries, and handlers in the `LinkModule` struct.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
