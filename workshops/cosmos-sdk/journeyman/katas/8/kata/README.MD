# Path of the Journeyman - Keepers > Simulation

This training exercise is a **journeyman-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

The simulation feature enables developers to run their applications in a sandboxed environment, where they can simulate various scenarios to test their application's behavior and performance.

Simulation in Cosmos SDK is achieved through the use of a module called `simulation`. This module provides a set of tools and functions that allow developers to define and execute simulations. The `simulation` module provides a deterministic environment that allows developers to reproduce the same results from each simulation, making it easy to identify and fix issues.

To use the `simulation` module, developers must first define a scenario. This scenario includes a set of input parameters and actions that emulate different user behaviors, such as token transfers or smart contract executions. Once the scenario is defined, developers can use the `simulation` module to execute the scenario and observe how the application behaves under different conditions.

The `simulation` module provides a variety of useful features for developers. For example, developers can use the `simulation` module to test the impact of different network conditions on their application's performance. They can also use it to test the scalability of their application via simulations of large numbers of users and transactions.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata8
cd kata8
```

## Conclusion

Overall, the `simulation` module in Cosmos SDK is a valuable tool for developers looking to build robust and reliable blockchain applications. By defining various scenarios and testing their application's behavior, developers can identify and fix issues before deploying their application to a live network, ensuring a smoother user experience and reducing the risk of bugs or security vulnerabilities.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
