CREATE TABLE Kierowcy(
  PracownikID INT NOT NULL,
  NrTelefonuSłużbowego NVARCHAR(9),
  DataUzyskaniaPrawaJazdy DATE NOT NULL,
  DataWażnościPrawaJazdy DATE NOT NULL,
  DataWażnościBadańLekarskich DATE NOT NULL,

  PRIMARY KEY (PracownikID) REFERENCES Pracownicy(PracownikID)
)