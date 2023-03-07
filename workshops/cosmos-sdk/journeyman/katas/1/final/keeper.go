package linkkeeper

import (
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	sdkerrors "github.com/cosmos/cosmos-sdk/types/errors"
)

type LinkKeeper interface {
	GetLink(ctx sdk.Context, key []byte) (Link, error)
	SetLink(ctx sdk.Context, key []byte, link Link) error
}

type Link struct {
	Link string `json:"link"`
}

type LinkKeeperImpl struct {
	storeKey sdk.StoreKey
	cdc      codec.BinaryMarshaler
}

var _ LinkKeeper = LinkKeeperImpl{}       // Verify that LinkKeeperImpl implements LinkKeeper.
var _ LinkKeeper = (*LinkKeeperImpl)(nil) // Verify that *LinkKeeperImpl implements LinkKeeper.

func (k LinkKeeperImpl) GetLink(ctx sdk.Context, key []byte) (Link, error) {
	store := ctx.KVStore(k.storeKey)

	if !store.Has(key) {
		return Link{}, sdkerrors.ErrKeyNotFound
	}

	bz := store.Get(key)

	var link Link
	err := k.cdc.UnmarshalBinaryBare(bz, &link)
	if err != nil {
		return Link{}, err
	}

	return link, nil
}

func (k LinkKeeperImpl) SetLink(ctx sdk.Context, key []byte, link Link) error {
	store := ctx.KVStore(k.storeKey)

	bz := k.cdc.MustMarshalBinaryBare(&link)
	store.Set(key, bz)

	return nil
}
