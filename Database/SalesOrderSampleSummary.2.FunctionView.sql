USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSampleSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSampleSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSampleSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSampleSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOSS].[DocumentID],            
            [SOSS].[ProductID],
            [SOSS].[PriceDate],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (
                SELECT CASE
                    WHEN [SOS].[DocumentStatusID] = 1 THEN
                    ISNULL(
                    (
                        SELECT
                                SUM([fSOHA].[QtyOnHandGood]) [QtyOnHand]
                            FROM
                                [dbo].[fStockOnHandAvailable]
                                (
                                    [SOS].[WarehouseID],
                                    NULL,
                                    [SOSS].[ProductID],
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
                                    @ProductCode,
                                    @ProductName,
                                    @ProductBrandID,
                                    @ProductBrandCode,
                                    @ProductBrandName,
                                    @ProductShortName,
                                    @ProductStatusID,
                                    @ProductAdditionalInfo,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL                
                                ) [fSOHA]
                            GROUP BY
                                [fSOHA].[WarehouseID],
                                [fSOHA].[ProductID]
                    ), 0)
                    ELSE
                        [SOSS].[QtyOnHand]
                END
            ) [QtyOnHand],
            [SOSS].[QtyConvL],
            [SOSS].[QtyConvM],
            [SOSS].[QtyConvS],
            [SOSS].[Qty],
            (CAST([SOSS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOSS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOSS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOSS].[Qty] * -1) [QtyOrder],
            [SOSS].[UnitGrossPrice],    
            [SOSS].[UnitPrice],
            [SOSS].[DiscountStrata1Percentage],
            [SOSS].[DiscountStrata2Percentage],
            [SOSS].[DiscountStrata3Percentage],
            [SOSS].[DiscountStrata4Percentage],
            [SOSS].[DiscountStrata5Percentage],
            [SOSS].[AddDiscountStrataPercentage],
            [SOSS].[TaxPercentage],
            [SOSS].[RawSubtotalGrossPrice],
            [SOSS].[RawSubtotalPrice],
            [SOSS].[RawSubtotalDiscountStrata1],
            ([SOSS].[RawSubtotalPrice] - [SOSS].[RawSubtotalDiscountStrata1]) [RawDiscountStrata1Amount],            
            [SOSS].[RawSubtotalDiscountStrata2],
            ([SOSS].[RawSubtotalDiscountStrata1] - [SOSS].[RawSubtotalDiscountStrata2]) [RawDiscountStrata2Amount],
            [SOSS].[RawSubtotalDiscountStrata3],
            ([SOSS].[RawSubtotalDiscountStrata2] - [SOSS].[RawSubtotalDiscountStrata3]) [RawDiscountStrata3Amount],
            [SOSS].[RawSubtotalDiscountStrata4],
            ([SOSS].[RawSubtotalDiscountStrata3] - [SOSS].[RawSubtotalDiscountStrata4]) [RawDiscountStrata4Amount],
            [SOSS].[RawSubtotalDiscountStrata5],
            ([SOSS].[RawSubtotalDiscountStrata4] - [SOSS].[RawSubtotalDiscountStrata5]) [RawDiscountStrata5Amount],
            ([SOSS].[RawSubtotalDiscountStrata5] - [SOSS].[RawSubtotal]) [RawAddDiscountStrataAmount],
            [SOSS].[RawSubtotalGross],
            [SOSS].[RawSubtotalTax],
            [SOSS].[RawSubtotal],
            [SOSS].[SubtotalGrossPrice],
            [SOSS].[SubtotalPrice],
            [SOSS].[SubtotalDiscountStrata1],
            ([SOSS].[SubtotalPrice] - [SOSS].[SubtotalDiscountStrata1]) [DiscountStrata1Amount],            
            [SOSS].[SubtotalDiscountStrata2],
            ([SOSS].[SubtotalDiscountStrata1] - [SOSS].[SubtotalDiscountStrata2]) [DiscountStrata2Amount],
            [SOSS].[SubtotalDiscountStrata3],
            ([SOSS].[SubtotalDiscountStrata2] - [SOSS].[SubtotalDiscountStrata3]) [DiscountStrata3Amount],
            [SOSS].[SubtotalDiscountStrata4],
            ([SOSS].[SubtotalDiscountStrata3] - [SOSS].[SubtotalDiscountStrata4]) [DiscountStrata4Amount],
            [SOSS].[SubtotalDiscountStrata5],
            ([SOSS].[SubtotalDiscountStrata4] - [SOSS].[SubtotalDiscountStrata5]) [DiscountStrata5Amount],
            ([SOSS].[SubtotalDiscountStrata5] - [SOSS].[Subtotal]) [AddDiscountStrataAmount],
            [SOSS].[SubtotalGross],
            [SOSS].[SubtotalTax],
            [SOSS].[Subtotal],
            [SOSS].[SubtotalWeight],
            [SOSS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderSampleSummary] [SOSS] INNER JOIN
            [dbo].[SalesOrderSample] [SOS] ON ([SOSS].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOSS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOSS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOSS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSampleSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSampleSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSampleSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSampleSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [PriceDate],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [UnitGrossPrice],    
            [UnitPrice],
            [DiscountStrata1Percentage],
            [DiscountStrata2Percentage],
            [DiscountStrata3Percentage],
            [DiscountStrata4Percentage],
            [DiscountStrata5Percentage],
            [AddDiscountStrataPercentage],
            [TaxPercentage],
            [RawSubtotalGrossPrice],
            [RawSubtotalPrice],
            [RawSubtotalDiscountStrata1],
            [RawDiscountStrata1Amount],
            [RawSubtotalDiscountStrata2],
            [RawDiscountStrata2Amount],
            [RawSubtotalDiscountStrata3],
            [RawDiscountStrata3Amount],
            [RawSubtotalDiscountStrata4],
            [RawDiscountStrata4Amount],
            [RawSubtotalDiscountStrata5],
            [RawDiscountStrata5Amount],
            [RawAddDiscountStrataAmount],
            [RawSubtotalGross],
            [RawSubtotalTax],
            [RawSubtotal],
            [SubtotalGrossPrice],
            [SubtotalPrice],
            [SubtotalDiscountStrata1],
            [DiscountStrata1Amount],
            [SubtotalDiscountStrata2],
            [DiscountStrata2Amount],
            [SubtotalDiscountStrata3],
            [DiscountStrata3Amount],
            [SubtotalDiscountStrata4],
            [DiscountStrata4Amount],
            [SubtotalDiscountStrata5],
            [DiscountStrata5Amount],
            [AddDiscountStrataAmount],
            [SubtotalGross],
            [SubtotalTax],
            [Subtotal],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderSampleSummary]
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
                NULL
            )
);
GO
