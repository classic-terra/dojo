package linkkeeper

import (
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	sdkerrors "github.com/cosmos/cosmos-sdk/types/errors"
)

func NewKeeper(cdc codec.BinaryMarshaler, storeKey sdk.StoreKey) LinkKeeper {
	return LinkKeeperImpl{
		storeKey: storeKey,
		cdc:      cdc,
	}
}

type LinkModule struct {
	keeper LinkKeeper
}

func NewModule(keeper LinkKeeper) LinkModule {
	return LinkModule{
		keeper: keeper,
	}
}

func (m LinkModule) RegisterInvariants(ir sdk.InvariantRegistry) {
	// Register module invariants here
}

func (m LinkModule) Route() sdk.Route {
	// Define module routes here
}

func (m LinkModule) QuerierRoute() string {
	// Define module querier route here
}

func (m LinkModule) LegacyQuerierHandler() sdk.Querier {
	// Define legacy module querier handler here
}
