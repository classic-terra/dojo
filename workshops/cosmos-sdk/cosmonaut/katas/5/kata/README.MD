# Path of the Cosmonaut - Token Transfer

This training exercise is a **cosmonaut-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

One of the core functionalities of a blockchain application is the ability to transfer tokens between users. In Cosmos SDK, token transfer functionality is built into the framework, allowing developers to easily implement token transfers within their blockchain applications.

The token transfer functionality in Cosmos SDK works by utilizing a module called `bank`. This module provides an interface for users to send and receive tokens within the blockchain application. The `bank` module also handles the accounting and bookkeeping associated with token transfers.

To send tokens, a user must have a wallet or account within the blockchain application. This account holds the user's token balance and provides the necessary information to send and receive tokens. The user must specify the recipient's account address, the amount of tokens to be sent, and any transaction fees associated with the transfer. Once the transaction is validated by the network, the specified amount of tokens is transferred from the sender's account to the recipient's account.

Token transfers in Cosmos SDK are designed to be secure and reliable. The framework uses cryptographic protocols to ensure that transactions are authenticated and cannot be tampered with. The transaction is also validated by the network of nodes running the blockchain application, ensuring that the transfer is valid and that the sender has sufficient funds to complete the transaction.

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
