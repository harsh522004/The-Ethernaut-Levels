### Level 14: Gatekeeper Two

-   **Date:** 01-05-2026
-   **Difficulty:** Medium

From this level, I have shifted to Foundry for writing and testing contracts.

#### Thinking

-   Learn about assembly
-   Learn about bitwise operations

#### Gate Two

-   The contract code size must be 0. This is only possible when the caller is an EOA or the contract has not been deployed yet.
-   One thing is certain: the function call must be made within the constructor of my contract.

#### Gate Three

-   Learn about:
    -   `abi.encodePacked(msg.sender)` --- Turns the value into raw bytes
    -   `keccak256(...)` --- Returns a fixed 32-byte hash
    -   `type(uint64).max` --- The maximum value a `uint64` can hold
-   `A ^ B = C`, or equivalently: `B = A ^ C`, where:
    -   `A` = `uint64(bytes8(keccak256(abi.encodePacked(msg.sender))))`
    -   `B` = `uint64(_gateKey)`
    -   `C` = `type(uint64).max` --- all 64 bits set to 1

```
function generateGateKey(address _address) public pure returns (uint64) {
    uint64 hashPart = uint64(bytes8(keccak256(abi.encodePacked(_address))));
    return hashPart ^ type(uint64).max;
}

```