# Metacrafters_AVAX_ADV_Intermediate_Project_02_Submission

**Project Objective:**
The objective of this project is to utilize the Avalanche HyperSDK to build and interact with a robust, feature-rich blockchain. The project will focus on designing a blockchain that incorporates multiple advanced features and functionalities, demonstrating the power and versatility of the HyperSDK framework. Through this project, we aim to showcase the seamless integration and interaction with the blockchain, emphasizing the practical applications and scalability of the technology.

## Introduction To 'HyperSDK' 

HyperSDK is a high-performance software development kit (SDK) designed by Avalanche specifically for creating custom blockchains, known as subnets, on the Avalanche platform. HyperSDK provides developers with the tools and resources needed to build, optimize, and scale blockchain networks that are tailored to specific use cases or industries.

**Key features of HyperSDK include:**

**Modular Design:** It allows developers to easily customize and extend the functionality of their blockchain by selecting and integrating various modules or components.
**High Throughput:** HyperSDK is optimized for performance, enabling the creation of blockchains that can handle a high volume of transactions with low latency.
**Interoperability:** Blockchains built using HyperSDK can seamlessly interact with other subnets within the Avalanche ecosystem, promoting a connected and scalable blockchain network.
**Security:** The SDK includes robust security features to protect the integrity of the blockchain and its transactions.
**Ease of Use:** HyperSDK is designed to be developer-friendly, with extensive documentation, tools, and support to simplify the process of building and deploying blockchains.

## Funtionality of Our Custom HyperChain 

**Arbitrary Token Minting:**
The TokenVM empowers users to effortlessly create, mint, and transfer custom tokens. Asset owners gain "admin control," enabling them to mint additional tokens, update metadata, and transfer or revoke ownership as needed. The system’s storage is highly optimized, using only 72 bytes per balance entry, which supports efficient and parallel transaction execution. This design ensures scalability and responsiveness, with future enhancements driven by the HyperSDK's capabilities.

**Seamless Token Trading:**
Beyond token creation, the TokenVM enables fully on-chain trading, allowing users to create and fill offers with ease. The in-memory order book provides real-time access to available trades, while the optimized storage system facilitates fast and parallel order execution. This feature-rich environment supports sophisticated trading strategies without the risk of front-running, thanks to strict order management and fill refunds. The integration with HyperSDK enhances performance and ensures a secure, efficient trading experience.

## Prerequisites

Before getting started with this project, ensure that you have the following prerequisites in place:

1. **Operating System:**  
   - Linux (preferably Ubuntu 20.04 or higher)
   - macOS (latest version recommended)
   - Windows Subsystem for Linux (WSL) for Windows users

2. **Development Tools:**
   - **Git:** Version control system for managing the codebase.
   - **CMake:** Required for building the project from source.
   - **GCC/Clang:** C++ compiler for building the HyperSDK and related tools.
   - **Node.js and NPM:** For managing dependencies and running scripts (if applicable).

3. **Blockchain Network Setup:**
   - **Avalanche Network Access:** A connection to the Avalanche network where your custom blockchain will be deployed.
   - **AvalancheGo Node:** Running an AvalancheGo node is recommended for testing and interacting with your custom blockchain.

4. **Libraries and Dependencies:**
   - **Boost Libraries:** Required for some components of the HyperSDK.
   - **OpenSSL:** Necessary for secure communications within the blockchain.
   - **Protocol Buffers:** Used for serializing structured data.

5. **Accounts and Permissions:**
   - **Avalanche Wallet:** To interact with the blockchain, you'll need an Avalanche wallet with some AVAX for transaction fees.
   - **API Keys:** If using third-party services, ensure you have the necessary API keys and permissions configured.

6. **Basic Knowledge:**
   - **Blockchain Concepts:** Familiarity with blockchain technology, consensus mechanisms, and smart contracts.
   - **Programming Skills:** Proficiency in C++ for working with HyperSDK, and optionally in JavaScript/TypeScript if you plan to work with frontend integrations.


## Steps To Reproduce 

**Mint and Trade**

**Step 1: Create Your Asset**  
First, let’s create your own asset. Run the following command:

```bash
./build/token-cli action create-asset
```

After executing the command, you'll see an output similar to this:

```bash
database: .token-cli
address: [Your Generated Address]
chainID: [Your ChainID]
metadata (can be changed later): MarioCoin
continue (y/n): y
✅ txID: [Generated Transaction ID]
```

Here, the `txID` is the `assetID` of your newly created asset. The "loaded address" represents the default private key used for all interactions with the TokenVM.

**Step 2: Mint Your Asset**  
Once you've created your asset, it’s time to mint some tokens. Execute the following command:

```bash
./build/token-cli action mint-asset
```

Upon completion, the output will look something like this:

```bash
database: .token-cli
address: [Your Generated Address]
chainID: [Your ChainID]
assetID: [Your AssetID]
metadata: MarioCoin supply: 0
recipient: [Recipient's Address]
amount: 10000
continue (y/n): y
✅ txID: [Generated Transaction ID]
```

You'll be asked to specify the recipient's address and the amount you wish to mint. Confirm the action by typing `y`, and your tokens will be successfully minted.

## Introduction To ZipKin Tracking 

To monitor the performance of TokenVM during load testing, we utilize OpenTelemetry alongside Zipkin.

To begin, start the Zipkin backend and the Elasticsearch database by navigating to the `hypersdk/trace` directory and running:

```bash
docker-compose -f trace/zipkin.yml up
```

Once Zipkin is up and running, you can access it at [http://localhost:9411](http://localhost:9411).

Next, initiate the load tester, which will automatically send performance traces to Zipkin:

```bash
TRACE=true ./scripts/tests.load.sh
```
