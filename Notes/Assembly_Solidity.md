* * * * *

#### What is `assembly` in Solidity? [click here](https://docs.soliditylang.org/en/v0.4.23/assembly.html)

When you write an `assembly` block, you step out of normal Solidity and into a lower-level language called **Yul / EVM assembly**.

```
assembly {
    // low-level code
}

```

Solidity is high-level --- comfortable and safe. Assembly is low-level --- raw control, less safety.

* * * * *

#### Why does `assembly` exist?

Solidity sometimes hides important details. Assembly lets you:

-   Access EVM internals
-   Use opcodes directly
-   Optimize gas
-   Do things Solidity normally restricts

Tradeoff: you lose safety checks and readability.

* * * * *

#### Key components

**Stack** EVM is stack-based. Temporary values live here, max depth 1024, operations push/pop values. You don't directly see the stack in Solidity, but assembly uses it internally.

```
PUSH 5
PUSH 3
ADD → result = 8

```

**Memory** Temporary and mutable. Cleared between external calls. Used for function arguments, return values. Think of it as the RAM of the EVM.

**Storage** Permanent, stored on-chain, expensive to write. Think of it as the database of your contract.

* * * * *

#### Common syntax

```
// Variable declaration
let x := 5

// Arithmetic
let z := add(x, y)
let z := sub(x, y)
let z := mul(x, y)
let z := div(x, y)

// Comparison
eq(x, y)   // x == y
lt(x, y)   // x < y
gt(x, y)   // x > y

// Control flow
if eq(x, 10) {
    // do something
}

// Loop
for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
    // loop body
}

```

Everything is function-style. No operators like `+` or `==`.

* * * * *

#### Important built-in functions

`extcodesize(addr)` --- returns the code size at an address. During a constructor, this returns `0`. This is a key insight for **Gatekeeper Two**.

-   EOA → code size = **0**
-   Contract (after deployment) → code size = **> 0**
-   Contract (inside constructor) → code size = **0** (important edge case)

```
let size := extcodesize(addr)

```

`caller()` --- equivalent to `msg.sender`

`origin()` --- equivalent to `tx.origin`

`gas()` --- remaining gas at that point

`keccak256(ptr, size)` --- hash function

* * * * *

#### Memory operations

```
mstore(ptr, value)   // write to memory
mload(ptr)           // read from memory

```

Memory is manually managed in assembly. Deep mastery isn't needed yet --- just know it exists and works differently from storage.

* * * * *

#### Type system

In Solidity you declare types explicitly. In assembly, everything is just a **256-bit number** --- no strict types.

```
let x := 5   // no uint256, no type annotation

```

Types like `bytes8` or `uint64` are just bit manipulations under the hood.