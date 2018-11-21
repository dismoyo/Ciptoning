USE [IDOS];
GO

CREATE TABLE [dbo].[StockDisposalDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_Qty] DEFAULT (0)
    CONSTRAINT [PK_StockDisposalDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockDisposalDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockDisposalDetails_StockDisposalSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockDisposalSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockDisposalDetails] NOCHECK CONSTRAINT [FK_StockDisposalDetails_StockDisposalSummary];
GO

ALTER TABLE [dbo].[StockDisposalDetails] WITH CHECK ADD CONSTRAINT [FK_StockDisposalDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalDetails] CHECK CONSTRAINT [FK_StockDisposalDetails_ProductLot];
GO

ALTER TABLE [dbo].[StockDisposalDetails] 
ENABLE CHANGE_TRACKING 
