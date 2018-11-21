USE [IDOS];
GO

CREATE TABLE [dbo].[StockDisposalSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_Qty] DEFAULT (0)  
    CONSTRAINT [PK_StockDisposalSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockDisposalSummary] WITH CHECK ADD CONSTRAINT [FK_StockDisposalSummary_StockDisposal] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockDisposal] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalSummary] CHECK CONSTRAINT [FK_StockDisposalSummary_StockDisposal];
GO

ALTER TABLE [dbo].[StockDisposalSummary] WITH CHECK ADD CONSTRAINT [FK_StockDisposalSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalSummary] CHECK CONSTRAINT [FK_StockDisposalSummary_Product];
GO

ALTER TABLE [dbo].[StockDisposalSummary] 
ENABLE CHANGE_TRACKING 
