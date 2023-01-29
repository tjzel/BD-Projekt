CREATE TABLE KosztyEksploatacji(
    AutobusID INT,
    DataWykonania DATE,
    NazwaUsługi NVARCHAR NOT NULL,
    Kwota MONEY NOT NULL

    PRIMARY KEY(AutobusID,DataWykonania),
    FOREIGN KEY(AutobusID) REFERENCES Autobusy(AutobusID),
    FOREIGN KEY(NazwaUsługi) REFERENCES Usługi(NazwaUsługi) 
);
GO
