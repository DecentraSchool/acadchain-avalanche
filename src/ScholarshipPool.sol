// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAcadRegistry {
    function isVerified(address student) external view returns (bool);
}

contract ScholarshipPool {

    IAcadRegistry public registry;
    address public owner;

    uint256 public applicationCount;

    struct Application {
        uint256 id;
        address student;
        uint256 amount;
        bool approved;
    }

    mapping(uint256 => Application) public applications;
    mapping(address => bool) public hasApplied;

    event ScholarshipApplied(
        uint256 indexed id,
        address indexed student,
        uint256 amount
    );

    event ScholarshipApproved(
        uint256 indexed id,
        address indexed student,
        uint256 amount
    );

    event PoolFunded(address indexed funder, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _registry) {
        registry = IAcadRegistry(_registry);
        owner = msg.sender;
    }

    /**
     * Fund the scholarship pool
     */
    function fundPool() external payable {
        require(msg.value > 0, "Must send AVAX");
        emit PoolFunded(msg.sender, msg.value);
    }

    /**
     * Student applies for scholarship
     */
    function applyForScholarship(uint256 amount) external {

        require(
            registry.isVerified(msg.sender),
            "Student not verified"
        );

        require(!hasApplied[msg.sender], "Already applied");

        require(amount > 0, "Invalid amount");

        applicationCount++;

        applications[applicationCount] = Application({
            id: applicationCount,
            student: msg.sender,
            amount: amount,
            approved: false
        });

        hasApplied[msg.sender] = true;

        emit ScholarshipApplied(
            applicationCount,
            msg.sender,
            amount
        );
    }

    /**
     * Approve scholarship and send funds
     */
    function approve(uint256 id) external onlyOwner {

        Application storage app = applications[id];

        require(!app.approved, "Already approved");
        require(
            address(this).balance >= app.amount,
            "Insufficient pool funds"
        );

        app.approved = true;

        payable(app.student).transfer(app.amount);

        emit ScholarshipApproved(
            id,
            app.student,
            app.amount
        );
    }

    /**
     * Check pool balance
     */
    function getPoolBalance()
        external
        view
        returns (uint256)
    {
        return address(this).balance;
    }
}