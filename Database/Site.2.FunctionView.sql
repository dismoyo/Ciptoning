USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSite]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSite];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Site] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSite]
(
    @ID uniqueidentifier,
    @Code nvarchar(10),
    @Name nvarchar(50),
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
    @DistributionTypeID int,
    @IsLotNumberEntryRequired bit,
    @Address nvarchar(100),
    @City nvarchar(50),
    @StateProvince nvarchar(50),
    @CountryID int,
    @CountryName nvarchar(50),
    @ZipCode nvarchar(10),
    @Phone1 nvarchar(20),
    @Phone2 nvarchar(20),
    @Fax nvarchar(20),
    @Email nvarchar(256),
    @TaxNumber nvarchar(20),
    @StatusID int,
    @AdditionalInfo nvarchar(100),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [S].[ID],
            [S].[Code],
            [S].[Name],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Site],
            [S].[AreaID],
            [fA].[Code] [AreaCode],
            [fA].[Name] [AreaName],
            [fA].[Area],
            [fA].[RegionID] [RegionID],
            [fA].[RegionCode] [RegionCode],
            [fA].[RegionName] [RegionName],
            [fA].[Region],
            [fA].[TerritoryID] [TerritoryID],
            [fA].[TerritoryCode] [TerritoryCode],
            [fA].[TerritoryName] [TerritoryName],
            [fA].[Territory],
            [fC].[ID] [CompanyID],
            [fC].[Code] [CompanyCode],
            [fC].[Name] [CompanyName],
            [fC].[Company],
            [S].[DistributionTypeID],
            [fSL].[Name] [DistributionTypeName],
            [S].[IsLotNumberEntryRequired],
            [fSA].[Address1],
            [fSA].[Address2],
            [fSA].[Address3],
            [fSA].[Address],
            [fSA].[City],
            [fSA].[StateProvince],
            [fSA].[CountryID],
            [fSA].[CountryName],
            [fSA].[ZipCode],
            [fSA].[Phone1],
            [fSA].[Phone2],
            [fSA].[Fax],
            [fSA].[Email],
            [fSAI].[AdditionalInfo1],
            [fSAI].[AdditionalInfo2],
            [fSAI].[AdditionalInfo3],
            [fSAI].[AdditionalInfo4],
            [fSAI].[AdditionalInfo5],
            [fSAI].[AdditionalInfo6],
            [fSAI].[AdditionalInfo7],
            [fSAI].[AdditionalInfo8],
            [fSAI].[AdditionalInfo9],
            [fSAI].[AdditionalInfo10],
            [S].[TaxNumber],
            [S].[StatusID],
            [fSL2].[Name] [StatusName],
            [S].[SAPCode],
            [S].[CreatedDate],
            [S].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [S].[ModifiedDate],
            [S].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [S].[IsDeleted]
        FROM
			[dbo].[Site] [S] INNER JOIN
            [dbo].[fArea]
            (
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                NULL
            ) [fA] ON ([S].[AreaID] = [fA].[ID]) INNER JOIN
            [dbo].[fCompany]
            (
                @CompanyID,
                @CompanyCode,
                @CompanyName,
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
            ) [fC] ON ([S].[CompanyID] = [fC].[ID]) INNER JOIN
            [dbo].[fSiteAddress]
            (
                @ID,
                @Address,
                @City,
                @StateProvince,
                @CountryID,
                @CountryName,
                @ZipCode,
                @Phone1,
                @Phone2,
                @Fax,
                @Email
            ) [fSA] ON ([S].[ID] = [fSA].[SiteID]) INNER JOIN
            [dbo].[fSiteAdditionalInfo]
            (
                @ID,
                @AdditionalInfo
            ) [fSAI] ON ([S].[ID] = [fSAI].[SiteID]) LEFT OUTER JOIN
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
                'SiteDistributionType',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([S].[DistributionTypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
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
                'SiteStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([S].[StatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([S].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([S].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR (@ID = [S].[ID])) AND
            ((@Code IS NULL) OR ([S].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([S].[Name] LIKE '%' + @Name + '%')) AND
            ((@DistributionTypeID IS NULL) OR ([S].[DistributionTypeID] = @DistributionTypeID)) AND
            ((@IsLotNumberEntryRequired IS NULL) OR ([S].[IsLotNumberEntryRequired] = @IsLotNumberEntryRequired)) AND
            ((@TaxNumber IS NULL) OR ([S].[TaxNumber] LIKE '%' + @TaxNumber + '%')) AND
            ((@StatusID IS NULL) OR ([S].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([S].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSite]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSite];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSite] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSite]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
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
            [DistributionTypeID],
            [DistributionTypeName],
            [IsLotNumberEntryRequired],
            [Address1],
            [Address2],
            [Address3],
            [Address],
            [City],
            [StateProvince],
            [CountryID],
            [CountryName],
            [ZipCode],
            [Phone1],
            [Phone2],
            [Fax],
            [Email],
            [AdditionalInfo1],
            [AdditionalInfo2],
            [AdditionalInfo3],
            [AdditionalInfo4],
            [AdditionalInfo5],
            [AdditionalInfo6],
            [AdditionalInfo7],
            [AdditionalInfo8],
            [AdditionalInfo9],
            [AdditionalInfo10],
            [TaxNumber],
            [StatusID],
            [StatusName],
            [SAPCode],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fSite]
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
                NULL
            )
);
GO
