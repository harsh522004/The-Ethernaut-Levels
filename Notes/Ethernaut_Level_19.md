Goal
----

Deploy a **Solver** contract that always returns the number **42** (`uint256`) while keeping the **runtime bytecode ≤ 10 bytes**.

* * * * *

Key Concepts Learned
====================

1\. Runtime Code vs Creation Code
---------------------------------

Every smart contract consists of two different programs.

### Creation Code

-   Executes **only once** during deployment.

-   Responsible for creating the contract.

-   Returns the runtime bytecode.

-   Disappears after deployment.

### Runtime Code

-   Stored permanently on-chain.

-   Executes whenever someone calls the contract.

-   Must satisfy the challenge's **10-byte limit**.

**Important:** The 10-byte limit applies only to the **runtime code**, not the creation code.

* * * * *

2\. EVM is a Stack Machine
--------------------------

Unlike Solidity, EVM instructions do not receive arguments directly.

Instead, every opcode takes its inputs from the **stack**.

Example:

```
MSTORE(offset, value)

```

Internally:

```
Stack
-----
value
offset

```

`MSTORE` pops both values from the stack and stores the value in memory.

**Golden Rule**

> If an opcode needs data, that data must already be on the stack.

* * * * *

3\. Memory vs Stack vs Storage
------------------------------

| Component | Lifetime | Purpose |
| --- | --- | --- |
| Stack | Temporary | Working area for opcodes |
| Memory | Temporary | Data during one execution |
| Storage | Permanent | Blockchain state |

For this challenge:

-   Stack holds temporary values.

-   Memory stores the return value.

-   Storage is never used.

* * * * *

4\. ABI Return Format
---------------------

Returning a `uint256` means returning **32 bytes**.

Example:

```
42

```

becomes

```
0x000000000000000000000000000000000000000000000000000000000000002a

```

Therefore:

```
MSTORE(0x00, 42)
RETURN(0x00, 0x20)

```

returns the correct ABI-encoded value.

* * * * *

5\. No Function Dispatcher Needed
---------------------------------

Normally Solidity generates code to:

-   Read calldata

-   Extract function selector

-   Jump to the correct function

-   Execute fallback if needed

In this challenge we wrote the runtime ourselves.

Therefore the contract simply:

```
Receive any call
      ↓
Return 42

```

No dispatcher.\
No fallback.\
No function selector.

* * * * *

6\. Bytecode is Machine Code
----------------------------

Each EVM opcode has a predefined hexadecimal value.

Example:

| Opcode | Hex |
| --- | --- |
| PUSH1 | 60 |
| PUSH0 | 5f |
| MSTORE | 52 |
| RETURN | f3 |

The EVM reads bytecode one byte at a time.

Example:

```
602a5f5260205ff3

```

is interpreted as

```
PUSH1 0x2a
PUSH0
MSTORE
PUSH1 0x20
PUSH0
RETURN

```

No separators are needed because every opcode defines how many bytes it consumes.

* * * * *

7\. PUSH Instructions
---------------------

Most opcodes occupy only **1 byte**.

`PUSH` instructions are different.

Example:

```
PUSH1 0x2a

```

becomes

```
60 2a

```

-   `60` → PUSH1 opcode

-   `2a` → Immediate value

Similarly,

```
PUSH2 0x1234

```

becomes

```
61 12 34

```

* * * * *

8\. Program Counter (PC)
------------------------

The EVM executes bytecode sequentially.

For each instruction:

1.  Read opcode.

2.  If it is `PUSHn`, read the next `n` bytes as data.

3.  Execute instruction.

4.  Move Program Counter (PC) to the next instruction.

* * * * *

9\. Runtime Logic
-----------------

The runtime performs only two logical operations:

```
Store 42 into memory
Return 32 bytes from memory

```

Conceptually:

```
MSTORE(0x00, 42)
RETURN(0x00, 0x20)

```

* * * * *

10\. Runtime Bytecode
---------------------

Opcode sequence:

```
PUSH1 0x2a
PUSH0
MSTORE
PUSH1 0x20
PUSH0
RETURN

```

Raw bytecode:

```
0x602a5f5260205ff3

```

Runtime size:

```
8 bytes

```

* * * * *
