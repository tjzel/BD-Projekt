CREATE FUNCTION HarmonogramJazdyAutobusu(@AutobusID,@DzienTyg)
RETURNS @KursyAutobusu TABLE
(
    GodzinaOdjazdu TIME,
    PrzystanekOdjazdu NVARCHAR,
    GodzinaPrzyjazdu TIME,
    PrzystanekPrzyjazdu NVARCHAR
)
AS
    BEGIN
        INSERT INTO @KursyAutobusu
            SELECT GodzinaOdjazdu,PrzystanekOdjazdu,
            GodzinaPrzyjazdu,PrzystanekPrzyjazdu
            FROM CzasyTrwaniaKursów
            WHERE AutobusID=@AutobusID AND
            ((Soboty=1 AND @DzienTyg=6) OR 
            (Niedziele=1 AND @DzienTyg=7) OR
            (DniPowszednie=1 AND @DzienTyg NOT IN(6,7)))
        RETURN
    END
    GO