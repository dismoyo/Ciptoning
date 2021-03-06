USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fUser]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fUser];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[User] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fUser]
(
    @ID int,
    @Name nvarchar(256),
    @IsHeadOffice bit,
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
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [U].[ID],
            [U].[Name],
            [U].[Password],
            [U].[IsHeadOffice],
            [U].[SiteID],
            [fS].[Code] [SiteCode],
            [fS].[Name] [SiteName],
            [fS].[Site],
            [fS].[AreaID],
            [fS].[AreaCode],
            [fS].[AreaName],
            [fS].[Area],            
            [fS].[RegionID],
            [fS].[RegionCode],
            [fS].[RegionName],
            [fS].[Region],
            [fS].[TerritoryID],
            [fS].[TerritoryCode],
            [fS].[TerritoryName],
            [fS].[Territory],
            [fS].[CompanyID],
            [fS].[CompanyCode],
            [fS].[CompanyName],
            [fS].[Company],
            [fS].[DistributionTypeID] [SiteDistributionTypeID],
            [fS].[DistributionTypeName] [SiteDistributionTypeName],
            [fS].[IsLotNumberEntryRequired] [IsSiteLotNumberEntryRequired],            
            [U].[StatusID],
            [fSL].[Name] [StatusName],
            [U].[CreatedDate],
            [U].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [U].[ModifiedDate],
            [U].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [U].[IsDeleted]
        FROM
			[dbo].[User] [U] LEFT OUTER JOIN
            [dbo].[fSite]
            (
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
            ) [fS] ON ([U].[SiteID] = [fS].[ID]) LEFT OUTER JOIN
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
                'UserStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([U].[StatusID] = [fSL].[Value_Int32])  LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([U].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([U].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([U].[ID] = @ID)) AND
            ((@Name IS NULL) OR ([U].[Name] = @Name)) AND
            ((@IsHeadOffice IS NULL) OR ([U].[IsHeadOffice] = @IsHeadOffice)) AND
            ((@SiteID IS NULL) OR ([U].[SiteID] = @SiteID)) AND
            ((@StatusID IS NULL) OR ([U].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([U].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vUser]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vUser];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fUser] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vUser]
AS
(
    SELECT
            [ID],
            [Name],
            [Password],
            [IsHeadOffice],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
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
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],            
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fUser]
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
                NULL
            )
);
GO
