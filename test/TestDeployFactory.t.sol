// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../script/DeployFactory.s.sol";
import {IUniV3Factory} from "../src/interfaces/IUniV3Factory.sol";

contract CounterTest is Test {

    IUniV3Factory public factory;

    function setUp() public {
        DeployFactory deployFactory = new DeployFactory();
        factory = IUniV3Factory(deployFactory.deployFactory(address(this)));
    }

    function testLogCode() public {
        assertEq(address(factory), 0x1F98431c8aD98523631AE4a59f267346ea31F984);
        assertTrue(address(factory).code.length > 0);
    }

    function testDeployedFactory() public {
        assertTrue(factory.owner() == address(this));
        assertEq(factory.feeAmountTickSpacing(500), 10);
    }

    function testDeployPool() public {
        address usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        assertEq(factory.getPool(usdc, weth, 500), address(0));
        address pool = factory.createPool(weth, usdc, 500);
        assertEq(pool, 0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640);
    }

}