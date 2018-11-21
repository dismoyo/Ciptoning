USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransferDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSBad] DEFAULT (0),
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyBad] DEFAULT (0)
    CONSTRAINT [PK_StockTransferDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransferDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockTransferDetails_StockTransferSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockTransferSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockTransferDetails] NOCHECK CONSTRAINT [FK_StockTransferDetails_StockTransferSummary];
GO

ALTER TABLE [dbo].[StockTransferDetails] WITH CHECK ADD CONSTRAINT [FK_StockTransferDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferDetails] CHECK CONSTRAINT [FK_StockTransferDetails_ProductLot];
GO

ALTER TABLE [dbo].[StockTransferDetails] 
ENABLE CHANGE_TRACKING 
