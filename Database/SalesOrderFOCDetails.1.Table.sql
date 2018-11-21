USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderFOCDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOCDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOCDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOCDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOCDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderFOCDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderFOCDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderFOCDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderFOCDetails_SalesOrderFOCSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderFOCSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderFOCDetails] NOCHECK CONSTRAINT [FK_SalesOrderFOCDetails_SalesOrderFOCSummary];
GO

ALTER TABLE [dbo].[SalesOrderFOCDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderFOCDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderFOCDetails] CHECK CONSTRAINT [FK_SalesOrderFOCDetails_ProductLot];
GO

ALTER TABLE [dbo].[SalesOrderFOCDetails] 
ENABLE CHANGE_TRACKING 
