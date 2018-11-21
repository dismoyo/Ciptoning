USE [IDOS];
GO

CREATE TABLE [dbo].[StockChangesSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyOnHand] DEFAULT (0),    
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_Qty] DEFAULT (0)  
    CONSTRAINT [PK_StockChangesSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChangesSummary] WITH CHECK ADD CONSTRAINT [FK_StockChangesSummary_StockChanges] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockChanges] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesSummary] CHECK CONSTRAINT [FK_StockChangesSummary_StockChanges];
GO

ALTER TABLE [dbo].[StockChangesSummary] WITH CHECK ADD CONSTRAINT [FK_StockChangesSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesSummary] CHECK CONSTRAINT [FK_StockChangesSummary_Product];
GO

ALTER TABLE [dbo].[StockChangesSummary] 
ENABLE CHANGE_TRACKING 
