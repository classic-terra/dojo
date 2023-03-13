#!/bin/bash
#Create a new directory called kata5
mkdir kata5

#Change into the kata5 directory
cd kata5

#Create directory structure for proto files
mkdir proto && cd proto && mkdir modules && cd modules && mkdir simple && cd simple

#Implement Product message contract
PROTO_MSG="syntax = \"proto3\";
package modules;

import \"gogoproto/gogo.proto\";

option go_package = \"modules/x/simple/types\";

message Product {
  string identifier = 1;
  string name = 2;
  string description = 3;
}"

#Create product.proto and add the above `protobuf` message contract
echo "$PROTO_MSG" > product.proto

#Return to the kata5 directory
cd ../../../

#Create config files for Cosmos SDK `protobuf` container tooling
BUF_WORK_YML="version: v1
directories:
  - proto"

echo "$BUF_WORK_YML" > buf.work.yaml

BUF_GEN_YML="version: v1
plugins:
  - name: gocosmos
    out: ..
    opt: plugins=grpc,Mgoogle/`protobuf`/any.proto=github.com/cosmos/cosmos-sdk/codec/types
  - name: grpc-gateway
    out: ..
    opt: logtostderr=true,allow_colon_final_segments=true"

echo "$BUF_GEN_YML" > proto/buf.gen.gogo.yaml

BUF_YML="version: v1

deps:
    - buf.build/cosmos/cosmos-sdk
    - buf.build/cosmos/cosmos-proto
    - buf.build/cosmos/gogo-proto
    - buf.build/googleapis/googleapis
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
    - FILE_LOWER_SNAKE_CASE
    - MESSAGE_PASCAL_CASE
    - RPC_PASCAL_CASE
    - SERVICE_PASCAL_CASE
  except:
    - UNARY_RPC
    - SERVICE_SUFFIX
    - PACKAGE_VERSION_SUFFIX
    - RPC_REQUEST_STANDARD_NAME
    - RPC_RESPONSE_STANDARD_NAME
    - ENUM_ZERO_VALUE_SUFFIX
    - ENUM_VALUE_PREFIX"

echo "$BUF_YML" > proto/buf.yaml

BUF_GEN_YML="version: v1
deps:
  - remote: buf.build
    owner: cosmos
    repository: cosmos-proto
    commit: 1935555c206d4afb9e94615dfd0fad31
  - remote: buf.build
    owner: cosmos
    repository: cosmos-sdk
    commit: 65ea24d045c846028b0c1b8d8723a29c
  - remote: buf.build
    owner: cosmos
    repository: gogo-proto
    commit: 34d970b699f84aa382f3c29773a60836
  - remote: buf.build
    owner: googleapis
    repository: googleapis
    commit: 75b4300737fb4efca0831636be94e517"

echo "$BUF_GEN_YML" > proto/buf.lock

#Create makefile to run Cosmos SDK `protobuf` container tooling
MAKEFILE="DOCKER := \$(shell which docker)
CONTAINER_PROTO_VER=v0.7
CONTAINER_PROTO_IMAGE=tendermintdev/sdk-proto-gen:\$(CONTAINER_PROTO_VER)
CONTAINER_PROTO_FMT=cosmos-sdk-proto-fmt-\$(CONTAINER_PROTO_VER)

proto-gen:
	@echo \"Generating `protobuf` files\"
	\"\$(DOCKER)\" run --rm -v \$(CURDIR):/workspace --workdir /workspace \$(CONTAINER_PROTO_IMAGE) sh ./scripts/protocgen.sh

.PHONY: proto-gen"

echo "$MAKEFILE" > makefile

#Create protocgen.sh to mount on container running Cosmos SDK `protobuf` container tooling
PROTOCGEN_SH="#!/usr/bin/env sh

set -eo pipefail

# get protoc executions
go get github.com/regen-network/cosmos-proto/protoc-gen-gocosmos 2>/dev/null

echo \"Generating gogo proto code\"
cd proto
proto_dirs=\$(find modules -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)
for dir in \$proto_dirs; do
  for file in \$(find \"\${dir}\" -maxdepth 1 -name '*.proto'); do
    if grep go_package \"\$file\" ; then
      buf generate --template buf.gen.gogo.yaml \"\$file\"
    fi
  done
done

cd ..

# move proto files to the right places
cp -r modules/* ./
rm -rf modules"

mkdir scripts && echo "$PROTOCGEN_SH" > scripts/protocgen.sh

#Initialize Go module
go mod init modules
go mod edit -replace github.com/99designs/keyring=github.com/cosmos/keyring@v1.2.0
go mod edit -replace github.com/dgrijalva/jwt-go=github.com/golang-jwt/jwt/v4@v4.4.2
go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.0
go mod edit -replace github.com/gogo/`protobuf`=github.com/regen-network/`protobuf`@v1.3.3-alpha.regen.1
go mod edit -replace github.com/jhump/protoreflect=github.com/jhump/protoreflect@v1.9.0
go get github.com/cosmos/cosmos-sdk@v0.45.12

mkdir x && cd x && mkdir simple && cd simple

#Create simple module
SIMPLE_MODULE="package simple

import (
	\"encoding/json\"
	\"math/rand\"
	\"modules/x/simple/keeper\"
	\"modules/x/simple/types\"

	\"github.com/grpc-ecosystem/grpc-gateway/runtime\"

	\"github.com/gorilla/mux\"
	\"github.com/spf13/cobra\"

	abci \"github.com/tendermint/tendermint/abci/types\"

	\"github.com/cosmos/cosmos-sdk/client\"
	\"github.com/cosmos/cosmos-sdk/codec\"
	codectypes \"github.com/cosmos/cosmos-sdk/codec/types\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
	\"github.com/cosmos/cosmos-sdk/types/module\"
	simtypes \"github.com/cosmos/cosmos-sdk/types/simulation\"
)

var (
	_ module.AppModule           = AppModule{}
	_ module.AppModuleBasic      = AppModuleBasic{}
	_ module.AppModuleSimulation = AppModule{}
)

// AppModuleBasic defines the basic application module used by the simple module.
type AppModuleBasic struct {
	cdc codec.Codec
}

// Name returns the simple module's name
func (AppModuleBasic) Name() string {
	return types.ModuleName
}

// RegisterLegacyAminoCodec registers the module's types on the given LegacyAmino codec.
func (AppModuleBasic) RegisterLegacyAminoCodec(cdc *codec.LegacyAmino) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// RegisterInterfaces registers the module's interface types
func (b AppModuleBasic) RegisterInterfaces(registry codectypes.InterfaceRegistry) {
	registry.RegisterInterface(\"types.Product\",
		(*types.Product)(nil),
		&types.Product{},
	)
}

// DefaultGenesis returns default genesis state as raw bytes for the module.
func (AppModuleBasic) DefaultGenesis(cdc codec.JSONCodec) json.RawMessage {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ValidateGenesis performs genesis state validation for the module.
func (AppModuleBasic) ValidateGenesis(cdc codec.JSONCodec, config client.TxEncodingConfig, bz json.RawMessage) error {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterRESTRoutes registers the REST routes for the module.
func (AppModuleBasic) RegisterRESTRoutes(clientCtx client.Context, rtr *mux.Router) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// RegisterGRPCGatewayRoutes registers the gRPC Gateway routes for the module.
func (AppModuleBasic) RegisterGRPCGatewayRoutes(clientCtx client.Context, mux *runtime.ServeMux) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// GetTxCmd returns the root tx command for the module.
func (AppModuleBasic) GetTxCmd() *cobra.Command {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// GetQueryCmd returns no root query command for the module.
func (AppModuleBasic) GetQueryCmd() *cobra.Command {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// AppModule implements an application module for the simple module.
type AppModule struct {
	AppModuleBasic

	keeper keeper.SimpleKeeper
}

// NewAppModule creates a new AppModule given a Codec (for serialization) and a Keeper (for db access)
func NewAppModule(cdc codec.Codec, keeper keeper.SimpleKeeper) AppModule {
	return AppModule{
		AppModuleBasic: AppModuleBasic{cdc},
		keeper:         keeper,
	}
}

// Name returns the module's name.
func (am AppModule) Name() string { return types.ModuleName }

// RegisterInvariants registers the module invariants.
func (AppModule) RegisterInvariants(_ sdk.InvariantRegistry) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// Route returns the message routing key for the module.
func (am AppModule) Route() sdk.Route {
	//We will show how to implement this logic in the Path of the Journeyman
	return sdk.NewRoute(am.Name(), nil)
}

// NewHandler returns an sdk.Handler for the module.
func (am AppModule) NewHandler() sdk.Handler {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// QuerierRoute returns the module's querier route name.
func (am AppModule) QuerierRoute() string { return am.Name() }

// LegacyQuerierHandler returns the treasury module sdk.Querier.
func (am AppModule) LegacyQuerierHandler(legacyQuerierCdc *codec.LegacyAmino) sdk.Querier {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterServices registers module services.
func (am AppModule) RegisterServices(cfg module.Configurator) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// InitGenesis performs genesis initialization for the treasury module. It returns
// no validator updates.
func (am AppModule) InitGenesis(ctx sdk.Context, cdc codec.JSONCodec, data json.RawMessage) []abci.ValidatorUpdate {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ExportGenesis returns the exported genesis state as raw bytes for the treasury
// module.
func (am AppModule) ExportGenesis(ctx sdk.Context, cdc codec.JSONCodec) json.RawMessage {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// ConsensusVersion implements AppModule/ConsensusVersion.
func (AppModule) ConsensusVersion() uint64 { return 1 }

// BeginBlock returns the begin blocker for the treasury module.
func (am AppModule) BeginBlock(ctx sdk.Context, req abci.RequestBeginBlock) {}

// EndBlock returns the end blocker for the treasury module.
func (am AppModule) EndBlock(ctx sdk.Context, _ abci.RequestEndBlock) []abci.ValidatorUpdate {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

//____________________________________________________________________________

// AppModuleSimulation functions used by sim operations in Cosmos SDK

// GenerateGenesisState creates a randomized GenState of the distribution module.
func (AppModule) GenerateGenesisState(simState *module.SimulationState) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// ProposalContents returns all the distribution content functions used to
// simulate governance proposals.
func (am AppModule) ProposalContents(_ module.SimulationState) []simtypes.WeightedProposalContent {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RandomizedParams creates randomized distribution param changes for the simulator.
func (AppModule) RandomizedParams(r *rand.Rand) []simtypes.ParamChange {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}

// RegisterStoreDecoder registers a decoder for distribution module's types
func (am AppModule) RegisterStoreDecoder(sdr sdk.StoreDecoderRegistry) {
	//We will show how to implement this logic in the Path of the Journeyman
}

// WeightedOperations returns the all the gov module operations with their respective weights.
func (am AppModule) WeightedOperations(simState module.SimulationState) []simtypes.WeightedOperation {
	//We will show how to implement this logic in the Path of the Journeyman
	return nil
}"

echo "$SIMPLE_MODULE" > module.go

#Create custom types
CUSTOM_TYPES="package types

const (
	// ModuleName is the module name of the simple module
	ModuleName = \"simple\"

	// StoreKey is the KVStore identifier for the simple module
	StoreKey = ModuleName

	// RouterKey is the message route for the simple module
	RouterKey = ModuleName

	// QuerierRoute is the querier route for the simple module
	QuerierRoute = ModuleName
)

var (
	// Keys for store prefixes
	ProductKey = []byte{0x01} // a key for a product
)

// GetProductKey - stored by *identifier* is used to marshal and unmarshal product identifiers
func GetProductKey(identifier string) []byte {
	return append(ProductKey, []byte(identifier)...)
}
"

mkdir types && echo "$CUSTOM_TYPES" > types/types.go

#Create simple keeper
SIMPLE_KEEPER="package keeper

//Define required imports
import (
	types \"modules/x/simple/types\"

	\"github.com/cosmos/cosmos-sdk/codec\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
)

// SimpleKeeper is the keeper for our simple module
type SimpleKeeper struct {
	storeKey sdk.StoreKey
	cdc      codec.BinaryCodec
}

// Constructor for SimpleKeeper
func NewSimpleKeeper(storeKey sdk.StoreKey, cdc codec.BinaryCodec) SimpleKeeper {
	return SimpleKeeper{
		storeKey: storeKey,
		cdc:      cdc,
	}
}

// Add a product to SimpleKeeper
func (sk SimpleKeeper) AddProduct(ctx sdk.Context, product types.Product) {
	store := ctx.KVStore(sk.storeKey)
	bz := sk.cdc.MustMarshal(&product)
	store.Set(types.GetProductKey(product.Identifier), bz)
}

// Get a product from SimpleKeeper
func (sk SimpleKeeper) GetProduct(ctx sdk.Context, identifier string) types.Product {
	store := ctx.KVStore(sk.storeKey)
	key := types.GetProductKey(identifier)
	if !store.Has(key) {
		return types.Product{}
	}

	var product types.Product
	bz := store.Get(key)
	sk.cdc.MustUnmarshal(bz, &product)

	return product
}"

mkdir keeper && echo "$SIMPLE_KEEPER" > keeper/keeper.go

#Return to the kata5 directory
cd ../../

#Create simple keeper
MAIN_PROGRAM="package main

import (
	\"fmt\"
	\"modules/x/simple/keeper\"
	\"modules/x/simple/types\"

	\"github.com/cosmos/cosmos-sdk/codec\"
	codectypes \"github.com/cosmos/cosmos-sdk/codec/types\"
	\"github.com/cosmos/cosmos-sdk/store/rootmulti\"
	storeTypes \"github.com/cosmos/cosmos-sdk/store/types\"
	sdk \"github.com/cosmos/cosmos-sdk/types\"
	\"github.com/tendermint/tendermint/libs/log\"
	tmproto \"github.com/tendermint/tendermint/proto/tendermint/types\"
)

func main() {
	//Initialize new LevelDB
	db, err := sdk.NewLevelDB(\"modules_store\", \"./\")

	if err != nil {
		fmt.Printf(\"Error creating new LevelDB: %v\", err)
	}

	//Initialize new root multi store
	ms := rootmulti.NewStore(db, log.NewNopLogger())

	//Initialize new store key
	storeKey := sdk.NewKVStoreKey(types.StoreKey)

	//Mount IAVL store to root multi store for store key
	ms.MountStoreWithDB(storeKey, storeTypes.StoreTypeIAVL, db)
	ms.LoadLatestVersion()

	//Initialize new context with multi store and header height of 1
	ctx := sdk.NewContext(ms, tmproto.Header{Height: 1}, false, log.NewNopLogger())

	//Create new interface registry
	ir := codectypes.NewInterfaceRegistry()

	//Create new proto codec
	cdc := codec.NewProtoCodec(ir)

	//Initialize new keeper with store key and codex
	keeper := keeper.NewSimpleKeeper(storeKey, cdc)

	//Create new product instance
	newProduct := types.Product{
		Identifier:  \"123\",
		Name:        \"Test\",
		Description: \"Test\",
	}

	//Add product to keeper
	keeper.AddProduct(ctx, newProduct)

	//Get product from keeper
	storeProduct := keeper.GetProduct(ctx, \"123\")

	//Print product information
	fmt.Printf(\"Product Identifier: %s\n\", storeProduct.Identifier)
	fmt.Printf(\"Product Name: %s\n\", storeProduct.Name)
	fmt.Printf(\"Product Description: %s\n\", storeProduct.Description)
}"

echo "$MAIN_PROGRAM" > main.go

#Generate Go code from *.proto files
make proto-gen

#Clean up dependency graph
go mod tidy

#Build the program
go build

#Run the program
./modules