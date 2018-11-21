USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransaction]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [RefVoidedDocumentID] [uniqueidentifier] NULL,
    [TransactionDate] [datetime] NOT NULL,
    [TransactionTypeID] [int] NOT NULL,
    [DocumentCode] [nvarchar](30) NOT NULL,
    [SourceID] [uniqueidentifier] NOT NULL,
    [DestinationID] [uniqueidentifier] NULL,
    [QtyGood] [int] NOT NULL,
    [QtyHold] [int] NOT NULL,
    [QtyBad] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransaction_CreatedDate] DEFAULT (GETUTCDATE()),
    CONSTRAINT [PK_StockTransaction] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockTransaction] ON [dbo].[StockTransaction]
(
    [ProductID] ASC,
    [ProductLotID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockTransaction2] ON [dbo].[StockTransaction]
(
    [SourceID] ASC,
    [ProductID] ASC,
    [ProductLotID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockTransaction3] ON [dbo].[StockTransaction]
(
    [DestinationID] ASC,
    [ProductID] ASC,
    [ProductLotID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransaction] WITH CHECK ADD CONSTRAINT [FK_StockTransaction_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransaction] CHECK CONSTRAINT [FK_StockTransaction_ProductLot];
GO

ALTER TABLE [dbo].[StockTransaction] 
ENABLE CHANGE_TRACKING 
