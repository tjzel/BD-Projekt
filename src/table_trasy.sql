CREATE TABLE Trasy(
    TrasaID INT,
    LiniaID INT NOT NULL,
    PrzystanekPoczatkowy INT NOT NULL

    PRIMARY KEY(TrasaID),
    FOREIGN KEY(LiniaID) REFERENCES Linie(LiniaID),
    FOREIGN KEY(PrzystanekPoczatkowy) REFERENCES Przystanki(PrzystanekID) 
)
GO