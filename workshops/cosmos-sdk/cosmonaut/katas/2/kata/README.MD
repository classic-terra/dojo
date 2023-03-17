# Path of the Cosmonaut - IBC > Connections

This training exercise is a **cosmonaut-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the Cosmos SDK, `IBC connections` refer to the channels through which independent blockchain networks can communicate and transfer digital assets and data between each other.

`IBC connections` are created between two independent blockchains to establish a secure and authenticated communication channel. Once a connection is established, the two blockchains can exchange packets of data, which can include digital assets, messages, and other forms of data.

The `IBC connection` process involves several steps, including:

* `Handshake`: The two blockchains initiate a handshake process to establish a connection. During the handshake process, the two blockchains exchange cryptographic proofs to verify each other's identity and establish a secure communication channel.
* `Capability negotiation`: The two blockchains negotiate the capabilities that each can support, including the types of packets that can be transferred and the level of security required for the connection.
* `Channel establishment`: Once the handshake and capability negotiation are complete, the two blockchains establish a channel for sending and receiving packets.

The `IBC connection` process is designed to be secure and flexible, enabling independent blockchains to communicate and exchange value without requiring trust between them. The Cosmos SDK provides a built-in implementation of the `IBC connection` protocol, making it easy for developers to build cross-chain applications that can communicate with other blockchains.

Overall, `IBC connections` in the Cosmos SDK provide a powerful tool for building decentralized applications that can communicate and exchange value with other blockchains, enabling new possibilities for cross-chain collaboration and interoperability.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata2
cd kata2
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
