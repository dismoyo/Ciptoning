USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransferSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandBad] DEFAULT (0),    
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSBad] DEFAULT (0),    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyBad] DEFAULT (0)    
    CONSTRAINT [PK_StockTransferSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransferSummary] WITH CHECK ADD CONSTRAINT [FK_StockTransferSummary_StockTransfer] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockTransfer] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferSummary] CHECK CONSTRAINT [FK_StockTransferSummary_StockTransfer];
GO

ALTER TABLE [dbo].[StockTransferSummary] WITH CHECK ADD CONSTRAINT [FK_StockTransferSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferSummary] CHECK CONSTRAINT [FK_StockTransferSummary_Product];
GO

ALTER TABLE [dbo].[StockTransferSummary] 
ENABLE CHANGE_TRACKING 
