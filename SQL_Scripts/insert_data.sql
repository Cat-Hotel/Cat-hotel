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

INSERT INTO Staff (FirstName, LastName, DateOfBirth)
VALUES
('Sarah', 'Jones', '1985-02-12'),
('David', 'Miller', '1990-08-21'),
('Maria', 'Garcia', '1978-09-16'),
('Michael', 'Chen', '1982-05-04'),
('Aisha', 'Campbell', '1995-11-23'),
('John', 'Lee', '1988-03-10');
GO

INSERT INTO Room (RoomName, Description)
VALUES
('Parisian Room', 'Elegant room with Eiffel Tower view, perfect for romantic getaways'),
('Jungle Room', 'Lush greenery and playful animal décor, ideal for adventurous cats'),
('Underwater Room', 'Relaxing ocean theme with calming blue tones and fish tank'),
('Modern Loft', 'Sleek and stylish space with plenty of climbing opportunities'),
('Cozy Cottage', 'Warm and inviting room with soft furnishings, good for shy cats');
GO

INSERT INTO Cat (CatName, DateOfBirth, Gender, FoodID, CatParentID)
VALUES
('Luna', '2023-01-15', 'F', 2, 1), 
('Oliver', '2022-05-08', 'M', 4, 2), 
('Milo', '2021-12-24', 'M', 1, 1), 
('Lucy', '2023-03-12', 'F', 5, 3), 
('Simba', '2020-07-21', 'M', 3, 3), 
('Bella', '2022-09-05', 'F', 6, 2);
GO

INSERT INTO Price (Amount, ChangeDate, RoomID)
VALUES
(3350.00, '2024-02-07', 1),
(4400.00, '2024-02-07', 2),
(4450.00, '2024-02-07', 3),
(5300.00, '2024-02-07', 4),
(6250.00, '2024-02-07', 5);
GO

INSERT INTO Booking (CatId, StaffId, RoomId, StartDate, EndDate, Notes)
VALUES
(1, 5, 3, '2024-02-17', '2024-02-21', 'Luna needs extra playtime.'),
(2, 3, 4, '2024-02-22', '2024-02-26', 'Oliver prefers wet food meals.'),
(3, 2, 2, '2024-02-27', '2024-03-03', 'Milo is an active cat, needs climbing structures.'),
(4, 6, 1, '2024-03-04', '2024-03-08', 'Lucy enjoys catnip toys.'),
(5, 4, 5, '2024-03-09', '2024-03-13', 'Simba is shy, needs gentle care.'),
(6, 1, 4, '2024-03-14', '2024-03-18', 'Bella likes to lounge in the sun.');
GO


