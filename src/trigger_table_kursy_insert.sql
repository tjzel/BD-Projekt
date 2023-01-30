CREATE TRIGGER KursyINSERT ON Kursy
AFTER INSERT
AS
    IF EXISTS(SELECT * FROM inserted WHERE (DniPowszednie=1 AND Soboty=1) 
    OR (DniPowszednie=1 AND Niedziele=1) OR (Soboty=1 AND Niedziele=1))
    BEGIN
        RAISERROR('Niejednoznaczne przypisanie dnia kursu', 0, 1)
        ROLLBACK TRANSACTION
    END
    
    IF EXISTS(SELECT K.KursID,K.GodzinaOdjazdu,
    dbo.ADDTIME(S.Czas,K.GodzinaOdjazdu) GodzinaPrzyjazdu,
    K.PracownikID,K.AutobusID
    FROM (SELECT Cz.TrasaID,
        MAX(CzasPrzejZPoczątku) Czas 
        FROM CzasyPrzejazdu Cz
        GROUP BY(Cz.TrasaID)) S 
    JOIN CzasyPrzejazdu C ON S.Czas=C.CzasPrzejZPoczątku AND S.TrasaID=C.TrasaID
    JOIN inserted K ON C.TrasaID=K.TrasaID JOIN Trasy T ON K.TrasaID=T.TrasaID CROSS APPLY 
    HarmonogramPracyKierowcy(K.PracownikID,IIF(K.Soboty=1,6,IIF(K.Niedziele=1,7,1))) H
    WHERE (K.GodzinaOdjazdu<H.GodzinaOdjazdu AND GodzinaPrzyjazdu>H.GodzinaOdjazdu) OR
    (K.GodzinaOdjazdu<H.GodzinaPrzyjazdu AND K.GodzinaOdjazdu>H.GodzinaOdjazdu))
    BEGIN
        RAISERROR('Kierowca ma już inny kurs w harmonogramie w tym czasie', 0, 1)
        ROLLBACK TRANSACTION
    END

    IF EXISTS(SELECT K.KursID,K.GodzinaOdjazdu,
    dbo.ADDTIME(S.Czas,K.GodzinaOdjazdu) GodzinaPrzyjazdu,
    K.PracownikID,K.AutobusID
    FROM (SELECT Cz.TrasaID,
        MAX(CzasPrzejZPoczątku) Czas 
        FROM CzasyPrzejazdu Cz
        GROUP BY(Cz.TrasaID)) S 
    JOIN CzasyPrzejazdu C ON S.Czas=C.CzasPrzejZPoczątku AND S.TrasaID=C.TrasaID
    JOIN inserted K ON C.TrasaID=K.TrasaID JOIN Trasy T ON K.TrasaID=T.TrasaID CROSS APPLY 
    HarmonogramJazdyAutobusu(K.PracownikID,IIF(K.Soboty=1,6,IIF(K.Niedziele=1,7,1))) H
    WHERE (K.GodzinaOdjazdu<H.GodzinaOdjazdu AND GodzinaPrzyjazdu>H.GodzinaOdjazdu) OR
    (K.GodzinaOdjazdu<H.GodzinaPrzyjazdu AND K.GodzinaOdjazdu>H.GodzinaOdjazdu))
    BEGIN
        RAISERROR('Autobus ma już inny kurs w harmonogramie w tym czasie', 0, 1)
        ROLLBACK TRANSACTION
    END
GO
