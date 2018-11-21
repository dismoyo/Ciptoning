USE [IDOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Holiday]
(
	[SiteID] [uniqueidentifier] NOT NULL,
    [Date] [datetime] NOT NULL,
	[Description] [nvarchar](50) NOT NULL CONSTRAINT [DF_Holiday_Description] DEFAULT (''),
    CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED
    (
        [SiteID],
	    [Date]
    ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_Holiday] ON [dbo].[Holiday]
(
    [SiteID] ASC,
    [Date] ASC    
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_HolidayDate] ON [dbo].[Holiday]
(
    [Date] ASC,
    [SiteID] ASC    
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Holiday] WITH CHECK ADD CONSTRAINT [FK_Holiday_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Holiday] CHECK CONSTRAINT [FK_Holiday_Site];
GO

--ALTER TABLE [dbo].[SalesmanProductTarget] 
--ENABLE CHANGE_TRACKING 