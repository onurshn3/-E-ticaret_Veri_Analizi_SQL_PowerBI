--en cok harcama yapan 5 müsteri 
SELECT
    k.ad_soyad,
    SUM(s.toplam_tutar) AS toplam_harcama
FROM Siparisler AS s
JOIN Kullanicilar AS k
    ON s.musteri_id = k.kullanici_id
GROUP BY
    k.ad_soyad
ORDER BY
    toplam_harcama DESC
LIMIT 5;

--en cok siparis veren müsteri
SELECT
    k.ad_soyad,
    COUNT(s.siparis_id) AS siparis_sayisi
FROM Siparisler AS s
JOIN Kullanicilar AS k
    ON s.musteri_id = k.kullanici_id
GROUP BY
    k.ad_soyad
ORDER BY
    siparis_sayisi DESC
LIMIT 5;


SELECT
    k.ad_soyad AS musteri_adi,
    r.ad AS restoran_adi,
    COUNT(s.siparis_id) AS siparis_sayisi
FROM Siparisler AS s
JOIN Kullanicilar AS k
    ON s.musteri_id = k.kullanici_id
JOIN Restoranlar AS r
    ON s.restoran_id = r.restoran_id
GROUP BY
    k.ad_soyad,
    r.ad
HAVING
    COUNT(s.siparis_id) > 1
ORDER BY
    siparis_sayisi DESC;
--en cok satan 3 ürün
SELECT
    m.urun_adi,
    SUM(sd.adet) AS toplam_satilan_adet
FROM Siparis_Detay AS sd
JOIN Menu AS m
    ON sd.urun_id = m.urun_id
GROUP BY
    m.urun_adi
ORDER BY
    toplam_satilan_adet DESC
LIMIT 3;

--en cok ciro yapan 5 restoran
SELECT
    r.ad AS restoran_adi,
    SUM(s.toplam_tutar) AS toplam_ciro
FROM Siparisler AS s
JOIN Restoranlar AS r
    ON s.restoran_id = r.restoran_id
GROUP BY
    r.ad
ORDER BY
    toplam_ciro DESC
LIMIT 5;

--odeme tipine göre ciro
SELECT
    odeme_tipi,
    COUNT(siparis_id) AS siparis_sayisi,
    SUM(toplam_tutar) AS toplam_ciro
FROM Siparisler
GROUP BY
    odeme_tipi
ORDER BY
    siparis_sayisi DESC;

--en cok yorum alan 5 restoran
SELECT
    r.ad AS restoran_adi,
    COUNT(d.yorum_id) AS yorum_sayisi,
    ROUND(AVG(d.puan), 2) AS ortalama_puan
FROM Restoranlar AS r
JOIN degerlendirme AS d
    ON r.restoran_id = d.restoran_id
GROUP BY
    restoran_adi
ORDER BY
    yorum_sayisi DESC,
    ortalama_puan DESC
LIMIT 5;

--müşterilerin sadık olduğu restoranlar (tekrar eden siparişleri) 
SELECT
    k.ad_soyad AS musteri_adi,
    r.ad AS restoran_adi,
    COUNT(s.siparis_id) AS siparis_sayisi
FROM Siparisler AS s
JOIN Kullanicilar AS k
    ON s.musteri_id = k.kullanici_id
JOIN Restoranlar AS r
    ON s.restoran_id = r.restoran_id
GROUP BY
    k.ad_soyad,
    r.ad
HAVING
    COUNT(s.siparis_id) > 1
ORDER BY
    siparis_sayisi DESC;
	