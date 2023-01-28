CREATE TABLE Trasy(
    KursID INT,
    DataKursu DATE NOT NULL,
    PracownikID INT NOT NULL,
    AutobusID INT NOT NULL

    PRIMARY KEY(KursID,DataKursu),
    FOREIGN KEY(KursID) REFERENCES Kursy(KursID),
    FOREIGN KEY(PracownikID) REFERENCES Kierowcy(PracownikID),
    FOREIGN KEY(AutobusID) REFERENCES Autobusy(AutobusID) 
)
GO