USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerStockOnHandPeriodic]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerStockOnHandPeriodic];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[CustomerStockOnHandPeriodic] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerStockOnHandPeriodic]
(
    @ID uniqueidentifier,
    @PeriodDateFrom datetime,
    @PeriodDateTo datetime,
    @SalesmanID uniqueidentifier,
    @CallDateFrom datetime,
    @CallDateTo datetime,
    @CustomerID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @BrandID int,
    @BrandCode nvarchar(10),
    @BrandName nvarchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CSOHP].[ID],
            [CSOHP].[PeriodDate],
            [CSOHP].[SalesmanCallID],            
            [SC].[SalesmanID],
            [SC].[CallDate],
            [SC].[CustomerID],
            [CSOHP].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [BrandID],
            [fP].[BrandCode] [BrandCode],
            [fP].[BrandName] [BrandName],
            [fP].[Brand],
            [CSOHP].[Qty],
            [CSOHP].[CreatedDate],
            [CSOHP].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName]
        FROM
			[dbo].[CustomerStockOnHandPeriodic] [CSOHP] INNER JOIN
            [dbo].[SalesmanCall] [SC] ON ([CSOHP].[SalesmanCallID] = [SC].[ID]) LEFT OUTER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @BrandID,
                @BrandCode,
                @BrandName,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fP] ON ([CSOHP].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([CSOHP].[CreatedByUserID] = [CU].[ID])
		WHERE
            ((@PeriodDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([CSOHP].[PeriodDate]) >= [dbo].[ValidateMinDate](@PeriodDateFrom))) AND
            ((@PeriodDateTo IS NULL) OR ([dbo].[ValidateMinDate]([CSOHP].[PeriodDate]) <= [dbo].[ValidateMaxDate](@PeriodDateTo))) AND
            ((@SalesmanID IS NULL) OR (@SalesmanID = [SC].[ID])) AND
            ((@CallDateFrom IS NULL) OR ([dbo].[ConvertToFirstTimeOfDay]([SC].[CallDate]) >= [dbo].[ConvertToFirstTimeOfDay](@CallDateFrom))) AND
            ((@CallDateTo IS NULL) OR ([dbo].[ConvertToLastTimeOfDay]([SC].[CallDate]) <= [dbo].[ConvertToLastTimeOfDay](@CallDateTo))) AND
            ((@CustomerID IS NULL) OR ([SC].[CustomerID] = @CustomerID)) AND
            ((@ProductID IS NULL) OR ([CSOHP].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerStockOnHandPeriodic]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerStockOnHandPeriodic];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerStockOnHandPeriodic] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerStockOnHandPeriodic]
AS
(
    SELECT
            [ID],
            [PeriodDate],
            [SalesmanCallID],            
            [SalesmanID],
            [CallDate],
            [CustomerID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [BrandID],
            [BrandCode],
            [BrandName],
            [Brand],
            [Qty],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName]
        FROM
			[dbo].[fCustomerStockOnHandPeriodic]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL                
            )
);
GO
