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
    JOIN Price P on r.RoomID = p.RoomID
    WHERE c.CatParentID = @CatParentID AND b.BookingStatusID <> 4
	ORDER BY b.BookingID DESC;

	RETURN @TotalCost;
END
GO

-- To call the function do this
-- SELECT dbo.GetTotalCost(4);

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
                SELECT DISTINCT RoomID
                FROM Booking
                WHERE StartDate <= @EndDate 
                    AND EndDate >= @StartDate 
                    AND BookingStatusID <> 4
            )
    );
GO

CREATE OR ALTER FUNCTION [dbo].[GetBookingStatusCount] (@startDate DATE, @endDate DATE)
RETURNS TABLE
AS
RETURN (
    SELECT * FROM (
        SELECT
            bs.BookingStatus,
            COUNT(*) AS Count
        FROM BookingStatus bs
        JOIN Booking b ON bs.BookingStatusID = b.BookingStatusID
        WHERE (b.StartDate >= @startDate AND b.StartDate <= @endDate)
        OR (b.EndDate >= @startDate AND b.EndDate <= @endDate)
        GROUP BY bs.BookingStatus 
    ) AS subquery 
    WHERE subquery.BookingStatus <> 'Checked in'
);
GO

-- To run: SELECT * FROM dbo.GetBookingStatusCount('2024-02-01', '2024-02-29')