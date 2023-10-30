// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Wethy} from "../contracts/Wethy.sol";

contract WethyTest is Test {

    address account = 0x0000000000000000000000000000000000003511;

    Wethy wethy;

    function setUp() public {

        vm.warp(1641070800); 
        vm.startPrank(account);

        // Deploy a new Wethy contract
        wethy = new Wethy(account, "First", "FST");

    }

    function test_Owner() public {

        // Make sure the owner is set correctly
        assertEq(wethy.owner(), account);

    }

}
