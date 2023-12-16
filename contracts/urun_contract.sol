// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract urun_contract {

  enum Durum {
    YerliUretim,
    OzelUretim
  }

  struct IsletmeBilgileri {
    string isletmeOnayNumarasi;
    bool satildimi;
  }

  struct urun {
    string urun_ismi;
    string uretici;
    string onayNumarasi;
    Durum durum;
    IsletmeBilgileri isletmeBilgileri;
  }

  mapping(string => urun) public urunler;

  function urunEkle(
    string memory _urunIsmi,
    string memory _hashedId,
    string memory _uretici,
    string memory _onayNumarasi,
    string memory _isletmeOnayNumarasi,
    Durum _durum
  ) external {
    require(bytes(urunler[_hashedId].urun_ismi).length == 0, "Product already exists");

    urunler[_hashedId] = urun({
      urun_ismi: _urunIsmi,
      uretici: _uretici,
      onayNumarasi: _onayNumarasi,
      durum: _durum,
      isletmeBilgileri: IsletmeBilgileri({
        isletmeOnayNumarasi: _isletmeOnayNumarasi,
        satildimi: false // Default to false
      })
    });
  }

  function urunSorgula(string memory _hashedId) external view returns (
    string memory urunIsmi,
    string memory uretici,
    string memory onayNumarasi,
    Durum durum,
    string memory isletmeOnayNumarasi,
    bool satildimi
  ) {
    urun memory queriedUrun = urunler[_hashedId];
    require(bytes(queriedUrun.urun_ismi).length > 0, "Product not found");

    return (
      queriedUrun.urun_ismi,
      queriedUrun.uretici,
      queriedUrun.onayNumarasi,
      queriedUrun.durum,
      queriedUrun.isletmeBilgileri.isletmeOnayNumarasi,
      queriedUrun.isletmeBilgileri.satildimi
    );
  }

  function urunGuncelle(
    string memory _hashedId,
    string memory _urunIsmi,
    string memory _uretici,
    string memory _onayNumarasi,
    string memory _isletmeOnayNumarasi,
    Durum _durum
  ) external {
    urun storage updatedUrun = urunler[_hashedId];
    require(bytes(updatedUrun.urun_ismi).length > 0, "Product not found");

    updatedUrun.urun_ismi = _urunIsmi;
    updatedUrun.uretici = _uretici;
    updatedUrun.onayNumarasi = _onayNumarasi;
    updatedUrun.durum = _durum;
    updatedUrun.isletmeBilgileri.isletmeOnayNumarasi = _isletmeOnayNumarasi;
  }

  function urunSatildi(string memory _hashedId) external {
    urun storage soldProduct = urunler[_hashedId];
    require(bytes(soldProduct.urun_ismi).length > 0, "Product not found");

    soldProduct.isletmeBilgileri.satildimi = true;
  }
}
