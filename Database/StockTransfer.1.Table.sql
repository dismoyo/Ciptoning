USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransfer]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockTransfer_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransfer_TransactionDate] DEFAULT (GETUTCDATE()),
    [SourceWarehouseID] [uniqueidentifier] NOT NULL,
    [SourcePIC] [nvarchar](50) NOT NULL,    
    [DestinationWarehouseID] [uniqueidentifier] NOT NULL,
    [DestinationPIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockTransfer_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DODocumentID] [uniqueidentifier] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockTransfer_DocumentStatusID] DEFAULT (1),
    [PrintCount] [int] NOT NULL CONSTRAINT [DF_StockTransfer_PrintCount] DEFAULT (0),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransfer_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockTransfer] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockTransfer] ON [dbo].[StockTransfer]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_StockTransfer_Unique] ON [dbo].[StockTransfer]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransfer] WITH CHECK ADD CONSTRAINT [FK_StockTransfer_SourceWarehouse] FOREIGN KEY
(
    [SourceWarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_SourceWarehouse];
GO

ALTER TABLE [dbo].[StockTransfer] WITH CHECK ADD CONSTRAINT [FK_StockTransfer_DestinationWarehouse] FOREIGN KEY
(
    [DestinationWarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_DestinationWarehouse];
GO

ALTER TABLE [dbo].[StockTransfer] 
ENABLE CHANGE_TRACKING 
