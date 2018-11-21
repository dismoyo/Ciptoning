USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpnameSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSBad] DEFAULT (0),    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyBad] DEFAULT (0)    
    CONSTRAINT [PK_StockOpnameSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpnameSummary] WITH CHECK ADD CONSTRAINT [FK_StockOpnameSummary_StockOpname] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockOpname] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameSummary] CHECK CONSTRAINT [FK_StockOpnameSummary_StockOpname];
GO

ALTER TABLE [dbo].[StockOpnameSummary] WITH CHECK ADD CONSTRAINT [FK_StockOpnameSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameSummary] CHECK CONSTRAINT [FK_StockOpnameSummary_Product];
GO

ALTER TABLE [dbo].[StockOpnameSummary] 
ENABLE CHANGE_TRACKING 
