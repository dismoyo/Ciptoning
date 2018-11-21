USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ReportSellOutByChannel]
(
    [ReportDate] [date] NOT NULL,
    [SiteID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
	[CategoryChannelCode] [nvarchar](10) NOT NULL,
    [CategoryChannelName] [nvarchar](50) NOT NULL,
    [CategoryChannel] [nvarchar](70) NOT NULL,
    [TerritoryID] [int] NOT NULL,
    [Territory] [nvarchar](100) NOT NULL,
	[RegionID] [int] NOT NULL,
    [Region] [nvarchar](100) NOT NULL,
	[AreaID] [int] NOT NULL,
    [Area] [nvarchar](100) NOT NULL,
	[CompanyID] [int] NOT NULL,
    [Company] [nvarchar](120) NOT NULL,	
    [Site] [nvarchar](120) NOT NULL,
    [SiteDistributionTypeID] [int] NOT NULL,
    [SiteDistributionTypeName] [nvarchar](100) NOT NULL,
    [Product] [nvarchar](100) NOT NULL,
    [ProductBrandID] [int] NOT NULL,
    [ProductBrand] [nvarchar](100) NOT NULL,
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
    CONSTRAINT [PK_ReportSellOutByChannel] PRIMARY KEY CLUSTERED
    (
	    [ReportDate] ASC,
        [SiteID] ASC,
        [ProductID] ASC,
	    [CategoryChannelCode] ASC        
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutByChannelCategoryChannel] ON [dbo].[ReportSellOutByChannel]
(
    [ReportDate] ASC,
	[CategoryChannelCode] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[ReportSellOutByChannel] 
--ENABLE CHANGE_TRACKING 
