USE CatHotel;
GO

CREATE OR ALTER VIEW CurrentBookingsView 
AS
    SELECT
        BookingID,
        Cat.CatName AS CatName,
        Room.RoomName AS RoomName,
        Staff.FirstName AS Staff_FirstName,
        Staff.LastName AS Staff_LastName,
        Booking.StartDate AS StartDate,
        Booking.EndDate AS EndDate
    FROM Booking

    INNER JOIN Cat ON Booking.CatID = Cat.CatID

    INNER JOIN Room ON Booking.RoomID = Room.RoomID

    INNER JOIN Staff ON Booking.StaffID = Staff.StaffID

    WHERE Booking.EndDate >= GETDATE() -- Only include active bookings
GO