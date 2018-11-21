USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSwap]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderSwap_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderSwap_TransactionDate] DEFAULT (GETUTCDATE()),
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_SalesOrderSwap_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DODocumentID] [uniqueidentifier] NOT NULL,
    [TotalWeight] [float] NOT NULL,
    [TotalDimension] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwap_DocumentStatusID] DEFAULT (1),
    [DocumentStatusReason] [nvarchar](200) NULL,
    [SFAInvoiceDocumentCode] [nvarchar](30) NULL,
    [PrintCount] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwap_PrintCount] DEFAULT (0),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderSwap_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_SalesOrderSwap] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderSwap] ON [dbo].[SalesOrderSwap]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderSwap_Unique] ON [dbo].[SalesOrderSwap]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesOrderSwap_UniqueSFA] ON [dbo].[SalesOrderSwap]
(
    [SFAInvoiceDocumentCode] ASC
)
WHERE ([SFAInvoiceDocumentCode] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSwap] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwap_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSwap] CHECK CONSTRAINT [FK_SalesOrderSwap_Salesman];
GO

ALTER TABLE [dbo].[SalesOrderSwap] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwap_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSwap] CHECK CONSTRAINT [FK_SalesOrderSwap_Warehouse];
GO

ALTER TABLE [dbo].[SalesOrderSwap] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwap_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSwap] CHECK CONSTRAINT [FK_SalesOrderSwap_Customer];
GO

ALTER TABLE [dbo].[SalesOrderSwap] 
ENABLE CHANGE_TRACKING 
