CREATE TABLE Pracownicy(
  OsobaID INT NOT NULL,
  PracownikID INT UNIQUE IDENTITY(1, 1),
  DataUrodzenia DATE NOT NULL,
  AdresZamieszkania NVARCHAR(256),
  NumerTelefonu NVARCHAR(9),
  Stanowisko NVARCHAR(256) NOT NULL,
  DataZatrudnienia DATE NOT NULL,
  StawkaGodzinowa MONEY NOT NULL,
  WymiarEtatu DECIMAL

  PRIMARY KEY(OsobaID),
  FOREIGN KEY(OsobaID) REFERENCES Osoby(OsobaID),
  FOREIGN KEY(Stanowisko) REFERENCES Stanowiska(NazwaStanowiska)
);
GO
