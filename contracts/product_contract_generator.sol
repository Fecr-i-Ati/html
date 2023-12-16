// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductBarcodeGenerator {
    
    address public manufacturer;
    
    mapping(uint256 => bool) public barcodeExists;
    
    event BarcodeGenerated(uint256 indexed barcode, address indexed manufacturer);

    modifier onlyManufacturer() {
        require(msg.sender == manufacturer, "Sadece uretici yetkilisi");
        _;
    }

    constructor() {
        manufacturer = msg.sender;
    }

    function generateBarcode(uint256 _barcode) external onlyManufacturer {
        require(!barcodeExists[_barcode], "Bu barkod zaten kullanimda");
        
        barcodeExists[_barcode] = true;
        emit BarcodeGenerated(_barcode, msg.sender);
    }
}
