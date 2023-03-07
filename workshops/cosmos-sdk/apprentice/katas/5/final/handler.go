package supplychain

import (
	"github.com/cosmos/cosmos-sdk/types"
)

type SupplyChainHandler struct {
	keeper SupplyChainKeeper
}

func NewSupplyChainHandler(keeper SupplyChainKeeper) SupplyChainHandler {
	return SupplyChainHandler{keeper: keeper}
}

func (h SupplyChainHandler) AddProductMsg(ctx types.Context, msg AddProductMsg) (types.Result, error) {
	product := Product{
		Name: msg.Name,
		ID:   msg.ID,
	}
	h.keeper.AddProduct(ctx, product)

	return types.NewResult(types.CodeOK, "product added"), nil
}
