USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSampleSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [PriceDate] [datetime] NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderSampleSummary_Qty] DEFAULT (0),
    [UnitGrossPrice] [float] NOT NULL,    
    [UnitPrice] [float] NOT NULL,
    [DiscountStrata1Percentage] [float] NULL,
    [DiscountStrata2Percentage] [float] NULL,
    [DiscountStrata3Percentage] [float] NULL,
    [DiscountStrata4Percentage] [float] NULL,
    [DiscountStrata5Percentage] [float] NULL,
    [AddDiscountStrataPercentage] [float] NULL,
    [TaxPercentage] [float] NOT NULL,
    [RawSubtotalGrossPrice] [float] NOT NULL,    
    [RawSubtotalPrice] [float] NOT NULL,
    [RawSubtotalDiscountStrata1] [float] NOT NULL,
    [RawSubtotalDiscountStrata2] [float] NOT NULL,
    [RawSubtotalDiscountStrata3] [float] NOT NULL,
    [RawSubtotalDiscountStrata4] [float] NOT NULL,
    [RawSubtotalDiscountStrata5] [float] NOT NULL,
    [RawSubtotalGross] [float] NOT NULL,
    [RawSubtotalTax] [float] NOT NULL,
    [RawSubtotal] [float] NOT NULL,
    [SubtotalGrossPrice] [float] NOT NULL,    
    [SubtotalPrice] [float] NOT NULL,
    [SubtotalDiscountStrata1] [float] NOT NULL,
    [SubtotalDiscountStrata2] [float] NOT NULL,
    [SubtotalDiscountStrata3] [float] NOT NULL,
    [SubtotalDiscountStrata4] [float] NOT NULL,
    [SubtotalDiscountStrata5] [float] NOT NULL,
    [SubtotalGross] [float] NOT NULL,
    [SubtotalTax] [float] NOT NULL,
    [Subtotal] [float] NOT NULL,
    [SubtotalWeight] [float] NOT NULL,
    [SubtotalDimension] [int] NOT NULL,
    CONSTRAINT [PK_SalesOrderSampleSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSampleSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSampleSummary_SalesOrderSample] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[SalesOrderSample] ([DocumentID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSampleSummary] CHECK CONSTRAINT [FK_SalesOrderSampleSummary_SalesOrderSample];
GO

ALTER TABLE [dbo].[SalesOrderSampleSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSampleSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSampleSummary] CHECK CONSTRAINT [FK_SalesOrderSampleSummary_Product];
GO

ALTER TABLE [dbo].[SalesOrderSampleSummary] 
ENABLE CHANGE_TRACKING 
