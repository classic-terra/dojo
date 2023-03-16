# Path of the Journeyman - Keepers > Types

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Cosmos SDK provides a set of tools and libraries for developers to build custom blockchain applications, which includes a number of built-in types that are used throughout the SDK:

* `Coin`: A struct representing a single coin, with a denomination and an amount.
* `Coins`: A slice of coin objects, representing a set of coins.
* `Int`: A struct representing a signed integer, used throughout the SDK for mathematical calculations.
* `Dec`: A struct representing a decimal number, used for precise mathematical calculations.
* `AccAddress`: A struct representing an account address, used to identify accounts on the blockchain.
* `ValAddress`: A struct representing a validator address, used to identify validators on the blockchain.
* `Context`: A struct representing the context in which a blockchain transaction is executed.
* `Msg`: An interface representing a message that can be sent as part of a transaction.
* `Result`: A struct representing the result of executing a blockchain transaction.
* `ModuleAccount`: A struct representing an account owned by a module on the blockchain.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata5
cd kata5
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
