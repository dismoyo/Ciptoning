USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOpnameSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOpnameSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockOpnameSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOpnameSummary]
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
            [SOS].[DocumentID],            
            [SOS].[ProductID],
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
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOS].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandHold], 0) ELSE [SOS].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandBad], 0) ELSE [SOS].[QtyOnHandBad] END) [QtyOnHandBad],
            [SOS].[QtyConvLGood],
            [SOS].[QtyConvMGood],
            [SOS].[QtyConvSGood],
            [SOS].[QtyConvLHold],
            [SOS].[QtyConvMHold],
            [SOS].[QtyConvSHold],
            [SOS].[QtyConvLBad],
            [SOS].[QtyConvMBad],
            [SOS].[QtyConvSBad],
            [SOS].[QtyGood],
            [SOS].[QtyHold],
            [SOS].[QtyBad],
            (CAST([SOS].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([SOS].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSGood] AS nvarchar(10))) [QtyOpnameConvGood],
            (CAST([SOS].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSHold] AS nvarchar(10))) [QtyOpnameConvHold],
            (CAST([SOS].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSBad] AS nvarchar(10))) [QtyOpnameConvBad],
            ([SOS].[QtyOnHandGood] + [SOS].[QtyGood]) [QtyOpnameGood],
            ([SOS].[QtyOnHandHold] + [SOS].[QtyHold]) [QtyOpnameHold],
            ([SOS].[QtyOnHandBad] + [SOS].[QtyBad]) [QtyOpnameBad]
        FROM
			[dbo].[StockOpnameSummary] [SOS] INNER JOIN
            [dbo].[StockOpname] [SO] ON ([SOS].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
            ) [SOHA] ON
            (
                [SO].[DocumentStatusID] = 1 AND
                [SO].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
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
            ) [fP] ON ([SOS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOpnameSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOpnameSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockOpnameSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOpnameSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
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
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [QtyConvLGood],
            [QtyConvMGood],
            [QtyConvSGood],
            [QtyConvLHold],
            [QtyConvMHold],
            [QtyConvSHold],
            [QtyConvLBad],
            [QtyConvMBad],
            [QtyConvSBad],
            [QtyGood],
            [QtyHold],
            [QtyBad],
            [QtyOpnameConvGood],
            [QtyOpnameConvHold],
            [QtyOpnameConvBad],
            [QtyOpnameGood],
            [QtyOpnameHold],
            [QtyOpnameBad]
        FROM
			[dbo].[fStockOpnameSummary]
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
