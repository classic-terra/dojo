# Path of the Expert - WASM

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

The WebAssembly (WASM) module in Cosmos SDK is a binary executable format that allows developers to write high-performance smart contracts in a variety of programming languages, including Rust, C++, and AssemblyScript.

WASM modules are designed to be lightweight, portable, and secure. They can be deployed and executed in a wide range of environments, including web browsers, mobile devices, and server-side applications.

In the context of Cosmos SDK, WASM modules are used to create custom application-specific modules that can be deployed on a Cosmos blockchain. These modules can implement custom business logic, such as token issuance, staking, governance, or other functionality.

The Cosmos SDK provides a WASM module interface that abstracts away the complexities of interacting with the low-level WASM runtime. This interface enables developers to write smart contracts in a familiar programming language and leverage the full power of the Cosmos SDK's ecosystem.

Once a WASM module is compiled, it can be uploaded to a Cosmos chain and instantiated as a contract instance. The module can then be called from other modules or external applications using standard Cosmos SDK messages.

Overall, the WASM module in Cosmos SDK provides developers with a powerful and flexible tool for building custom blockchain applications that can be easily deployed and executed in a wide range of environments.

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
