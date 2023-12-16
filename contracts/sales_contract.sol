// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SalesContract {
    address public manufacturer;
    address public buyer;
    uint256 public barcode;
    string public medicineType;
    uint256 public price;
    bool public isPaid;

    event PurchaseConfirmed(address indexed buyer, uint256 amount);

    modifier onlyManufacturer() {
        require(
            msg.sender == manufacturer,
            "Only manufacturer can call this function"
        );
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this function");
        _;
    }

    modifier onlyParties() {
        require(
            msg.sender == manufacturer || msg.sender == buyer,
            "Only parties involved can call this function"
        );
        _;
    }

    constructor(
        address _buyer,
        uint256 _barcode,
        string memory _medicineType,
        uint256 _price
    ) {
        manufacturer = msg.sender;
        buyer = _buyer;
        barcode = _barcode;
        medicineType = _medicineType;
        price = _price;
        isPaid = false;
    }

    function confirmPurchase() external payable onlyBuyer {
        require(msg.value == price, "Incorrect amount sent");
        isPaid = true;
        emit PurchaseConfirmed(msg.sender, msg.value);
    }

    function releasePayment() external onlyManufacturer {
        require(isPaid, "Payment has not been made yet");
        payable(manufacturer).transfer(address(this).balance);
        isPaid = false;
    }
}
