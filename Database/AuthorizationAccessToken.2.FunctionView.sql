USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fAuthorizationAccessToken]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fAuthorizationAccessToken];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:40:06
-- Description   : Provide function to retrieve [dbo].[AuthorizationAccessToken] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fAuthorizationAccessToken]
(
    @ID uniqueidentifier,
    @UserID int,
    @UserName nvarchar(256),
    @IsUserHeadOffice bit,
    @UserSiteID uniqueidentifier,
    @UserSiteCode nvarchar(10),
    @UserSiteName nvarchar(50),
    @UserAreaID int,
    @UserAreaCode nvarchar(10),
    @UserAreaName nvarchar(50),
    @UserRegionID int,
    @UserRegionCode nvarchar(10),
    @UserRegionName nvarchar(50),
    @UserTerritoryID int,
    @UserTerritoryCode nvarchar(10),
    @UserTerritoryName nvarchar(50),
    @UserCompanyID int,
    @UserCompanyCode nvarchar(10),
    @UserCompanyName nvarchar(50),
    @UserSiteDistributionTypeID int,
    @IsUserSiteLotNumberEntryRequired bit,
    @UserStatusID int,
    @IsUserDeleted bit,
	@DeviceID nvarchar(256),
	@IsExpired bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [AAT].[ID],
            [AAT].[UserID],
            [fU].[Name] [UserName],
            [fU].[IsHeadOffice] [IsUserHeadOffice],
            [fU].[SiteID] [UserSiteID],
            [fU].[SiteCode] [UserSiteCode],
            [fU].[SiteName] [UserSiteName],
            [fU].[Site] [UserSite],
            [fU].[AreaID] [UserAreaID],
            [fU].[AreaCode] [UserAreaCode],
            [fU].[AreaName] [UserAreaName],
            [fU].[Area] [UserArea],
            [fU].[RegionID] [UserRegionID],
            [fU].[RegionCode] [UserRegionCode],
            [fU].[RegionName] [UserRegionName],
            [fU].[Region] [UserRegion],
            [fU].[TerritoryID] [UserTerritoryID],
            [fU].[TerritoryCode] [UserTerritoryCode],
            [fU].[TerritoryName] [UserTerritoryName],
            [fU].[Territory] [UserTerritory],
            [fU].[CompanyID] [UserCompanyID],
            [fU].[CompanyCode] [UserCompanyCode],
            [fU].[CompanyName] [UserCompanyName],
            [fU].[Company] [UserCompany],
            [fU].[SiteDistributionTypeID] [UserSiteDistributionTypeID],
            [fU].[SiteDistributionTypeName] [UserSiteDistributionTypeName],
            [fU].[IsSiteLotNumberEntryRequired] [IsUserSiteLotNumberEntryRequired],            
            [fU].[StatusID] [UserStatusID],
            [fU].[StatusName] [UserStatusName],
            [AAT].[DeviceID],
			[AAT].[ExpiredDate],
			[AAT].[CreatedDate],
            [AAT].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName]
        FROM
			[dbo].[AuthorizationAccessToken] [AAT] INNER JOIN
            [dbo].[fUser]
            (
                @UserID,
                @UserName,
                @IsUserHeadOffice,
                @UserSiteID,
                @UserSiteCode,
                @UserSiteName,
                @UserAreaID,
                @UserAreaCode,
                @UserAreaName,
                @UserRegionID,
                @UserRegionCode,
                @UserRegionName,
                @UserTerritoryID,
                @UserTerritoryCode,
                @UserTerritoryName,
                @UserCompanyID,
                @UserCompanyCode,
                @UserCompanyName,
                @UserSiteDistributionTypeID,
                @IsUserSiteLotNumberEntryRequired,
                @UserStatusID,
                @IsUserDeleted
            ) [fU] ON ([AAT].[UserID] = [fU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([AAT].[CreatedByUserID] = [CU].[ID])
		WHERE
            ((@ID IS NULL) OR ([AAT].[ID] = @ID)) AND
            ((@UserID IS NULL) OR ([AAT].[UserID] = @UserID)) AND
            ((@DeviceID IS NULL) OR ([AAT].[DeviceID] = @DeviceID)) AND
			(
				(@IsExpired IS NULL) OR
				(
					((@IsExpired = 1) AND ([AAT].[ExpiredDate] >= GETUTCDATE())) OR
					((@IsExpired = 0) AND ([AAT].[ExpiredDate] < GETUTCDATE()))
				)
			)
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vAuthorizationAccessToken]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vAuthorizationAccessToken];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:40:06
-- Description   : Provide view (model) to retrieve [dbo].[fAuthorizationAccessToken] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vAuthorizationAccessToken]
AS
(
    SELECT
            [ID],
            [UserID],
            [UserName],
            [IsUserHeadOffice],
            [UserSiteID],
            [UserSiteCode],
            [UserSiteName],
            [UserSite],
            [UserAreaID],
            [UserAreaCode],
            [UserAreaName],
            [UserArea],
            [UserRegionID],
            [UserRegionCode],
            [UserRegionName],
            [UserRegion],
            [UserTerritoryID],
            [UserTerritoryCode],
            [UserTerritoryName],
            [UserTerritory],
            [UserCompanyID],
            [UserCompanyCode],
            [UserCompanyName],
            [UserCompany],
            [UserSiteDistributionTypeID],
            [UserSiteDistributionTypeName],
            [IsUserSiteLotNumberEntryRequired],            
            [UserStatusID],
            [UserStatusName],
			[DeviceID],
			[ExpiredDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName]
        FROM
			[dbo].[fAuthorizationAccessToken]
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
                NULL
            )
);
GO
