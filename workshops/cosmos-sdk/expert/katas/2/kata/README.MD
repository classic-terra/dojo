# Path of the Expert - Events

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

In the Cosmos SDK, events refer to a mechanism for notifying clients and external applications about changes that occur within a blockchain application.

Events are emitted by modules within the application and can include information about a wide range of state changes, such as the creation of a new account, the transfer of tokens, or the execution of a smart contract.

Events are typically represented as key-value pairs and include a type field that identifies the type of event, as well as any additional fields that provide more detailed information about the event.

Clients and external applications can subscribe to events emitted by a Cosmos SDK application using a variety of mechanisms, including web sockets, REST APIs, or other communication protocols. This allows developers to build real-time monitoring tools, notification systems, or other applications that rely on up-to-date information about the state of the blockchain.

The Cosmos SDK provides a built-in event system that makes it easy for developers to emit and subscribe to events within their applications. Events can be emitted using the `sdk.Event` type, and clients can subscribe to events using the `sdk.EventQuery` type.

Overall, events in the Cosmos SDK provide a powerful tool for building applications that can respond to changes in the state of the blockchain in real-time. By enabling real-time monitoring and notification systems, events help to unlock new possibilities for blockchain applications in a wide range of industries.

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
