USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockChangesDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockChangesDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockChangesDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockChangesDetails]
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
            [SCD].[DocumentID],
            [SCD].[ProductID],
            [SCD].[ProductLotID],
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
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (
                SELECT CASE
                    WHEN [SC].[DocumentStatusID] = 1 THEN
                    ISNULL(
                    (
                        SELECT
                                (
                                    SELECT CASE
                                        WHEN [SC].[OldItemStatusID] = 1 THEN SUM([fSOHA].[QtyOnHandGood])
                                        WHEN [SC].[OldItemStatusID] = 2 THEN SUM([fSOHA].[QtyOnHandHold])
                                        WHEN [SC].[OldItemStatusID] = 3 THEN SUM([fSOHA].[QtyOnHandBad])
                                    END
                                ) [QtyOnHand]
                            FROM
                                [dbo].[fStockOnHandAvailable]
                                (
                                    [SC].[WarehouseID],
                                    NULL,
                                    [SCD].[ProductID],
                                    [SCD].[ProductLotID],
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
                        [SCD].[QtyOnHand]
                END
            ) [QtyOnHand],
            [SCD].[QtyConvL],
            [SCD].[QtyConvM],
            [SCD].[QtyConvS],
            [SCD].[Qty],
            (CAST([SCD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SCD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SCD].[QtyConvS] AS nvarchar(10))) [QtyChangesConv],
            ([SCD].[Qty] * -1) [QtyChanges]
        FROM
			[dbo].[StockChangesDetails] [SCD] INNER JOIN
            [dbo].[StockChanges] [SC] ON ([SCD].[DocumentID] = [SC].[DocumentID]) INNER JOIN
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
            ) [fPL] ON ([SCD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SCD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SCD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SCD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockChangesDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockChangesDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockChangesDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockChangesDetails]
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
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyChangesConv],
            [QtyChanges]
        FROM
			[dbo].[fStockChangesDetails]
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
