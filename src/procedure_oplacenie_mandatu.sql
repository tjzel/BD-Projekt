CREATE PROCEDURE OpłacenieMandatu(
  @mandatID INT,
  @kwota MONEY,
  @reszta MONEY OUTPUT)
AS
  IF @mandatID NOT IN(
    SELECT KaraID FROM NałożoneKary)
    RAISERROR('Niepoprawny numer mandatu!', 0, 2)
    RETURN
  SET @reszta = (
  SELECT KwotaKary
  FROM NałożoneKary
  WHERE @mandatID = KaraID) - @kwota
  IF @reszta < 0
    RAISERROR('Za mała kwota do opłacenia mandatu!', 0, 1)
    RETURN
  ALTER TABLE NałożoneKary DISABLE TRIGGER NałożoneKaryALL
  UPDATE NałożoneKary
    SET DataOpłacenia = GETDATE()
    WHERE @mandatID = KaraID
  ALTER TABLE NałożoneKary ENABLE TRIGGER NałożoneKaryALL
GO
