USE [IDOS];
GO

CREATE TABLE [dbo].[StockReceiveDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockReceiveDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockReceiveDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockReceiveDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockReceiveDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockReceiveDetails_Qty] DEFAULT (0)
    CONSTRAINT [PK_StockReceiveDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockReceiveDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockReceiveDetails_StockReceiveSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockReceiveSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockReceiveDetails] NOCHECK CONSTRAINT [FK_StockReceiveDetails_StockReceiveSummary];
GO

ALTER TABLE [dbo].[StockReceiveDetails] WITH CHECK ADD CONSTRAINT [FK_StockReceiveDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockReceiveDetails] CHECK CONSTRAINT [FK_StockReceiveDetails_ProductLot];
GO

ALTER TABLE [dbo].[StockReceiveDetails] 
ENABLE CHANGE_TRACKING 
