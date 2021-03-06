USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderFOCDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderFOCDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderFOCDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderFOCDetails]
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
            [SOFOCD].[DocumentID],
            [SOFOCD].[ProductID],
            [SOFOCD].[ProductLotID],
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
                    WHEN [SOFOC].[DocumentStatusID] = 1 THEN
                    ISNULL(
                    (
                        SELECT
                                SUM([fSOHA].[QtyOnHandGood]) [QtyOnHand]
                            FROM
                                [dbo].[fStockOnHandAvailable]
                                (
                                    [SOFOC].[WarehouseID],
                                    NULL,
                                    [SOFOCD].[ProductID],
                                    [SOFOCD].[ProductLotID],
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
                        [SOFOCD].[QtyOnHand]
                END
            ) [QtyOnHand],
            [SOFOCD].[QtyConvL],
            [SOFOCD].[QtyConvM],
            [SOFOCD].[QtyConvS],
            [SOFOCD].[Qty],
            (CAST([SOFOCD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOFOCD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOFOCD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOFOCD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderFOCDetails] [SOFOCD] INNER JOIN
            [dbo].[SalesOrderFOC] [SOFOC] ON ([SOFOCD].[DocumentID] = [SOFOC].[DocumentID]) INNER JOIN
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
            ) [fPL] ON ([SOFOCD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOFOCD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOFOCD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOFOCD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderFOCDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderFOCDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderFOCDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderFOCDetails]
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
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderFOCDetails]
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
