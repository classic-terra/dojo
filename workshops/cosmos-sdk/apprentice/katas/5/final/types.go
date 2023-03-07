package supplychain

import (
	"github.com/cosmos/cosmos-sdk/types"
)

type Product struct {
	ID          uint64           `json:"id"`
	Name        string           `json:"name"`
	Description string           `json:"description"`
	Owner       types.AccAddress `json:"owner"`
	History     []string         `json:"history"`
}
