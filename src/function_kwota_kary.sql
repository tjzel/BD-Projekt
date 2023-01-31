CREATE FUNCTION KwotaKary(
  @ukaranyID INT,
  @przewinienieID INT
) RETURNS MONEY 
AS
BEGIN
  DECLARE @dzisiaj DATE = GETDATE();
  DECLARE @modyfikator DECIMAL = (
    SELECT TOP 1 PK.Modyfikator
    FROM ProgresjaKar PK
    WHERE PK.LiczbaPrzewinień >= (
      SELECT COUNT(NK.UkaranyID) LiczbaPrzewinień
      FROM NałożoneKary AS NK
      WHERE NK.UkaranyID = @ukaranyID AND DATEDIFF(DAY, @dzisiaj, NK.DataUkarania) < 365
    )
    ORDER BY PK.LiczbaPrzewinień ASC
  )
  DECLARE @kwotaBazowa MONEY = (
    SELECT P.AktualnaKwotaKary
    FROM Przewinienia P
    WHERE @przewinienieID = P.PrzewinienieID
  )
  DECLARE @wynik MONEY = @kwotaBazowa * @modyfikator;
  RETURN @wynik;
END;
GO
