CREATE FUNCTION RozkładJazdyDlaPrzystanku ( @PrzystanekID INT,@DzienTyg INT)
RETURNS @RozkladTab TABLE(NazwaLinii NVARCHAR, KursID INT, Godzina Time)
AS
BEGIN
    INSERT INTO @RozkladTab
        SELECT T.LiniaID, K.KursID, K.GodzinaOdjazdu+C.CzasPrzejZPoczątku Godzina
        FROM Przystanki P JOIN CzasyPrzejazdu C
        ON P.PrzystanekID=C.PrzystanekID
        JOIN Trasy T ON C.TrasaID=T.TrasaID 
        JOIN Kursy K ON T.TrasaID=K.TrasaID
        WHERE P.PrzystanekID=@PrzystanekID AND 
        ((K.Soboty=1 AND @DzienTyg=6) OR
        (K.Niedziele=1 AND @DzienTyg=7) OR
        (K.DniPowszednie=1 AND @DzienTyg NOT IN(6,7)))
    
    INSERT INTO @RozkladTab
        SELECT T.LiniaID, K.KursID, K.GodzinaOdjazdu Godzina
        FROM Przystanki P JOIN Trasy T
        ON P.PrzystanekID=T.PrzystanekID
        JOIN Kursy K ON K.TrasaID=T.TrasaID
        WHERE P.PrzystanekID=@PrzystanekID AND 
        ((K.Soboty=1 AND @DzienTyg=6) OR
        (K.Niedziele=1 AND @DzienTyg=7) OR
        (K.DniPowszednie=1 AND @DzienTyg NOT IN(6,7))) 
    RETURN
END
GO