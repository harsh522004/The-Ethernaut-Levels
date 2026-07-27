// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";

contract DeployMagicNumber is Script {
    function run() external returns (address deployedAddress) {
        bytes memory magicNumber = hex"67602a5f5260205ff360005260076019f3";
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        assembly {
            deployedAddress := create(
                0,
                add(magicNumber, 0x20),
                mload(magicNumber)
            )
        }
        vm.stopBroadcast();
        require(deployedAddress != address(0), "Deployment failed!");
        console2.log("Raw Bytecode Contract Deployed at:", deployedAddress);
    }
}
