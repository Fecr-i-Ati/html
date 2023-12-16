// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KullaniciBilgileri {
    struct Kullanici {
        string mersisNo;
        string firmaAdi;
        string eposta;
        string telefonNo;
        address walletAdresi;
    }

    mapping(address => Kullanici) public kullaniciBilgileri;

    function kullaniciBilgisiEkle(string memory _mersisNo, string memory _firmaAdi, string memory _eposta, string memory _telefonNo, address _walletAdresi) public {
        kullaniciBilgileri[_walletAdresi] = Kullanici(_mersisNo, _firmaAdi, _eposta, _telefonNo, _walletAdresi);
    }

    function mersisNoGetir(address _walletAdresi) public view returns (string memory) {
        return kullaniciBilgileri[_walletAdresi].mersisNo;
    }
}

contract UreticiKaydi {
    KullaniciBilgileri public kullaniciBilgileriContract;

    constructor(address _kullaniciBilgileriContractAdres) {
        kullaniciBilgileriContract = KullaniciBilgileri(_kullaniciBilgileriContractAdres);
    }

    function ureticiKaydiOlustur(string memory _mersisNo, string memory _firmaAdi, string memory _eposta, string memory _telefonNo, address _walletAdresi) public returns (bool) {
        // Kullanıcı bilgilerini ekleme
        kullaniciBilgileriContract.kullaniciBilgisiEkle(_mersisNo, _firmaAdi, _eposta, _telefonNo, _walletAdresi);

        // Diğer üretici kaydı kodları...

        // Üretici başarıyla eklendiğinden true döndür
        return true;
    }

    function kullaniciMersisNoGetir(address _walletAdresi) public view returns (string memory) {
        return kullaniciBilgileriContract.mersisNoGetir(_walletAdresi);
    }
}
