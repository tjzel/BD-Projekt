CREATE TABLE Kursy(
    KursID INT,
    TrasaID INT NOT NULL,
    GodzinaOdjazdu TIME NOT NULL,
    DniPowszednie BIT NOT NULL,
    Soboty BIT NOT NULL,
    Niedziele BIT NOT NULL,
    AutobusID INT,
    PracownikID INT

    PRIMARY KEY(KursID),
    FOREIGN KEY(TrasaID) REFERENCES Trasy(TrasaID),
    FOREIGN KEY(AutobusID) REFERENCES Autobusy(AutobusID),
    FOREIGN KEY (PracownikID) REFERENCES Kierowcy(PracownikID) 
)
GO