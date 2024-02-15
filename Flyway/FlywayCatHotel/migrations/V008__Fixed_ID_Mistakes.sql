USE CatHotel;
GO


ALTER TABLE Booking
DROP CONSTRAINT DEF_Booking_BookingStatusID
GO

ALTER TABLE Booking
add CONSTRAINT DEF_Booking_BookingStatusID DEFAULT 6
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


CREATE OR ALTER TRIGGER PreventRoomDoubleBooking
ON Booking
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Booking b ON i.RoomID = b.RoomID
        WHERE (
            (i.StartDate <= b.StartDate AND i.EndDate >= b.StartDate)
            OR (i.StartDate <= b.EndDate AND i.EndDate >= b.EndDate)
            OR (i.StartDate >= b.StartDate AND i.EndDate <= b.EndDate)
        )
        AND i.BookingID <> b.BookingID
    ) AND NOT EXISTS (
        SELECT 1
        FROM inserted i
        JOIN BookingStatus s ON i.BookingStatusID = s.BookingStatusID
        WHERE s.BookingStatus = 'Canceled'
    )
    BEGIN
        RAISERROR ('Double booking a room is not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO


CREATE OR ALTER TRIGGER PreventOverlap
ON Booking
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Booking b ON i.CatID = b.CatID
        WHERE (
            (i.StartDate <= b.StartDate AND i.EndDate >= b.StartDate)
            OR (i.StartDate <= b.EndDate AND i.EndDate >= b.EndDate)
            OR (i.StartDate >= b.StartDate AND i.EndDate <= b.EndDate)
        )
        AND i.BookingID <> b.BookingID
    ) AND NOT EXISTS (
        SELECT 1
        FROM inserted i
        JOIN BookingStatus s ON i.BookingStatusID = s.BookingStatusID
        WHERE s.BookingStatus = 'Canceled'
    )
    BEGIN
        RAISERROR ('Overlapping booking is not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO


CREATE OR ALTER VIEW CurrentBookingsView 
AS
    SELECT
        b.BookingID,
        c.CatName AS CatName,
        r.RoomName AS RoomName,
        s.FirstName AS Staff_FirstName,
        s.LastName AS Staff_LastName,
        b.StartDate AS StartDate,
        b.EndDate AS EndDate
    FROM Booking AS b

    INNER JOIN Cat AS c ON b.CatID = c.CatID

    INNER JOIN Room AS r ON b.RoomID = r.RoomID

    INNER JOIN Staff as s ON b.StaffID = s.StaffID

    INNER JOIN BookingStatus bs ON b.BookingStatusID = bs.BookingStatusID

    WHERE b.EndDate >= GETDATE() AND bs.BookingStatus <> 'Canceled'-- Only include active bookings
GO

