AcadChain

AcadChain transforms verified student credentials into on-chain scholarships and student loans using decentralized identity and programmable finance on the Avalanche network.

Instead of relying on manual verification, opaque scholarship committees, or traditional credit scores, AcadChain introduces a trust-minimized funding infrastructure where verified academic credentials unlock transparent financial access.

✅ Built on Avalanche C-Chain
✅ Smart Contracts Deployed on Avalanche Fuji Testnet
✅ On-Chain Student Verification (ACAD ID)
✅ Scholarship Pool Funding Mechanism
✅ Decentralized Student Loan Protocol

Overview

AcadChain introduces a blockchain-based education financing system where academic identity becomes a financial primitive.

Students receive an ACAD ID, a verified on-chain credential representing their academic profile. Once verified, students can interact directly with scholarship pools and lending protocols without requiring centralized financial intermediaries.

The system removes reliance on traditional credit scoring and instead enables merit-based financial access powered by verified credentials.

         ✨ Built on Avalanche • ⚙️ Smart Contract Infrastructure
         

Core Principles
1) Verifiable Academic Identity

Students receive a unique ACAD ID that anchors verified academic credentials to their wallet. Credential metadata is stored on decentralized storage while verification proofs exist on-chain.

2) Merit-Based Financial Access

Instead of credit scores, verified academic achievements determine eligibility for scholarships and loans.

3) Transparent Funding Infrastructure

Scholarship pools and lending transactions are executed entirely via smart contracts, making funding decisions transparent and auditable.

4) Trust-Minimized Verification

All eligibility checks are performed on-chain through the ACAD ID Registry, eliminating manual document verification.

5) Non-Custodial Financial System

Students maintain full custody of their wallets at all times. Funds are transferred directly between contracts and user wallets.



Features
ACAD ID Verification System

The AcadIDRegistry contract provides the identity layer of the system.

Features:

Register verified students

Store credential metadata (IPFS reference)

Provide on-chain verification checks

Enable eligibility checks for financial services

Functions:

         registerStudent(address student, string acadId, string metadataURI)
         isVerified(address student)
         getStudent(address student)

Scholarship Funding Pools

The ScholarshipPool contract allows organizations or DAOs to fund scholarships.

Features:

Funders deposit AVAX into scholarship pools

Verified students apply for scholarships

Admin approval triggers automated fund distribution

Transparent scholarship allocation

Key Functions:

       fundPool()
       applyForScholarship(uint256 amount)
       approve(uint256 applicationId)
       getPoolBalance()

Student Loan Protocol

The StudentLoan contract enables decentralized student loans.

Features:

Verified students request loans

Lenders fund loan requests

Borrowers repay loans with interest

Transparent loan lifecycle tracking

Key Functions:

         requestLoan(uint256 amount, uint256 repaymentAmount)
         fundLoan(uint256 loanId)
         repay(uint256 loanId)
         getLoan(uint256 loanId)

Usage Guide
1) Verify Student

An institution or admin registers a student with an ACAD ID.

        registerStudent(
        studentAddress,
        "ACAD123",
        "ipfs://credential-metadata"
        )
This creates a verified on-chain identity.

2) Fund Scholarship Pool

Organizations deposit AVAX to fund scholarships.

      fundPool()
This creates available capital for student applications.

3) Apply for Scholarship

Verified students submit scholarship applications.

      applyForScholarship(amount)

The system verifies the student through the ACAD ID registry.

4) Approve Scholarship

Admin approves scholarship applications.

        approve(applicationId)

Funds are automatically transferred to the student.


5) Request Student Loan

Students can request loans directly.

         requestLoan(
         loanAmount,
         repaymentAmount
         )

6) Fund Loan

A lender funds the loan request.

        fundLoan(loanId)

The student receives funds instantly.

7) Repay Loan

Borrowers repay loans through the smart contract.

        repay(loanId)

Loan status updates on-chain.


Architecture

           ┌──────────── Student Wallet ────────────┐
                                │
                         Connect Wallet
                                │
                    ┌───────────▼───────────┐
                    │     ACAD ID Registry  │
                    │ (Student Verification)│
                    └───────────┬───────────┘
                                │
               ┌────────────────▼───────────────┐
               │       Eligibility Check        │
               └───────────┬───────────┬────────┘
                           │           │
             ┌─────────────▼───┐   ┌───▼─────────────┐
             │ ScholarshipPool │   │   StudentLoan   │
             │  Funding Pools  │   │ Loan Protocol   │
             └─────────┬───────┘   └───────┬─────────┘
                       │                   │
                ┌──────▼──────┐     ┌──────▼──────┐
                │ Scholarship │     │ Loan Funding│
                │ Distribution│     │ & Repayment │
                └─────────────┘     └─────────────┘


Running Tests

This project uses Foundry.

Install Foundry:

       curl -L https://foundry.paradigm.xyz | bash
       foundryup

Run tests:

       forge test -vvvv
Deployed Contracts

Network:

Avalanche Fuji Testnet

AcadIDRegistry
          
          0x92a61054c1aE91Fad5089a02B24b07d60BaBeBBc

Explorer:

         https://testnet.snowtrace.io/address/0x92a61054c1aE91Fad5089a02B24b07d60BaBeBBc
         
ScholarshipPool:

         0x393f05632c0f76382B66811Ac7b71609d2f7edA5

Explorer:

         https://testnet.snowtrace.io/address/0x393f05632c0f76382B66811Ac7b71609d2f7edA5
         
StudentLoan:

         0x88AaF57ac739f630CA56E98e91ace8EEF14467f1

Explorer:

         https://testnet.snowtrace.io/address/0x88AaF57ac739f630CA56E98e91ace8EEF14467f1



Security Model:

Only verified students can access scholarships and loans

ACAD ID verification controlled by registry owner

Scholarship approvals restricted to pool owner

Loan repayment enforced through smart contracts

No centralized custody of funds

All transactions are fully verifiable on-chain.
