// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleContract {
    uint256 private immutable number;

    constructor(uint256 _number) {
        number = _number;
    }

    function getNumber() external view returns(uint256) {
        return number;
    }
}