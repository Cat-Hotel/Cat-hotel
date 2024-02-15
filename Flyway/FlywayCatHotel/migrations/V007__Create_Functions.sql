USE CatHotel;
GO

CREATE OR ALTER FUNCTION GetTotalCost
(
    @CatParentID int
)
RETURNS decimal(18,2)
AS
BEGIN 
    DECLARE @TotalCost decimal(18,2) = 0.00;

	SELECT TOP 1 @TotalCost = ((DATEDIFF(DAY, b.StartDate, b.EndDate) + 1) * p.Amount)
    FROM Booking b
    JOIN Cat c ON b.CatID = c.CatID
    JOIN Room r ON b.RoomID = r.RoomID
    JOIN Price p ON r.RoomID = p.RoomID
    JOIN BookingStatus s ON b.BookingStatusID = s.BookingStatusID
    WHERE c.CatParentID = @CatParentID AND s.BookingStatus <> 'Canceled'
	ORDER BY b.BookingID DESC;

	RETURN @TotalCost;
END
GO





CREATE OR ALTER FUNCTION [dbo].[GetAvailableRooms]
(   
    @StartDate DATE, 
    @EndDate DATE
)
RETURNS TABLE
AS
    RETURN
    (
        SELECT
            RoomID,
            RoomName,
            Description
        FROM
            Room
        WHERE
            RoomID NOT IN 
            (
                SELECT DISTINCT b.RoomID
                FROM Booking as b
                JOIN BookingStatus s ON b.BookingStatusID = s.BookingStatusID
                WHERE b.StartDate <= @EndDate 
                    AND b.EndDate >= @StartDate 
                    AND s.BookingStatus <> 'Canceled'
            )
    );
GO