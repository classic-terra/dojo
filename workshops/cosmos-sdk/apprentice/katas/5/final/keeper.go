package supplychain

import (
	"github.com/cosmos/cosmos-sdk/codec"
	"github.com/cosmos/cosmos-sdk/telemetry"
	"github.com/cosmos/cosmos-sdk/types"
)

type SupplyChainKeeper struct {
	storeKey types.StoreKey
	cdc      *codec.Codec
}

func NewSupplyChainKeeper(storeKey types.StoreKey, cdc *codec.Codec) SupplyChainKeeper {
	return SupplyChainKeeper{
		storeKey: storeKey,
		cdc:      cdc,
	}
}

func (sk SupplyChainKeeper) AddProduct(ctx types.Context, product Product) {
	telemetry.IncrCounter(1, "supplychain/product/add")

	store := ctx.KVStore(sk.storeKey)
	bz := sk.cdc.MustMarshalBinaryLengthPrefixed(product)
	store.Set(product.ID, bz)
}

func (sk SupplyChainKeeper) GetProduct(ctx types.Context, id types.HexBytes) (Product, bool) {
	store := ctx.KVStore(sk.storeKey)
	if !store.Has(id) {
		return Product{}, false
	}

	var product Product
	bz := store.Get(id)
	sk.cdc.MustUnmarshalBinaryLengthPrefixed(bz, &product)

	return product, true
}
