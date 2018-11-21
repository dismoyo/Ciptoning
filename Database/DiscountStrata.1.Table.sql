USE [IDOS];
GO

CREATE TABLE [dbo].[DiscountStrata]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [ValidDateFrom] [datetime] NULL,
    [ValidDateTo] [datetime] NULL,
    [StatusID] [int] NOT NULL,    
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DiscountStrata_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_DiscountStrata_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_DiscountStrata] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_DiscountStrata] ON [dbo].[DiscountStrata]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DiscountStrata_Unique] ON [dbo].[DiscountStrata]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountStrata] 
ENABLE CHANGE_TRACKING 
