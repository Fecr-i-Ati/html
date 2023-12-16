// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductContract {
    address public owner;

    struct Product {
        string name;
        string contents;
        string productType;
        string category;
        uint256 producerId;
        bool typeChangeable;
    }

    Product public product;

    event ProductInfoUpdated(
        string name,
        string contents,
        string productType,
        string category,
        uint256 producerId
    );

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can call this function"
        );
        _;
    }

    modifier typeChangeable() {
        require(
            product.typeChangeable,
            "Product type can only be changed once"
        );
        _;
    }

    constructor(
        string memory _name,
        string memory _contents,
        string memory _productType,
        string memory _category,
        uint256 _producerId
    ) {
        owner = msg.sender;
        product = Product({
            name: _name,
            contents: _contents,
            productType: _productType,
            category: _category,
            producerId: _producerId,
            typeChangeable: true
        });
    }

    function updateProductInfo(
        string memory _name,
        string memory _contents,
        string memory _productType,
        string memory _category,
        uint256 _producerId
    ) external onlyOwner {
        product.name = _name;
        product.contents = _contents;
        product.productType = _productType;
        product.category = _category;
        product.producerId = _producerId;
        emit ProductInfoUpdated(
            _name,
            _contents,
            _productType,
            _category,
            _producerId
        );
    }

    function changeProductType(
        string memory _newType
    ) external onlyOwner typeChangeable {
        product.productType = _newType;
        product.typeChangeable = false;
        emit ProductInfoUpdated(
            product.name,
            product.contents,
            _newType,
            product.category,
            product.producerId
        );
    }
}
