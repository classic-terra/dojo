# Path of the Journeyman - Keepers > Genesis

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the context of blockchain technology, the term "genesis" refers to the initial state of a blockchain network when it is first created.

The genesis state of the Cosmos SDK includes a set of initial parameters that define the basic configuration of the blockchain network, including:

* `genesis_time`: The time at which the network was created.
* `chain_id`: A unique identifier for the network.
* `consensus_params`: Parameters that define the rules for validating transactions on the network.
* `app_state`: The initial state of the application, including the accounts and validators that are present at the genesis block.
* `staking`: Parameters that define the rules for staking on the network.

The `app_state` is particularly important, as it contains the initial state of the application and all of its components. This includes the initial set of accounts and validators, as well as any other data structures defined by the application.

Developers can customize the genesis state of their blockchain network by modifying these parameters to fit the specific needs of their application. For example, they can adjust the staking parameters to change the rewards for validators, or add additional parameters to the app_state object to define new types of data structures.

Overall, the genesis state of the Cosmos SDK serves as the foundation for the entire blockchain network, and developers must carefully consider the initial configuration of their network to ensure that it is secure, stable, and capable of supporting their intended use cases.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata6
cd kata6
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
