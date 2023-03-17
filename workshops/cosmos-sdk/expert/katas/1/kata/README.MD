# Path of the Expert - Contexts

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

A context in Cosmos SDK refers to an object that contains information about the current state of the blockchain which is passed to various modules and functions as they execute. It contains a number of important properties that help support module and function "internals":

* `BlockHeight`: This is the height of the current block being processed.
* `BlockTime`: This is the time at which the current block was created.
* `TxBytes`: This is the size of the transaction being processed.
* `Logger`: This is a logger object that can be used to log messages during execution.
* `ChainID`: This is the ID of the current blockchain.
* `MinimumGasPrices`: This is the minimum gas price required for a transaction to be processed.
* `GasMeter`: This is an object that tracks the amount of gas used during execution.
* `CoinType`: This is the type of cryptocurrency being used in the blockchain.

Contexts are important because they allow different modules to access and update information about the current state of the blockchain in a consistent and secure manner. They also help ensure that transactions are processed correctly by providing information about gas usage and minimum gas prices.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata1
cd kata1
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
