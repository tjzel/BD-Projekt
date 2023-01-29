CREATE PROCEDURE ZmieńKary(
  @proporcja DECIMAL)
AS
  IF @proporcja <= 0
    RAISERROR('Niepoprawna proporcja!', 0, 1)
    RETURN
  UPDATE Przewinienia
  SET
    AktualnaKwotaKary = AktualnaKwotaKary * @proporcja
GO
