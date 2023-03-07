# Cosmos SDK - Training
## Preface
Distributed Ledger Technology (DLT), commonly referred to as blockchain, was introduced with the launch of Bitcoin in 2009 which featured an open-source software client released into a distributed peer-to-peer network to facilitate transactions and store data amongst its peers. This innovation brought about the worlds first secure and transparent `digital value network` which was not dependant on a centralized intermediary to operate. However, as Bitcoin grew in popularity, two major challenges become apparent in its `proof-of-work` architecture:

- **Scalability** => As the number of transactions on a blockchain network grows, the network becomes slower and more expensive to operate. This leads to higher transaction fees and longer wait times for users.

- **Interoperability** => Different blockchain networks are often unable to communicate with each other, which limits their potential use cases and makes it difficult to exchange assets across different networks.

`Cosmos SDK` attempts to address these challenges by providing a framework for building interconnected blockchain applications, which allows for the creation of `application specific blockchains` that can exchange assets and data across a wide varity of networks (Gaia, Juno, etc), while still maintaining the security and decentralization of each individual network.

Overall, `Cosmos SDK` represents an important milestone in the evolution of blockchain technology, as it offers a potential solution to some of the major limitations of existing blockchain networks like Ethereum which are more akin to a "distributed mainframe" where Cosmos compare more to the architecture of [Component Object Model](https://en.wikipedia.org/wiki/Component_Object_Model) which was introduced by Microsoft in 1993.

## Introduction
In order to help accelerate the adoption of Cosmos SDK the Terra Classic L1 Task Force has commited to the implemention and future maintainance of a dedicated `programming dojo` which serves as a `training ground` for people wanting to learn from our experience with Cosmos SDK in the hope that some day they can become the future maintainers of the various networks that make up the Cosmos as a whole.

To accomplish this task we break `Cosmos SDK` into individual `learning paths` with each path consisting of a series of interlinked `training steps` that allow students to transition from apprentice to `cosmonaut` at their own pace via a combination of "visual presentation techniques" and "coding katas" that largely try to mimic the processes associated with peer-assisted-learning-strategies ([PALS](https://ies.ed.gov/ncee/wwc/docs/interventionReports/wwc_pals_013112.pdf)), a peer tutoring strategy that can be incorporated into a literacy curriculum to improve fluency, decoding, and comprehension by allowing students to divided into pairs and alternate between the role of the tutor and tutee.

The Terra Classic L1 Task Force `Cosmos SDK` dojo consist of four major `learning paths`, which when broken down into `training steps` result in the following literacy curriculum:

### Path of the Apprentice
- [Protobuf](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/1/kata) - learn about the language-agnostic data serialization format developed by Google.
- [Transactions](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/2/kata) - try to create a simple `Cosmos SDK` transaction.
- [Messages](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/3/kata) - examine how messages work in `Cosmos SDK`.
- [Queries](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/4/kata) - play around with `Cosmos SDK` queries.
- [Modules](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/apprentice/katas/5/kata) - explore existing `Cosmos SDK` modules, their structure & internals.

### Path of the Journeyman
- [Keepers](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/1/kata)
- Keepers > [Types](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/2/kata)
- Keepers > [Genesis](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/3/kata)
- Keepers > [Client](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/4/kata)
- [BaseApp](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/5/kata)
- [AppIntegration](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/journeyman/katas/6/kata)

### Path of the Expert
- [Events](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/1/kata)
- [Context](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/2/kata)
- [Migrations](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/3/kata)
- [Bridges](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/expert/katas/4/kata)

### Path of the Cosmonaut
- [IBC](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/1/kata)
- IBC > [Connections](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/2/kata)
- IBC > [Channels](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/3/kata)
- IBC > [Clients](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/4/kata)
- IBC > [Token Transfer](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/5/kata)
- IBC > [Interchain Accounts](https://github.com/classic-terra/dojo/tree/main/workshops/cosmos-sdk/cosmonaut/katas/6/kata)

## Troubleshooting
If you face a situation where one or more domains and/or sections are broken or incompatible with your training environment please contact your instructor for assistance on how to proceed. Alternatively you can post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).
