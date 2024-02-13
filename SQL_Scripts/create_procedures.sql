USE CatHotel;
GO

CREATE OR ALTER PROCEDURE [dbo].[GetErrorInfo]
AS
  SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
GO

CREATE OR ALTER PROCEDURE [dbo].[CreateOrUpdateBooking]
(
    @CatID INT,
    @StaffID INT,
    @RoomID INT,
    @StartDate DATE,
    @EndDate DATE,
    @BookingStatusID INT,
    @Notes NVARCHAR(255) = NULL,
    @BookingID INT = NULL --set to value to update
)
AS
    BEGIN TRANSACTION BookingTransaction;

    BEGIN TRY
        IF @BookingID IS NULL
            INSERT INTO dbo.Booking 
                (CatID, StaffID, RoomID, StartDate, EndDate, BookingStatusID, Notes)
            VALUES	(@CatID, @StaffID, @RoomID, @StartDate, @EndDate, @BookingStatusID, @Notes);
        ELSE
            UPDATE dbo.Booking 
            SET	CatID = @CatID, StaffID = @StaffID, RoomID = @RoomID, 
                StartDate = @StartDate, EndDate = @EndDate, 
                BookingStatusID = @BookingStatusID, Notes = @Notes
            WHERE @BookingID = @BookingID;
        COMMIT TRANSACTION BookingTransaction;
    END TRY

    BEGIN CATCH
        EXECUTE [dbo].[GetErrorInfo]
        ROLLBACK TRANSACTION BookingTransaction;
    END CATCH
GO