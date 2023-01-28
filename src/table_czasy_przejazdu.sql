CREATE TABLE Czasy_przejazdu(
    TrasaID INT,
    KolejnośćPrzystanku INT NOT NULL,
    PrzystanekID NVARCHAR(4) NOT NULL,
    CzasPrzejZPoprz TIME NOT NULL

    PRIMARY KEY(TrasaID,KolejnośćPrzystanku),
    FOREIGN KEY(PrzystanekID) REFERENCES Przystanki(PrzystanekID),
    FOREIGN KEY(TrasaID) REFERENCES Trasy(TrasaID) 
)
GO