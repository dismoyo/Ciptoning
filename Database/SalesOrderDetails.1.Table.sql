USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderDetails_SalesOrderSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderDetails] NOCHECK CONSTRAINT [FK_SalesOrderDetails_SalesOrderSummary];
GO

ALTER TABLE [dbo].[SalesOrderDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderDetails] CHECK CONSTRAINT [FK_SalesOrderDetails_ProductLot];
GO

ALTER TABLE [dbo].[SalesOrderDetails] 
ENABLE CHANGE_TRACKING 
