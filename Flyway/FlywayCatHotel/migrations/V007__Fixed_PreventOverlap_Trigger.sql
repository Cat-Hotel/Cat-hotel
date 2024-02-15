DROP TRIGGER PreventOverlap
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
        WHERE i.BookingStatusID = 4
    )
    BEGIN
        RAISERROR ('Overlapping booking is not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO