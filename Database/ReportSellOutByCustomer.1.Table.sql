USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ReportSellOutByCustomer]
(
    [ReportDate] [date] NOT NULL,
    [SalesmanID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,    
	[ProductID] [int] NOT NULL,
	[TerritoryID] [int] NOT NULL,
    [Territory] [nvarchar](70) NOT NULL,
	[RegionID] [int] NOT NULL,
    [Region] [nvarchar](70) NOT NULL,
	[AreaID] [int] NOT NULL,
    [Area] [nvarchar](70) NOT NULL,
	[CompanyID] [int] NOT NULL,
    [Company] [nvarchar](70) NOT NULL,
	[SiteID] [uniqueidentifier] NOT NULL,
    [Site] [nvarchar](70) NOT NULL,
    [SiteDistributionTypeID] [int] NOT NULL,
    [SiteDistributionTypeName] [nvarchar](100) NOT NULL,    
    [Salesman] [nvarchar](80) NOT NULL,
	[WarehouseID] [uniqueidentifier] NOT NULL,
    [Warehouse] [nvarchar](72) NOT NULL,
	[WarehouseTypeID] [int] NOT NULL,
    [WarehouseTypeName] [nvarchar](100) NOT NULL,
    [Customer] [nvarchar](80) NOT NULL,
	[Product] [nvarchar](70) NOT NULL,
    [ProductBrandID] [int] NOT NULL,
    [ProductBrand] [nvarchar](70) NOT NULL,
    [ProductEquivalent] [float] NOT NULL,
	[ProductGroup] [nvarchar](100) NOT NULL,
    [TotalSalesOrderAmount] [float] NOT NULL,
    [TotalSalesOrderQty] [int] NOT NULL,
    CONSTRAINT [PK_ReportSellOutByCustomer] PRIMARY KEY CLUSTERED
    (
	    [ReportDate] ASC,
	    [SalesmanID] ASC,
        [CustomerID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutByCustomerTerritory] ON [dbo].[ReportSellOutByCustomer]
(
    [ReportDate] ASC,
	[TerritoryID] ASC,
	[RegionID] ASC,
	[AreaID] ASC,
	[SiteID] ASC,
	[WarehouseID] ASC,
	[SalesmanID] ASC,
    [CustomerID] ASC,
	[ProductBrandID] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutByCustomerCompany] ON [dbo].[ReportSellOutByCustomer]
(
    [ReportDate] ASC,
	[CompanyID] ASC,
	[SiteID] ASC,
	[WarehouseID] ASC,
	[SalesmanID] ASC,
    [CustomerID] ASC,
	[ProductBrandID] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutByCustomerProduct] ON [dbo].[ReportSellOutByCustomer]
(
    [SalesmanID] ASC,
    [CustomerID] ASC,
	[ProductBrandID] ASC,
    [ProductGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[ReportSellOutByCustomer] 
--ENABLE CHANGE_TRACKING 
