const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.set('view engine', 'ejs');

app.use(express.static('public'));

// Middleware olarak body-parser eklemek
app.use(bodyParser.urlencoded({ extended: false }));

// MySQL bağlantısı oluşturun
const db = mysql.createConnection({
  host: 'localhost', // MySQL sunucusunun adresi
  user: 'root', // MySQL kullanıcı adı
  password: '', // MySQL şifresi
  database: 'e-saglik' // Veritabanı adı
});

// MySQL bağlantısını açın
db.connect((err) => {
  if (err) {
    console.error('MySQL bağlantısı kurulamadı: ' + err.stack);
    return;
  }
  console.log('MySQL bağlantısı başarıyla kuruldu, bağlantı ID: ' + db.threadId);
});





app.get('/uretici_kayit', (req, res) => {
  res.render('uretici_kayit');
});



app.get('/satici_kayit', (req, res) => {
  res.render('satici_kayit');
});

app.get('/satici_dogrulama_satis', (req, res) => {
  res.render('satici_dogrulama_satis');
});
app.get('/son_kullanici', (req, res) => {
  res.render('son_kullanici');
});
app.get('/e_devlet', (req, res) => {
  res.render('son_kullanici');
});

app.get('/uretici_ilac_kayit', (req, res) => {
  res.render('uretici_ilac_kayit');
});
app.get('/uretici_giris', (req, res) => {
  res.render('uretici_giris');
});

app.get('/uretici_ilac_listesi', (req, res) => {
  res.render('uretici_ilac_listesi');
});

app.get('/urun_timeline', (req, res) => {
  res.render('urun_timeline');
});






// POST isteği ile veri eklemek
app.post('/uretici_kayit', (req, res) => {
  let { mersisno, firma_adi, e_posta, tel_no } = req.body;
  // MySQL sorgusu ile veriyi ekleyin
  const sql = 'INSERT INTO uretici (mersisno, firma_adi, e_posta, tel_no) VALUES (?, ?, ?, ?)';
  db.query(sql, [mersisno, firma_adi, e_posta, tel_no], (err, result) => {
    if (err) {
      console.error('Veri eklenirken hata oluştu: ' + err);
      res.status(500).send('Veri eklenirken hata oluştu.');
    } else {
      console.log('Veri başarıyla eklendi.');
      res.status(200).send('Veri başarıyla eklendi.');
    }
  });
});

app.post('/satici_kayit', (req, res) => {
  let { mersisno, firma_adi, e_posta, tel_no } = req.body;
  // MySQL sorgusu ile veriyi ekleyin
  const sql = 'INSERT INTO satici (mersisno, firma_adi, e_posta, tel_no) VALUES (?, ?, ?, ?)';
  db.query(sql, [mersisno, firma_adi, e_posta, tel_no], (err, result) => {
    if (err) {
      console.error('Veri eklenirken hata oluştu: ' + err);
      res.status(500).send('Veri eklenirken hata oluştu.');
    } else {
      console.log('Veri başarıyla eklendi.');
      res.status(200).send('Veri başarıyla eklendi.');
    }
  });
});



app.post('/uretici_ilac_kayit', async (req, res) => {
  let { urun_ismi, urun_icindekiler, urun_turu, urun_kategori } = req.body;
  // MySQL sorgusu ile veriyi ekleyin
  const sql2 = 'SELECT * FROM uretici LIMIT 1'; // LIMIT 1 ile sadece ilk veriyi çekiyoruz
  let mersisno;
  db.query(sql2, (err, result) => {
    if (err) {
      console.error('Veri çekme hatası: ' + err);
    } else {
      // Sonuç bir dizi olarak döner, çünkü birden fazla satır dönebilir, ancak burada sadece ilk satırı alıyoruz.
      const firstRow = result[0];

      if (firstRow) {

        mersisno = firstRow.mersisno;
        console.log('İlk verinin Mersis No: ' + mersisno);

        const sql = 'INSERT INTO urunler (urun_ismi	,urun_icindekiler,	urun_turu,	urun_kategori,	uretici_id) VALUES (?, ?, ?, ?,?)';
        db.query(sql, [urun_ismi, urun_icindekiler, urun_turu, urun_kategori, "12412412"], (err, result) => {
          if (err) {
            console.error('Veri eklenirken hata oluştu: ' + err);
            res.status(500).send('Veri eklenirken hata oluştu.');
          } else {
            console.log('Veri başarıyla eklendi.');
            res.status(200).send('Veri başarıyla eklendi.');
          }
        });


      } else {
        console.log('Üretici tablosunda veri bulunamadı.');
      }
    }
  });




});
// Belirtilen bir portta sunucuyu dinleme
app.listen(port, () => {
  console.log(`Sunucu ${port} portunda çalışıyor.`);
});
