USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderFOC]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderFOC_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderFOC_TransactionDate] DEFAULT (GETUTCDATE()),
    [PODocumentID] [uniqueidentifier] NULL,    
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_SalesOrderFOC_ReferenceNumber] DEFAULT (''),
    [DODocumentID] [uniqueidentifier] NOT NULL,
    [InvoiceDocumentID] [uniqueidentifier] NULL,
    [RawTotalGrossPrice] [float] NOT NULL,    
    [RawTotalPrice] [float] NOT NULL,
    [RawTotalDiscountStrata1Amount] [float] NOT NULL,
    [RawTotalDiscountStrata2Amount] [float] NOT NULL,
    [RawTotalDiscountStrata3Amount] [float] NOT NULL,
    [RawTotalDiscountStrata4Amount] [float] NOT NULL,
    [RawTotalDiscountStrata5Amount] [float] NOT NULL,
    [RawTotalAddDiscountStrataAmount] [float] NOT NULL,
    [RawTotalGross] [float] NOT NULL,
    [RawTotalTax] [float] NOT NULL,
    [RawTotal] [float] NOT NULL,
    [TotalGrossPrice] [float] NOT NULL,    
    [TotalPrice] [float] NOT NULL,
    [TotalDiscountStrata1Amount] [float] NOT NULL,
    [TotalDiscountStrata2Amount] [float] NOT NULL,
    [TotalDiscountStrata3Amount] [float] NOT NULL,
    [TotalDiscountStrata4Amount] [float] NOT NULL,
    [TotalDiscountStrata5Amount] [float] NOT NULL,
    [TotalAddDiscountStrataAmount] [float] NOT NULL,
    [TotalGross] [float] NOT NULL,
    [TotalTax] [float] NOT NULL,
    [Total] [float] NOT NULL,
    [TotalWeight] [float] NOT NULL,
    [TotalDimension] [int] NOT NULL,
    [AddDiscountStrataReason] [nvarchar](200) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOC_DocumentStatusID] DEFAULT (1),
    [DocumentStatusReason] [nvarchar](200) NULL,
    [SFAInvoiceDocumentCode] [nvarchar](30) NULL,
    [PrintCount] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOC_PrintCount] DEFAULT (0),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderFOC_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_SalesOrderFOC] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderFOC] ON [dbo].[SalesOrderFOC]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderFOC_Unique] ON [dbo].[SalesOrderFOC]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderFOC_UniqueSFA] ON [dbo].[SalesOrderFOC]
(
    [SFAInvoiceDocumentCode] ASC
)
WHERE ([SFAInvoiceDocumentCode] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderFOC] WITH CHECK ADD CONSTRAINT [FK_SalesOrderFOC_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderFOC] CHECK CONSTRAINT [FK_SalesOrderFOC_Salesman];
GO

ALTER TABLE [dbo].[SalesOrderFOC] WITH CHECK ADD CONSTRAINT [FK_SalesOrderFOC_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderFOC] CHECK CONSTRAINT [FK_SalesOrderFOC_Warehouse];
GO

ALTER TABLE [dbo].[SalesOrderFOC] WITH CHECK ADD CONSTRAINT [FK_SalesOrderFOC_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderFOC] CHECK CONSTRAINT [FK_SalesOrderFOC_Customer];
GO

ALTER TABLE [dbo].[SalesOrderFOC] WITH CHECK ADD CONSTRAINT [FK_SalesOrderFOC_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderFOC] CHECK CONSTRAINT [FK_SalesOrderFOC_DiscountGroup];
GO

ALTER TABLE [dbo].[SalesOrderFOC] 
ENABLE CHANGE_TRACKING 
