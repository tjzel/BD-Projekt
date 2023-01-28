CREATE TABLE Osoby (
  OsobaID INT UNIQUE IDENTITY(1, 1),
  Imię NVARCHAR(256) NOT NULL,
  Nazwisko NVARCHAR(256) NOT NULL,
  PESEL NVARCHAR(9) UNIQUE,
  NrDowoduOsobistego NVARCHAR(9) UNIQUE,
  PRIMARY KEY (OsobaID)
);
GO
