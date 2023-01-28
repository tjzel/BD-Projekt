CREATE TABLE Kary(
  PrzewinienieID INT IDENTITY(1,1),
  PrzewinienieRodzaj NVARCHAR(256) UNIQUE NOT NULL,
  WysokośćKary MONEY NOT NULL,

  PRIMARY KEY(PrzewinienieID, PrzewinienieRodzaj)
)