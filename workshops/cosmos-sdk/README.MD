# Cosmos SDK - Training

## Preface

Distributed Ledger Technology (DLT), commonly referred to as blockchain, was introduced with the launch of Bitcoin in 2009 which featured an open-source software client released into a distributed peer-to-peer network to facilitate transactions and store data amongst its peers. This innovation brought about the worlds first secure and transparent `digital value network` which was not dependant on a centralized intermediary to operate. However, as Bitcoin grew in popularity, two major challenges become apparent in its `proof-of-work` architecture:

- **Scalability** => As the number of transactions on a blockchain network grows, the network becomes slower and more expensive to operate. This leads to higher transaction fees and longer wait times for users.

- **Interoperability** => Different blockchain networks are often unable to communicate with each other, which limits their potential use cases and makes it difficult to exchange assets across different networks.

Cosmos SDK attempts to address these challenges by providing a framework for building interconnected blockchain applications, which allows for the creation of `application specific blockchains` that can exchange assets and data across a wide varity of networks (Gaia, Juno, etc), while still maintaining the security and decentralization of each individual network.

Overall, Cosmos SDK represents an important milestone in the evolution of blockchain technology, as it offers a potential solution to some of the major limitations of existing blockchain networks like Ethereum which are more akin to a "distributed mainframe" where Cosmos compare more to the architecture of [Component Object Model](https://en.wikipedia.org/wiki/Component_Object_Model) which was introduced by Microsoft in 1993.

## Introduction

In order to help accelerate the adoption of Cosmos SDK the Terra Classic L1 Task Force has commited to the implemention and future maintainance of a dedicated `programming dojo` which serves as a `training ground` for people wanting to learn from our experience with Cosmos SDK in the hope that some day they can become the future maintainers of the various networks that make up the Cosmos as a whole.

To accomplish this task we break Cosmos SDK into individual `learning paths` with each path consisting of a series of interlinked `training steps` that allow students to transition from apprentice to `cosmonaut` at their own pace via a combination of "visual presentation techniques" and "coding katas" that largely try to mimic the processes associated with peer-assisted-learning-strategies ([PALS](https://ies.ed.gov/ncee/wwc/docs/interventionReports/wwc_pals_013112.pdf)), a peer tutoring strategy that can be incorporated into a literacy curriculum to improve fluency, decoding, and comprehension by allowing students to divided into pairs and alternate between the role of the tutor and tutee.

The Terra Classic L1 Task Force Cosmos SDK dojo consist of four major `learning paths`, which when broken down into `training steps` result in the following literacy curriculum:

### Path of the Apprentice

- [Protocol Buffers](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/1/kata) (Beta)
- [Transactions](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/2/kata) (Beta)
- [Messages](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/3/kata) (Beta)
- [Queries](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/4/kata) (Beta)
- [Modules](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/5/kata) (Beta)

### Path of the Journeyman

- [AnteHandler](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/1/kata) (InProgress)
- [BaseApp](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/2/kata) (InProgress)
- [SimpleApp](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/3/kata) (InProgress)
- [Keepers](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/4/kata) (InProgress)
- Keepers > [Types](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/5/kata) (InProgress)
- Keepers > [Genesis](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/6/kata) (InProgress)
- Keepers > [Client](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/7/kata) (InProgress)
- Keepers > [Simulation](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/8/kata) (InProgress)

### Path of the Expert

- [Contexts](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/1/kata) (Pending)
- [Events](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/2/kata) (Pending)
- [Bridges](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/3/kata) (Pending)
- [Migrations](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/4/kata) (Pending)
- [Wasm](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/5/kata) (Pending)
- [Cosmovisor](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/6/kata) (Pending)

### Path of the Cosmonaut

- [IBC](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/1/kata) (Pending)
- IBC > [Connections](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/2/kata) (Pending)
- IBC > [Channels](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/3/kata) (Pending)
- IBC > [Clients](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/4/kata) (Pending)
- IBC > [Token Transfer](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/5/kata) (Pending)
- IBC > [Interchain Accounts](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/6/kata) (Pending)

## Troubleshooting

If you face a situation where one or more `learning paths` and/or `training steps` are broken or incompatible with your training environment please contact your instructor for assistance on how to proceed. Alternatively you can post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).
