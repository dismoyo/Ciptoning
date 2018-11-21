USE [IDOS];
GO

CREATE TABLE [dbo].[StockChanges]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockChanges_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockChanges_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [OldItemStatusID] [int] NOT NULL,
    [NewItemStatusID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockChanges_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockChanges_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockChanges_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockChanges] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockChanges] ON [dbo].[StockChanges]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_StockChanges_Unique] ON [dbo].[StockChanges]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChanges] WITH CHECK ADD CONSTRAINT [FK_StockChanges_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChanges] CHECK CONSTRAINT [FK_StockChanges_Warehouse];
GO

ALTER TABLE [dbo].[StockChanges] 
ENABLE CHANGE_TRACKING 
