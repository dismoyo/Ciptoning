USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ProductPrice]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](20) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ValidDateFrom] [datetime] NULL,
    [ValidDateTo] [datetime] NULL,
    [PriceGroupID] [int] NOT NULL,
    [GrossPrice] [float] NOT NULL,
    [TaxPercentage] [float] NOT NULL,
    [Price] [float] NOT NULL,
    [StatusID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductPrice_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductPrice_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ProductPrice] ON [dbo].[ProductPrice]
(
    [Code] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductPrice_Unique] ON [dbo].[ProductPrice]
(
    [Code] ASC,
    [ProductID] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[ProductPrice] WITH CHECK ADD CONSTRAINT [FK_ProductPrice_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_Product];
GO

ALTER TABLE [dbo].[ProductPrice] 
ENABLE CHANGE_TRACKING 
