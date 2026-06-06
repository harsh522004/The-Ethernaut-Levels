// SPDX-License-Identifier: MIT
pragma solidity ^0.8.32;

import "forge-std/Script.sol";

contract RecoverETH is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address originContract = 0xf7BAfB833B437E03B74a3806602488AE8Cd75f97;

        address target = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            originContract,
                            bytes1(0x01)
                        )
                    )
                )
            )
        );
        address to = vm.addr(deployerPrivateKey);

        console.log("Target address:", target);
        console.log("Recipient address:", to);

        vm.startBroadcast(deployerPrivateKey);
        (bool success, ) = target.call(
            abi.encodeWithSignature("destroy(address)", to)
        );
        require(success, "Call failed");
        vm.stopBroadcast();
    }
}
