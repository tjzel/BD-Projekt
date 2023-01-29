CREATE FUNCTION PracownicyNaStanowisku(@stanowisko NVARCHAR(256))
RETURNS TABLE
AS
  RETURN(
    SELECT P.PracownikID, O.Imię, O.Nazwisko
    FROM Pracownicy P
    JOIN Osoby O
    ON P.OsobaID = P.OsobaID
    WHERE P.Stanowisko = @stanowisko)
GO