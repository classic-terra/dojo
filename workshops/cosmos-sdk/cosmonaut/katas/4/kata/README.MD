# Path of the Cosmonaut - IBC > Clients

This training exercise is a **cosmonaut-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the Cosmos SDK, `IBC clients` refer to the components that enable independent blockchain networks to verify the state and validity of data being transferred between them.

`IBC clients` serve as a bridge between two independent blockchains, ensuring that both parties can verify the authenticity and integrity of data being transferred between them. IBC clients are responsible for maintaining a local copy of the state of the remote blockchain and verifying the validity of incoming data from that blockchain.

The `IBC client` protocol includes several key components, including:

* `Light client`: A lightweight version of the `IBC client` that runs on the sending blockchain and provides proof of the validity of outgoing data.
* `Full client`: A more complete version of the `IBC client` that runs on the receiving blockchain and maintains a local copy of the state of the sending blockchain.
* `Verification`: A mechanism that allows the full client to verify the validity of incoming data by checking cryptographic proofs provided by the light client.
* `Upgrade`: A mechanism that allows the two blockchains to upgrade their `IBC clients` and ensure compatibility with each other.

`IBC clients` are designed to be modular and extensible, allowing developers to customize and extend the protocol to meet their specific needs. The Cosmos SDK includes a built-in implementation of the `IBC client` protocol, making it easy for developers to build cross-chain applications that can communicate with other blockchains.

Overall, `IBC clients` in the Cosmos SDK provide a powerful tool for building decentralized applications that can communicate and exchange value with other blockchains, enabling new possibilities for cross-chain collaboration and interoperability.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata4
cd kata4
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
