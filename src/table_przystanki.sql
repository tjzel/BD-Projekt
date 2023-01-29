CREATE TABLE Przystanki(
    PrzystanekID NVARCHAR(4),
    NazwaPrzystanku NVARCHAR NOT NULL,
    IlośćWiat TINYINT NOT NULL,
    NaŻądanie BIT,
    ElektronicznaInformacja BIT,
    AutomatBiletowy BIT,
    Strefa INT

    PRIMARY KEY(PrzystanekID),
    FOREIGN KEY(Strefa) REFERENCES Strefy(StrefaID) 
);
GO
