// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC1967Proxy} from "lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Script} from "lib/forge-std/src/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1();
        vm.stopBroadcast();
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");

        return address(proxy);
    }
}
