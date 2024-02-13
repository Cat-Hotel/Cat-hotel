USE master;
GO

IF DB_ID (N'CatHotel') IS NOT NULL
ALTER DATABASE CatHotel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

IF DB_ID (N'CatHotel') IS NOT NULL
DROP DATABASE CatHotel;
GO

CREATE DATABASE CatHotel;
GO

USE CatHotel;
GO

CREATE TABLE CatParent (
    CatParentID INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL, 
    LastName NVARCHAR(50), 
    CellNumber NVARCHAR(20),
    EmailAddress NVARCHAR(100), 
    CONSTRAINT [PK_CatParent] PRIMARY KEY CLUSTERED 
	(
		[CatParentID] ASC
	),
    CONSTRAINT UNQ_CatParent_CellNumber UNIQUE(CellNumber),
    CONSTRAINT UNQ_CatParent_EmailAddress UNIQUE(EmailAddress)
);
GO

CREATE TABLE Food (
    FoodID INT IDENTITY(1,1) NOT NULL,
    FoodName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255),
    CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
	(
		[FoodID] ASC
	)
);
GO

CREATE TABLE Staff (
    StaffID INT IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    DateOfBirth DATE NOT NULL,
    CellNumber NVARCHAR(20),
    CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
	(
		[StaffID] ASC
	),
    CONSTRAINT CHK_Staff_DOB CHECK (DateOfBirth < GETDATE()),
    CONSTRAINT UNQ_Staff_CellNumber UNIQUE(CellNumber)
);
GO

CREATE TABLE Room (
    RoomID INT IDENTITY(1,1) NOT NULL,
    RoomName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255),
    CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
	(
		[RoomID] ASC
	)
);
GO

CREATE TABLE Cat (
    CatID INT IDENTITY(1,1) NOT NULL,
    CatName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Sex Char(1),
    FoodID INT,
    CatParentID INT,
    CONSTRAINT [PK_Cat] PRIMARY KEY CLUSTERED 
	(
		[CatID] ASC
	),
    CONSTRAINT [FK_Cat_Food] FOREIGN KEY (FoodID)
        REFERENCES [dbo].[Food] (FoodID),
    CONSTRAINT [FK_Cat_Parent] FOREIGN KEY (CatParentID)
        REFERENCES [dbo].[CatParent] (CatParentID),
    CONSTRAINT CHK_Cat_Sex CHECK (Sex IN ('M','F')) 
)
GO

CREATE TABLE Price (
    PriceID INT IDENTITY(1,1) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    ChangeDate DATE CONSTRAINT DEF_Price_ChangeDate DEFAULT GETDATE(),
    RoomID INT,
    CONSTRAINT FK_Price_Room FOREIGN KEY (RoomID) 
        REFERENCES [dbo].[Room] (RoomID) 
        ON DELETE CASCADE,
    CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED 
	(
		[PriceID] ASC
	)
);
GO

CREATE TABLE BookingStatus (
    BookingStatusID INT IDENTITY (1,1), 
    BookingStatus VARCHAR(255),
    CONSTRAINT [PK_BookingStatus] PRIMARY KEY CLUSTERED 
	(
		[BookingStatusID] ASC
	),
    CONSTRAINT UNQ_BookingStatus_BookingStatus UNIQUE(BookingStatus)
); 
GO 

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) NOT NULL,
    CatID INT,
    StaffID INT,
    RoomID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Notes NVARCHAR(255),
    BookingStatusID INT CONSTRAINT DEF_Booking_BookingStatusID DEFAULT 1,
    CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
	(
		[BookingID] ASC
	),
    CONSTRAINT [FK_Booking_Cat] FOREIGN KEY (CatID)
        REFERENCES [dbo].[Cat] (CatID),
    CONSTRAINT [FK_Booking_Staff] FOREIGN KEY (StaffID)
        REFERENCES [dbo].[Staff] (StaffID),
    CONSTRAINT [FK_Booking_Room] FOREIGN KEY (RoomID)
        REFERENCES [dbo].[Room] (RoomID),
    CONSTRAINT [FK_Booking_BookingStatus] FOREIGN KEY (BookingStatusID)
        REFERENCES [dbo].[BookingStatus] (BookingStatusID),
    CONSTRAINT CHK_Booking_Dates CHECK (StartDate < EndDate)
);
GO
