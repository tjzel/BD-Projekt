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
