CREATE FUNCTION RozkładJazdyDlaKursu ( @KursID INT)
RETURNS @RozkladTab TABLE(PrzystanekID NVARCHAR, Godzina Time)
AS
BEGIN
    INSERT INTO @RozkladTab
        SELECT P.PrzystanekID, dbo.ADDTIME(K.GodzinaOdjazdu,C.CzasPrzejZPoczątku)
        FROM Przystanki P JOIN CzasyPrzejazdu C
        ON P.PrzystanekID=C.PrzystanekID
        JOIN Trasy T ON C.TrasaID=T.TrasaID 
        JOIN Kursy K ON T.TrasaID=K.TrasaID
        WHERE K.KursID=@KursID
    
    INSERT INTO @RozkladTab
        SELECT P.PrzystanekID, K.GodzinaOdjazdu Godzina
        FROM Przystanki P JOIN Trasy T
        ON P.PrzystanekID=T.PrzystanekPoczątkowy
        JOIN Kursy K ON K.TrasaID=T.TrasaID
        WHERE K.KursID=@KursID
    RETURN
END
GO
