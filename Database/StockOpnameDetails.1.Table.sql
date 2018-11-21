USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpnameDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSBad] DEFAULT (0),
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyBad] DEFAULT (0)
    CONSTRAINT [PK_StockOpnameDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpnameDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockOpnameDetails_StockOpnameSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockOpnameSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockOpnameDetails] NOCHECK CONSTRAINT [FK_StockOpnameDetails_StockOpnameSummary];
GO

ALTER TABLE [dbo].[StockOpnameDetails] WITH CHECK ADD CONSTRAINT [FK_StockOpnameDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameDetails] CHECK CONSTRAINT [FK_StockOpnameDetails_ProductLot];
GO

ALTER TABLE [dbo].[StockOpnameDetails] 
ENABLE CHANGE_TRACKING 
