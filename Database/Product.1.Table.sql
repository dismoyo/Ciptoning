USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Product]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [BrandID] [int] NOT NULL,    
	[ShortName] [nvarchar](30) NOT NULL,
    [UOMLID] [int] NULL,
    [UOMMID] [int] NULL,
    [UOMSID] [int] NULL,
	[Weight] [float] NOT NULL,
	[DimensionL] [int] NULL,
	[DimensionW] [int] NULL,
	[DimensionH] [int] NULL,
	[ConversionL] [int] NULL,
	[ConversionM] [int] NULL,
	[ConversionS] [int] NULL,
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Product_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Product_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Product_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Product] ON [dbo].[Product]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_Unique] ON [dbo].[Product]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Product] WITH CHECK ADD CONSTRAINT [FK_Product_ProductBrand] FOREIGN KEY
(
    [BrandID]
) REFERENCES [dbo].[ProductBrand] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductBrand];
GO

ALTER TABLE [dbo].[Product] 
ENABLE CHANGE_TRACKING 
