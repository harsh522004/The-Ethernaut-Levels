# Ethernaut

### Level 6: Delegation

Date: 23-04-2026

Difficulty: Simple (if you know about `delegatecall`)

Think of `delegatecall` like **hiring a contractor to work in your house, using your tools and your address.**

- Normal `call`: *"Hey Contract B, do this task using your own stuff"*
- `delegatecall`: *"Hey Contract B, lend me your logic/code, but run it in my context (my storage, my balance, my address)"*

![delegation_diagram](images/delegation_diagram.png)

#### Approach:

- I think I just need to trigger the `fallback` of the Delegation contract with the method signature of the `pwn` function.
- But how do I get the signature of the `pwn` function's data?

`bytes4(keccak256("pwn()"))` → returns `0xdd365b8b`

```jsx
await web3.eth.sendTransaction({
  from: player,
  to: instance,
  data: "0xdd365b8b"
})
```

---

### Level 7: Force

Date: 23-04-2026

Difficulty: Simple

Key Learnings:

- So, I explored some ways to send value to any contract.
- If our function call is wrong and `fallback` and `receive` functions exist, then we have a way to send value. But if nothing exists, then there are very few ways:
    - The "Self-Destruct" - When a contract is destroyed, it **must** send its remaining ETH to a target address. This transfer bypasses all code.
    - Pre-calculation - Contract addresses are deterministic (calculated based on the creator's address and their transaction count). You can calculate what a contract's address will be, send ETH to that address now, and then deploy the contract later.
    - Block Rewards
- I thought the latest Solidity had removed the concept of `selfdestruct`, so I deployed my contract with an old Solidity version:

```jsx
function deposit() external payable {}

function selfDestroy(address payable _recipient) public {
    selfdestruct(_recipient);
}
```

- First, I sent some value via `deposit`, and then I simply called `selfDestroy` and passed the address of the game contract instance. And it worked.

---

### Level 8: Vault

Date: 23-04-2026

Difficulty: Simple

#### Approach:

- I had read somewhere that nothing is hidden in the blockchain, not even your private fields. It just introduces an access layer, but we can see the value of it.
- So, here, the first thought that came to my mind was: simply go to Etherscan on Sepolia and check the private variable value. But eventually, the contract is not deployed on Sepolia; it's only within a browser-specific environment.
- So, I got to know about the syntax:

```jsx
await web3.eth.getStorageAt(contractAddress, 1) // 1 is the slot of the variable
```

- Which returns a bytes32 value "0x412076657279207374726f6e67207365637265742070617373776f7264203a2900" → `A very strong secret password :)`