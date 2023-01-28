CREATE FUNCTION KwotaKary(
  @kontrolerID,
  @ukaranyID,
  @przewinienieID,
) RETURNS MONEY 
AS
BEGIN
  DECLARE @dzisiaj DATE = GETDATE();
  DECLARE @modyfikator DECIMAL = (
    SELECT TOP 1
    FROM ProgesjaKar PK
    WHERE P.LiczbaPrzewinień >= (
      SELECT COUNT(NK.OsobaID) LiczbaPrzewinień
      FROM NałożoneKary AS NK
      WHERE DATEDIFF(DAY, @dzisiaj, NK.DataUkarania) > 365
    )
    ORDER BY PK.LiczbaPrzewinień ASC
  )
  DECLARE @kwotaBazowa = (
    SELECT P.AktualnaKwotaKary
    FROM Przewinienia P
    WHERE @przewinienieID = P.PrzewinienieID
  )
  DECLARE @wynik = @kwotaBazowa * @modyfikator
  RETURN @wynik
END;
GO

  