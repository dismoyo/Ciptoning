USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spSalesByOrderReport]') AND type IN (N'P'))
    DROP PROCEDURE [dbo].[spSalesByOrderReport];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 7 Jun 2016 23:32:11
-- Description   : Provide procedure to get Sales by Customer Report.
-- 
-- ===================================================================================

CREATE PROCEDURE [dbo].[spSalesByOrderReport]
(
    @ReportDateFrom date,
    @ReportDateTo date,
    @TerritoryID int,
    @RegionID int,
    @AreaID int,
    @CompanyID int,
    @SiteID uniqueidentifier
)
AS
BEGIN
	SELECT
			[TerritoryName],
            [RegionName],
            [AreaName],
            [SiteCode],
            [SiteName],
            [DocumentType],
            [DocumentID],
            [DocumentNumber],
            [TransactionDate],
            [SalesmanCode],
            [SalesmanName],
            [SalesmanGroupName],
	        [SalesmanCategoryName],
            [TermOfPaymentName],
            [CustomerID],
            [CustomerCode],
	        [CustomerCode_OLD_IDOS],
	        [CustomerName],
	        [CustomerAddress],
	        [City],
            [CustomerTypeCode],
            [CustomerTypeName],
	        [CustomerGroupCode],
	        [CustomerGroupName],
	        [CustomerLocationCode],
	        [CustomerLocationName],
            [CustomerChannelCode],
	        [CustomerChannelName],
            [CustomerShowcaseCode],
	        [CustomerShowcaseName],
	        [PostedDate],
            [CreatedDate],
	        [DocumentStatusID],
            [DocumentStatusName],
	        [ProductCode],
	        [ProductName],
	        [ProductBrand],
	        [Qty],
	        [NetPrice],
	        [Discount],
	        [VAT],
	        [NetTotal],
	        [GrossTotal]
		FROM
		(
			SELECT
					[R].[TerritoryID],
                    [SOX].[TerritoryName],
					[A].[RegionID],
                    [SOX].[RegionName],
					[ST].[AreaID],
                    [SOX].[AreaName],
                    [ST].[CompanyID],
                    [SOX].[CompanyName],
                    [W].[SiteID],
					[SOX].[SiteCode],
					[SOX].[SiteName],
					'SalesOrder' [DocumentType],
					[SOX].[DocumentID],
					[SOX].[DocumentCode] [DocumentNumber],
					[SOX].[TransactionDate],
					[SOX].[SalesmanCode],
					[SOX].[SalesmanName],
					[SOX].[SalesmanGroupName],
					[SOX].[SalesmanCategoryName],
					[SOX].[TermOfPaymentName],
					[SO].[CustomerID],
					[SOX].[CustomerCode],
					[CAI].[AdditionalInfo1] [CustomerCode_OLD_IDOS],
					[SOX].[CustomerName],
					[dbo].[fAddressFormatter]([CA].[Address1], [CA].[Address2], [CA].[Address3]) [CustomerAddress],
					[CA].[City] [City],
					[CC1].[Code] [CustomerTypeCode],
					[CC1].[Name] [CustomerTypeName],
					[CC2].[Code] [CustomerGroupCode],
					[CC2].[Name] [CustomerGroupName],
					[CC3].[Code] [CustomerLocationCode],
					[CC3].[Name] [CustomerLocationName],
                    [CC4].[Code] [CustomerChannelCode],
					[CC4].[Name] [CustomerChannelName],
                    [CC5].[Code] [CustomerShowcaseCode],
					[CC5].[Name] [CustomerShowcaseName],
					[SO].[PostedDate],
					[SO].[CreatedDate],
					[SO].[DocumentStatusID],
					[SL].[Name] [DocumentStatusName],
					[P].[Code] [ProductCode],
					[P].[Name] [ProductName],
					[PB].[Name] [ProductBrand],
					([SOS].[Qty] * -1) [Qty],
					[SOS].[UnitGrossPrice] [NetPrice],
					[SOS].[SubtotalDiscountStrata5] [Discount],
					[SOS].[SubtotalTax] [VAT],
					[SOS].[SubtotalGross] [NetTotal],
					[SOS].[Subtotal] [GrossTotal]
				FROM
					[dbo].[SalesOrderExt] [SOX] INNER JOIN
					[dbo].[SalesOrder] [SO] ON ([SOX].[DocumentID] = [SO].[DocumentID]) INNER JOIN                
					[dbo].[SalesOrderSummary] [SOS] ON ([SOX].[DocumentID] = [SOS].[DocumentID]) LEFT OUTER JOIN
					[dbo].[SystemLookup] [SL] ON ([SO].[DocumentStatusID] = [SL].[Value_Int32]) INNER JOIN
					[dbo].[Product] [P] ON ([SOS].[ProductID] = [P].[ID]) INNER JOIN
					[dbo].[ProductBrand] [PB] ON ([P].[BrandID] = [PB].[ID]) INNER JOIN
					[dbo].[Customer] [C] ON ([SO].[CustomerID] = [C].[ID]) INNER JOIN
					[dbo].[CustomerCategoryInfo] [CCI] ON ([SO].[CustomerID] = [CCI].[CustomerID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC1] ON ([CCI].[Category1ID] = [CC1].[ID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC3] ON ([CCI].[Category3ID] = [CC3].[ID]) LEFT OUTER JOIN 
                    [dbo].[CustomerCategory] [CC4] ON ([CCI].[Category4ID] = [CC4].[ID]) LEFT OUTER JOIN 
                    [dbo].[CustomerCategory] [CC5] ON ([CCI].[Category5ID] = [CC5].[ID]) INNER JOIN 
					[dbo].[CustomerAddress] [CA] ON ([SO].[CustomerID] = [CA].[CustomerID]) INNER JOIN
					[dbo].[CustomerAdditionalInfo] [CAI] ON ([SO].[CustomerID] = [CAI].[CustomerID]) INNER JOIN
					[dbo].[Salesman] [S] ON ([C].[SalesmanID] = [S].[ID]) INNER JOIN
					[dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID]) INNER JOIN
					[dbo].[Site] [ST] ON ([W].[SiteID] = [ST].[ID]) INNER JOIN
					[dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) INNER JOIN
					[dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
					[dbo].[Territory] [T] ON ([R].[TerritoryID] = [T].[ID])
				WHERE
					[SL].[Group] = 'DocumentStatus' AND            
					[SO].[DocumentStatusID] = 2 AND
					((@ReportDateFrom IS NULL) OR ([SO].[TransactionDate] >= [dbo].[ConvertToFirstTimeOfDay](@ReportDateFrom))) AND
					((@ReportDateTo IS NULL) OR ([SO].[TransactionDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo))) AND
					((@TerritoryID IS NULL) OR ([TerritoryID] = @TerritoryID)) AND
					((@RegionID IS NULL) OR ([RegionID] = @RegionID)) AND
					((@AreaID IS NULL) OR ([AreaID] = @AreaID)) AND
					((@CompanyID IS NULL) OR ([CompanyID] = @CompanyID)) AND
					((@SiteID IS NULL) OR ([SiteID] = @SiteID))
			UNION ALL
			SELECT
                    [R].[TerritoryID],
                    [SORX].[TerritoryName],
					[A].[RegionID],
                    [SORX].[RegionName],
					[ST].[AreaID],
                    [SORX].[AreaName],
                    [ST].[CompanyID],
                    [SORX].[CompanyName],
                    [W].[SiteID],
					[SORX].[SiteCode],
					[SORX].[SiteName],
					'SalesOrderReturn' [DocumentType],
					[SORX].[DocumentID],
					[SORX].[DocumentCode] [DocumentNumber],
					[SORX].[TransactionDate],
					[SORX].[SalesmanCode],
					[SORX].[SalesmanName],
					[SORX].[SalesmanGroupName],
					[SORX].[SalesmanCategoryName],
					[SORX].[TermOfPaymentName],
					[SOR].[CustomerID],
					[SORX].[CustomerCode],
					[CAI].[AdditionalInfo1] [CustomerCode_OLD_IDOS],
					[SORX].[CustomerName],
					[dbo].[fAddressFormatter]([CA].[Address1], [CA].[Address2], [CA].[Address3]) [CustomerAddress],
					[CA].[City] [City],
					[CC1].[Code] [CustomerTypeCode],
					[CC1].[Name] [CustomerTypeName],
					[CC2].[Code] [CustomerGroupCode],
					[CC2].[Name] [CustomerGroupName],
					[CC3].[Code] [CustomerLocationCode],
					[CC3].[Name] [CustomerLocationName],
                    [CC4].[Code] [CustomerChannelCode],
					[CC4].[Name] [CustomerChannelName],
                    [CC5].[Code] [CustomerShowcaseCode],
					[CC5].[Name] [CustomerShowcaseName],
					[SOR].[PostedDate],
					[SOR].[CreatedDate],
					[SOR].[DocumentStatusID],
					[SL].[Name] [DocumentStatusName],
					[P].[Code] [ProductCode],
					[P].[Name] [ProductName],
					[PB].[Name] [ProductBrand],
					[SORS].[Qty] [Qty],
					([SORS].[UnitGrossPrice] * -1) [NetPrice],
					([SORS].[SubtotalDiscountStrata5] * -1) [Discount],
					([SORS].[SubtotalTax] * -1) [VAT],
					([SORS].[SubtotalGross] * -1) [NetTotal],
					([SORS].[Subtotal] * -1) [GrossTotal]
				FROM
					[dbo].[SalesOrderReturnExt] [SORX] INNER JOIN
					[dbo].[SalesOrderReturn] [SOR] ON ([SORX].[DocumentID] = [SOR].[DocumentID]) INNER JOIN                
					[dbo].[SalesOrderReturnSummary] [SORS] ON ([SORX].[DocumentID] = [SORS].[DocumentID]) LEFT OUTER JOIN
					[dbo].[SystemLookup] [SL] ON ([SOR].[DocumentStatusID] = [SL].[Value_Int32]) INNER JOIN
					[dbo].[Product] [P] ON ([SORS].[ProductID] = [P].[ID]) INNER JOIN
					[dbo].[ProductBrand] [PB] ON ([P].[BrandID] = [PB].[ID]) INNER JOIN
					[dbo].[Customer] [C] ON ([SOR].[CustomerID] = [C].[ID]) INNER JOIN
					[dbo].[CustomerCategoryInfo] [CCI] ON ([SOR].[CustomerID] = [CCI].[CustomerID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC1] ON ([CCI].[Category1ID] = [CC1].[ID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID]) LEFT OUTER JOIN
					[dbo].[CustomerCategory] [CC3] ON ([CCI].[Category3ID] = [CC3].[ID]) LEFT OUTER JOIN
                    [dbo].[CustomerCategory] [CC4] ON ([CCI].[Category4ID] = [CC4].[ID]) LEFT OUTER JOIN 
                    [dbo].[CustomerCategory] [CC5] ON ([CCI].[Category5ID] = [CC5].[ID]) INNER JOIN
					[dbo].[CustomerAddress] [CA] ON ([C].[ID] = [CA].[CustomerID]) INNER JOIN
					[dbo].[CustomerAdditionalInfo] [CAI] ON ([C].[ID] = [CAI].[CustomerID]) INNER JOIN
					[dbo].[Salesman] [S] ON ([C].[SalesmanID] = [S].[ID]) INNER JOIN
					[dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID]) INNER JOIN
					[dbo].[Site] [ST] ON ([W].[SiteID] = [ST].[ID]) INNER JOIN
					[dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) INNER JOIN
					[dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
					[dbo].[Territory] [T] ON ([R].[TerritoryID] = [T].[ID])
				WHERE
					[SL].[Group] = 'DocumentStatus' AND            
					[SOR].[DocumentStatusID] = 2 AND
					((@ReportDateFrom IS NULL) OR ([SOR].[TransactionDate] >= [dbo].[ConvertToFirstTimeOfDay](@ReportDateFrom))) AND
					((@ReportDateTo IS NULL) OR ([SOR].[TransactionDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo))) AND
					((@TerritoryID IS NULL) OR ([TerritoryID] = @TerritoryID)) AND
					((@RegionID IS NULL) OR ([RegionID] = @RegionID)) AND
					((@AreaID IS NULL) OR ([AreaID] = @AreaID)) AND
					((@CompanyID IS NULL) OR ([CompanyID] = @CompanyID)) AND
					((@SiteID IS NULL) OR ([SiteID] = @SiteID))
		) [Q]
		ORDER BY
			[TerritoryID],
            [RegionID],
            [AreaID],
            [CompanyID],
            [SiteID],
            [TransactionDate],
			[DocumentNumber],
			[ProductCode];
END;
GO
