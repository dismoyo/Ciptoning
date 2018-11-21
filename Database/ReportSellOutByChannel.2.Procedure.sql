USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spReportSellOutByChannel]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spReportSellOutByChannel];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to create [dbo].[ReportSellOutByChannel] data.
-- ===================================================================================

CREATE PROCEDURE [dbo].[spReportSellOutByChannel]
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
            [dbo].[ReportSellOutByChannel]
        WHERE
            ([ReportDate] >= @TransactionDateFrom) AND
            ((@TransactionDateTo IS NULL) OR ([ReportDate] <= @TransactionDateTo)) AND
            ((@SiteID IS NULL) OR ([SiteID] = @SiteID));
    
    WITH        
        TBL 
        AS
        (
            SELECT
                    [RSOC].[TransactionDate] [ReportDate],
                    ISNULL([RSOC].[CategoryChannelCode], '') [CategoryChannelCode],
                    ISNULL([CC].[CategoryChannelName], '') [CategoryChannelName],
                    ISNULL([CC].[CategoryChannel], '') [CategoryChannel],
                    [RSOC].[ProductID],
                    [OS].[TerritoryID],
                    [OS].[Territory],
                    [OS].[RegionID],
                    [OS].[Region],
                    [OS].[AreaID],
                    [OS].[Area],
                    [OS].[CompanyID],
                    [OS].[Company],
                    [OS].[SiteID],
                    [OS].[Site],
                    [OS].[SiteDistributionTypeID],
                    [OS].[SiteDistributionTypeName],                    
                    [P].[Product],
                    [P].[ProductBrandID],
                    [P].[ProductBrand],
                    [P].[ProductEquivalent],
                    [P].[ProductGroup],
                    0 [TargetSalesOrderAmount], --------------------------------------
                    [RSOC].[TotalSalesOrderAmount],
                    [RSOC].[TotalSalesOrderReturnAmount],
                    [RSOC].[ActualSalesOrderAmount],
                    0 [TargetSalesOrderQty], --------------------------------------
                    ISNULL([RSOC].[TotalSalesOrderQty], 0) [TotalSalesOrderQty],
                    ISNULL([RSOC].[TotalSalesOrderReturnQty], 0) [TotalSalesOrderReturnQty],
                    ISNULL([RSOC].[ActualSalesOrderQty], 0) [ActualSalesOrderQty]
                FROM                    
                    (
                        SELECT
                                ISNULL([vRSO].[TransactionDate], [vRSOR].[TransactionDate]) [TransactionDate],
                                ISNULL([vRSO].[SiteID], [vRSOR].[SiteID]) [SiteID],
                                ISNULL([vRSO].[CategoryChannelCode], [vRSOR].[CategoryChannelCode]) [CategoryChannelCode],
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
                                        ISNULL(RTRIM(SUBSTRING([SOX].[CustomerCategory4], 1, NULLIF(CHARINDEX('-', [SOX].[CustomerCategory4]), 0) - 1)), '') [CategoryChannelCode],
                                        [SOS].[ProductID],
                                        SUM([SOS].[Subtotal]) [TotalSalesOrderAmount],
                                        SUM([SOS].[Qty] * -1) [TotalSalesOrderQty]                    
                                    FROM
                                        [dbo].[SalesOrder] [SO] INNER JOIN
                                        [dbo].[SalesOrderSummary] [SOS] ON ([SO].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
                                        [dbo].[SalesOrderExt] [SOX] ON ([SO].[DocumentID] = [SOX].[DocumentID]) INNER JOIN
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
                                        ISNULL(RTRIM(SUBSTRING([SOX].[CustomerCategory4], 1, NULLIF(CHARINDEX('-', [SOX].[CustomerCategory4]), 0) - 1)), ''),
                                        [SOS].[ProductID]
                            ) [vRSO] FULL OUTER JOIN
                            (
                                SELECT
                                        [dbo].[ConvertToFirstTimeOfDay]([SOR].[TransactionDate]) [TransactionDate],
                                        [W].[SiteID],
                                        ISNULL(RTRIM(SUBSTRING([SORX].[CustomerCategory4], 1, NULLIF(CHARINDEX('-', [SORX].[CustomerCategory4]), 0) - 1)), '') [CategoryChannelCode],
                                        [SORS].[ProductID],
                                        SUM([SORS].[Subtotal]) [TotalSalesOrderReturnAmount],
                                        SUM([SORS].[Qty] * -1) [TotalSalesOrderReturnQty]
                                    FROM
                                        [dbo].[SalesOrderReturn] [SOR] INNER JOIN
                                        [dbo].[SalesOrderReturnSummary] [SORS] ON ([SOR].[DocumentID] = [SORS].[DocumentID]) INNER JOIN
                                        [dbo].[SalesOrderReturnExt] [SORX] ON ([SOR].[DocumentID] = [SORX].[DocumentID]) INNER JOIN
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
                                        ISNULL(RTRIM(SUBSTRING([SORX].[CustomerCategory4], 1, NULLIF(CHARINDEX('-', [SORX].[CustomerCategory4]), 0) - 1)), ''),
                                        [SORS].[ProductID]                                
                            ) [vRSOR] ON
                            (
                                [vRSO].[TransactionDate] = [vRSOR].[TransactionDate] AND
                                [vRSO].[SiteID] = [vRSOR].[SiteID] AND
                                [vRSO].[CategoryChannelCode] = [vRSOR].[CategoryChannelCode] AND
                                [vRSO].[ProductID] = [vRSOR].[ProductID]
                            )
                    ) [RSOC] INNER JOIN
                    (
                        SELECT
                                [P].[ID] [ProductID],
                                [dbo].[fCodeNameFormatter]([P].[Code], [P].[Name]) [Product],
                                [PB].[ID] [ProductBrandID],
                                [dbo].[fCodeNameFormatter]([PB].[Code], [PB].[Name]) [ProductBrand],
                                CAST(ISNULL([PAI].[AdditionalInfo1], 1) AS float) [ProductEquivalent],
                                ISNULL([PAI].[AdditionalInfo2], '') [ProductGroup]
                            FROM
                                [dbo].[Product] [P] INNER JOIN
                                [dbo].[ProductBrand] [PB] ON ([P].[BrandID] = [PB].[ID]) INNER JOIN
                                [dbo].[ProductAdditionalInfo] [PAI] ON ([P].[ID] = [PAI].[ProductID])
                    ) [P] ON ([RSOC].[ProductID] = [P].[ProductID]) INNER JOIN
                    (
                        SELECT
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
                                [fSL].[Name] [SiteDistributionTypeName]
                            FROM
                                [dbo].[Site] [ST] INNER JOIN
                                [dbo].[Company] [C] ON ([ST].[CompanyID] = [C].[ID]) INNER JOIN
                                [dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) INNER JOIN
                                [dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
                                [dbo].[Territory] [T] ON ([R].[TerritoryID] = [T].[ID]) LEFT OUTER JOIN
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
                                ) [fSL] ON ([ST].[DistributionTypeID] = [fSL].[Value_Int32])
                            WHERE
                                ((@SiteID IS NULL) OR ([ST].[ID] = @SiteID))
                    ) [OS] ON ([RSOC].[SiteID] = [OS].[SiteID]) LEFT OUTER JOIN
                    (
                        SELECT 
                                [Code] [CategoryChannelCode],
                                [Name] [CategoryChannelName],
                                [dbo].[fCodeNameFormatter]([Code], [Name]) [CategoryChannel]
                            FROM
                                [CustomerCategory]
                            WHERE
                                [Group] = 'Channel'
                    ) [CC] ON ([RSOC].[CategoryChannelCode] = [CC].[CategoryChannelCode])
        )
    INSERT INTO
            [dbo].[ReportSellOutByChannel]
        SELECT
                [ReportDate],
                [SiteID],
                [ProductID],
	            [CategoryChannelCode],
                [CategoryChannelName],
                [CategoryChannel],
                [TerritoryID],
                [Territory],
	            [RegionID],
                [Region],
	            [AreaID],
                [Area],
	            [CompanyID],
                [Company],	
                [Site],
                [SiteDistributionTypeID],
                [SiteDistributionTypeName],
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
	            [ActualSalesOrderQty]
            FROM
                TBL;
END;
GO
