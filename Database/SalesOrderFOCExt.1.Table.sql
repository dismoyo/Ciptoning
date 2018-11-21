USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderFOCExt]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL,
    [TerritoryCode] [nvarchar](10) NOT NULL,
    [TerritoryName] [nvarchar](50) NOT NULL,
    [RegionCode] [nvarchar](10) NOT NULL,
    [RegionName] [nvarchar](50) NOT NULL,
    [AreaCode] [nvarchar](10) NOT NULL,
    [AreaName] [nvarchar](50) NOT NULL,
    [CompanyCode] [nvarchar](10) NOT NULL,
    [CompanyName] [nvarchar](50) NOT NULL,
    [SiteCode] [nvarchar](10) NOT NULL,
    [SiteName] [nvarchar](50) NOT NULL,
    [WarehouseCode] [nvarchar](12) NOT NULL,
    [WarehouseName] [nvarchar](50) NOT NULL,
    [WarehouseTypeName] [nvarchar](128) NOT NULL,
    [SalesmanCode] [nvarchar](20) NOT NULL,
    [SalesmanName] [nvarchar](50) NOT NULL,
    [SalesmanGroupName] [nvarchar](128) NOT NULL,
    [SalesmanCategoryName] [nvarchar](128) NOT NULL,
    [TermOfPaymentName] [nvarchar](128) NOT NULL,
    [CustomerCode] [nvarchar](20) NOT NULL,
    [CustomerName] [nvarchar](50) NOT NULL,
    [CustomerTerritoryCode] [nvarchar](10) NOT NULL,
    [CustomerTerritoryName] [nvarchar](50) NOT NULL,
    [CustomerRegionCode] [nvarchar](10) NOT NULL,
    [CustomerRegionName] [nvarchar](50) NOT NULL,
    [CustomerAreaCode] [nvarchar](10) NOT NULL,
    [CustomerAreaName] [nvarchar](50) NOT NULL,
    [CustomerCompanyCode] [nvarchar](10) NOT NULL,
    [CustomerCompanyName] [nvarchar](50) NOT NULL,
    [CustomerSiteCode] [nvarchar](10) NOT NULL,
    [CustomerSiteName] [nvarchar](50) NOT NULL,
    [CustomerSalesmanCode] [nvarchar](20) NOT NULL,
    [CustomerSalesmanName] [nvarchar](50) NOT NULL,
    [CustomerSalesmanGroupName] [nvarchar](50) NOT NULL,
    [CustomerSalesmanCategoryName] [nvarchar](50) NOT NULL,
    [CustomerTermOfPaymentName] [nvarchar](128) NOT NULL,
    [CustomerCategory1] [nvarchar](512) NULL,
    [CustomerCategory2] [nvarchar](512) NULL,
    [CustomerCategory3] [nvarchar](512) NULL,
    [CustomerCategory4] [nvarchar](512) NULL,
    [CustomerCategory5] [nvarchar](512) NULL,
    [CustomerCategory6] [nvarchar](512) NULL,
    [CustomerCategory7] [nvarchar](512) NULL,
    [CustomerCategory8] [nvarchar](512) NULL,
    [CustomerCategory9] [nvarchar](512) NULL,
    [CustomerCategory10] [nvarchar](512) NULL,
    CONSTRAINT [PK_SalesOrderFOCExt] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderFOCExt] 
ENABLE CHANGE_TRACKING 
