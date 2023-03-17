# Path of the Cosmonaut - IBC > Channels

This training exercise is a **cosmonaut-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the Cosmos SDK, `IBC channels` refer to the communication channels established between independent blockchain networks to facilitate the transfer of digital assets and data.

`IBC channels` provide a secure and authenticated way for two blockchains to communicate and exchange data with each other. `IBC channels` can be used to transfer digital assets, messages, and other forms of data, and can be customized to meet the specific needs of the applications using them.

The `IBC channel` protocol includes several key components, including:

`Packet`: A unit of data that can be transferred between two blockchains over an `IBC channel`.
`Acknowledgement`: A message that is sent by the receiving blockchain to acknowledge receipt of a packet and confirm its validity.
`Timeout`: A mechanism that allows packets to be retransmitted if they are not acknowledged within a specified timeframe.
`Sequence`: A mechanism that ensures that packets are delivered in the correct order and that no packets are missed or duplicated.

`IBC channels` can be used to build a wide range of decentralized applications, including cross-chain asset transfers, inter-chain messaging, and more. The Cosmos SDK includes a built-in implementation of the `IBC channel` protocol, making it easy for developers to build cross-chain applications that can communicate with other blockchains.

Overall, `IBC channels` in the Cosmos SDK provide a powerful tool for building decentralized applications that can communicate and exchange value with other blockchains, enabling new possibilities for cross-chain collaboration and interoperability.

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
