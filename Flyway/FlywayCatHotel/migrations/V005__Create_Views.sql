USE CatHotel;
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

    WHERE b.EndDate >= GETDATE() AND b.BookingStatusID <> 4-- Only include active bookings
GO