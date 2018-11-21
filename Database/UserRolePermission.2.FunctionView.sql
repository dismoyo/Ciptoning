USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fUserRolePermission]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fUserRolePermission];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:40:06
-- Description   : Provide function to retrieve [dbo].[UserRole] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fUserRolePermission]
(
    @PermissionObjectID nvarchar(256),
    @RoleID int,
    @UserID int,
    @RoleName nvarchar(256),    
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
    @IsUserDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [URP].[PermissionObjectID],
            [URP].[UserRoleID],
            [URP].[IsUser],
            (SELECT CASE WHEN ([URP].[IsUser] = 0) THEN [R].[Name] ELSE [fU].[Name] END) [UserRoleName],
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
            [URP].[CreatedDate],
            [URP].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName]
        FROM
			[dbo].[UserRolePermission] [URP] LEFT OUTER JOIN
            [dbo].[Role] [R] ON
            (
                ([URP].[IsUser] = 0) AND
                ([URP].[UserRoleID] = [R].[ID])
            ) LEFT OUTER JOIN
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
            ) [fU] ON
            (                
                ([URP].[IsUser] = 1) AND                
                ([URP].[UserRoleID] = [fU].[ID])
            ) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([URP].[CreatedByUserID] = [CU].[ID])
		WHERE
            ((@PermissionObjectID IS NULL) OR ([URP].[PermissionObjectID] = @PermissionObjectID)) AND
            ((@RoleID IS NULL) OR (([URP].[IsUser] = 0) AND ([URP].[UserRoleID] = @RoleID))) AND
            ((@UserID IS NULL) OR (([URP].[IsUser] = 1) AND ([URP].[UserRoleID] = @UserID))) AND
            ((@RoleName IS NULL) OR ([R].[Name] = @RoleName))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vUserRolePermission]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vUserRolePermission];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:40:06
-- Description   : Provide view (model) to retrieve [dbo].[fUserRole] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vUserRolePermission]
AS
(
    SELECT
            [PermissionObjectID],
            [UserRoleID],
            [IsUser],
            [UserRoleName],
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
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName]
        FROM
			[dbo].[fUserRolePermission]
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
