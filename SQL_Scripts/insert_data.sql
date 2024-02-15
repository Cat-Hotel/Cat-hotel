USE CatHotel;
GO

INSERT INTO CatParent (FirstName, LastName, CellNumber, EmailAddress)
VALUES
('Emily', 'Johnson', '0123456789', 'emily.johnson@example.com'),
('Daniel', 'Williams', '0987654321', 'daniel.williams@example.com'),
('Olivia', 'Garcia', '0112233445', 'olivia.garcia@example.com'),
('Liam', 'Chen', '0998877665', 'liam.chen@example.com'),
('Sophia', 'Lee', '0123345678', 'sophia.lee@example.com'),
('Ethan', 'Campbell', '0987634321', 'ethan.campbell@example.com');
GO

INSERT INTO Food (FoodName, Description)
VALUES
('Royal Canin', 'Specially formulated kibble for all life stages, supports healthy digestion'),
('Whiskas', 'Moist and flavorful pouches, perfect for picky eaters'),
('Acana', 'Grain-free, protein-rich formula for active cats'),
('Nutribyte', 'Balanced nutrition with added vitamins and minerals for overall health'),
('Catmore', 'Delicious wet food with real meat and vegetables'),
('Feline Cuisine', 'Gourmet recipes for the discerning feline palate, good for bones');
GO

INSERT INTO Staff (FirstName, LastName, DateOfBirth, CellNumber)
VALUES
('Sarah', 'Jones', '1985-02-12', '+27111111111'),
('David', 'Miller', '1990-08-21', '+27222222222'),
('Maria', 'Garcia', '1978-09-16', '+27333333333'),
('Michael', 'Chen', '1982-05-04', '+27444444444'),
('Aisha', 'Campbell', '1995-11-23', '+27555555555'),
('John', 'Lee', '1988-03-10', '+27666666666');
GO

INSERT INTO Room (RoomName, Description)
VALUES
('Parisian Room', 'Elegant room with Eiffel Tower view, perfect for romantic getaways'),
('Jungle Room', 'Lush greenery and playful animal décor, ideal for adventurous cats'),
('Underwater Room', 'Relaxing ocean theme with calming blue tones and fish tank'),
('Modern Loft', 'Sleek and stylish space with plenty of climbing opportunities'),
('Cozy Cottage', 'Warm and inviting room with soft furnishings, good for shy cats');
GO

INSERT INTO Cat (CatName, DateOfBirth, Sex, FoodID, CatParentID)
VALUES
('Luna', '2023-01-15', 'F', 2, 1), 
('Oliver', '2022-05-08', 'M', 4, 2), 
('Milo', '2021-12-24', 'M', 1, 1), 
('Lucy', '2023-03-12', 'F', 5, 3), 
('Simba', '2020-07-21', 'M', 3, 3), 
('Bella', '2022-09-05', 'F', 6, 2),
('Bovril', '2021-01-01', 'M', 1, 4),
('Fifi', '2023-11-18', 'M', 2, 5),
('Frank', '2019-02-14', 'F', 6, 6);
GO

INSERT INTO Price (Amount, ChangeDate, RoomID)
VALUES
(3350.00, '2024-02-07', 1),
(4400.00, '2024-02-07', 2),
(4450.00, '2024-02-07', 3),
(5300.00, '2024-02-07', 4),
(6250.00, '2024-02-07', 5);
GO


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
    (2, 5, 5, '2024-02-28', '2024-03-05', 'Whiskers loves to sunbathe', 1),
    (3, 6, 1, '2023-12-15', '2023-12-20', 'Milo needs plenty of toys', 3),
    (4, 1, 2, '2024-01-18', '2024-01-25', 'Needs to be fed twice a day', 5),
    (5, 2, 3, '2024-04-01', '2024-04-05', 'Likes cacti a bit too much', 4),
    (6, 3, 4, '2024-02-20', '2024-02-24', 'Does not like cacti', 1),
    (7, 4, 5, '2024-02-12', '2024-02-18', 'Has not yet come to a conclusion about cacti', 2),
    (8, 5, 1, '2024-02-25', '2024-02-27', 'Ate a cactus once', 1),
    (9, 6, 2, '2024-02-01', '2024-02-05', 'Has no idea what is going on ever', 5);


