// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperTwoAttacker.sol";
import "../src/GatekeeperTwo.sol";

contract GateKeeperTwoTest is Test {
    GatekeeperTwo public gateKeeper;
    Attacker public attacker;

    address public PLAYER = makeAddr("player");

    function setUp() public {
        gateKeeper = new GatekeeperTwo();
    }

    function testExploit() public {
        // Arrange
        vm.prank(PLAYER, PLAYER);

        // Act
        attacker = new Attacker(address(gateKeeper));

        // assert
        assertEq(gateKeeper.entrant(), PLAYER);
    }
}
