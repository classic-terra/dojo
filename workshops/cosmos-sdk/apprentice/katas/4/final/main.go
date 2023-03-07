package main

import (
	"context"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/client"
	"github.com/cosmos/cosmos-sdk/client/flags"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth/types"
	"github.com/spf13/cobra"
)

func main() {
	// Initialize the command
	cmd := &cobra.Command{
		Use:   "balance",
		Args:  cobra.ExactArgs(1),
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

	// Add the flags
	flags.AddQueryFlagsToCmd(cmd)

	// Execute the command
	if err := cmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
