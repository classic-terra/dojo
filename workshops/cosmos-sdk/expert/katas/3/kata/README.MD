# Path of the Expert - Bridges

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the context of Cosmos SDK, bridges refer to a set of tools and protocols that enable interoperability between independent blockchain networks.

Bridges are necessary because each blockchain network typically operates in isolation, with its own set of rules, validators, and consensus mechanisms. This isolation can limit the potential of blockchain technology by preventing cross-chain communication and collaboration.

Bridges allow independent blockchain networks to communicate and exchange value with each other. This enables a wide range of use cases, including cross-chain asset transfers, decentralized exchanges, and interoperable smart contracts.

The Cosmos SDK provides several tools and protocols to facilitate cross-chain interoperability, including:

* `IBC (Inter-Blockchain Communication)`: IBC is a protocol for transferring digital assets and data across independent blockchain networks. IBC allows independent blockchains to interoperate without requiring them to trust each other.
* `Peggy`: Peggy is a bridge between Ethereum and Cosmos SDK-based blockchains that allows users to transfer `ERC20` tokens to and from Cosmos-based blockchains.
* `BandChain`: BandChain is an oracle network that provides reliable and decentralized price feeds for various digital assets. BandChain is used by the Cosmos SDK to provide price information for cross-chain asset transfers.
* `Gravity DEX`: Gravity DEX is a decentralized exchange that allows users to trade tokens from different blockchains. Gravity DEX is built on top of the `IBC` protocol and enables cross-chain liquidity pools.

Overall, bridges in the Cosmos SDK provide a powerful toolset for enabling cross-chain interoperability between independent blockchain networks. This interoperability opens up a wide range of possibilities for decentralized finance, gaming, and other blockchain applications.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata3
cd kata3
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
