CREATE TRIGGER OsobyUPDATE
ON Osoby
INSTEAD OF UPDATE
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
