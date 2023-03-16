# Path of the Journeyman - SimpleApp

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Now that we have mastered the basics of the `AnteHandler` & `BaseApp` we are ready to begin implementing our very own Cosmos SDK blockchain application. For this we need to implement a `SimpleApp` struct that acts as a surrogate for our custom `BaseApp` to enables us to wire together the different pieces of our blockchain application. At a high level the areas of responsibility that will be managed by our `SimpleApp` are as follow:

* `codec`: TODO @ Cosmos SDK codec.Codec

* `interface registry`: TODO @ Cosmos SDK sdk.InterfaceRegistry

* `params & subspaces`: TODO @ https://docs.cosmos.network/v0.45/modules/params/

* `module manager`: helps developers manage the modules in their blockchain application via a struct named `Manager`. `Manager` is a native Cosmos SDK type that provides a convenient way to add, remove, update and determine order-of-execution of modules in our blockchain application. This helps avoid `AppHash errors` and a very important thing to remember when dealing with the `module manager` is that any module instantiated in the module manager, which is later modified outside the `module manager` by our blockchain application, must be passed by reference upon `module registration` to help ensure the overall integrity of our `replicated state machine`. If you want to learn more about the `module manager` read the [official documentation](https://docs.cosmos.network/main/building-modules/module-manager)

* `module configurator`: provides hooks to allow nested modules to configure and register their services in the `RegisterServices` method. It is designed to eventually support module object capabilities isolation as described [here](https://github.com/cosmos/cosmos-sdk/issues/7093).

* `module permission`: TODO @ auth.PermissionsForAddress

## Exercise

[TEXT]

### Step #1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata3
cd kata3
```

### Step #2: TODO

TODO:

```go
type SimpleApp struct { // nolint: golint
	*baseapp.BaseApp
	keepers.AppKeepers

	legacyAmino       *codec.LegacyAmino
	appCodec          codec.Codec
	interfaceRegistry codectypes.InterfaceRegistry

	// the module manager
	mm *module.Manager

	// simulation manager
	sm *module.SimulationManager

	// the configurator
	configurator module.Configurator
}
```

Our `SimpleApp` struct contains several fields that are important for our blockchain application:

* `baseapp.BaseApp`: A pointer to a `BaseApp` struct, which is defined in our `baseapp` package. It represents the core functionality of our custom blockchain application.

* `keepers.AppKeepers`: A struct that contains references to all of the keepers. Module keepers are responsible for handling the state and business logic of individual modules within the blockchain application.

* `legacyAmino`: A pointer to a `LegacyAmino` struct, which is defined in the Cosmos SDK `codec` package. It is used to serialize and deserialize data in a backward-compatible way.

* `appCodec`: A codec that is used to serialize and deserialize application-specific data.

* `interfaceRegistry`: A registry that maps interface types to their concrete implementations. It is used to deserialize data into the appropriate `Go` types.

* `mm`: A pointer to a `Manager` struct that manages the application's modules, including their initialization and execution.

* `sm`: A pointer to a `SimulationManager` struct that manages the application's simulation environment.

* `configurator`: A struct that handles the configuration of the application's modules. It is responsible for setting up the initial state and parameters for each module.

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **Log an issue** or **request a new kata**. Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
