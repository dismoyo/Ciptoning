USE [IDOS];
GO

CREATE TABLE [dbo].[StockChangesDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_Qty] DEFAULT (0)
    CONSTRAINT [PK_StockChangesDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChangesDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockChangesDetails_StockChangesSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockChangesSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockChangesDetails] NOCHECK CONSTRAINT [FK_StockChangesDetails_StockChangesSummary];
GO

ALTER TABLE [dbo].[StockChangesDetails] WITH CHECK ADD CONSTRAINT [FK_StockChangesDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesDetails] CHECK CONSTRAINT [FK_StockChangesDetails_ProductLot];
GO

ALTER TABLE [dbo].[StockChangesDetails] 
ENABLE CHANGE_TRACKING 
