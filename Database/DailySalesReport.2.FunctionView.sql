USE [IDOS_LIVE];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDailySalesReport]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDailySalesReport];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[RoutePlan] by Salesman data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDailySalesReport]
(
    @ReportDateFrom date,
    @ReportDateTo date,
    @TerritoryID int,
    @RegionID int,
    @AreaID int,
    @CompanyID int,
    @SiteID uniqueidentifier,
    @SiteDistributionTypeID int,
    @SalesmanID uniqueidentifier,
    @WarehouseID uniqueidentifier,
    @WarehouseTypeID int,
    @SalesmanGroupID int,
    @SalesmanCategoryID int,
    @ProductBrandID int,
    @ProductID int
)
RETURNS TABLE 
AS
RETURN 
(
    WITH        
        TBL
        AS
        (
            SELECT
                    [RSO].[SalesmanID],
                    [RSO].[ProductBrandID],
                    [RSO].[ProductGroup],
                    [RSO].[Salesman],                    
                    [RSO].[SalesmanGroupID],
                    [RSO].[SalesmanGroupName],
                    [RSO].[SalesmanCategoryID],
                    [RSO].[SalesmanCategoryName],                    
                    [RSO].[ProductBrand],
                    [RSO].[ProductEquivalent],
                    [RSO].[TargetSalesOrderQty],
                    [RSO].[TotalSalesOrderQty],
                    [RSO].[TotalSalesOrderReturnQty],
                    [RSO].[ActualSalesOrderQty],
                    [RSO].[TargetNewCustomer],
                    [RSO].[ActualNewCustomer],
                    [RSO].[TargetCall],
                    [RSO].[ActualCall],
                    [RSO].[TargetVisibility],
                    [RSO].[ActualVisibility],
                    [RSO].[TargetEffectiveCall],
                    [RSO].[ActualEffectiveCall],
                    [RSO].[TargetCustomerTransaction],
                    [ACT].[ActualCustomerTransaction]
                FROM
                (
                        SELECT
                                [SalesmanID],
                                [ProductBrandID],
	                            [ProductGroup],
                                MIN([Salesman]) [Salesman],                    
                                MIN([SalesmanGroupID]) [SalesmanGroupID],
                                MIN([SalesmanGroupName]) [SalesmanGroupName],
                                MIN([SalesmanCategoryID]) [SalesmanCategoryID],
                                MIN([SalesmanCategoryName]) [SalesmanCategoryName],                    
                                MIN([ProductBrand]) [ProductBrand],
                                MIN([ProductEquivalent]) [ProductEquivalent],
                                MIN([TargetSalesOrderQty]) [TargetSalesOrderQty],
                                SUM([TotalSalesOrderQty]) [TotalSalesOrderQty],
                                SUM([TotalSalesOrderReturnQty]) [TotalSalesOrderReturnQty],
                                SUM([ActualSalesOrderQty]) [ActualSalesOrderQty],
                                MIN([TargetNewCustomer]) [TargetNewCustomer],
                                SUM([ActualNewCustomer]) [ActualNewCustomer],
                                SUM([TargetCall]) [TargetCall],
                                SUM([ActualCall]) [ActualCall],
                                MIN([TargetVisibility]) [TargetVisibility],
                                SUM([ActualVisibility]) [ActualVisibility],
                                MIN([TargetEffectiveCall]) [TargetEffectiveCall],
                                SUM([ActualEffectiveCall]) [ActualEffectiveCall],
                                MIN([TargetCustomerTransaction]) [TargetCustomerTransaction]
                            FROM
                                [dbo].[ReportSellOut]                            
                            WHERE
                                ((@ReportDateFrom IS NULL) OR ([ReportDate] >= [dbo].[ConvertToFirstTimeOfDay](@ReportDateFrom))) AND
                                ((@ReportDateTo IS NULL) OR ([ReportDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo))) AND
                                ((@SalesmanID IS NULL) OR ([SalesmanID] = @SalesmanID)) AND
                                ((@ProductID IS NULL) OR ([ProductID] = @ProductID)) AND
                                ((@TerritoryID IS NULL) OR ([TerritoryID] = @TerritoryID)) AND
                                ((@RegionID IS NULL) OR ([RegionID] = @RegionID)) AND
                                ((@AreaID IS NULL) OR ([AreaID] = @AreaID)) AND
                                ((@CompanyID IS NULL) OR ([CompanyID] = @CompanyID)) AND
                                ((@SiteID IS NULL) OR ([SiteID] = @SiteID)) AND
                                ((@SiteDistributionTypeID IS NULL) OR ([SiteDistributionTypeID] = @SiteDistributionTypeID)) AND
                                ((@WarehouseID IS NULL) OR ([WarehouseID] = @WarehouseID)) AND
                                ((@WarehouseTypeID IS NULL) OR ([WarehouseTypeID] = @WarehouseTypeID)) AND
                                ((@SalesmanGroupID IS NULL) OR ([SalesmanGroupID] = @SalesmanGroupID)) AND
                                ((@SalesmanCategoryID IS NULL) OR ([SalesmanCategoryID] = @SalesmanCategoryID)) AND
                                ((@ProductBrandID IS NULL) OR ([ProductBrandID] = @ProductBrandID))
                            GROUP BY
                                [SalesmanID],
                                [ProductBrandID],
	                            [ProductGroup]
                ) [RSO] INNER JOIN
                (
                    SELECT
                            [SalesmanID],
                            [ProductGroup],
                            COUNT([CustomerID]) [ActualCustomerTransaction]
                        FROM
                        (
                            SELECT
                                    [SalesmanID],                                        
                                    [ProductGroup],
                                    COUNT([CustomerID]) [CustomerID]
                                FROM
                                    [dbo].[ReportSellOutByCustomer]
                                WHERE
                                    ((@ReportDateFrom IS NULL) OR ([ReportDate] >= [dbo].[ConvertToFirstTimeOfDay](@ReportDateFrom))) AND
                                    ((@ReportDateTo IS NULL) OR ([ReportDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo))) AND
                                    ((@SalesmanID IS NULL) OR ([SalesmanID] = @SalesmanID)) AND
                                    ((@ProductID IS NULL) OR ([ProductID] = @ProductID)) AND
                                    ((@TerritoryID IS NULL) OR ([TerritoryID] = @TerritoryID)) AND
                                    ((@RegionID IS NULL) OR ([RegionID] = @RegionID)) AND
                                    ((@AreaID IS NULL) OR ([AreaID] = @AreaID)) AND
                                    ((@CompanyID IS NULL) OR ([CompanyID] = @CompanyID)) AND
                                    ((@SiteID IS NULL) OR ([SiteID] = @SiteID)) AND
                                    ((@SiteDistributionTypeID IS NULL) OR ([SiteDistributionTypeID] = @SiteDistributionTypeID)) AND
                                    ((@WarehouseID IS NULL) OR ([WarehouseID] = @WarehouseID)) AND
                                    ((@WarehouseTypeID IS NULL) OR ([WarehouseTypeID] = @WarehouseTypeID)) AND
                                    ((@ProductBrandID IS NULL) OR ([ProductBrandID] = @ProductBrandID)) AND
                                    ((@ProductID IS NULL) OR ([ProductID] = @ProductID))
								GROUP BY
									[SalesmanID],
		                            [ProductGroup],
		                            [CustomerID]								
                        ) [vACT]
                        GROUP BY
                            [SalesmanID],
                            [ProductGroup]
                ) [ACT] ON
                (
                    ([RSO].[SalesmanID] = [ACT].[SalesmanID]) AND
                    ([RSO].[ProductGroup] = [ACT].[ProductGroup])
                )
        )
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{1_Summary}' [ColumnArea1],
                '{1}' [ColumnArea2],
                '{1_ProductBrands}' [ColumnArea3],
                MIN([ProductBrand]) [ColumnArea4],
                CAST(SUM([TargetSalesOrderQty] * [ProductEquivalent]) AS float) [DataArea1],
                CAST(SUM([TotalSalesOrderQty] * [ProductEquivalent]) AS float) [DataArea2],
                CAST(SUM([TotalSalesOrderReturnQty] * [ProductEquivalent]) AS float) [DataArea3],
                CAST(SUM([ActualSalesOrderQty] * [ProductEquivalent]) AS float) [DataArea4],
                CAST(ISNULL((SUM([ActualSalesOrderQty]) / NULLIF(SUM([TargetSalesOrderQty]), 0)) * 100, 0) AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID],
                [ProductBrandID]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{1_Summary}' [ColumnArea1],
                '{1}' [ColumnArea2],
                '{2}' [ColumnArea3],
                '{1_TotalCustomer}' [ColumnArea4],
                CAST(ISNULL(
                (
                    SELECT COUNT([C].[ID]) FROM [dbo].[Customer] [C]
                        WHERE
                            [C].[SalesmanID] = [TBL].[SalesmanID] AND
                            ((@ReportDateTo IS NULL) OR ([C].[RegisteredDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo)))
                ), 0) - MIN([ActualNewCustomer]) AS float) [DataArea1],
                CAST(NULL AS float) [DataArea2],
                CAST(NULL AS float) [DataArea3],
                CAST(NULL AS float) [DataArea4],
                CAST(NULL AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{1_Summary}' [ColumnArea1],
                '{1}' [ColumnArea2],
                '{2}' [ColumnArea3],
                '{2_NewCustomer}' [ColumnArea4],
                CAST(MIN([TargetNewCustomer]) AS float) [DataArea1],
                CAST(MIN([ActualNewCustomer]) AS float) [DataArea2],
                CAST(ISNULL((CAST(MIN([ActualNewCustomer]) AS float) / NULLIF(CAST(MIN([TargetNewCustomer]) AS float), 0)) * 100, 0) AS float) [DataArea3],
                CAST(NULL AS float) [DataArea4],
                CAST(NULL AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{1_Summary}' [ColumnArea1],
                '{1}' [ColumnArea2],
                '{2}' [ColumnArea3],
                '{3_Call}' [ColumnArea4],
                CAST(SUM([TargetCall]) AS float) [DataArea1],
                CAST(SUM([ActualCall]) AS float) [DataArea2],
                CAST(ISNULL((CAST(SUM([ActualCall]) AS float) / NULLIF(CAST(SUM([TargetCall]) AS float), 0)) * 100, 0) AS float) [DataArea3],
                CAST(NULL AS float) [DataArea4],
                CAST(NULL AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{1_Summary}' [ColumnArea1],
                '{1}' [ColumnArea2],
                '{2}' [ColumnArea3],
                '{4_Visibility}' [ColumnArea4],
                CAST(MIN([TargetVisibility]) AS float) [DataArea1],
                CAST(SUM([ActualVisibility]) AS float) [DataArea2],
                CAST(ISNULL((CAST(SUM([ActualVisibility]) AS float) / NULLIF(CAST(MIN([TargetVisibility]) AS float), 0)) * 100, 0) AS float) [DataArea3],
                CAST(NULL AS float) [DataArea4],
                CAST(NULL AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID]
        UNION        
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{2_Details}' [ColumnArea1],
                MIN([ProductBrand]) [ColumnArea2],
                MIN([ProductGroup]) [ColumnArea3],
                '{1_ProductGroupActivity}' [ColumnArea4],
                CAST(MIN([TargetEffectiveCall]) AS float) [DataArea1],
                CAST(SUM([ActualEffectiveCall]) AS float) [DataArea2],
                CAST(ISNULL((CAST(SUM([ActualEffectiveCall]) AS float) / NULLIF(CAST(MIN([TargetEffectiveCall]) AS float), 0)) * 100, 0) AS float) [DataArea3],
                CAST(MIN([TargetCustomerTransaction]) AS float) [DataArea4],
                CAST(MIN([ActualCustomerTransaction]) AS float) [DataArea5],
                CAST(ISNULL((CAST(MIN([ActualCustomerTransaction]) AS float) / NULLIF(CAST(MIN([TargetCustomerTransaction]) AS float), 0)) * 100, 0) AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID],
                [ProductBrandID],
                [ProductGroup]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{2_Details}' [ColumnArea1],
                MIN([ProductBrand]) [ColumnArea2],
                MIN([ProductGroup]) [ColumnArea3],
                '{2_ProductGroupQuantity}' [ColumnArea4],
                CAST(MIN([TargetSalesOrderQty]) AS float) [DataArea1],
                CAST(SUM([TotalSalesOrderQty]) AS float) [DataArea2],
                CAST(SUM([TotalSalesOrderReturnQty]) AS float) [DataArea3],
                CAST(SUM([ActualSalesOrderQty]) AS float) [DataArea4],
                CAST(ISNULL((CAST(SUM([ActualSalesOrderQty]) AS float) / NULLIF(CAST(MIN([TargetSalesOrderQty]) AS float), 0)) * 100, 0) AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID],
                [ProductBrandID],
                [ProductGroup]
        UNION
        SELECT
                MIN([SalesmanGroupName]) [RowArea1],
                MIN([SalesmanCategoryName]) [RowArea2],
                MIN([Salesman]) [RowArea3],
                '{2_Details}' [ColumnArea1],
                MIN([ProductBrand]) [ColumnArea2],
                MIN([ProductGroup]) [ColumnArea3],
                '{3_ProductGroupDropSize}' [ColumnArea4],
                CAST(ISNULL(CAST(SUM([ActualSalesOrderQty]) AS float) / NULLIF(CAST(SUM([ActualEffectiveCall]) AS float), 0), 0) AS float) [DataArea1],
                CAST(ISNULL(CAST(SUM([ActualSalesOrderQty]) AS float) / NULLIF(CAST(MIN([ActualCustomerTransaction]) AS float), 0), 0) AS float) [DataArea2],
                CAST(NULL AS float) [DataArea3],
                CAST(NULL AS float) [DataArea4],
                CAST(NULL AS float) [DataArea5],
                CAST(NULL AS float) [DataArea6]
            FROM
                TBL
            GROUP BY
                [SalesmanGroupID],
                [SalesmanCategoryID],
                [SalesmanID],
                [ProductBrandID],
                [ProductGroup]
);
GO
