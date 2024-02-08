USE CatHotel;
GO

CREATE FUNCTION GetTotalCost(@CatParentID int)
RETURNS decimal(18,2)
AS
BEGIN 
    DECLARE @TotalCost decimal(18,2) = 0.00;

	SELECT @TotalCost = SUM((DATEDIFF(DAY, b.StartDate, b.EndDate) + 1) * p.Amount)
    FROM Booking b
    JOIN Cat c ON b.CatID = c.CatID
    JOIN Room r ON b.RoomID = r.RoomID
    JOIN Price P on r.RoomID = p.RoomID
    WHERE c.CatParentID = @CatParentID;

	RETURN @TotalCost;
END
GO

-- To call the function do this
-- SELECT dbo.GetTotalCost(4);