CREATE TRIGGER NałożoneKaryALL
ON NałożoneKary
AFTER INSERT, UPDATE, DELETE
AS
  RAISERROR('Zakaz manualnej ingerencji w mandaty!', 0, 1)
GO
