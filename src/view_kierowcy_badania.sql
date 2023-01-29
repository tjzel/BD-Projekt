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
