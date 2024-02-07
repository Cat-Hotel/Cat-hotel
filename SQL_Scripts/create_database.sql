USE master;
GO

CREATE DATABASE CatHotel;
GO

USE CatHotel;
GO

CREATE TABLE CatParent (
    CatParentID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL, 
    LastName NVARCHAR(50), 
    CellNumber NVARCHAR(20) UNIQUE,
    EmailAddress NVARCHAR(100) UNIQUE
);
GO

CREATE TABLE Food (
    FoodID INT PRIMARY KEY IDENTITY(1,1),
    FoodName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);
GO

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    DateOfBirth DATE NOT NULL
);
GO

CREATE TABLE Room (
  RoomID INT PRIMARY KEY IDENTITY(1,1),
  RoomName NVARCHAR(50) NOT NULL,
  Description NVARCHAR(255)
);
GO

CREATE TABLE Cat (
    CatID INT PRIMARY KEY IDENTITY(1,1),
    CatName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender Char(1),
    FoodID INT FOREIGN KEY REFERENCES Food(FoodID),
    CatParentID INT FOREIGN KEY REFERENCES CatParent(CatParentID)
);
GO

CREATE TABLE Price (
  PriceID INT PRIMARY KEY IDENTITY(1,1),
  Amount DECIMAL(10,2) NOT NULL,
  ChangeDate DATE,
  RoomID INT FOREIGN KEY REFERENCES Room(RoomID),
  CONSTRAINT FK_Price_Room_RoomID FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);
GO

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CatID INT FOREIGN KEY REFERENCES Cat(CatID),
    StaffID INT FOREIGN KEY REFERENCES Staff(StaffID),
    RoomID INT FOREIGN KEY REFERENCES Room(RoomID),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Notes NVARCHAR(255)
);
GO
