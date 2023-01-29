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
