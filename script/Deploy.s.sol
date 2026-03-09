// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import "../src/AcadIDRegistry.sol";
import "../src/ScholarshipPool.sol";
import "../src/StudentLoan.sol";

contract Deploy is Script {

    function run() external {

        // Start broadcasting using the private key passed via CLI
        vm.startBroadcast();

        // Deploy AcadID Registry
        AcadIDRegistry registry = new AcadIDRegistry();

        console2.log("AcadIDRegistry deployed at:", address(registry));

        // Deploy Scholarship Pool
        ScholarshipPool scholarship = new ScholarshipPool(address(registry));

        console2.log("ScholarshipPool deployed at:", address(scholarship));

        // Deploy Student Loan
        StudentLoan loan = new StudentLoan(address(registry));

        console2.log("StudentLoan deployed at:", address(loan));

        vm.stopBroadcast();
    }
}