# Path of the Journeyman - AnteHandler

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

The `AnteHandler` is essentially a middleware component that leverages a [`chain-of-responsibility pattern`](https://www.geeksforgeeks.org/chain-responsibility-design-pattern/) to easily enable developers to define and run custom pre-processing logic for incoming transactions. This pre-processing is important because it helps ensure that all transactions added to the blockchain are valid and conform to certain requirements.

The `AnteHandler` operates on a per-transaction basis, and is responsible for running a series of `ante operations` before the transaction is processed by the application's handler. These `ante operations` are defined by developers and can include any number of checks or calculations that need to be performed before the transaction can be added to the block.

Some examples of the types of `ante operations` that might be included in an `AnteHandler` are:

* `Signature verification`: ensuring that the transaction has been signed by the appropriate parties, and that the signatures are valid.
* `Fee calculation`: determining the appropriate transaction fee based on the size and complexity of the transaction.
* `Gas estimation`: estimating the amount of gas that will be required to execute the transaction.
* `Application-specific logic`: running custom code that checks for specific conditions or requirements before allowing the transaction to proceed.

If a transaction fails any of the `ante operations`, it is rejected and not included in the block. This helps ensure that only valid transactions are added to the blockchain, and prevents invalid or malicious transactions from being processed.

Developers can customize the `AnteHandler` to add or remove specific `ante operations`, depending on the requirements of their application. This allows for greater flexibility and control over transaction processing, and helps ensure that the blockchain remains secure and reliable.

## Exercise

[TEXT]

### Step #1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata1
cd kata1
```

## Conclusion

In conclusion, the `AnteHandler` is an important middleware component in Cosmos SDK that allows developers to define and run custom pre-processing logic for incoming transactions. This allows for greater flexibility and control over transaction processing, and helps ensure that the blockchain remains secure and reliable.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
