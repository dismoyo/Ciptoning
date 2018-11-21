USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockChanges]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockChanges];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockChanges] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockChanges]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @PIC nvarchar(50),
    @OldItemStatusID int,
    @NewItemStatusID int,
    @ReferenceNumber nvarchar(30),
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SC].[DocumentID],
            [SC].[DocumentCode],
            [SC].[TransactionDate],
            [SC].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],            
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SC].[PIC],
            [SC].[OldItemStatusID],
            [fSL].[Name] [OldItemStatusName],
            [SC].[NewItemStatusID],
            [fSL2].[Name] [NewItemStatusName],
            [SC].[ReferenceNumber],
            [SC].[AttachmentFile],
            [SC].[DocumentStatusID],
            [fSL3].[Name] [DocumentStatusName],
            [SC].[PostedDate],
            [SC].[CreatedDate],
            [SC].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SC].[ModifiedDate],
            [SC].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockChanges] [SC] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
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
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SC].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
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
                'ProductItemStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SC].[OldItemStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
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
                'ProductItemStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SC].[NewItemStatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SC].[DocumentStatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SC].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SC].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SC].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SC].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([SC].[TransactionDate] >= [dbo].[ConvertToFirstTimeOfDay](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([SC].[TransactionDate] <= [dbo].[ConvertToLastTimeOfDay](@TransactionDateTo))) AND
            ((@WarehouseID IS NULL) OR ([SC].[WarehouseID] = @WarehouseID)) AND
            ((@PIC IS NULL) OR ([SC].[PIC] LIKE '%' + @PIC + '%')) AND
            ((@OldItemStatusID IS NULL) OR ([SC].[OldItemStatusID] = @OldItemStatusID)) AND
            ((@NewItemStatusID IS NULL) OR ([SC].[NewItemStatusID] = @NewItemStatusID)) AND
            ((@ReferenceNumber IS NULL) OR ([SC].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SC].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SC].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SC].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockChanges]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockChanges];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockChanges] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockChanges]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],            
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [PIC],
            [OldItemStatusID],
            [OldItemStatusName],
            [NewItemStatusID],
            [NewItemStatusName],
            [ReferenceNumber],
            [AttachmentFile],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockChanges]
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
                NULL                
            )
);
GO
