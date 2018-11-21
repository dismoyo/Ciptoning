USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ReportSellOutSummary]
(
    [ReportDate] [date] NOT NULL,
	[SODocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [SODocumentCode] [nvarchar](30) NOT NULL,
    [TaxInvoiceCode] [nvarchar](30) NULL,
    [SFADocumentCode] [nvarchar](30) NULL, 
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
    [WarehouseID] [uniqueidentifier],
    [Warehouse] [nvarchar](72) NOT NULL,
    [SalesmanID] [uniqueidentifier],
    [Salesman] [nvarchar](80) NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [Customer] [nvarchar](80) NOT NULL,
    [CategoryCustomerType] [nvarchar](100),                    
    [CashPaymentAmount] [float] NULL,
    [CreditPaymentAmount] [float] NULL,
    [CreditDueDate] [datetime] NULL,
    [TrxFormBankName] [nvarchar](50) NULL,
    [TrxFormCode] [nvarchar](30) NULL,
    [TrxFormDueDate] [datetime] NULL,
    [TrxFormAmount] [float] NULL,
    [AdditionalCost] [float] NULL,
    [CreditBalance] [float] NULL,
    [TotalSalesOrder] [float] NOT NULL,
    [ProductBrandID] [int] NOT NULL,
    [ProductBrand] [nvarchar](70) NOT NULL,
    [ProductShortName] [nvarchar](30) NOT NULL,
    [Qty] [int] NOT NULL,
    CONSTRAINT [PK_ReportSellOutSummary] PRIMARY KEY CLUSTERED
    (
	    [ReportDate] ASC,
        [SODocumentID] ASC,
	    [ProductID] ASC        
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ReportSellOutSummary] ON [dbo].[ReportSellOutSummary]
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

ALTER TABLE [dbo].[ReportSellOutSummary] 
ENABLE CHANGE_TRACKING 
