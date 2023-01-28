CREATE TABLE NałożoneKary(
  KaraID INT IDENTITY(1, 1),
  KontrolerID INT NOT NULL,
  PrzewinienieID INT NOT NULL,
  UkaranyID INT NOT NULL,
  DataUkarania DATE NOT NULL,
  KwotaKary MONEY NOT NULL,
  DataOpłacenia DATE,

  PRIMARY KEY (KaraID),
  FOREIGN KEY (KontrolerID) REFERENCES Kontrolerzy(KontrolerID),
  FOREIGN KEY (PrzewinienieID) REFERENCES Przewinienia(PrzewinienieID)
)