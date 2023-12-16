// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthProductSupplyChain {

    address public firma;
    address public tedarikci;
    address public tuketici;

    bool public firmaOnaylandi;
    bool public tedarikciOnaylandi;
    bool public tuketiciOnaylandi;

    event FirmaOnaylandi();
    event TedarikciOnaylandi();
    event TuketiciOnaylandi();

    modifier onlyFirma() {
        require(msg.sender == firma, "Sadece firma yetkilisi");
        _;
    }

    modifier onlyTedarikci() {
        require(msg.sender == tedarikci, "Sadece tedarikci yetkilisi");
        _;
    }

    modifier onlyTuketici() {
        require(msg.sender == tuketici, "Sadece tuketici yetkilisi");
        _;
    }

    modifier notOnaylandi(bool onayDurumu) {
        require(!onayDurumu, "islem zaten onaylandi");
        _;
    }

    constructor(address _tedarikci, address _tuketici) {
        firma = msg.sender;
        tedarikci = _tedarikci;
        tuketici = _tuketici;
    }

    function firmaOnayla() external onlyFirma notOnaylandi(firmaOnaylandi) {
        firmaOnaylandi = true;
        emit FirmaOnaylandi();
    }

    function tedarikciOnayla() external onlyTedarikci notOnaylandi(tedarikciOnaylandi) {
        require(firmaOnaylandi, "Firma henuz onaylanmamis");
        tedarikciOnaylandi = true;
        emit TedarikciOnaylandi();
    }

    function tuketiciOnayla() external onlyTuketici notOnaylandi(tuketiciOnaylandi) {
        require(firmaOnaylandi && tedarikciOnaylandi, "Firma veya tedarikci henuz onaylanmamis");
        tuketiciOnaylandi = true;
        emit TuketiciOnaylandi();
    }
}
