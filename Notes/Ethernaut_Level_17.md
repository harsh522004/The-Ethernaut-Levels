### Level 17: Recovery

-   **Date:** 06-06-2026
-   **Difficulty:** Easy

* * * * *

### Thinking

-   First, I analyzed the challenge objective instead of getting distracted by bugs in `transfer()` or token accounting.
-   The main challenge was not about stealing tokens, but about recovering ETH from a "lost" contract.
-   `Recovery` acts as a factory contract and deploys `SimpleToken` contracts using the `CREATE` opcode.
-   The factory does not store deployed token addresses, which initially makes it seem like the token contract address is lost.
-   I learned that contract addresses created with `CREATE` are deterministic and can be reconstructed.
-   The address of a deployed contract depends on:
    -   The deployer address.
    -   The deployer's nonce at the time of deployment.

```
Address = Keccak256(RLP([deployer_address, nonce]))[-20:]

```

-   Since the challenge mentions the **first token contract**, the deployment nonce becomes an important clue.
-   The `SimpleToken` contract contains a public `destroy()` function that can remove the contract and transfer all ETH held by it to a specified address.

* * * * *

### Learning

-   Learned how contract addresses are generated when using the `CREATE` opcode.
-   Learned that deployed contract addresses are deterministic, not random.
-   Learned that even if a factory contract does not store child contract addresses, they can still be reconstructed if the deployer address and nonce are known.
-   Understood the difference between contract deployment using `CREATE` and simply looking up deployment history on a block explorer.
-   Learned to focus on the actual challenge objective instead of getting distracted by unrelated bugs in the code.
-   Observed a major security issue: `destroy()` has no access control, meaning any user can trigger contract destruction and redirect the contract's ETH balance.