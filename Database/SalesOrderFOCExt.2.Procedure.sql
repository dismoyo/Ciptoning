USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spSalesOrderFOCExt]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spSalesOrderFOCExt];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to create [dbo].[SalesOrderFOCExt] data as history of
--                 [dbo].[SalesOrderFOC]
-- ===================================================================================

CREATE PROCEDURE [dbo].[spSalesOrderFOCExt]
(
    @DocumentID uniqueidentifier    
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RetDocumentID uniqueidentifier = NULL;
    DECLARE @DocumentCode nvarchar(30);
    DECLARE @TransactionDate datetime;
    DECLARE @TerritoryCode nvarchar(10);
    DECLARE @TerritoryName nvarchar(50);
    DECLARE @RegionCode nvarchar(10);
    DECLARE @RegionName nvarchar(50);
    DECLARE @AreaCode nvarchar(10);
    DECLARE @AreaName nvarchar(50);
    DECLARE @CompanyCode nvarchar(10);
    DECLARE @CompanyName nvarchar(50);
    DECLARE @SiteCode nvarchar(10);
    DECLARE @SiteName nvarchar(50);
    DECLARE @WarehouseCode nvarchar(12);
    DECLARE @WarehouseName nvarchar(50);
    DECLARE @WarehouseTypeName nvarchar(128);
    DECLARE @SalesmanCode nvarchar(20);
    DECLARE @SalesmanName nvarchar(50);
    DECLARE @SalesmanGroupName nvarchar(128);
    DECLARE @SalesmanCategoryName nvarchar(128);
    DECLARE @TermOfPaymentName nvarchar(128);
    DECLARE @CustomerCode nvarchar(20);
    DECLARE @CustomerName nvarchar(50);
    DECLARE @CustomerTerritoryCode nvarchar(10);
    DECLARE @CustomerTerritoryName nvarchar(50);
    DECLARE @CustomerRegionCode nvarchar(10);
    DECLARE @CustomerRegionName nvarchar(50);
    DECLARE @CustomerAreaCode nvarchar(10);
    DECLARE @CustomerAreaName nvarchar(50);
    DECLARE @CustomerCompanyCode nvarchar(10);
    DECLARE @CustomerCompanyName nvarchar(50);
    DECLARE @CustomerSiteCode nvarchar(10);
    DECLARE @CustomerSiteName nvarchar(50);
    DECLARE @CustomerSalesmanCode nvarchar(20);
    DECLARE @CustomerSalesmanName nvarchar(50);
    DECLARE @CustomerSalesmanGroupName nvarchar(50);
    DECLARE @CustomerSalesmanCategoryName nvarchar(50);
    DECLARE @CustomerTermOfPaymentName nvarchar(128);
    DECLARE @CustomerCategory1ID int;
    DECLARE @CustomerCategory1 nvarchar(512);
    DECLARE @CustomerCategory2ID int;
    DECLARE @CustomerCategory2 nvarchar(512);
    DECLARE @CustomerCategory3ID int;
    DECLARE @CustomerCategory3 nvarchar(512);
    DECLARE @CustomerCategory4ID int;
    DECLARE @CustomerCategory4 nvarchar(512);
    DECLARE @CustomerCategory5ID int;
    DECLARE @CustomerCategory5 nvarchar(512);
    DECLARE @CustomerCategory6ID int;
    DECLARE @CustomerCategory6 nvarchar(512);
    DECLARE @CustomerCategory7ID int;
    DECLARE @CustomerCategory7 nvarchar(512);
    DECLARE @CustomerCategory8ID int;
    DECLARE @CustomerCategory8 nvarchar(512);
    DECLARE @CustomerCategory9ID int;
    DECLARE @CustomerCategory9 nvarchar(512);
    DECLARE @CustomerCategory10ID int;
    DECLARE @CustomerCategory10 nvarchar(512);
    
    SELECT
            @RetDocumentID = [fSOFOC].[DocumentID],
            @DocumentCode = [fSOFOC].[DocumentCode],
            @TransactionDate = [fSOFOC].[TransactionDate],
            @TerritoryCode = [fS].[TerritoryCode],
            @TerritoryName = [fS].[TerritoryName],
            @RegionCode = [fS].[RegionCode],
            @RegionName = [fS].[RegionName],
            @AreaCode = [fS].[AreaCode],
            @AreaName = [fS].[AreaName],
            @CompanyCode = [fS].[CompanyCode],
            @CompanyName = [fS].[CompanyName],
            @SiteCode = [fS].[SiteCode],
            @SiteName = [fS].[SiteName],
            @WarehouseCode = [fS].[WarehouseCode],
            @WarehouseName = [fS].[WarehouseName],
            @WarehouseTypeName = [fS].[WarehouseTypeName],
            @SalesmanCode = [fS].[Code],
            @SalesmanName = [fS].[Name],
            @SalesmanGroupName = [fS].[GroupName],
            @SalesmanCategoryName = [fS].[CategoryName],
            @TermOfPaymentName = [fSOFOC].[TermOfPaymentName],
            @CustomerCode = [fC].[Code],
            @CustomerName = [fC].[Name],
            @CustomerTerritoryCode = [fC].[TerritoryCode],
            @CustomerTerritoryName = [fC].[TerritoryName],
            @CustomerRegionCode = [fC].[RegionCode],
            @CustomerRegionName = [fC].[RegionName],
            @CustomerAreaCode = [fC].[AreaCode],
            @CustomerAreaName = [fC].[AreaName],
            @CustomerCompanyCode = [fC].[CompanyCode],
            @CustomerCompanyName = [fC].[CompanyName],
            @CustomerSiteCode = [fC].[SiteCode],
            @CustomerSiteName = [fC].[SiteName],
            @CustomerSalesmanCode = [fC].[SalesmanCode],
            @CustomerSalesmanName = [fC].[SalesmanName],
            @CustomerSalesmanGroupName = [fC].[SalesmanGroupName],
            @CustomerSalesmanCategoryName = [fC].[SalesmanCategoryName],
            @CustomerTermOfPaymentName = [fC].[TermOfPaymentName],
            @CustomerCategory1ID = [fC].[Category1ID],
            @CustomerCategory2ID = [fC].[Category2ID],
            @CustomerCategory3ID = [fC].[Category3ID],
            @CustomerCategory4ID = [fC].[Category4ID],
            @CustomerCategory5ID = [fC].[Category5ID],
            @CustomerCategory6ID = [fC].[Category6ID],
            @CustomerCategory7ID = [fC].[Category7ID],
            @CustomerCategory8ID = [fC].[Category8ID],
            @CustomerCategory9ID = [fC].[Category9ID],
            @CustomerCategory10ID = [fC].[Category10ID]
        FROM
            [dbo].[fSalesOrderFOC]
            (
                @DocumentID,
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
            ) [fSOFOC] INNER JOIN
            [dbo].[fSalesman]
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
                NULL
            ) [fS] ON ([fSOFOC].[SalesmanID] = [fS].[ID]) INNER JOIN
            [dbo].[fCustomer]
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
            ) [fC] ON ([fSOFOC].[CustomerID] = [fC].[ID]);

    IF (@RetDocumentID IS NOT NULL)
    BEGIN
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory1ID, @CustomerCategory1 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory2ID, @CustomerCategory2 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory3ID, @CustomerCategory3 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory4ID, @CustomerCategory4 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory5ID, @CustomerCategory5 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory6ID, @CustomerCategory6 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory7ID, @CustomerCategory7 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory8ID, @CustomerCategory8 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory9ID, @CustomerCategory9 OUTPUT;
        EXEC [dbo].[spFlattenCustomerCategory] @CustomerCategory10ID, @CustomerCategory10 OUTPUT;

        INSERT INTO
            [dbo].[SalesOrderFOCExt]
            (
                [DocumentID],
                [DocumentCode],
                [TransactionDate],
                [TerritoryCode],
                [TerritoryName],
                [RegionCode],
                [RegionName],
                [AreaCode],
                [AreaName],
                [CompanyCode],
                [CompanyName],
                [SiteCode],
                [SiteName],
                [WarehouseCode],
                [WarehouseName],
                [WarehouseTypeName],
                [SalesmanCode],
                [SalesmanName],
                [SalesmanGroupName],
                [SalesmanCategoryName],
                [TermOfPaymentName],
                [CustomerCode],
                [CustomerName],
                [CustomerTerritoryCode],
                [CustomerTerritoryName],
                [CustomerRegionCode],
                [CustomerRegionName],
                [CustomerAreaCode],
                [CustomerAreaName],
                [CustomerCompanyCode],
                [CustomerCompanyName],
                [CustomerSiteCode],
                [CustomerSiteName],
                [CustomerSalesmanCode],
                [CustomerSalesmanName],
                [CustomerSalesmanGroupName],
                [CustomerSalesmanCategoryName],
                [CustomerTermOfPaymentName],
                [CustomerCategory1],
                [CustomerCategory2],
                [CustomerCategory3],
                [CustomerCategory4],
                [CustomerCategory5],
                [CustomerCategory6],
                [CustomerCategory7],
                [CustomerCategory8],
                [CustomerCategory9],
                [CustomerCategory10]
            )
            VALUES
            (
                @RetDocumentID,
                @DocumentCode,
                @TransactionDate,
                @TerritoryCode,
                @TerritoryName,
                @RegionCode,
                @RegionName,
                @AreaCode,
                @AreaName,
                @CompanyCode,
                @CompanyName,
                @SiteCode,
                @SiteName,
                @WarehouseCode,
                @WarehouseName,
                @WarehouseTypeName,
                @SalesmanCode,
                @SalesmanName,
                @SalesmanGroupName,
                @SalesmanCategoryName,
                @TermOfPaymentName,
                @CustomerCode,
                @CustomerName,
                @CustomerTerritoryCode,
                @CustomerTerritoryName,
                @CustomerRegionCode,
                @CustomerRegionName,
                @CustomerAreaCode,
                @CustomerAreaName,
                @CustomerCompanyCode,
                @CustomerCompanyName,
                @CustomerSiteCode,
                @CustomerSiteName,
                @CustomerSalesmanCode,
                @CustomerSalesmanName,
                @CustomerSalesmanGroupName,
                @CustomerSalesmanCategoryName,
                @CustomerTermOfPaymentName,
                @CustomerCategory1,
                @CustomerCategory2,
                @CustomerCategory3,
                @CustomerCategory4,
                @CustomerCategory5,
                @CustomerCategory6,
                @CustomerCategory7,
                @CustomerCategory8,
                @CustomerCategory9,
                @CustomerCategory10
            );
    END;
END;
GO
