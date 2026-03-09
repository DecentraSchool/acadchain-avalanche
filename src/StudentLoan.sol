// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IRegistry {
    function isVerified(address student) external view returns (bool);
}

contract StudentLoan {

    IRegistry public registry;

    uint256 public loanCount;

    struct Loan {
        uint256 id;
        address borrower;
        address lender;
        uint256 amount;
        uint256 repaymentAmount;
        bool funded;
        bool repaid;
    }

    mapping(uint256 => Loan) public loans;

    event LoanRequested(
        uint256 indexed loanId,
        address indexed borrower,
        uint256 amount,
        uint256 repaymentAmount
    );

    event LoanFunded(
        uint256 indexed loanId,
        address indexed lender,
        uint256 amount
    );

    event LoanRepaid(
        uint256 indexed loanId,
        address indexed borrower,
        uint256 amount
    );

    constructor(address _registry) {
        registry = IRegistry(_registry);
    }

    /**
     * Student requests loan
     */
    function requestLoan(
        uint256 amount,
        uint256 repaymentAmount
    ) external {

        require(
            registry.isVerified(msg.sender),
            "Student not verified"
        );

        require(amount > 0, "Invalid loan amount");
        require(repaymentAmount > amount, "Invalid repayment");

        loanCount++;

        loans[loanCount] = Loan({
            id: loanCount,
            borrower: msg.sender,
            lender: address(0),
            amount: amount,
            repaymentAmount: repaymentAmount,
            funded: false,
            repaid: false
        });

        emit LoanRequested(
            loanCount,
            msg.sender,
            amount,
            repaymentAmount
        );
    }

    /**
     * Lender funds the loan
     */
    function fundLoan(uint256 loanId) external payable {

        Loan storage loan = loans[loanId];

        require(!loan.funded, "Loan already funded");
        require(msg.value == loan.amount, "Incorrect funding");

        loan.lender = msg.sender;
        loan.funded = true;

        payable(loan.borrower).transfer(msg.value);

        emit LoanFunded(
            loanId,
            msg.sender,
            msg.value
        );
    }

    /**
     * Borrower repays loan
     */
    function repay(uint256 loanId) external payable {

        Loan storage loan = loans[loanId];

        require(msg.sender == loan.borrower, "Not borrower");
        require(loan.funded, "Loan not funded");
        require(!loan.repaid, "Already repaid");

        require(
            msg.value == loan.repaymentAmount,
            "Incorrect repayment"
        );

        loan.repaid = true;

        payable(loan.lender).transfer(msg.value);

        emit LoanRepaid(
            loanId,
            msg.sender,
            msg.value
        );
    }

    /**
     * View loan details
     */
    function getLoan(uint256 loanId)
        external
        view
        returns (Loan memory)
    {
        return loans[loanId];
    }
}