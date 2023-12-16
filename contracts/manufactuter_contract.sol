// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ManufacturerContract {
    address public owner;
    string public mersisNumber;
    string public manufacturerName;
    string public companyNumber;

    event ManufacturerInfoUpdated(
        string mersisNumber,
        string manufacturerName,
        string companyNumber
    );

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can call this function"
        );
        _;
    }

    constructor(
        string memory _mersisNumber,
        string memory _manufacturerName,
        string memory _companyNumber
    ) {
        owner = msg.sender;
        mersisNumber = _mersisNumber;
        manufacturerName = _manufacturerName;
        companyNumber = _companyNumber;
    }

    function updateManufacturerInfo(
        string memory _mersisNumber,
        string memory _manufacturerName,
        string memory _companyNumber
    ) external onlyOwner {
        mersisNumber = _mersisNumber;
        manufacturerName = _manufacturerName;
        companyNumber = _companyNumber;
        emit ManufacturerInfoUpdated(
            _mersisNumber,
            _manufacturerName,
            _companyNumber
        );
    }
}
