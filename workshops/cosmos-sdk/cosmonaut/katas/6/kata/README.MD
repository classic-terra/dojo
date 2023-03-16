# Path of the Cosmonaut - Interchain Accounts

This training exercise is a **cosmonaut-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

To transfer digital assets between different chains in the Cosmos ecosystem we have to use something called an `interchain account`, which is a type of account that can be used to hold digital assets on one chain and transfer them to another chain in the Cosmos network. This is accomplished through the use of an intermediate account, called a `relay account`, which acts as a bridge between the two chains. The `relay account` is responsible for receiving the assets on one chain and then transferring them to the user's `interchain account` on another chain.

`Interchain accounts` are designed to be interoperable, meaning that they can be used across different chains in the Cosmos network. This allows users to move their digital assets freely between different chains, without having to worry about the underlying technical details of each chain.

To use `interchain accounts` in Cosmos SDK, developers must first enable the `IBC` (Inter-Blockchain Communication) module in their application. They can then create interchain accounts by implementing the `Relayer` interface and defining the necessary functions for sending and receiving interchain transfers.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata6
cd kata6
```

## Conclusion

Overall, `interchain accounts` represent an important step forward for the Cosmos ecosystem, as they make it easier for users to transfer digital assets between different chains in a secure and interoperable manner.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
