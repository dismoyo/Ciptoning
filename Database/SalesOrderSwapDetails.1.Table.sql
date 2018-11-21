USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSwapDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderSwapDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSwapDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderSwapDetails_SalesOrderSwapSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderSwapSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderSwapDetails] NOCHECK CONSTRAINT [FK_SalesOrderSwapDetails_SalesOrderSwapSummary];
GO

ALTER TABLE [dbo].[SalesOrderSwapDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwapDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSwapDetails] CHECK CONSTRAINT [FK_SalesOrderSwapDetails_ProductLot];
GO

ALTER TABLE [dbo].[SalesOrderSwapDetails] 
ENABLE CHANGE_TRACKING 
