// SPDX-License-Identifier: MIT
pragma solidity ^0.8.32;

import "forge-std/Test.sol";

contract PredictContractAddress is Test {
    address public constant RECOVERY_CONTRACT_ADDRESS =
        0xf7BAfB833B437E03B74a3806602488AE8Cd75f97;

    function testPredictContractAddress() public {
        address target = vm.computeCreateAddress(RECOVERY_CONTRACT_ADDRESS, 1);
        console.log("Predicted Address:", target);
        assertTrue(target != address(0));
    }
}
