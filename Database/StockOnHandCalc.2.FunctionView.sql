USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOnHandCalc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOnHandCalc];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockOnHandCalc] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOnHandCalc]
(
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
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
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            SUM([QtyTransactionGood]) [QtyTransactionGood],
            SUM([QtyTransactionHold]) [QtyTransactionHold],
            SUM([QtyTransactionBad]) [QtyTransactionBad]
        FROM
            (
                SELECT
                        [WarehouseID],
                        [ProductID],
                        [ProductLotID],
                        [TransactionDate],
                        [QtyPeriodOnHandGood],
                        [QtyPeriodOnHandHold],
                        [QtyPeriodOnHandBad],
                        [QtyTransactionGood],
                        [QtyTransactionHold],
                        [QtyTransactionBad]
                    FROM
                        [dbo].[fStockOnHandPreCalc]
                        (
                            1, -- Source
                            @WarehouseID,
                            @TransactionDate,
                            @ProductID,
                            @ProductLotID,
                            @WarehouseCode,
                            @WarehouseName,
                            @SiteID,
                            @SiteCode,
                            @SiteName,
                            @AreaID,
                            @AreaCode,
                            @AreaName,
                            @RegionID,
                            @RegionCode,
                            @RegionName,
                            @TerritoryID,
                            @TerritoryCode,
                            @TerritoryName,
                            @CompanyID,
                            @CompanyCode,
                            @CompanyName,
                            @SiteDistributionTypeID,
                            @IsSiteLotNumberEntryRequired,
                            @WarehouseTypeID,
                            @IsWarehouseSOAllowed,
                            @WarehouseStatusID,
                            @IsWarehouseDeleted,
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
                            @IsProductLotDeleted
                        ) [fSOHPCSrc]
                UNION ALL
                SELECT
                        [WarehouseID],
                        [ProductID],
                        [ProductLotID],
                        [TransactionDate],
                        [QtyPeriodOnHandGood],
                        [QtyPeriodOnHandHold],
                        [QtyPeriodOnHandBad],
                        [QtyTransactionGood],
                        [QtyTransactionHold],
                        [QtyTransactionBad]
                    FROM
                        [dbo].[fStockOnHandPreCalc]
                        (
                            0, -- Destination
                            @WarehouseID,
                            @TransactionDate,
                            @ProductID,
                            @ProductLotID,
                            @WarehouseCode,
                            @WarehouseName,
                            @SiteID,
                            @SiteCode,
                            @SiteName,
                            @AreaID,
                            @AreaCode,
                            @AreaName,
                            @RegionID,
                            @RegionCode,
                            @RegionName,
                            @TerritoryID,
                            @TerritoryCode,
                            @TerritoryName,
                            @CompanyID,
                            @CompanyCode,
                            @CompanyName,
                            @SiteDistributionTypeID,
                            @IsSiteLotNumberEntryRequired,
                            @WarehouseTypeID,
                            @IsWarehouseSOAllowed,
                            @WarehouseStatusID,
                            @IsWarehouseDeleted,
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
                            @IsProductLotDeleted
                        ) [fSOHPCDest]
            ) [fSOHPC]
        GROUP BY
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad]
);
GO
