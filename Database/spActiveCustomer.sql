USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spActiveCustomer]') AND type IN (N'P'))
    DROP PROCEDURE [dbo].[spActiveCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 7 Jun 2016 23:32:11
-- Description   : Provide procedure to get auto number counter.
-- 
-- ===================================================================================

CREATE PROCEDURE [dbo].[spActiveCustomer]
(
    @SiteID uniqueidentifier
)
AS
BEGIN
    DECLARE @ActiveTransactionPeriod int;

    SET @ActiveTransactionPeriod = CAST((SELECT [Value] FROM [dbo].[SystemParameter] WHERE [ID] = 'Customer.ActiveTransactionPeriod') AS int);

    UPDATE
            [dbo].[Customer]
        SET
            [StatusID] = 2 -- Inactive
        WHERE
            [ID] IN
            (
                SELECT
                        [SO].[CustomerID]
                    FROM
                        [dbo].[SalesOrder] [SO] INNER JOIN
                        [dbo].[Customer] [C] ON ([SO].[CustomerID] = [C].[ID]) INNER JOIN
                        [dbo].[Warehouse] [W] ON ([SO].[WarehouseID] = [W].[ID])
                    WHERE
                        ([SO].[DocumentStatusID] = 2) AND -- Posted
                        ([C].[StatusID] = 1) AND -- Active
                        ([C].[IsDeleted] = 0) AND
                        ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                    GROUP BY
                        [SO].[CustomerID]
                    HAVING
                        (MAX([SO].[TransactionDate]) < DATEADD(m, (@ActiveTransactionPeriod * -1), [dbo].[ConvertToFirstTimeOfDay](GETUTCDATE())))
            );
END;
GO
