// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SimpleContract.sol";

import "openzeppelin-contracts/contracts/proxy/Clones.sol";

contract CloneTest is Test {
    
    function test_fuzz_predictDeterministicAddressDeployer(address deployer) external {
        bytes32 salt = keccak256(abi.encodePacked("the salt"));
        uint256 number = 77;

        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }
}