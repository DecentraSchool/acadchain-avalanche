// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AcadIDRegistry is Ownable {

    struct Student {
        string acadId;
        string metadataURI;   // IPFS credential proof
        bool verified;
    }

    mapping(address => Student) private students;

    event StudentRegistered(
        address indexed student,
        string acadId,
        string metadataURI
    );

    event StudentUpdated(
        address indexed student,
        string metadataURI
    );

    event VerificationRevoked(
        address indexed student
    );

    constructor() Ownable(msg.sender) {}

    
    function registerStudent(
        address student,
        string calldata acadId,
        string calldata metadataURI
    ) external onlyOwner {

        require(student != address(0), "Invalid address");
        require(!students[student].verified, "Already verified");

        students[student] = Student({
            acadId: acadId,
            metadataURI: metadataURI,
            verified: true
        });

        emit StudentRegistered(student, acadId, metadataURI);
    }

    
    function updateMetadata(
        address student,
        string calldata newMetadataURI
    ) external onlyOwner {

        require(students[student].verified, "Student not verified");

        students[student].metadataURI = newMetadataURI;

        emit StudentUpdated(student, newMetadataURI);
    }

   
    function revokeVerification(address student)
        external
        onlyOwner
    {
        require(students[student].verified, "Not verified");

        students[student].verified = false;

        emit VerificationRevoked(student);
    }

  
    function isVerified(address student)
        external
        view
        returns (bool)
    {
        return students[student].verified;
    }

 
    function getStudent(address student)
        external
        view
        returns (
            string memory acadId,
            string memory metadataURI,
            bool verified
        )
    {
        Student memory s = students[student];
        return (s.acadId, s.metadataURI, s.verified);
    }

}
