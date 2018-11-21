USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[DiscountGroup]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](200) NULL CONSTRAINT [DF_DiscountGroup_Description] DEFAULT (''),
    [StatusID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DiscountGroup_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_DiscountGroup_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_DiscountGroup] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_DiscountGroup] ON [dbo].[DiscountGroup]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DiscountGroup_Unique] ON [dbo].[DiscountGroup]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountGroup] 
ENABLE CHANGE_TRACKING 
