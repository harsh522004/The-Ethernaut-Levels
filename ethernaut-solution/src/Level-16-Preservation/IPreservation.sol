// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation {
    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) external ;
    function owner() external view returns (address);
}
