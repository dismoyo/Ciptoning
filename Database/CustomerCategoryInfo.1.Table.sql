USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerCategoryInfo]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [Category1ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address1] DEFAULT NULL,
    [Category2ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address2] DEFAULT NULL,
    [Category3ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address3] DEFAULT NULL,
	[Category4ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address4] DEFAULT NULL,
    [Category5ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address5] DEFAULT NULL,
	[Category6ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address6] DEFAULT NULL,
    [Category7ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address7] DEFAULT NULL,
    [Category8ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address8] DEFAULT NULL,
	[Category9ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address9] DEFAULT NULL,
    [Category10ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address10] DEFAULT NULL
    CONSTRAINT [PK_CustomerCategoryInfo] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerCategoryInfo] WITH CHECK ADD CONSTRAINT [FK_CustomerCategoryInfo_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerCategoryInfo] CHECK CONSTRAINT [FK_CustomerCategoryInfo_Customer];
GO

ALTER TABLE [dbo].[CustomerCategoryInfo] 
ENABLE CHANGE_TRACKING 
