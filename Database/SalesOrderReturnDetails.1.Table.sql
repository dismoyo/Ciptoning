USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderReturnDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturnDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturnDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturnDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturnDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderReturnDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderReturnDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderReturnDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderReturnDetails_SalesOrderReturnSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderReturnSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderReturnDetails] NOCHECK CONSTRAINT [FK_SalesOrderReturnDetails_SalesOrderReturnSummary];
GO

ALTER TABLE [dbo].[SalesOrderReturnDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderReturnDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderReturnDetails] CHECK CONSTRAINT [FK_SalesOrderReturnDetails_ProductLot];
GO

ALTER TABLE [dbo].[SalesOrderReturnDetails] 
ENABLE CHANGE_TRACKING 
