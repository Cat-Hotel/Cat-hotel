USE CatHotel;
GO

EXEC tSQLt.NewTestClass 'TestGetTotalCost';
GO

CREATE OR ALTER PROC TestGetTotalCost.[test total cost amount]
AS 
BEGIN
DECLARE @TestedID AS int = 2
DECLARE @expected AS DECIMAL(18,2) = 43750.00
DECLARE @actual AS DECIMAL(18,2)
SET @actual = dbo.GetTotalCost(2)

EXEC tSQLt.AssertEquals @expected, @actual

END
GO

CREATE OR ALTER PROC TestGetTotalCost.[test total cost amount when zero]
AS 
BEGIN
DECLARE @TestedID AS int = 3
DECLARE @expected AS DECIMAL(18,2) = 0.00
DECLARE @actual AS DECIMAL(18,2)
SET @actual = dbo.GetTotalCost(3)

EXEC tSQLt.AssertEquals @expected, @actual

END
GO

EXEC tSQLt.NewTestClass 'TestGetAvailableRooms';
GO

CREATE OR ALTER PROC TestGetAvailableRooms.[test rooms when booked]
AS
BEGIN
  IF OBJECT_ID('[schema_name].expected', 'U') IS NOT NULL
    DROP TABLE [schema_name].expected;

  DECLARE @TestStartDate DATE = '2024-02-17';
  DECLARE @TestEndDate DATE = '2024-02-19';

  CREATE TABLE #expected (
    RoomID INT,
    RoomName NVARCHAR(50),
    Description NVARCHAR(255)
  );

  INSERT INTO #expected (RoomID, RoomName, Description)
  VALUES
    (3, 'Underwater Room', 'Relaxing ocean theme with calming blue tones and fish tank'),
    (4, 'Modern Loft', 'Sleek and stylish space with plenty of climbing opportunities'),
    (5, 'Cozy Cottage', 'Warm and inviting room with soft furnishings, good for shy cats');

  CREATE TABLE #actual (
    RoomID INT,
    RoomName NVARCHAR(50),
    Description NVARCHAR(255)
  );

  INSERT INTO #actual (RoomID, RoomName, Description)
  SELECT RoomID, RoomName, Description
  FROM dbo.GetAvailableRooms(@TestStartDate, @TestEndDate);

  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;
GO

CREATE OR ALTER PROC TestGetAvailableRooms.[test rooms when not booked]
AS
BEGIN
  IF OBJECT_ID('[schema_name].expected', 'U') IS NOT NULL
    DROP TABLE [schema_name].expected;

  DECLARE @TestStartDate DATE = '2025-01-01';
  DECLARE @TestEndDate DATE = '2025-01-05';

  CREATE TABLE #expected (
    RoomID INT,
    RoomName NVARCHAR(50),
    Description NVARCHAR(255)
  );

  INSERT INTO #expected (RoomID, RoomName, Description)
  VALUES
    (1, 'Parisian Room', 'Elegant room with Eiffel Tower view, perfect for romantic getaways'),
    (2, 'Jungle Room', 'Lush greenery and playful animal décor, ideal for adventurous cats'),
    (3, 'Underwater Room', 'Relaxing ocean theme with calming blue tones and fish tank'),
    (4, 'Modern Loft', 'Sleek and stylish space with plenty of climbing opportunities'),
    (5, 'Cozy Cottage', 'Warm and inviting room with soft furnishings, good for shy cats');

  CREATE TABLE #actual (
    RoomID INT,
    RoomName NVARCHAR(50),
    Description NVARCHAR(255)
  );

  INSERT INTO #actual (RoomID, RoomName, Description)
  SELECT RoomID, RoomName, Description
  FROM dbo.GetAvailableRooms(@TestStartDate, @TestEndDate);

  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;
GO

EXEC tSQLt.NewTestClass 'TestGetBookingStatusCount';
GO

CREATE OR ALTER PROC TestGetBookingStatusCount.[test during a single month]
AS
BEGIN
  IF OBJECT_ID('[schema_name].expected', 'U') IS NOT NULL
    DROP TABLE [schema_name].expected;

  DECLARE @TestStartDate DATE = '2024-02-01';
  DECLARE @TestEndDate DATE = '2024-02-29';

  CREATE TABLE #expected (
    BookingStatus VARCHAR(255),
    Count int
  );

  INSERT INTO #expected (BookingStatus, Count)
  VALUES
    ('Canceled', 1),
	  ('Checked out', 1),
	  ('Pending', 1);

  CREATE TABLE #actual (
    BookingStatus VARCHAR(255),
    Count int
  );

  INSERT INTO #actual (BookingStatus, Count)
  SELECT BookingStatus, Count
  FROM dbo.GetBookingStatusCount(@TestStartDate, @TestEndDate);

  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;
GO

CREATE OR ALTER PROC TestGetBookingStatusCount.[test during multiple months]
AS
BEGIN
  IF OBJECT_ID('[schema_name].expected', 'U') IS NOT NULL
    DROP TABLE [schema_name].expected;

  DECLARE @TestStartDate DATE = '2024-02-01';
  DECLARE @TestEndDate DATE = '2024-03-31';

  CREATE TABLE #expected (
    BookingStatus VARCHAR(255),
    Count int
  );

  INSERT INTO #expected (BookingStatus, Count)
  VALUES
    ('Canceled', 1),
	  ('Checked out', 1),
	  ('Pending', 2);

  CREATE TABLE #actual (
    BookingStatus VARCHAR(255),
    Count int
  );

  INSERT INTO #actual (BookingStatus, Count)
  SELECT BookingStatus, Count
  FROM dbo.GetBookingStatusCount(@TestStartDate, @TestEndDate);

  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;
GO

CREATE OR ALTER PROC TestGetBookingStatusCount.[test when no bookings]
AS
BEGIN
  IF OBJECT_ID('[schema_name].expected', 'U') IS NOT NULL
    DROP TABLE [schema_name].expected;

  DECLARE @TestStartDate DATE = '2024-04-01';
  DECLARE @TestEndDate DATE = '2024-04-30';

  CREATE TABLE #expected (
    BookingStatus VARCHAR(255),
    Count int
  );

  CREATE TABLE #actual (
    BookingStatus VARCHAR(255),
    Count int
  );

  INSERT INTO #actual (BookingStatus, Count)
  SELECT BookingStatus, Count
  FROM dbo.GetBookingStatusCount(@TestStartDate, @TestEndDate);

  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;
GO