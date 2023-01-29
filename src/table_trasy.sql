CREATE TABLE Trasy(
    TrasaID INT,
    LiniaID INT NOT NULL,
    PrzystanekPoczątkowy NVARCHAR(4) NOT NULL

    PRIMARY KEY(TrasaID),
    FOREIGN KEY(LiniaID) REFERENCES Linie(LiniaID),
    FOREIGN KEY(PrzystanekPoczątkowy) REFERENCES Przystanki(PrzystanekID) 
);
GO
