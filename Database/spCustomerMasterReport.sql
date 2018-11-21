USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spCustomerMasterReport]') AND type IN (N'P'))
    DROP PROCEDURE [dbo].[spCustomerMasterReport];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 7 Jun 2016 23:32:11
-- Description   : Provide procedure to get Sales by Customer Report.
-- 
-- ===================================================================================

CREATE PROCEDURE [dbo].[spCustomerMasterReport]
(
    @ReportDateFrom datetime,
    @ReportDateTo datetime,
    @TerritoryID int,
    @RegionID int,
    @AreaID int,
    @CompanyID int,
    @SiteID uniqueidentifier,
    @StatusID int
)
AS
BEGIN
    SELECT
        [TerritoryName],
        [RegionName],
        [AreaName],
        [SiteCode],
        [SiteName],
        [Code] [CustomerCode],
        [AdditionalInfo1] [CustomerCode_OLD_IDOS],
        [Name] [CustomerName],
        [Address],
        [City],
        [Category1Name] [CustomerType],
        [Category2Name] [CustomerGroup],
        [Category3Name] [CustomerLocation],
        [Category4Name] [CustomerChannel],
        [Category5Name] [CustomerShowcase],
        [TermOfPaymentName],
        [CreditLimit],
        [RegisteredDate],
        [CreatedDate],
        [PriceGroupName],
        [DiscountGroupName],
        [StatusName] [Status],  
        [SalesmanCode],
        [SalesmanName],
        [SalesmanCategoryName],
        [SalesmanGroupName]
    FROM
        [dbo].[vCustomer]
    WHERE
        ([IsDeleted] = 0) AND
        ((@ReportDateFrom IS NULL) OR ([RegisteredDate] >= [dbo].[ConvertToFirstTimeOfDay](@ReportDateFrom))) AND
		((@ReportDateTo IS NULL) OR ([RegisteredDate] <= [dbo].[ConvertToLastTimeOfDay](@ReportDateTo))) AND
		((@TerritoryID IS NULL) OR ([TerritoryID] = @TerritoryID)) AND
		((@RegionID IS NULL) OR ([RegionID] = @RegionID)) AND
		((@AreaID IS NULL) OR ([AreaID] = @AreaID)) AND
		((@CompanyID IS NULL) OR ([CompanyID] = @CompanyID)) AND        
		((@SiteID IS NULL) OR ([SiteID] = @SiteID)) AND
        (
            (@StatusID IS NULL) OR
            ((@StatusID != 10) AND ([StatusID] = @StatusID)) OR
            ((@StatusID = 10) AND ([StatusID] >= 1))
        )
    ORDER BY
        [RegisteredDate],
        [CustomerCode];
END;
GO
