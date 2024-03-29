CREATE PROCEDURE AktualizacjaMandatów
AS
  ALTER TABLE NałożoneKary DISABLE TRIGGER NałożoneKaryALL
  DELETE FROM NałożoneKary
  WHERE DataOpłacenia IS NOT NULL AND DATEDIFF(DAY, DataUkarania, GETDATE()) > 365
  ALTER TABLE NałożoneKary ENABLE TRIGGER NałożoneKaryALL
GO
