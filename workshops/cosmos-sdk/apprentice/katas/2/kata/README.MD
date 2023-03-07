Path of the Apprentice - Transactions
======================================

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started
These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the assignment(s). If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites
* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface
`Cosmos SDK` is a framework for building blockchain applications. Transactions are the basic building blocks of any blockchain system, and they play a crucial role in the functioning of the `Cosmos SDK`.

In the `Cosmos SDK`, a transaction is a message that is sent from one account to another account. A transaction can contain multiple messages, each of which specifies an action that is to be executed on the blockchain. For example, a message might instruct the blockchain to transfer tokens from one account to another account, or it might instruct the blockchain to create a new smart contract.

Each transaction is signed using the private key of the account that initiated the transaction. This ensures that only the owner of the account can authorize the transaction. When a transaction is received by the blockchain, it is validated to ensure that it meets certain criteria. For example, the transaction might be checked to ensure that the sender has sufficient funds to cover the transaction fee.

Once a transaction is validated, it is added to a pool of pending transactions. These transactions are then processed by validators who compete to add them to the next block in the blockchain. Validators are rewarded for adding transactions to the blockchain, which helps to incentivize them to participate in the network.

In summary, transactions in the `Cosmos SDK` are messages that specify actions to be executed on the blockchain. They are signed by the sender's private key, validated by the network, and processed by validators who compete to add them to the blockchain. Transactions are an essential component of the `Cosmos SDK's architecture`, and they enable a wide range of blockchain applications to be built on top of the framework.

## Exercise
This `training step` uses an example program written in `Go` to demonstrate how to create a transactions  to send tokens from one account to another using the `Cosmos SDK`.

**Note**: this `training step` assumes that you have set up a working `Cosmos SDK` node and configured the SDK client accordingly. Additionally, you will need to import the appropriate SDK modules and define the token type and decimal places for your specific blockchain network in order for this to be used in production.

### Step 1: Create kata directory
First we setup a directory for our exercise files. It's pretty straight forward:

```
mkdir kata2
cd kata2
```

### Step #2: Create a file called `main.go`
Secondly we need to create a file for our code kata:

```
cat > main.go
```

### Step #3: Import the necessary packages
At the top of `main.go` add an import statements for the `Go` packages neccessary to work with the `Cosmos SDK` transactions types:

```
import (
	"context"
	"fmt"

	sdk "github.com/cosmos/cosmos-sdk/types"
	auth "github.com/cosmos/cosmos-sdk/x/auth"
)
```

### Step #4: Set up the SDK client
Now we need to set up the SDK client used by our `training step`:

```
client := auth.NewCLIContext().WithCodec(sdk.MustSortJSONCodec())
```

### Step #5: Set up the sender and recipient addresses
Then initialize sender & recipient addresses variables with the appropriate values:

```
senderAddr := sdk.AccAddress([]byte("sender_address"))
recipientAddr := sdk.AccAddress([]byte("recipient_address"))
```

### Step #6: Build the transaction
Once our variablees are initialized we can use then to setup a transaction to acts as a `message envelope` for broadcasting:

```
amount := sdk.NewCoin("uluna", sdk.NewInt(100))
msg := auth.NewStdMsg(
    []sdk.Msg{bank.NewMsgSend(senderAddr, recipientAddr, sdk.NewCoins(amount))},
    auth.NewStdFee(100000, sdk.NewCoins(sdk.NewCoin("uluna", sdk.NewInt(10)))),
    []auth.StdSignature{},
    "",
)
```

### Step #7: Sign & broadcast the transaction
Before we can broadcast our transaction we need to sign it with the sender's private key:

```
txBytes, err := client.TxEncoder()(msg)

if err != nil {
    panic(err)
}

res, err := client.BroadcastTx(txBytes)

if err != nil {
    panic(err)
}

fmt.Println(res.String())
```

### Step #8: Build executable
Build a new `Go` binary based on `main.go`:

```
go build
```

### Step #9: Run executable
Lastly we can run our new `Go` program with the following command:

```
./main
```

## Conclusion
In this `training step`, we learned how to set up the SDK client and define the sender and recipient addresses. We then created a transaction using the `bank.NewMsgSend` function, which send `tokens` from the sender address to the recipient address. We then set a transactions fee using the `auth.NewStdFee` function.

Next, we signed and broadcasted the transaction using the SDK client. We encoded the transaction message using the client's `TxEncoder` function, and then broadcasted the transaction using the `BroadcastTx` function.


## Want to help make our training material better?
 * Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
 