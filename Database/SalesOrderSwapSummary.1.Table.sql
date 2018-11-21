USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSwapSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderSwapSummary_Qty] DEFAULT (0),
    [SubtotalWeight] [float] NOT NULL,
    [SubtotalDimension] [int] NOT NULL,
    CONSTRAINT [PK_SalesOrderSwapSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSwapSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwapSummary_SalesOrderSwap] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[SalesOrderSwap] ([DocumentID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSwapSummary] CHECK CONSTRAINT [FK_SalesOrderSwapSummary_SalesOrderSwap];
GO

ALTER TABLE [dbo].[SalesOrderSwapSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSwapSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSwapSummary] CHECK CONSTRAINT [FK_SalesOrderSwapSummary_Product];
GO

ALTER TABLE [dbo].[SalesOrderSwapSummary] 
ENABLE CHANGE_TRACKING 
