USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spReportSellOut]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spReportSellOut];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to create [dbo].[ReportSellOut] data.
-- ===================================================================================

CREATE PROCEDURE [dbo].[spReportSellOut]
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
            [dbo].[ReportSellOut]
        WHERE
            ([ReportDate] >= @TransactionDateFrom) AND
            ([ReportDate] <= @TransactionDateTo) AND
            ((@SiteID IS NULL) OR ([SiteID] = @SiteID));
    
    WITH
        TBL 
        AS
        (
            SELECT
                    [RSOP].[TransactionDate] [ReportDate],
                    [RSOP].[TerritoryID],
                    [RSOP].[Territory],
                    [RSOP].[RegionID],
                    [RSOP].[Region],
                    [RSOP].[AreaID],
                    [RSOP].[Area],
                    [RSOP].[CompanyID],
                    [RSOP].[Company],
                    [RSOP].[SiteID],
                    [RSOP].[Site],
                    [RSOP].[SiteDistributionTypeID],
                    [RSOP].[SiteDistributionTypeName],
                    [RSOP].[SalesmanID],
                    [RSOP].[Salesman],
                    [RSOP].[WarehouseID],
                    [RSOP].[Warehouse],
                    [RSOP].[WarehouseTypeID],
                    [RSOP].[WarehouseTypeName],
                    [RSOP].[SalesmanGroupID],
                    [RSOP].[SalesmanGroupName],
                    [RSOP].[SalesmanCategoryID],
                    [RSOP].[SalesmanCategoryName],
                    [RSOP].[ProductID],
                    [RSOP].[Product],
                    [RSOP].[ProductBrandID],
                    [RSOP].[ProductBrand],
                    [RSOP].[ProductEquivalent],
                    [RSOP].[ProductGroup],
                    ISNULL([ST].[SalesOrderAmount], 0) [TargetSalesOrderAmount],
                    [RSOP].[TotalSalesOrderAmount],
                    [RSOP].[TotalSalesOrderReturnAmount],
                    [RSOP].[ActualSalesOrderAmount],
                    ISNULL([SPT].[SalesOrderQty], 0) [TargetSalesOrderQty],
                    [RSOP].[TotalSalesOrderQty],
                    [RSOP].[TotalSalesOrderReturnQty],
                    [RSOP].[ActualSalesOrderQty],
                    ISNULL([ST].[NewCustomer], 0) [TargetNewCustomer],
                    (
                        SELECT
                                COUNT([C].[ID])
                            FROM
                                [dbo].[Customer] [C]
                            WHERE
                                [C].[SalesmanID] = [RSOP].[SalesmanID] AND
                                ([dbo].[ConvertToFirstTimeOfDay]([C].[RegisteredDate]) = [RSOP].[TransactionDate])
                    ) [ActualNewCustomer],
                    (
                        SELECT
                                COUNT([RP].[CustomerID])
                            FROM
                                [dbo].[RoutePlan] [RP]
                            WHERE
                                ([RP].[SalesmanID] = [RSOP].[SalesmanID]) AND
                                ([RP].[WeekID] = (CAST(~(CAST(DATEPART(WEEK, [RSOP].[TransactionDate]) % 2 AS bit)) AS int) + 1)) AND
                                ([RP].[DayID] = DATEPART(WEEKDAY, [RSOP].[TransactionDate]))
                    ) [TargetCall],
                    0 [ActualCall], ------------------------------------
                    ISNULL([ST].[Visibility], 0) [TargetVisibility],
                    0 [ActualVisibility], ------------------------------------
                    (ISNULL([SPT].[EffectiveCall], 0) * (ISNULL([SPT].[CustomerTransaction], 0) / 100 * ISNULL([ST].[RegisteredCustomer], 0))) [TargetEffectiveCall],
                    ISNULL([AEC].[ActualEffectiveCall], 0) [ActualEffectiveCall],
                    (ISNULL([SPT].[CustomerTransaction], 0) / 100 * ISNULL([ST].[RegisteredCustomer], 0)) [TargetCustomerTransaction]
                FROM
                    (                                    
                        SELECT
                                [RSO].[TransactionDate],
                                [T].[ID] [TerritoryID],
                                [dbo].[fCodeNameFormatter]([T].[Code], [T].[Name]) [Territory],
                                [R].[ID] [RegionID],
                                [dbo].[fCodeNameFormatter]([R].[Code], [R].[Name]) [Region],
                                [A].[ID] [AreaID],
                                [dbo].[fCodeNameFormatter]([A].[Code], [A].[Name]) [Area],
                                [C].[ID] [CompanyID],
                                [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Company],
                                [ST].[ID] [SiteID],
                                [dbo].[fCodeNameFormatter]([ST].[Code], [ST].[Name]) [Site],
                                [ST].[DistributionTypeID] [SiteDistributionTypeID],
                                [fSL].[Name] [SiteDistributionTypeName],
                                [S].[ID] [SalesmanID],
                                [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
                                [W].[ID] [WarehouseID],
                                [dbo].[fCodeNameFormatter]
                                (
                                    [W].[Code],
                                    (SELECT CASE WHEN [W].[TypeID] = 1 THEN '[' + [fSL2].[Name] + '] ' ELSE '' END) + [W].[Name]
                                ) [Warehouse],
                                [W].[TypeID] [WarehouseTypeID],
                                [fSL2].[Name] [WarehouseTypeName],
                                [S].[GroupID] [SalesmanGroupID],
                                [fSL3].[Name] [SalesmanGroupName],
                                [S].[CategoryID] [SalesmanCategoryID],
                                [fSL4].[Name] [SalesmanCategoryName],
                                [RSO].[ProductID],
                                [dbo].[fCodeNameFormatter]([P].[Code], [P].[Name]) [Product],
                                [PB].[ID] [ProductBrandID],
                                [dbo].[fCodeNameFormatter]([PB].[Code], [PB].[Name]) [ProductBrand],
                                CAST(ISNULL([PAI].[AdditionalInfo1], 1) AS float) [ProductEquivalent],
                                ISNULL([PAI].[AdditionalInfo2], '') [ProductGroup],
                                [RSO].[TotalSalesOrderAmount],
                                [RSO].[TotalSalesOrderReturnAmount],
                                [RSO].[ActualSalesOrderAmount],
                                [RSO].[TotalSalesOrderQty],
                                [RSO].[TotalSalesOrderReturnQty],
                                [RSO].[ActualSalesOrderQty]
                            FROM
                                (
                                    SELECT
                                            ISNULL([vRSO].[TransactionDate], [vRSOR].[TransactionDate]) [TransactionDate],
                                            ISNULL([vRSO].[SiteID], [vRSOR].[SiteID]) [SiteID],
                                            ISNULL([vRSO].[SalesmanID], [vRSOR].[SalesmanID]) [SalesmanID],
                                            ISNULL([vRSO].[ProductID], [vRSOR].[ProductID]) [ProductID],
                                            ISNULL([vRSO].[TotalSalesOrderAmount], 0) [TotalSalesOrderAmount],
                                            ISNULL([vRSOR].[TotalSalesOrderReturnAmount], 0) [TotalSalesOrderReturnAmount],
                                            (ISNULL([vRSO].[TotalSalesOrderAmount], 0) - ISNULL([vRSOR].[TotalSalesOrderReturnAmount], 0)) [ActualSalesOrderAmount],
                                            ISNULL([vRSO].[TotalSalesOrderQty], 0) [TotalSalesOrderQty],
                                            ISNULL([vRSOR].[TotalSalesOrderReturnQty], 0) [TotalSalesOrderReturnQty],
                                            (ISNULL([vRSO].[TotalSalesOrderQty], 0) - ISNULL([vRSOR].[TotalSalesOrderReturnQty], 0)) [ActualSalesOrderQty]
                                        FROM
                                        (
                                            SELECT
                                                    [dbo].[ConvertToFirstTimeOfDay]([SO].[TransactionDate]) [TransactionDate],
                                                    [W].[SiteID],
                                                    [SO].[SalesmanID],
                                                    [SOS].[ProductID],
                                                    SUM([SOS].[Subtotal]) [TotalSalesOrderAmount],
                                                    SUM([SOS].[Qty] * -1) [TotalSalesOrderQty]
                                                FROM
                                                    [dbo].[SalesOrder] [SO] INNER JOIN
                                                    [dbo].[SalesOrderSummary] [SOS] ON ([SO].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
                                                    [dbo].[Salesman] [S] ON ([SO].[SalesmanID] = [S].[ID]) INNER JOIN
                                                    [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID])
                                                WHERE
                                                    ([SO].[DocumentStatusID] = 2) AND
                                                    ([SO].[TransactionDate] >= @TransactionDateFrom) AND
                                                    ([SO].[TransactionDate] <= @TransactionDateTo) AND
                                                    ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                                                GROUP BY
                                                    [dbo].[ConvertToFirstTimeOfDay]([SO].[TransactionDate]),
                                                    [W].[SiteID],
                                                    [SO].[SalesmanID],
                                                    [SOS].[ProductID]
                                        ) [vRSO] FULL OUTER JOIN
                                        (
                                            SELECT
                                                    [dbo].[ConvertToFirstTimeOfDay]([SOR].[TransactionDate]) [TransactionDate],
                                                    [W].[SiteID],
                                                    [SOR].[SalesmanID],
                                                    [SORS].[ProductID],
                                                    SUM([SORS].[Subtotal]) [TotalSalesOrderReturnAmount],
                                                    SUM([SORS].[Qty] * -1) [TotalSalesOrderReturnQty]
                                                FROM
                                                    [dbo].[SalesOrderReturn] [SOR] INNER JOIN
                                                    [dbo].[SalesOrderReturnSummary] [SORS] ON ([SOR].[DocumentID] = [SORS].[DocumentID]) INNER JOIN
                                                    [dbo].[Salesman] [S] ON ([SOR].[SalesmanID] = [S].[ID]) INNER JOIN
                                                    [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID])
                                                WHERE
                                                    ([SOR].[DocumentStatusID] = 2) AND
                                                    ([SOR].[TransactionDate] >= @TransactionDateFrom) AND
                                                    ([SOR].[TransactionDate] <= @TransactionDateTo) AND
                                                    ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                                                GROUP BY
                                                    [dbo].[ConvertToFirstTimeOfDay]([SOR].[TransactionDate]),
                                                    [W].[SiteID],
                                                    [SOR].[SalesmanID],
                                                    [SORS].[ProductID]                                
                                        ) [vRSOR] ON
                                        (
                                            [vRSO].[TransactionDate] = [vRSOR].[TransactionDate] AND
                                            [vRSO].[SalesmanID] = [vRSOR].[SalesmanID] AND
                                            [vRSO].[ProductID] = [vRSOR].[ProductID]
                                        )
                                ) [RSO] INNER JOIN
                                [dbo].[Salesman] [S] ON ([RSO].[SalesmanID] = [S].[ID]) INNER JOIN
                                [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID]) INNER JOIN
                                [dbo].[Site] [ST] ON ([W].[SiteID] = [ST].[ID]) INNER JOIN
                                [dbo].[Company] [C] ON ([ST].[CompanyID] = [C].[ID]) INNER JOIN
                                [dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) INNER JOIN
                                [dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
                                [dbo].[Territory] [T] ON ([R].[TerritoryID] = [T].[ID]) INNER JOIN
                                [dbo].[Product] [P] ON ([RSO].[ProductID] = [P].[ID]) INNER JOIN
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
                                ) [fSL2] ON ([W].[TypeID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
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
                                    'SalesmanGroup',
                                    NULL,
                                    NULL,
                                    NULL
                                ) [fSL3] ON ([S].[GroupID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
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
                                    'SalesmanCategory',
                                    NULL,
                                    NULL,
                                    NULL
                                ) [fSL4] ON ([S].[CategoryID] = [fSL4].[Value_Int32])
                            WHERE
                                ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                    ) [RSOP] LEFT OUTER JOIN
                    (
                        SELECT
                                [SalesmanID],
                                [PeriodID],
                                [SalesOrderAmount],
                                [NewCustomer],
                                [Visibility],
                                (
                                    SELECT
                                            COUNT([C].[ID]) [Count]
                                        FROM
                                            [dbo].[Customer] [C]
                                        WHERE
                                            ([C].[SalesmanID] = [vST].[SalesmanID]) AND
                                            ([C].[IsDeleted] = 0) AND
                                            ([C].[StatusID] >= 1) AND
                                            ([C].[RegisteredDate] <= [dbo].[ConvertToLastDayOfMonth](DATEADD(m, -1, [vST].[PeriodID])))
                                ) [RegisteredCustomer]
                            FROM
                                [dbo].[SalesmanTarget] [vST]                                                
                    ) [ST] ON
                    (                        
                        [dbo].[ConvertToFirstDayOfMonth]([RSOP].[TransactionDate]) = [dbo].[ConvertToFirstDayOfMonth]([ST].[PeriodID]) AND
                        [RSOP].[SalesmanID] = [ST].[SalesmanID] 
                    ) LEFT OUTER JOIN
                    [dbo].[SalesmanProductTarget] [SPT] ON
                    (
                        [dbo].[ConvertToFirstDayOfMonth]([RSOP].[TransactionDate]) = [dbo].[ConvertToFirstDayOfMonth]([SPT].[PeriodID]) AND
                        [RSOP].[SalesmanID] = [SPT].[SalesmanID] AND
                        [RSOP].[ProductID] = [SPT].[ProductID]
                    ) LEFT OUTER JOIN                    
                    (
                        SELECT
                                [SalesmanID],
                                [ProductID],
                                [TransactionDate],
                                COUNT([CustomerID]) [ActualEffectiveCall]
                            FROM
                            (
                                SELECT DISTINCT
                                        [SO].[SalesmanID],                                        
                                        [SOS].[ProductID],
                                        [dbo].[ConvertToFirstTimeOfDay]([SO].[TransactionDate]) [TransactionDate],
                                        [SO].[CustomerID]
                                    FROM
                                        [dbo].[SalesOrder] [SO] INNER JOIN
                                        [dbo].[SalesOrderSummary] [SOS] ON ([SO].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
                                        [dbo].[Salesman] [S] ON ([SO].[SalesmanID] = [S].[ID]) INNER JOIN
                                        [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID])
                                    WHERE
                                        ([SO].[DocumentStatusID] = 2) AND
                                        ([SO].[TransactionDate] >= @TransactionDateFrom) AND
                                        ([SO].[TransactionDate] <= @TransactionDateTo) AND
                                        ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
                            ) [vACT]
                            GROUP BY
                                [SalesmanID],
                                [ProductID],
                                [TransactionDate]
                    ) [AEC] ON
                    (
                        [RSOP].[SalesmanID] = [AEC].[SalesmanID] AND
                        [RSOP].[ProductID] = [AEC].[ProductID] AND
                        [RSOP].[TransactionDate] = [AEC].[TransactionDate]
                    )
        )
    INSERT INTO
            [dbo].[ReportSellOut]
        SELECT
                [ReportDate],
                [SalesmanID],
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
                [SalesmanGroupID],
                [SalesmanGroupName],
                [SalesmanCategoryID],
                [SalesmanCategoryName],
                [Product],
                [ProductBrandID],
                [ProductBrand],
                [ProductEquivalent],
                [ProductGroup],
                [TargetSalesOrderAmount],
                [TotalSalesOrderAmount],
                [TotalSalesOrderReturnAmount],
                [ActualSalesOrderAmount],
                [TargetSalesOrderQty],
                [TotalSalesOrderQty],
                [TotalSalesOrderReturnQty],
                [ActualSalesOrderQty],                
                [TargetNewCustomer],
                [ActualNewCustomer],
                [TargetCall],
                [ActualCall],
                [TargetVisibility],
                [ActualVisibility],
                [TargetEffectiveCall],
                [ActualEffectiveCall],
                [TargetCustomerTransaction]
            FROM
                TBL;
END;
GO
