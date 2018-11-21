USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spGetAutoNumberCounter]') AND type IN (N'P'))
    DROP PROCEDURE [dbo].[spGetAutoNumberCounter];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 7 Jun 2016 23:32:11
-- Description   : Provide procedure to get auto number counter.
-- 
-- ===================================================================================

CREATE PROCEDURE [dbo].[spGetAutoNumberCounter]
(
    @SiteID uniqueidentifier,
    @TypeID int
)
AS
BEGIN
    IF (NOT EXISTS(SELECT [SiteID] FROM [dbo].[AutoNumberCounter] WHERE [SiteID] = @SiteID))
    BEGIN
        DECLARE @SiteCode nvarchar(10);

        SELECT @SiteCode = [Code] FROM [dbo].[Site] WHERE [ID] = @SiteID;

        IF (@SiteCode IS NOT NULL)
        BEGIN
            INSERT INTO
                [dbo].[AutoNumberCounter]
                (
                    [SiteID],
	                [SalesOrder],
	                [SalesOrderReturn],
	                [SalesOrderSwap],
	                [SalesOrderSample],
	                [SalesOrderFOC],
	                [StockOpname],
	                [StockChanges],
	                [StockTransfer],
	                [StockDisposal],
	                [DeliveryOrder],
	                [Invoice],
	                [StockReceive],
	                [Customer]
                )
                VALUES
                (
                    @SiteID,
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [SalesOrder] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [SalesOrderReturn] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [SalesOrderSwap] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [SalesOrderSample] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [SalesOrderFOC] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [StockOpname] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [StockChanges] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [StockTransfer] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [StockDisposal] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [DeliveryOrder] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [Invoice] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([DocumentCode], 7) AS int)) FROM [StockReceive] WHERE (CHARINDEX(@SiteCode, [DocumentCode]) = 1)), 0),
                    ISNULL((SELECT MAX(CAST(RIGHT([Code], 7) AS int)) FROM [Customer] WHERE (CHARINDEX(@SiteCode, [Code]) = 1)), 0)
                );
        END;
    END;

    DECLARE @Counter int;

    IF (@TypeID = 1)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [SalesOrder] = ([SalesOrder] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 2)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [SalesOrderReturn] = ([SalesOrderReturn] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 3)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [SalesOrderSwap] = ([SalesOrderSwap] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 4)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [SalesOrderSample] = ([SalesOrderSample] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 5)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [SalesOrderFOC] = ([SalesOrderFOC] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 6)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [StockOpname] = ([StockOpname] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 7)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [StockChanges] = ([StockChanges] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 8)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [StockTransfer] = ([StockTransfer] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 9)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [StockDisposal] = ([StockDisposal] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 10)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [DeliveryOrder] = ([DeliveryOrder] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 11)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [Invoice] = ([Invoice] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 12)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [StockReceive] = ([StockReceive] + 1) WHERE [SiteID] = @SiteID;
    ELSE IF (@TypeID = 20)
        UPDATE [dbo].[AutoNumberCounter] SET @Counter = [Customer] = ([Customer] + 1) WHERE [SiteID] = @SiteID;
    
    SELECT @Counter;
END;
GO
