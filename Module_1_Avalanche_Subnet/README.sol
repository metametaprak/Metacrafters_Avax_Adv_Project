# Metacrafters_AVAX_ADV_Intermediate_Project_01_Submission

**Objective:** Develop a custom blockchain game on the Avalanche network by leveraging the EVM Subnet for smart contract deployment.

**Key Steps:**

1. **Establish Your EVM Subnet:**
   - Utilize the provided guide and Avalanche documentation to create a custom EVM subnet.
   - Benefit from low fees and the ability to deploy smart contracts to a custom chain.

2. **Define Your Native Currency:**
   - Set up your own native currency to be used as the in-game currency for your DeFi Kingdom clone.

3. **Integrate with Metamask:**
   - Connect your EVM Subnet to Metamask by following the detailed steps in the guide.

4. **Deploy Basic Building Blocks:**
   - Use Solidity and Remix to deploy essential smart contracts for game functionalities such as battling, exploring, and trading.
   - Define game rules, including liquidity pools, tokens, and more, through these contracts.

**Outcome:** Successfully architect and customize a game on the Avalanche network with your own custom token and smart contract functionalities.

## Avalanche Subnet 

An Avalanche Subnet (short for "subnetwork") is a dynamic subset of Avalanche validators working together to achieve consensus on the state of one or more blockchains

1. **Create a Subnet:**
   ```bash
   avalanche subnet create <subnet_name>
   ```
   - **`<subnet_name>`**: Replace this with the name you want to assign to your Subnet. This command initializes a new Subnet with the given name.

2. **Deploy a Subnet:**
   ```bash
   avalanche subnet deploy <subnet_name>
   ```
   - **`<subnet_name>`**: Replace this with the name of the Subnet you created. This command deploys the Subnet to the Avalanche network.

These commands would typically be part of a CLI tool designed for managing Avalanche Subnets, simplifying the process of creation and deployment.

## 'ERC20' Contract Explanation 

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Solidity by Example";
    string public symbol = "SOLBYEX";
    uint8 public decimals = 18;

		event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
```
This Solidity code defines a basic ERC-20 token contract, a widely used standard for creating fungible tokens on the Ethereum blockchain. Here’s a breakdown of the key components and functionalities of the contract:

### 1. **Contract Declaration**

```solidity
contract ERC20 {
```

- **`ERC20`**: The name of the contract. This is a basic implementation of the ERC-20 token standard.

### 2. **State Variables**

```solidity
uint public totalSupply;
mapping(address => uint) public balanceOf;
mapping(address => mapping(address => uint)) public allowance;
string public name = "Solidity by Example";
string public symbol = "SOLBYEX";
uint8 public decimals = 18;
```

- **`totalSupply`**: Keeps track of the total supply of tokens in circulation.
- **`balanceOf`**: A mapping that associates each address with its token balance.
- **`allowance`**: A nested mapping that tracks the amount of tokens an owner allows a spender to use on their behalf.
- **`name`**: The name of the token.
- **`symbol`**: The ticker symbol for the token.
- **`decimals`**: The number of decimal places the token uses (commonly 18 for ERC-20 tokens).

### 3. **Events**

```solidity
event Transfer(address indexed from, address indexed to, uint value);
event Approval(address indexed owner, address indexed spender, uint value);
```

- **`Transfer`**: Emitted when tokens are transferred from one address to another.
- **`Approval`**: Emitted when an owner approves a spender to spend tokens on their behalf.

### 4. **Functions**

#### Transfer Function

```solidity
function transfer(address recipient, uint amount) external returns (bool) {
    balanceOf[msg.sender] -= amount;
    balanceOf[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
    return true;
}
```

- **`transfer`**: Allows a token holder to send tokens to another address. Updates balances and emits a `Transfer` event.

#### Approve Function

```solidity
function approve(address spender, uint amount) external returns (bool) {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
```

- **`approve`**: Allows a token holder to approve a spender to use a specified amount of their tokens. Updates the `allowance` mapping and emits an `Approval` event.

#### Transfer From Function

```solidity
function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
    allowance[sender][msg.sender] -= amount;
    balanceOf[sender] -= amount;
    balanceOf[recipient] += amount;
    emit Transfer(sender, recipient, amount);
    return true;
}
```

- **`transferFrom`**: Allows a spender (who has been approved) to transfer tokens from another address to a recipient. It adjusts balances and allowances accordingly and emits a `Transfer` event.

#### Mint Function

```solidity
function mint(uint amount) external {
    balanceOf[msg.sender] += amount;
    totalSupply += amount;
    emit Transfer(address(0), msg.sender, amount);
}
```

- **`mint`**: Allows the contract creator (or any address in this case) to create new tokens and increase the total supply. The `Transfer` event is emitted with `address(0)` as the sender to indicate the creation of new tokens.

#### Burn Function

```solidity
function burn(uint amount) external {
    balanceOf[msg.sender] -= amount;
    totalSupply -= amount;
    emit Transfer(msg.sender, address(0), amount);
}
```

- **`burn`**: Allows the token holder to destroy their own tokens, reducing both their balance and the total supply. The `Transfer` event is emitted with `address(0)` as the recipient to indicate the destruction of tokens.

### Summary

This contract implements basic ERC-20 functionality with additional features for minting and burning tokens. It allows for the transfer of tokens, approval of spending, and tracking of token balances and allowances. The minting and burning functions provide mechanisms to adjust the total supply of tokens.

## 'Vault' Contract Explanation 

```solidity 
