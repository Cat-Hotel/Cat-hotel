USE CatHotel;
GO

-- Inserting data into CatParent table
INSERT INTO CatParent (FirstName, LastName, CellNumber, EmailAddress)
VALUES 
    ('Alice', 'Johnson', '0821234567', 'alice.johnson@example.com'),
    ('Michael', 'Smith', '0839876543', 'michael.smith@example.com'),
    ('Emily', 'Brown', '0711112222', 'emily.brown@example.com'),
    ('Daniel', 'Martinez', '0644445555', 'daniel.martinez@example.com'),
    ('Sophia', 'Davis', '0797778888', 'sophia.davis@example.com');

-- Inserting data into Staff table
INSERT INTO Staff (FirstName, LastName, DateOfBirth, CellNumber)
VALUES 
    ('Emma', 'Anderson', '1992-08-25', '0785551111'),
    ('Jacob', 'Wilson', '1988-04-12', '0766663333'),
    ('Olivia', 'Martinez', '1995-12-01', '0827774444'),
    ('Ethan', 'Taylor', '1987-06-18', '0738885555'),
    ('Isabella', 'Garcia', '1990-03-07', '0839996666');

-- Inserting data into Food table
INSERT INTO Food (FoodName, Description)
VALUES 
    ('Grain-Free Dry Food', 'Premium grain-free dry cat food'),
    ('Seafood Medley Wet Food', 'A blend of seafood flavors in wet cat food'),
    ('Senior Formula', 'Special formula for older cats'),
    ('Organic Chicken', 'Organic chicken-based cat food'),
    ('Vegetarian Delight', 'Vegetarian cat food with essential nutrients');

-- Inserting data into Food table
INSERT INTO Cat (CatName, DateOfBirth, Sex, FoodID, CatParentID)
VALUES 
    ('Whiskers', '2019-07-20', 'M', 1, 1),
    ('Fluffy', '2018-03-10', 'F', 2, 2),
    ('Mittens', '2020-01-15', 'F', 1, 3),
    ('Simba', '2017-11-28', 'M', 1, 4),
    ('Luna', '2019-09-05', 'F', 2, 5);

-- Inserting data into Room table
INSERT INTO Room (RoomName, Description)
VALUES 
    ('VIP Suite', 'Luxurious suite with private balcony and grooming service'),
    ('Family Room', 'Spacious room for multiple cats from the same family'),
    ('Playroom', 'Large play area with climbing structures and toys'),
    ('Cozy Corner', 'Quiet corner room with calming music'),
    ('Sunshine Terrace', 'Room with natural sunlight and comfortable bedding');

-- Inserting data into BookingStatus table
INSERT INTO BookingStatus (BookingStatus)
VALUES 
    ('Pending'),
    ('Checked in'),
    ('Checked out'),
    ('Canceled'),
    ('Non-refundable');

-- Inserting data into Booking table
INSERT INTO Booking (CatID, StaffID, RoomID, StartDate, EndDate, Notes, BookingStatusID)
VALUES 
    (1, 1, 1, '2024-02-15', '2024-02-20', 'First booking for Fluffy', 2),
    (2, 2, 2, '2024-02-18', '2024-02-25', 'Whiskers prefers wet food', 1),
    (1, 3, 3, '2024-03-01', '2024-03-05', 'Special diet required for Fluffy', 1),
    (2, 4, 4, '2024-02-20', '2024-02-22', 'Whiskers has a vet appointment on the 23rd', 4),
    (2, 5, 5, '2024-02-28', '2024-03-05', 'Whiskers loves to sunbathe', 3);



