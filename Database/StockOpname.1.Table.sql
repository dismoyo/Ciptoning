USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpname]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockOpname_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockOpname_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockOpname_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockOpname_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockOpname_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockOpname] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockOpname] ON [dbo].[StockOpname]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_StockOpname_Unique] ON [dbo].[StockOpname]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpname] WITH CHECK ADD CONSTRAINT [FK_StockOpname_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpname] CHECK CONSTRAINT [FK_StockOpname_Warehouse];
GO

ALTER TABLE [dbo].[StockOpname] 
ENABLE CHANGE_TRACKING 
