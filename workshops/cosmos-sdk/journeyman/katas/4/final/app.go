package linkkeeper

import (
	"fmt"

	"github.com/cosmos/cosmos-sdk/codec"
	"github.com/cosmos/cosmos-sdk/server"
	"github.com/cosmos/cosmos-sdk/simapp"
)

func main() {
	cdc := codec.New()
	supplyChainKeeper := supplychain.NewSupplyChainKeeper(simapp.MakeCodec().Name(), cdc)
	// add other module keepers as necessary

	app := simapp.NewSimApp(
		logger, db, nil, true, map[int64]bool{},
		simapp.DefaultNodeHome, supplyChainKeeper,
		// add other module keepers as necessary
	)

	server.Main(app)

	item, err := supplyChainKeeper.GetProduct(ctx, "123")

	if err != nil {
		// handle error
	}

	fmt.Println(item)
}
