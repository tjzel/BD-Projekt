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
