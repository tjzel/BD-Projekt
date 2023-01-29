CREATE FUNCTION RozkładJazdyDlaKursu ( @KursID )
RETURNS @RozkladTab TABLE(PrzystanekID NVARCHAR, Godzina Time)
AS
BEGIN
    INSERT INTO @RozkladTab
        SELECT P.PrzystanekID, K.GodzinaOdjazdu+C.CzasPrzejZPoczątku
        FROM Przystanki P JOIN CzasyPrzejazdu C
        ON P.PrzystanekID=C.PrzystanekID
        JOIN Trasy T ON C.TrasaID=T.TrasaID 
        JOIN Kursy K ON T.TrasaID=K.TrasaID
        WHERE K.KursID=@KursID
    
    INSERT INTO @RozkladTab
        SELECT P.PrzystanekID, K.GodzinaOdjazdu Godzina
        FROM Przystanki P JOIN Trasy T
        ON P.PrzystanekID=T.PrzystanekID
        JOIN Kursy K ON K.TrasaID=T.TrasaID
        WHERE P.KursID=@KursID
    RETURN
END
GO