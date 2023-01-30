CREATE TRIGGER NałożoneKaryALL
ON NałożoneKary
INSTEAD OF INSERT, UPDATE, DELETE
AS
  RAISERROR('Zakaz manualnej ingerencji w mandaty!', 0, 1)
GO
