CREATE FUNCTION ADDTIME (@StartTime TIME,@Offset TIME)
RETURNS TIME
AS
BEGIN
	SET @StartTime = DATEADD (hour, DATEPART(hh,@Offset),@StartTime)
	SET @StartTime = DATEADD (n, DATEPART(n,@Offset),@StartTime)

    RETURN @StartTime
END
GO
