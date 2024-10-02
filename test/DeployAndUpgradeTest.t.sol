// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgrade is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    BoxV1 box1;
    BoxV2 box2;
    address proxy;

    function setUp() external {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    function test_proxyIsOfVersionOne() public view {
        assert(1 == BoxV2(proxy).getVersion());
    }

    function test_upgrades() public {
        box2 = new BoxV2();
        upgrader.upgradeContract(proxy, address(box2));

        uint256 expectedVersion = 2;

        assertEq(expectedVersion, BoxV2(proxy).getVersion());

        BoxV2(proxy).setValue(7);

        assertEq(7, BoxV2(proxy).getValue());
    }
}
