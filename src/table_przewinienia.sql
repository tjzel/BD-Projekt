CREATE TABLE Przewinienia(
  PrzewinienieID INT IDENTITY(1,1),
  PrzewinienieRodzaj NVARCHAR(256) UNIQUE NOT NULL,
  AktualnaKwotaKary MONEY NOT NULL,

  PRIMARY KEY(PrzewinienieID)
);
GO
