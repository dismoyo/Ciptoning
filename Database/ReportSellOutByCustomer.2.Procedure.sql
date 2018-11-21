USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spReportSellOutByCustomer]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spReportSellOutByCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to create [dbo].[ReportSellOutByCustomer] data.
-- ===================================================================================

CREATE PROCEDURE [dbo].[spReportSellOutByCustomer]
(
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SiteID uniqueidentifier
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @date datetime = '2016-07-01'; -- iDOS 2.0 Live Start Date
    IF ((@TransactionDateFrom IS NULL) OR (@TransactionDateFrom <= @date))
        SET @TransactionDateFrom = @date;
    
    SET @date = GETUTCDATE();
    IF ((@TransactionDateTo IS NULL) OR (@TransactionDateTo >= @date))
        SET @TransactionDateTo = @date;

    SET @TransactionDateFrom = [dbo].[ConvertToFirstTimeOfDay](@TransactionDateFrom);
    SET @TransactionDateTo = [dbo].[ConvertToLastTimeOfDay](@TransactionDateTo);

    DELETE FROM
            [dbo].[ReportSellOutByCustomer]
        WHERE
            ([ReportDate] >= @TransactionDateFrom) AND
            ([ReportDate] <= @TransactionDateTo) AND
            ((@SiteID IS NULL) OR ([SiteID] = @SiteID));
    
    WITH
        TBL 
        AS
        (
            SELECT
                    [RSOC].[TransactionDate] [ReportDate],
                    [RSOC].[CustomerID],
                    [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
                    [R].[TerritoryID],
                    [dbo].[fCodeNameFormatter]([T].[Code], [T].[Name]) [Territory],
                    [A].[RegionID],
                    [dbo].[fCodeNameFormatter]([R].[Code], [R].[Name]) [Region],
                    [ST].[AreaID],
                    [dbo].[fCodeNameFormatter]([A].[Code], [A].[Name]) [Area],
                    [ST].[CompanyID],
                    [dbo].[fCodeNameFormatter]([CP].[Code], [CP].[Name]) [Company],
                    [W].[SiteID],
                    [dbo].[fCodeNameFormatter]([ST].[Code], [ST].[Name]) [Site],
                    [ST].[DistributionTypeID] [SiteDistributionTypeID],
                    [fSL].[Name] [SiteDistributionTypeName],
                    [RSOC].[SalesmanID],
                    [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
                    [S].[WarehouseID],
                    [dbo].[fCodeNameFormatter]
                    (
                        [W].[Code],
                        (SELECT CASE WHEN [W].[TypeID] = 1 THEN '[' + [fSL2].[Name] + '] ' ELSE '' END) + [W].[Name]
                    ) [Warehouse],
                    [W].[TypeID] [WarehouseTypeID],
                    [fSL2].[Name] [WarehouseTypeName],
                    [RSOC].[ProductID],
                    [dbo].[fCodeNameFormatter]([P].[Code], [P].[Name]) [Product],
                    [P].[BrandID] [ProductBrandID],
                    [dbo].[fCodeNameFormatter]([PB].[Code], [PB].[Name]) [ProductBrand],
                    CAST(ISNULL([PAI].[AdditionalInfo1], 1) AS float) [ProductEquivalent],
                    ISNULL([PAI].[AdditionalInfo2], '') [ProductGroup],
                    [RSOC].[TotalSalesOrderAmount],
                    [RSOC].[TotalSalesOrderQty]
                FROM
                    (
                        SELECT
                                [SO].[TransactionDate],
                                [SO].[SalesmanID],
                                [SO].[CustomerID],
                                [SOS].[ProductID],
                                SUM([SOS].[Subtotal]) [TotalSalesOrderAmount],
                                SUM([SOS].[Qty] * -1) [TotalSalesOrderQty]
                            FROM
                                [dbo].[SalesOrder] [SO] INNER JOIN
                                [dbo].[SalesOrderSummary] [SOS] ON ([SO].[DocumentID] = [SOS].[DocumentID]) INNER JOIN                                
                                [dbo].[Warehouse] [W] ON ([SO].[WarehouseID] = [W].[ID])
                            WHERE
                                ([SO].[DocumentStatusID] = 2) AND
                                ([SO].[TransactionDate] >= @TransactionDateFrom) AND
                                ([SO].[TransactionDate] <= @TransactionDateTo) AND
                                ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                            GROUP BY
                                [SO].[TransactionDate],
                                [SO].[SalesmanID],
                                [SO].[CustomerID],
                                [SOS].[ProductID]
                    ) [RSOC] INNER JOIN                    
                    [dbo].[Salesman] [S] ON ([RSOC].[SalesmanID] = [S].[ID]) INNER JOIN
                    [dbo].[Customer] [C] ON ([RSOC].[CustomerID] = [C].[ID]) INNER JOIN
                    [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID]) INNER JOIN
                    [dbo].[Site] [ST] ON ([W].[SiteID] = [ST].[ID]) INNER JOIN
                    [dbo].[Company] [CP] ON ([ST].[CompanyID] = [CP].[ID]) INNER JOIN
                    [dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) INNER JOIN
                    [dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
                    [dbo].[Territory] [T] ON ([R].[TerritoryID] = [T].[ID]) INNER JOIN
                    [dbo].[Product] [P] ON ([RSOC].[ProductID] = [P].[ID]) INNER JOIN
                    [dbo].[ProductBrand] [PB] ON ([P].[BrandID] = [PB].[ID]) INNER JOIN
                    [dbo].[ProductAdditionalInfo] [PAI] ON ([P].[ID] = [PAI].[ProductID]) LEFT OUTER JOIN
                    [dbo].[fSystemLookup]
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
                        'SiteDistributionType',
                        NULL,
                        NULL,
                        NULL
                    ) [fSL] ON ([ST].[DistributionTypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
                    [dbo].[fSystemLookup]
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
                        'WarehouseType',
                        NULL,
                        NULL,
                        NULL
                    ) [fSL2] ON ([W].[TypeID] = [fSL2].[Value_Int32])
                            
        )
    INSERT INTO
            [dbo].[ReportSellOutByCustomer]
        SELECT
                [ReportDate],
                [SalesmanID],
	            [CustomerID],
	            [ProductID],
	            [TerritoryID],
                [Territory],
	            [RegionID],
                [Region],
	            [AreaID],
                [Area],
	            [CompanyID],
                [Company],
	            [SiteID],
                [Site],
                [SiteDistributionTypeID],
                [SiteDistributionTypeName],                
                [Salesman],
	            [WarehouseID],
                [Warehouse],
	            [WarehouseTypeID],
                [WarehouseTypeName],
                [Customer],
	            [Product],
                [ProductBrandID],
                [ProductBrand],
                [ProductEquivalent],
	            [ProductGroup],
                [TotalSalesOrderAmount],
                [TotalSalesOrderQty]
            FROM
                TBL;
END;
GO
