USE [IDOS];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fRoutePlan]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fRoutePlan];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[RoutePlan] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fRoutePlan]
(
    @SalesmanID uniqueidentifier,
    @CustomerID uniqueidentifier,
    @WeekID int,
    @DayID int,
    @SalesmanCode nvarchar(20),
    @SalesmanName nvarchar(50),
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
    @SalesmanGroupID int,
    @SalesmanCategoryID int,
    @SalesmanStatusID int,
    @CustomerCode nvarchar(20),
    @CustomerName nvarchar(50),
    @OrderBySalesmanID uniqueidentifier,
    @WeekIDNotEqual int,
    @DayIDNotEqual int
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
	        [RP].[CustomerID],
            [RP].[SalesmanID],
            [RP].[WeekID],
            [RP].[DayID],
            [fS].[Code] [SalesmanCode],
            [fS].[Name] [SalesmanName],
            [fS].[Salesman],
            [fS].[WarehouseID],
            [fS].[WarehouseCode],
            [fS].[WarehouseName],
            [fS].[Warehouse],
            [fS].[SiteID],
            [fS].[SiteCode],
            [fS].[SiteName],
            [fS].[Site],
            [fS].[CompanyID],
            [fS].[CompanyCode],
            [fS].[CompanyName],
            [fS].[Company],
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
            [fC].[Code] [CustomerCode],
            [fC].[Name] [CustomerName],
            [fC].[Customer],
            [fC].[Address1] [CustomerAddress1],
            [fC].[Address2] [CustomerAddress2],
            [fC].[Address3] [CustomerAddress3],
            [fC].[Address] [CustomerAddress],
            [fSL].[Name] [WeekName],
            [fSL2].[Name] [DayName],
            [RP].[CreatedDate],
            [RP].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            @OrderBySalesmanID [OrderBySalesmanID],
            (SELECT CASE WHEN (@OrderBySalesmanID IS NOT NULL) AND (@OrderBySalesmanID = [fC].[SalesmanID]) THEN 0 ELSE 1 END) [SortIndex],
            @WeekIDNotEqual [WeekIDNotEqual],
            @DayIDNotEqual [DayIDNotEqual]
        FROM
            [dbo].[RoutePlan] [RP] INNER JOIN
            [dbo].[fSalesman]
            (
                @SalesmanID,
                @SalesmanCode,
                @SalesmanName,
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,    
                @SiteDistributionTypeID,
				NULL,
                @WarehouseTypeID,
                @SalesmanGroupID,
                @SalesmanCategoryID,
                NULL,
                NULL,
                @SalesmanStatusID,
                NULL
	        ) [fS] ON ([RP].[SalesmanID] = [fS].[ID]) INNER JOIN
            [dbo].[fCustomer]
            (
                @CustomerID,
                @CustomerCode,
                @CustomerName,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                @SiteID,
                @SiteCode,
                @SiteName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,    
                @SiteDistributionTypeID,
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
                0,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fC] ON ([RP].[CustomerID] = [fC].[ID]) LEFT OUTER JOIN
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
                'Week',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([RP].[WeekID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
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
                'Day',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([RP].[DayID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([RP].[CreatedByUserID] = [CU].[ID])
        WHERE
			((@SalesmanID IS NULL) OR (@SalesmanID = [RP].[SalesmanID])) AND
			((@CustomerID IS NULL) OR (@CustomerID = [RP].[CustomerID])) AND
            ((@WeekID IS NULL) OR ([RP].[WeekID] = @WeekID)) AND
            ((@DayID IS NULL) OR ([RP].[DayID] = @DayID)) AND            
            (
                ((@SalesmanID IS NULL) OR (@WeekIDNotEqual IS NULL) OR (@DayIDNotEqual IS NULL)) OR
                (
                    (@SalesmanID IS NOT NULL) AND (@WeekIDNotEqual IS NOT NULL) AND (@DayIDNotEqual IS NOT NULL) AND
                    (
                        [RP].[CustomerID] IN
                        (
                            SELECT [RP].[CustomerID] FROM [dbo].[RoutePlan] [RP]
                                WHERE [RP].[SalesmanID] = @SalesmanID AND ([RP].[WeekID] != @WeekIDNotEqual OR [RP].[DayID] != @DayIDNotEqual)
                        )
                         AND
                        [RP].[CustomerID] NOT IN
                        (
                            SELECT [RP].[CustomerID] FROM [dbo].[RoutePlan] [RP]
                                WHERE [RP].[SalesmanID] = @SalesmanID AND ([RP].[WeekID] = @WeekIDNotEqual AND [RP].[DayID] = @DayIDNotEqual)
                        )
                    )
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vRoutePlan]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vRoutePlan];
GO

---- ===================================================================================
---- Author        : System
---- Created date  : 17 Mar 2016 20:37:01
---- Description   : Provide view (model) to retrieve [dbo].[fRoutePlan] data.
----
---- NOTE: This View is initially generated by system and can be modified following
----       the requirement.
---- ===================================================================================

CREATE VIEW [dbo].[vRoutePlan]
AS
(
    SELECT
            [CustomerID],
            [SalesmanID],
            [WeekID],
            [DayID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
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
            [CustomerCode],
            [CustomerName],
            [Customer],
            [CustomerAddress1],
            [CustomerAddress2],
            [CustomerAddress3],
            [CustomerAddress],
            [WeekName],
            [DayName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [OrderBySalesmanID],
            [SortIndex],
            [WeekIDNotEqual],
            [DayIDNotEqual]
        FROM
			[dbo].[fRoutePlan]
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
                NULL,
                NULL,
                NULL
            )
);
GO