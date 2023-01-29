CREATE TABLE ModeleAutobusów(
    ModelID INT,
    Producent NVARCHAR NOT NULL,
    NazwaModelu NVARCHAR NOT NULL,
    MiejscaSiedzące INT NOT NULL,
    MiejscaStojące INT NOT NULL,
    MiejscaNaRowery INT,
    MiejscaNaWózki INT,
    Niskopodłogowy BIT,
    Przegubowy BIT,
    Napęd NVARCHAR


    PRIMARY KEY(ModelID),
);
GO
