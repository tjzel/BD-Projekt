CREATE PROCEDURE ZastąpKierowcę(@zastępowany INT,@zastępujący INT)
AS
    UPDATE Kursy
    SET PracownikID=@zastępujący
    WHERE PracownikID=@zastępowany
GO
