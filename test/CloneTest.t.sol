// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SimpleContract.sol";

import "openzeppelin-contracts/contracts/proxy/Clones.sol";

contract CloneTest is Test {
    
    // FUZZ DEPLOYER
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

    // FUZZ DEPLOYER, SALT
    function test_fuzz_predictDeterministicAddressSalt(address deployer, bytes32 salt) external {
        uint256 number = 77;

        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }

    // FUZZ DEPLOYER, SALT, NUMBER
    function test_fuzz_predictDeterministicAddressNumber(address deployer, bytes32 salt, uint256 number) external {
        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }

}