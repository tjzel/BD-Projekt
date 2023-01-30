CREATE PROCEDURE ZastąpAutobus(@zastępowany INT,@zastępujący INT)
AS
    UPDATE Kursy
    SET AutobusID=@zastępujący
    WHERE AutobusID=@zastępowany
GO
