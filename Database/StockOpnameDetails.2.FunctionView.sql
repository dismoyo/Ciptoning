USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOpnameDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOpnameDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockOpnameDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOpnameDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOD].[DocumentID],
            [SOD].[ProductID],
            [SOD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[ExpiredDate] [ProductLotExpiredDate],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOD].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandHold], 0) ELSE [SOD].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandBad], 0) ELSE [SOD].[QtyOnHandBad] END) [QtyOnHandBad],            
            [SOD].[QtyConvLGood],
            [SOD].[QtyConvMGood],
            [SOD].[QtyConvSGood],
            [SOD].[QtyConvLHold],
            [SOD].[QtyConvMHold],
            [SOD].[QtyConvSHold],
            [SOD].[QtyConvLBad],
            [SOD].[QtyConvMBad],
            [SOD].[QtyConvSBad],
            [SOD].[QtyGood],
            [SOD].[QtyHold],
            [SOD].[QtyBad],
            (CAST([SOD].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([SOD].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSGood] AS nvarchar(10))) [QtyOpnameConvGood],
            (CAST([SOD].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSHold] AS nvarchar(10))) [QtyOpnameConvHold],
            (CAST([SOD].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSBad] AS nvarchar(10))) [QtyOpnameConvBad],
            ([SOD].[QtyOnHandGood] + [SOD].[QtyGood]) [QtyOpnameGood],
            ([SOD].[QtyOnHandHold] + [SOD].[QtyHold]) [QtyOpnameHold],
            ([SOD].[QtyOnHandBad] + [SOD].[QtyBad]) [QtyOpnameBad]
        FROM
			[dbo].[StockOpnameDetails] [SOD] INNER JOIN
            [dbo].[StockOpname] [SO] ON ([SOD].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SO].[DocumentStatusID] = 1 AND
                [SO].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOD].[ProductID] = [fSOHA].[ProductID] AND
                [SOD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOpnameDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOpnameDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockOpnameDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOpnameDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
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
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLotStatusID],
            [ProductLotStatusName],            
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
			[dbo].[fStockOpnameDetails]
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
                NULL,
                NULL,
                NULL
            )
);
GO