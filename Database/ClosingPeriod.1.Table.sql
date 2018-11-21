USE [IDOS];
GO

CREATE TABLE [dbo].[ClosingPeriod]
(
    [SiteID] [uniqueidentifier] NOT NULL,
	[YearID] [int] NOT NULL,
	[Jan] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Jan] DEFAULT (0),
	[Feb] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Feb] DEFAULT (0),
	[Mar] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Mar] DEFAULT (0),
	[Apr] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Apr] DEFAULT (0),
	[May] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_May] DEFAULT (0),
	[Jun] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Jun] DEFAULT (0),
	[Jul] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Jul] DEFAULT (0),
	[Aug] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Aug] DEFAULT (0),
	[Sep] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Sep] DEFAULT (0),
	[Oct] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Oct] DEFAULT (0),
	[Nov] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Nov] DEFAULT (0),
	[Dec] [bit] NOT NULL CONSTRAINT [DF_ClosingPeriod_Dec] DEFAULT (0),
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ClosingPeriod_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_ClosingPeriod] PRIMARY KEY CLUSTERED
    (
	    [SiteID] ASC,
        [YearID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ClosingPeriod] ON [dbo].[ClosingPeriod]
(
    [SiteID] ASC,
    [YearID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[ClosingPeriod] WITH CHECK ADD CONSTRAINT [FK_ClosingPeriod_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[ClosingPeriod] CHECK CONSTRAINT [FK_ClosingPeriod_Site];
GO

--ALTER TABLE [dbo].[ClosingPeriod] 
--ENABLE CHANGE_TRACKING 