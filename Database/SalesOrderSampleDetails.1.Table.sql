USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSampleDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderSampleDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSampleDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderSampleDetails_SalesOrderSampleSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderSampleSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderSampleDetails] NOCHECK CONSTRAINT [FK_SalesOrderSampleDetails_SalesOrderSampleSummary];
GO

ALTER TABLE [dbo].[SalesOrderSampleDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSampleDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSampleDetails] CHECK CONSTRAINT [FK_SalesOrderSampleDetails_ProductLot];
GO

ALTER TABLE [dbo].[SalesOrderSampleDetails] 
ENABLE CHANGE_TRACKING 
