# Path of the Journeyman - BaseApp

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

At a high level, the `BaseApp` consists of several components, including the `AnteHandler`, `RouteHandler`, and `QueryRouter`. The `AnteHandler` is responsible for validating and modifying incoming transactions before they are processed by the application. It can perform tasks like verifying signatures, checking for account balances, and enforcing custom rules specific to the application. The `RouteHandler` is responsible for routing incoming transactions to the appropriate module based on their message type. This allows different modules to handle different types of transactions and reduces the complexity of the application. The `QueryRouter` is responsible for handling queries to the state. It allows clients to retrieve information from the blockchain, such as account balances or transaction history.

One of the key benefits of the `BaseApp` is its modular architecture. It allows developers to easily add and remove modules as needed, which can improve scalability and reduce complexity. Modules can be added to handle specific types of transactions, store data in a different format, or provide additional functionality to the application. For example, a module could be added to handle staking functionality or to support a new cryptocurrency.

To create a new `BaseApp` using the Cosmos SDK, developers define their application modules and implement the BaseApp interface. They then configure the modules and register them with the BaseApp, which handles the execution of transactions, state management, and event broadcasting.

Overall, the `Cosmos SDK BaseApp` provides a powerful foundation for building scalable and modular blockchain applications. It provides a set of modules and APIs that make it easy to build and execute transactions, manage state, and handle events in a modular way. By leveraging the BaseApp, developers can focus on building the core features of their application while relying on the SDK to handle the underlying blockchain functionality.

## Exercise

This `training step` teaches us how to implement a new `myApp` struct that extends the `baseapp.BaseApp` struct provided by the Cosmos SDK. We then implement a `NewMyApp` constructor method that sets up the application's modules (`bank`, `auth`, and `params`), initializes the application's state, and sets the `initChainer` function to be called during the initialization process.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata2
cd kata2
```

### Step 2: TODO

TODO:

```go
package main

import (
	"fmt"

	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth"
	"github.com/cosmos/cosmos-sdk/x/bank"
	"github.com/cosmos/cosmos-sdk/x/params"
	"github.com/tendermint/tendermint/libs/log"

	abci "github.com/tendermint/tendermint/abci/types"
	cmn "github.com/tendermint/tendermint/libs/common"
	dbm "github.com/tendermint/tm-db"
)

type myApp struct {
	*baseapp.BaseApp
}

func NewMyApp(logger log.Logger, db dbm.DB) *myApp {
	bApp := baseapp.NewBaseApp("myApp", logger, db)

	var app = &myApp{
		BaseApp: bApp,
	}

	// Define and register the application's modules
	app.Router().AddRoute("bank", bank.NewHandler())
	app.Router().AddRoute("auth", auth.NewHandler())
	app.Router().AddRoute("params", params.NewHandler())

	// Initialize the application's state
	app.MountStores(db)
	app.SetInitChainer(app.initChainer)

	err := app.LoadLatestVersion(app.KeyMain)
	if err != nil {
		cmn.Exit(fmt.Sprintf("Failed to load latest version: %v", err))
	}

	return app
}

func (app *myApp) initChainer(ctx sdk.Context, req abci.RequestInitChain) abci.ResponseInitChain {
	return abci.ResponseInitChain{}
}

func main() {
	logger := log.NewNopLogger()
	db := dbm.NewMemDB()

	app := NewMyApp(logger, db)

	if err := app.Run(); err != nil {
		cmn.Exit(err.Error())
	}
}
```

## Conclusion

In conclusion, the `BaseApp` is a powerful abstraction for building blockchain applications. It provides developers with a range of tools and components for creating custom modules, defining transactions, and managing state.

The `BaseApp` is built on top of the `Tendermint` consensus engine, which provides secure and reliable consensus for the blockchain. It is highly configurable and can be customized to suit the specific needs of almost any blockchain application by providing a flexible and modular architecture that allows developers to easily add new features and functionality to their applications.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
