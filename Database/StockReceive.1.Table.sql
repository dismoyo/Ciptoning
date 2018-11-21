USE [IDOS];
GO

CREATE TABLE [dbo].[StockReceive]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockReceive_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockReceive_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockReceive_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockReceive_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockReceive_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockReceive] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockReceive] ON [dbo].[StockReceive]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_StockReceive_Unique] ON [dbo].[StockReceive]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockReceive] WITH CHECK ADD CONSTRAINT [FK_StockReceive_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockReceive] CHECK CONSTRAINT [FK_StockReceive_Warehouse];
GO

ALTER TABLE [dbo].[StockReceive] 
ENABLE CHANGE_TRACKING 
