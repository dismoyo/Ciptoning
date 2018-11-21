USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderReturn]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderReturn_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderReturn_TransactionDate] DEFAULT (GETUTCDATE()),
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_SalesOrderReturn_ReferenceNumber] DEFAULT (''),
    [ReasonID] [int] NOT NULL,
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
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturn_DocumentStatusID] DEFAULT (1),
    [DocumentStatusReason] [nvarchar](200) NULL,
    [SFAInvoiceDocumentCode] [nvarchar](30) NULL,
    [PrintCount] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturn_PrintCount] DEFAULT (0),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderReturn_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_SalesOrderReturn] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderReturn] ON [dbo].[SalesOrderReturn]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderReturn_Unique] ON [dbo].[SalesOrderReturn]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderReturn_UniqueSFA] ON [dbo].[SalesOrderReturn]
(
    [SFAInvoiceDocumentCode] ASC
)
WHERE ([SFAInvoiceDocumentCode] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderReturn] WITH CHECK ADD CONSTRAINT [FK_SalesOrderReturn_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderReturn] CHECK CONSTRAINT [FK_SalesOrderReturn_Salesman];
GO

ALTER TABLE [dbo].[SalesOrderReturn] WITH CHECK ADD CONSTRAINT [FK_SalesOrderReturn_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderReturn] CHECK CONSTRAINT [FK_SalesOrderReturn_Warehouse];
GO

ALTER TABLE [dbo].[SalesOrderReturn] WITH CHECK ADD CONSTRAINT [FK_SalesOrderReturn_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderReturn] CHECK CONSTRAINT [FK_SalesOrderReturn_Customer];
GO

ALTER TABLE [dbo].[SalesOrderReturn] WITH CHECK ADD CONSTRAINT [FK_SalesOrderReturn_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderReturn] CHECK CONSTRAINT [FK_SalesOrderReturn_DiscountGroup];
GO

ALTER TABLE [dbo].[SalesOrderReturn] 
ENABLE CHANGE_TRACKING 
