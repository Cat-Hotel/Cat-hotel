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