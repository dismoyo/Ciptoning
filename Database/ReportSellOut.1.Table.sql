USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ReportSellOut]
(
    [ReportDate] [date] NOT NULL,
	[SalesmanID] [uniqueidentifier] NOT NULL,
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
	[SalesmanGroupID] [int] NOT NULL,
    [SalesmanGroupName] [nvarchar](100) NOT NULL,
	[SalesmanCategoryID] [int] NOT NULL,
    [SalesmanCategoryName] [nvarchar](100) NOT NULL,
    [Product] [nvarchar](70) NOT NULL,
    [ProductBrandID] [int] NOT NULL,
    [ProductBrand] [nvarchar](70) NOT NULL,
    [ProductEquivalent] [float] NOT NULL,
	[ProductGroup] [nvarchar](100) NOT NULL,
	[TargetSalesOrderAmount] [float] NOT NULL,
	[TotalSalesOrderAmount] [float] NOT NULL,
	[TotalSalesOrderReturnAmount] [float] NOT NULL,
	[ActualSalesOrderAmount] [float] NOT NULL,    
    [TargetSalesOrderQty] [int] NOT NULL,
	[TotalSalesOrderQty] [int] NOT NULL,
	[TotalSalesOrderReturnQty] [int] NOT NULL,
	[ActualSalesOrderQty] [int] NOT NULL,    
	[TargetNewCustomer] [int] NOT NULL,
	[ActualNewCustomer] [int] NOT NULL,
	[TargetCall] [int] NOT NULL,
	[ActualCall] [int] NOT NULL,
    [TargetVisibility] [int] NOT NULL,
	[ActualVisibility] [int] NOT NULL,
    [TargetEffectiveCall] [float] NOT NULL,
	[ActualEffectiveCall] [float] NOT NULL,
    [TargetCustomerTransaction] [float] NOT NULL,	
    CONSTRAINT [PK_ReportSellOut] PRIMARY KEY CLUSTERED
    (
	    [ReportDate] ASC,
	    [SalesmanID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutTerritory] ON [dbo].[ReportSellOut]
(
    [ReportDate] ASC,
	[TerritoryID] ASC,
	[RegionID] ASC,
	[AreaID] ASC,
	[SiteID] ASC,
	[WarehouseID] ASC,
	[SalesmanID] ASC,
	[ProductBrandID] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutCompany] ON [dbo].[ReportSellOut]
(
    [ReportDate] ASC,
	[CompanyID] ASC,
	[SiteID] ASC,
	[WarehouseID] ASC,
	[SalesmanID] ASC,
	[ProductBrandID] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutProduct] ON [dbo].[ReportSellOut]
(
    [SalesmanID] ASC,
	[ProductBrandID] ASC,
    [ProductGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[ReportSellOut] 
--ENABLE CHANGE_TRACKING 
