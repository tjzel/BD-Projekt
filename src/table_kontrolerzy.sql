CREATE TABLE Kontrolerzy(
  PracownikID INT NOT NULL,
  KontrolerID INT UNIQUE IDENTITY(1, 1),

  PRIMARY KEY(PracownikID, KontrolerID),
  FOREIGN KEY (PracownikID) REFERENCES Pracownicy(PracownikID)
);
GO
