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
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Vault {
    IERC20 public immutable token;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function _mint(address _to, uint _shares) private {
        totalSupply += _shares;
        balanceOf[_to] += _shares;
    }

    function _burn(address _from, uint _shares) private {
        totalSupply -= _shares;
        balanceOf[_from] -= _shares;
    }

    function deposit(uint _amount) external {
        /*
        a = amount
        B = balance of token before deposit
        T = total supply
        s = shares to mint

        (T + s) / T = (a + B) / B 

        s = aT / B
        */
        uint shares;
        if (totalSupply == 0) {
            shares = _amount;
        } else {
            shares = (_amount * totalSupply) / token.balanceOf(address(this));
        }

        _mint(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint _shares) external {
        /*
        a = amount
        B = balance of token before withdraw
        T = total supply
        s = shares to burn

        (T - s) / T = (B - a) / B 

        a = sB / T
        */
        uint amount = (_shares * token.balanceOf(address(this))) / totalSupply;
        _burn(msg.sender, _shares);
        token.transfer(msg.sender, amount);
    }
}
```

This Solidity contract defines a `Vault` that interacts with an ERC-20 token, allowing users to deposit and withdraw tokens while managing shares within the vault. The contract follows a common pattern for vaults or liquidity pools, where users receive or redeem shares in exchange for tokens. Here's a detailed explanation of each component:

### 1. **Interface Declaration**

```solidity
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
```

- **`IERC20` Interface:** This defines the standard functions and events for ERC-20 tokens. The `Vault` contract interacts with ERC-20 tokens by using this interface.

### 2. **Vault Contract Declaration**

```solidity
contract Vault {
    IERC20 public immutable token;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token) {
        token = IERC20(_token);
    }
```

- **`IERC20 public immutable token;`**: This state variable holds the address of the ERC-20 token the vault will interact with. It’s marked as `immutable`, meaning it’s set only once during contract deployment and cannot be changed thereafter.
- **`uint public totalSupply;`**: This tracks the total supply of shares issued by the vault.
- **`mapping(address => uint) public balanceOf;`**: This mapping tracks the balance of shares held by each address.

### 3. **Mint and Burn Functions**

```solidity
function _mint(address _to, uint _shares) private {
    totalSupply += _shares;
    balanceOf[_to] += _shares;
}

function _burn(address _from, uint _shares) private {
    totalSupply -= _shares;
    balanceOf[_from] -= _shares;
}
```

- **`_mint`**: Increases the total supply of shares and updates the balance for the given address. It’s a private function, meaning it can only be called within this contract.
- **`_burn`**: Decreases the total supply of shares and updates the balance for the given address. It’s also a private function.

### 4. **Deposit Function**

```solidity
function deposit(uint _amount) external {
    /*
    a = amount
    B = balance of token before deposit
    T = total supply
    s = shares to mint

    (T + s) / T = (a + B) / B 

    s = aT / B
    */
    uint shares;
    if (totalSupply == 0) {
        shares = _amount;
    } else {
        shares = (_amount * totalSupply) / token.balanceOf(address(this));
    }

    _mint(msg.sender, shares);
    token.transferFrom(msg.sender, address(this), _amount);
}
```

- **`deposit`**: Allows users to deposit tokens into the vault. It calculates how many shares to mint based on the amount of tokens being deposited and the current balance of tokens in the vault. If the vault is empty (`totalSupply == 0`), it mints shares 1:1 with the deposited amount. Otherwise, it calculates the number of shares using the formula provided in the comment:
  \[
  s = \frac{aT}{B}
  \]
  where:
  - \( a \) = amount of tokens being deposited
  - \( B \) = current token balance of the vault
  - \( T \) = total supply of shares
  - \( s \) = number of shares to mint
- The `token.transferFrom` function transfers the deposited tokens from the user to the vault.

### 5. **Withdraw Function**

```solidity
function withdraw(uint _shares) external {
    /*
    a = amount
    B = balance of token before withdraw
    T = total supply
    s = shares to burn

    (T - s) / T = (B - a) / B 

    a = sB / T
    */
    uint amount = (_shares * token.balanceOf(address(this))) / totalSupply;
    _burn(msg.sender, _shares);
    token.transfer(msg.sender, amount);
}
```

- **`withdraw`**: Allows users to withdraw tokens from the vault by redeeming their shares. It calculates the amount of tokens to transfer based on the number of shares being burned and the current balance of tokens in the vault. The calculation is given by:
  \[
  a = \frac{sB}{T}
  \]
  where:
  - \( a \) = amount of tokens to withdraw
  - \( B \) = current token balance of the vault
  - \( T \) = total supply of shares
  - \( s \) = number of shares to burn
- The `token.transfer` function sends the calculated amount of tokens to the user.

### Summary

The `Vault` contract allows users to deposit and withdraw ERC-20 tokens while managing shares that represent ownership in the vault. The deposit function mints shares based on the amount of tokens deposited, and the withdraw function burns shares in exchange for tokens. This contract effectively provides a mechanism for users to participate in a tokenized vault system, where shares represent their stake or claim on the assets held by the vault.
