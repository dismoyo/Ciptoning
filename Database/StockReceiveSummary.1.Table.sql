USE [IDOS];
GO

CREATE TABLE [dbo].[StockReceiveSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockReceiveSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockReceiveSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockReceiveSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockReceiveSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockReceiveSummary_Qty] DEFAULT (0)  
    CONSTRAINT [PK_StockReceiveSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockReceiveSummary] WITH CHECK ADD CONSTRAINT [FK_StockReceiveSummary_StockReceive] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockReceive] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockReceiveSummary] CHECK CONSTRAINT [FK_StockReceiveSummary_StockReceive];
GO

ALTER TABLE [dbo].[StockReceiveSummary] WITH CHECK ADD CONSTRAINT [FK_StockReceiveSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockReceiveSummary] CHECK CONSTRAINT [FK_StockReceiveSummary_Product];
GO

ALTER TABLE [dbo].[StockReceiveSummary] 
ENABLE CHANGE_TRACKING 
