### Level 12: Privacy

**Date:** 27-04-2026\
**Difficulty:** Easy if you are familiar with the concepts

#### Learning:

### 1\. Storage

-   State variables are stored on-chain in 32-byte **slots** (starting from slot `0`).
-   `uint256` always occupies its own full slot.
-   Smaller types (`uint8`, `uint16`, `bool`) are **packed together** into a single slot to save gas.
-   `private` only restricts access from other contracts --- anyone can still read the data off-chain. Nothing on a public blockchain is truly hidden.

* * * * *

### 2\. Parameter Passing

-   `memory` parameters are **temporary** --- they exist only during the function call.
-   Assigning a `memory` variable to a state variable **copies** it into permanent storage.
-   Parameters are always **copied in** --- modifying them inside a function does not affect the caller's original data.

* * * * *

### 3\. Casting

-   **`bytes` types** are left-aligned → casting down keeps the **first (leftmost) bytes** and drops the rest.
-   **`uint` types** are right-aligned → casting down keeps the **last (rightmost) bytes** and drops the rest.

| Cast | Keeps |
| --- | --- |
| `bytes32` → `bytes16` | First 16 bytes |
| `uint256` → `uint16` | Last 2 bytes |

 // Read slot 5\
let data = await web3.eth.getStorageAt(contract.address, 5);

// Convert bytes32 to bytes16\
let key = data.slice(0, 34);

// Unlock contract\
await contract.unlock(key);

* * * * *