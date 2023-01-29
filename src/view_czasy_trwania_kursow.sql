CREATE VIEW CzasyTrwaniaKursów
AS
    SELECT K.KursID,K.GodzinaOdjazdu,T.PrzystanekPoczątkowy PrzystanekOdjazdu,
    dbo.ADDTIME(S.Czas,GodzinaOdjazdu) GodzinaPrzyjazdu, C.PrzystanekID PrzystanekPrzyjazdu,
    K.DniPowszednie,K.Soboty,K.Niedziele,K.PracownikID,K.AutobusID
    FROM (SELECT Cz.TrasaID,
        MAX(CzasPrzejZPoczątku) Czas 
        FROM CzasyPrzejazdu Cz
        GROUP BY(Cz.TrasaID)) S 
    JOIN CzasyPrzejazdu C ON S.Czas=C.CzasPrzejZPoczątku AND S.TrasaID=C.TrasaID
    JOIN Kursy K ON C.TrasaID=K.TrasaID JOIN Trasy T ON K.TrasaID=T.TrasaID
GO
