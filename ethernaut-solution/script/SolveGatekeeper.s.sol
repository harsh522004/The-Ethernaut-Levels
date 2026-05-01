// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Attacker.sol";

contract SolveGateKeeper is Script {
    function run() external{
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address levelInstance = 0x3e45589475dE34CE2830bf1725B4bF2522c8d897;
        new Attacker(levelInstance);
        vm.stopBroadcast();
    }
}