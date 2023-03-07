# Path of the Apprentice - Queries

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the kata and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

`Cosmos SDK` queries are a way to retrieve data from a blockchain network built using the `Cosmos SDK`. The `Cosmos SDK` is a popular blockchain development framework that allows developers to build custom blockchain applications with their own set of rules and features.

In the context of `Cosmos SDK`, queries are used to fetch data from the blockchain's state. The blockchain state is a record of all the transactions that have taken place on the network, along with the current state of all the accounts and other data structures that are relevant to the network.

Queries in `Cosmos SDK` can be used to retrieve information about things like account balances, transaction history, and other data that is stored on the blockchain. Queries can be executed through various channels, including CLI commands, RESTful APIs, and web sockets.

There are several types of queries that can be executed using `Cosmos SDK`, including:

* `Account queries`: These queries allow you to retrieve information about a particular account on the blockchain, including the account balance, transaction history, and other details.

* `Validator queries`: These queries allow you to retrieve information about validators on the blockchain, including their voting power, commission rates, and other details.

* `Block queries`: These queries allow you to retrieve information about specific blocks on the blockchain, including the block height, hash, and other details.

* `Event queries`: These queries allow you to retrieve information about events that have taken place on the blockchain, including transaction events, validator events, and other types of events.

## Exercise

In this exercise we  will learn how to use the balance command, which takes the account address as an argumeent, and use the Cosmos SDK client to query the balance of that account on the blockchain. The `cliCtx.QueryWithData()` function is used to execute the query, and the response is printed to the console.

**Note**: this `training step` that the `Cosmos SDK` client is properly configured and that the blockchain network is up and running. It also assumes that the auth module is installed and enabled on the network.

### Step 1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata4
cd kata4
```

### Step #2: Create a file called `main.go`

Secondly we need to create a file for our code kata:

```bash
cat > main.go
```

### Step #3: Import the necessary packages

At the top of `main.go` add an import statements for the `Go` packages neccessary to work with the `Cosmos SDK` `MsgSend` type:

```go
package main

import (
    "context"
    "fmt"

    sdk "github.com/cosmos/cosmos-sdk/types"
    "github.com/cosmos/cosmos-sdk/client"
    "github.com/cosmos/cosmos-sdk/client/flags"
    "github.com/cosmos/cosmos-sdk/x/auth/types"
    "github.com/spf13/cobra"
)
```

### Step #4: Add empty main() method

Then create an empty method body below the import statements:

```go
func main() {
}
```

### Step #5: Initialize the command

Inside the main method begin by initializing the command used by this `training step`:

```go
cmd := &cobra.Command{
        Use: "balance",
        Args: cobra.ExactArgs(1),
        Short: "Get the balance of an account",
        RunE: func(cmd *cobra.Command, args []string) error {
            // Get the account address
            address, err := sdk.AccAddressFromBech32(args[0])
            if err != nil {
                return err
            }

            // Create a new CLI context
            ctx := context.Background()
            cliCtx := client.Context{}.WithCodec(sdk.NewCodec())

            // Query the balance of the account
            res, _, err := cliCtx.QueryWithData(fmt.Sprintf("custom/%s/%s/%s", types.QuerierRoute, types.QueryBalance, address), nil)
            if err != nil {
                return err
            }

            // Print the balance
            fmt.Println(string(res))

            return nil
        },
    }
```

### Step #6: Add the flags

Then we need to add query flags to our new command object, as follows:

```go
flags.AddQueryFlagsToCmd(cmd)
```

### Step #7: Execute command

Lastly we need to execute our command and print out any errors:

```go
if err := cmd.Execute(); err != nil {
    fmt.Println(err)
    os.Exit(1)
}
```

### Step #8: Build executable

Build a new `Go` binary based on `main.go`:

```bash
go build
```

### Step #9: Run executable

Lastly we can run our new `Go` program with the following command:

```bash
./main
```

## Conclusion

Queries are an important tool for blockchain developers who want to build applications that interact with the blockchain state. By using queries, developers can retrieve relevant data from the blockchain and use it to build powerful decentralized applications. The `Cosmos SDK` provides a variety of tools and APIs to make it easy to execute queries and retrieve data from the blockchain network.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues)