CREATE DATABASE KomunikacjaMiejska;
GO
USE KomunikacjaMiejska;
GO
CREATE TABLE Osoby(
  OsobaID INT UNIQUE IDENTITY(1, 1),
  Imię NVARCHAR(256) NOT NULL,
  Nazwisko NVARCHAR(256) NOT NULL,
  PESEL NVARCHAR(11) UNIQUE,
  NrDowoduOsobistego NVARCHAR(9) UNIQUE,
  PRIMARY KEY (OsobaID)
);
GO
CREATE TABLE Stanowiska(
  NazwaStanowiska NVARCHAR(256) NOT NULL,
  PRIMARY KEY (NazwaStanowiska)
);
GO
CREATE TABLE Pracownicy(
  OsobaID INT NOT NULL,
  PracownikID INT UNIQUE IDENTITY(1, 1),
  DataUrodzenia DATE NOT NULL,
  AdresZamieszkania NVARCHAR(256),
  NumerTelefonu NVARCHAR(9),
  Stanowisko NVARCHAR(256) NOT NULL,
  DataZatrudnienia DATE NOT NULL,
  StawkaGodzinowa MONEY NOT NULL,
  WymiarEtatu DECIMAL

  PRIMARY KEY(OsobaID),
  FOREIGN KEY(OsobaID) REFERENCES Osoby(OsobaID),
  FOREIGN KEY(Stanowisko) REFERENCES Stanowiska(NazwaStanowiska)
);
GO
CREATE TABLE Kierowcy(
  PracownikID INT NOT NULL,
  NrTelefonuSłużbowego NVARCHAR(9),
  DataUzyskaniaPrawaJazdy DATE NOT NULL,
  DataWażnościPrawaJazdy DATE NOT NULL,
  DataWażnościBadańLekarskich DATE NOT NULL,

  PRIMARY KEY (PracownikID),
  FOREIGN KEY (PracownikID) REFERENCES Pracownicy(PracownikID)
);
GO
CREATE TABLE Kontrolerzy(
  PracownikID INT NOT NULL,
  KontrolerID INT UNIQUE IDENTITY(1, 1),

  PRIMARY KEY(PracownikID, KontrolerID),
  FOREIGN KEY (PracownikID) REFERENCES Pracownicy(PracownikID)
);
GO
CREATE TABLE Strefy(
  StrefaID INT IDENTITY(1, 1),
  
  PRIMARY KEY (StrefaID)
);
GO
CREATE TABLE Bilety(
  StrefaID INT NOT NULL,
  CenaNor20min MONEY NOT NULL,
  CenaUlg20min MONEY NOT NULL,
  CenaNor60min MONEY NOT NULL,
  CenaUlg60min MONEY NOT NULL,
  CenaNor24h MONEY NOT NULL,
  CenaUlg24h MONEY NOT NULL,
  CenaNorMsc MONEY NOT NULL,
  CenaUlgMsc MONEY NOT NULL

  PRIMARY KEY(StrefaID),
  FOREIGN KEY(StrefaID) REFERENCES Strefy(StrefaID)
);
GO
CREATE TABLE Przewinienia(
  PrzewinienieID INT IDENTITY(1,1),
  PrzewinienieRodzaj NVARCHAR(256) UNIQUE NOT NULL,
  AktualnaKwotaKary MONEY NOT NULL,

  PRIMARY KEY(PrzewinienieID)
);
GO
CREATE TABLE ProgresjaKar(
  LiczbaPrzewinień INT UNIQUE NOT NULL,
  Modyfikator DECIMAL NOT NULL,
  PRIMARY KEY (LiczbaPrzewinień)
);
GO
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
);
GO
CREATE FUNCTION KwotaKary(
  @ukaranyID INT,
  @przewinienieID INT
) RETURNS MONEY 
AS
BEGIN
  DECLARE @dzisiaj DATE = GETDATE();
  DECLARE @modyfikator DECIMAL = (
    SELECT TOP 1 PK.Modyfikator
    FROM ProgresjaKar PK
    WHERE PK.LiczbaPrzewinień >= (
      SELECT COUNT(NK.UkaranyID) LiczbaPrzewinień
      FROM NałożoneKary AS NK
      WHERE NK.UkaranyID = @ukaranyID AND DATEDIFF(DAY, @dzisiaj, NK.DataUkarania) < 365
    )
    ORDER BY PK.LiczbaPrzewinień ASC
  )
  DECLARE @kwotaBazowa MONEY = (
    SELECT P.AktualnaKwotaKary
    FROM Przewinienia P
    WHERE @przewinienieID = P.PrzewinienieID
  )
  DECLARE @wynik MONEY = @kwotaBazowa * @modyfikator;
  RETURN @wynik;
END;
GO
  CREATE VIEW KierowcyBadania
AS
SELECT P.PracownikID, O.Imię, O.Nazwisko, T.UpływająBadaniaZPrawaJazdy, T.UpływająBadaniaLekarskie
FROM (
  SELECT K.PracownikID,
    CASE 
      WHEN DATEDIFF(MONTH, GETDATE(), K.DataWażnościPrawaJazdy) < 3
        THEN N'TAK'
      ELSE N'NIE'
    END
    UpływająBadaniaZPrawaJazdy,
    CASE
      WHEN DATEDIFF(MONTH, GETDATE(), K.DataWażnościBadańLekarskich) < 3
       THEN N'TAK'
      ELSE N'NIE'
    END
    UpływająBadaniaLekarskie
  FROM Kierowcy K
) AS T
JOIN Pracownicy P
ON P.PracownikID = T.PracownikID
JOIN Osoby O
ON P.OsobaID = O.OsobaID
GO
CREATE VIEW PrzedawnioneKary
AS
SELECT O.Imię, O.Nazwisko, O.PESEL, O.NrDowoduOsobistego, T.Suma
FROM Osoby O
JOIN (
  SELECT NK.UkaranyID, SUM(NK.KwotaKary) Suma
  FROM NałożoneKary NK
  WHERE NK.DataOpłacenia IS NOT NULL AND 
    DATEDIFF(DAY, GETDATE(), NK.DataUkarania) > 30
  GROUP BY NK.UkaranyID) AS T
ON O.OsobaID = T.UkaranyID
GO
CREATE VIEW RankingKontrolerów
AS
SELECT P.PracownikID, O.Imię, O.Nazwisko, T.SumaKar
FROM (
  SELECT NK.KontrolerID, SUM(NK.KwotaKary) SumaKar
  FROM NałożoneKary NK
  WHERE DATEDIFF(DAY, GETDATE(), NK.DataUkarania) < 30
  GROUP BY NK.KontrolerID
) AS T
JOIN Kontrolerzy K
ON K.KontrolerID = T.KontrolerID
JOIN Pracownicy P
ON P.PracownikID = K.PracownikID
JOIN Osoby O
ON O.OsobaID = P.OsobaID
GO
CREATE PROCEDURE WystawMandat(
  @kontrolerID INT,
  @ukaranyImię NVARCHAR(256),
  @ukaranyNazwisko NVARCHAR(256),
  @ukaranyPESEL INT,
  @ukaranyNrDowoduOsobistego INT,
  @przewinienieID INT,
  @wymuśNadpisanieDanych BIT,
  @kwota MONEY OUT)
AS
  IF (@ukaranyPESEL IS NULL AND @ukaranyNrDowoduOsobistego IS NULL) OR @kontrolerID IS NULL OR @ukaranyImię IS NULL OR @ukaranyNazwisko IS NULL OR @przewinienieID IS NULL
    RAISERROR('Błędnie wprowadzone dane, nie wystawiono mandatu!', 0, 1)
    RETURN

  IF @kontrolerID NOT IN(
    SELECT K.KontrolerID
    FROM Kontrolerzy K)
    RAISERROR('Nieznany numer kontrolera!', 0, 6)
    RETURN

  IF @przewinienieID NOT IN(
    SELECT P.PrzewinienieID
    FROM Przewinienia P)
    RAISERROR('Nieznane ID przewinienia!', 0, 7)
    RETURN  

  IF @ukaranyPESEL IS NOT NULL AND @ukaranyPESEL NOT IN(SELECT O.PESEL FROM Osoby O) AND
  @ukaranyNrDowoduOsobistego IS NOT NULL AND @ukaranyNrDowoduOsobistego NOT IN (SELECT O.NrDowoduOsobistego FROM Osoby O)
    INSERT INTO Osoby (Imię, Nazwisko, PESEL, NrDowoduOsobistego)
    VALUES (@ukaranyImię, @ukaranyNazwisko, @ukaranyPESEL, @ukaranyNrDowoduOsobistego)

  DECLARE @daneOsobaID INT, @daneImię INT, @daneNazwisko NVARCHAR(256), @danePESEL NVARCHAR(11), @daneNrDowoduOsobistego NVARCHAR(9)

  SELECT
    @daneOsobaID = OsobaID,
    @daneImię = Imię,
    @daneNazwisko = Nazwisko,
    @danePESEL = PESEL,
    @daneNrDowoduOsobistego = NrDowoduOsobistego
  FROM Osoby
  WHERE @ukaranyPESEL IS NOT NULL AND @ukaranyPESEL = PESEL OR
  @ukaranyNrDowoduOsobistego IS NOT NULL AND @ukaranyNrDowoduOsobistego = NrDowoduOsobistego

  IF @wymuśNadpisanieDanych = 1
    BEGIN TRY
      UPDATE Osoby
        SET 
          Imię = @ukaranyImię,
          Nazwisko = @ukaranyNazwisko,
          PESEL = COALESCE(@ukaranyPESEL, PESEL),
          NrDowoduOsobistego = COALESCE(@ukaranyNrDowoduOsobistego, NrDowoduOsobistego)
      WHERE @ukaranyPESEL IS NOT NULL AND @ukaranyPESEL = PESEL OR
        @ukaranyNrDowoduOsobistego IS NOT NULL AND @ukaranyNrDowoduOsobistego = NrDowoduOsobistego
    END TRY
    BEGIN CATCH
      RAISERROR('Niepoprawny PESEL lub numer dowodu osobistego!', 0, 8)
      RETURN
    END CATCH
  ELSE
    DECLARE @errorFlag BIT = 0
    IF @daneImię != @ukaranyImię
      RAISERROR('Imię niezgodne z bazą danych!', 0, 2)
      SET @errorFlag = 1
    IF @daneNazwisko != @ukaranyNazwisko
      RAISERROR('Nazwisko niezgodne z bazą danych!', 0, 3)
      SET @errorFlag = 1
    IF @danePESEL IS NOT NULL AND @danePESEL IS NOT NULL AND @danePESEL != @ukaranyPESEL
      RAISERROR('PESEL niezgodny z bazą danych!', 0, 4)
      SET @errorFlag = 1
    IF @daneNrDowoduOsobistego IS NOT NULL AND @daneNrDowoduOsobistego IS NOT NULL AND @daneNrDowoduOsobistego != @ukaranyNrDowoduOsobistego
      RAISERROR('Numer dowodu osobistego niezgodny z bazą danych!', 0, 5)
      SET @errorFlag = 1
    IF @errorFlag = 1
      RETURN

  SET @kwota = (SELECT * FROM KwotaKary(@daneOsobaID, @przewinienieID))
  
  INSERT INTO NałożoneKary(KontrolerID, PrzewinienieID, UkaranyID, DataUkarania, KwotaKary, DataOpłacenia)
  VALUES(@kontrolerID, @przewinienieID, @daneOsobaID, GETDATE(), @kwota, NULL)

GO
CREATE PROCEDURE OpłacenieMandatu(
  @mandatID INT,
  @kwota MONEY,
  @reszta MONEY OUTPUT)
AS
  IF @mandatID NOT IN(
    SELECT KaraID FROM NałożoneKary)
    RAISERROR('Niepoprawny numer mandatu!', 0, 2)
    RETURN
  SET @reszta = (
  SELECT KwotaKary
  FROM NałożoneKary
  WHERE @mandatID = KaraID) - @kwota
  IF @reszta < 0
    RAISERROR('Za mała kwota do opłacenia mandatu!', 0, 1)
    RETURN
  UPDATE NałożoneKary
    SET DataOpłacenia = GETDATE()
    WHERE @mandatID = KaraID
GO
CREATE TRIGGER OsobyINSERT
ON Osoby
AFTER INSERT
AS
  IF EXISTS(
    SELECT * FROM inserted
    WHERE PESEL IS NOT NULL AND PESEL NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
      NrDowoduOsobistego IS NOT NULL AND NrDowoduOsobistego NOT LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]')
    RAISERROR('Niepoprawne dane!', 0, 1)

  INSERT INTO Osoby
  SELECT * FROM inserted
  WHERE (PESEL IS NULL OR PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') AND
      (NrDowoduOsobistego IS NULL OR NrDowoduOsobistego LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]')
GO
CREATE TRIGGER OsobyUPDATE
ON Osoby
AFTER UPDATE
AS
  IF EXISTS(
    SELECT * FROM inserted
    WHERE PESEL IS NOT NULL AND PESEL NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
      NrDowoduOsobistego IS NOT NULL AND NrDowoduOsobistego NOT LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]')
    RAISERROR('Niepoprawne dane!', 0, 1)

  UPDATE 
    Osoby
  SET 
    Imię = I.Imię,
    Nazwisko = I.Nazwisko,
    PESEL = I.PESEL,
    NrDowoduOsobistego = I.NrDowoduOsobistego
  FROM
    Osoby O
  INNER JOIN inserted I
  ON O.OsobaID = I.OsobaID
  WHERE (I.PESEL IS NULL OR I.PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') AND
      (I.NrDowoduOsobistego IS NULL OR I.NrDowoduOsobistego LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]') AND
      O.OsobaID = I.OsobaID
GO
