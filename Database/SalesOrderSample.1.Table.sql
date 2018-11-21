USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSample]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderSample_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderSample_TransactionDate] DEFAULT (GETUTCDATE()),
    [PODocumentID] [uniqueidentifier] NULL,    
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_SalesOrderSample_ReferenceNumber] DEFAULT (''),
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
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_SalesOrderSample_DocumentStatusID] DEFAULT (1),
    [DocumentStatusReason] [nvarchar](200) NULL,
    [SFAInvoiceDocumentCode] [nvarchar](30) NULL,
    [PrintCount] [int] NOT NULL CONSTRAINT [DF_SalesOrderSample_PrintCount] DEFAULT (0),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderSample_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_SalesOrderSample] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderSample] ON [dbo].[SalesOrderSample]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderSample_Unique] ON [dbo].[SalesOrderSample]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderSample_UniqueSFA] ON [dbo].[SalesOrderSample]
(
    [SFAInvoiceDocumentCode] ASC
)
WHERE ([SFAInvoiceDocumentCode] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSample] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSample_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSample] CHECK CONSTRAINT [FK_SalesOrderSample_Salesman];
GO

ALTER TABLE [dbo].[SalesOrderSample] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSample_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSample] CHECK CONSTRAINT [FK_SalesOrderSample_Warehouse];
GO

ALTER TABLE [dbo].[SalesOrderSample] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSample_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSample] CHECK CONSTRAINT [FK_SalesOrderSample_Customer];
GO

ALTER TABLE [dbo].[SalesOrderSample] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSample_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSample] CHECK CONSTRAINT [FK_SalesOrderSample_DiscountGroup];
GO

ALTER TABLE [dbo].[SalesOrderSample] 
ENABLE CHANGE_TRACKING 
