CREATE TABLE Autobusy(
    AutobusID INT,
    NumerRejestracyjny NVARCHAR NOT NULL UNIQUE,
    ModelID INT NOT NULL,
    RokProdukcji INT NOT NULL,
    DataRozpEksploatacji DATE,
    DataWaznosciPrzegladu DATE NOT NULL,
    AutomatyBiletowe TINYINT

    PRIMARY KEY(AutobusID),
    FOREIGN KEY(ModelID) REFERENCES ModeleAutobusów(ModelID)
)
GO