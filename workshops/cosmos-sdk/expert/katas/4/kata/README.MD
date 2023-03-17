# Path of the Expert - Migrations

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Migrations in Cosmos SDK refer to the process of upgrading a blockchain application by modifying the state and/or structure of the underlying database.

As blockchain applications evolve, the schema of the underlying database may need to change to support new features or to fix bugs. These changes can include adding new tables, modifying existing tables, or altering the relationships between tables.

Migrations are necessary to ensure that the changes to the database schema are propagated correctly and consistently across all nodes in the network. Without proper migrations, nodes that have not been updated to the latest version of the application may encounter compatibility issues, leading to inconsistencies in the state of the blockchain and potential security vulnerabilities.

The Cosmos SDK provides a built-in migration framework that allows developers to define and execute database schema changes in a safe and consistent manner. Migrations can be defined using `Go` code and are typically bundled with application upgrades.

The migration framework provides several key features, including:

* `Safe execution`: Migrations are executed in a transactional manner, ensuring that either all of the changes are applied or none of them are.
* `Atomicity`: If a migration fails to complete, all changes are rolled back to the previous state.
* `Version tracking`: The migration framework tracks the current version of the database schema, allowing applications to determine if an upgrade is necessary.
* `Dependency management`: Migrations can have dependencies on other migrations, allowing them to be executed in a specific order.

Overall, the Cosmos SDK's migration framework provides a powerful tool for managing the evolution of blockchain applications in a safe and consistent manner.

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
