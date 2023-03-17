# Path of the Expert - Cosmovisor

This training exercise is a **expert-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

`Cosmovisor` is a tool that helps manage the upgrade process for Cosmos-based blockchain networks. It is designed to simplify the process of upgrading a node to a new version of the Cosmos SDK or a related application by automating many of the steps involved.

`Cosmovisor` works by creating a `symlink` (symbolic link) between the current version of the Cosmos SDK binary and the new version that is being installed. This allows the new version to be installed and tested without affecting the current version that is running. Once the new version has been tested and is ready to be used, `Cosmovisor` can activate it by updating the `symlink` to point to the new version.

`Cosmovisor` also includes features for handling rollback and automatic restarts in case of failure during an upgrade process. This helps to ensure that the network stays online and running smoothly even during upgrades.

Overall, `Cosmovisor` is an important tool for Cosmos-based blockchain networks as it helps to simplify the upgrade process and minimize downtime for the network. It makes upgrading to new versions of the Cosmos SDK or related applications easier and less risky, which can help encourage more frequent upgrades and improvements to the network.

## Exercise

[TEXT]

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata6
cd kata6
```

## Conclusion

[TEXT]

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
