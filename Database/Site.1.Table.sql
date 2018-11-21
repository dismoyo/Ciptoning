USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Site]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Site_ID] DEFAULT (NEWID()),
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[AreaID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[DistributionTypeID] [int] NOT NULL CONSTRAINT [DF_Site_DistributionTypeID] DEFAULT (1),
    [IsLotNumberEntryRequired] [bit] NOT NULL CONSTRAINT [DF_Site_IsLotNumberEntryRequired] DEFAULT (0),
    [TaxNumber] [nvarchar](20) NULL,
	[StatusID] [int] NOT NULL CONSTRAINT [DF_Site_StatusID] DEFAULT (1),
    [SAPCode] [nvarchar](50) NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Site_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Site_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Site] ON [dbo].[Site]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Site_Unique] ON [dbo].[Site]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Site] WITH CHECK ADD CONSTRAINT [FK_Site_Area] FOREIGN KEY
(
    [AreaID]
) REFERENCES [dbo].[Area] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Area];
GO

ALTER TABLE [dbo].[Site] WITH CHECK ADD CONSTRAINT [FK_Site_Company] FOREIGN KEY
(
    [CompanyID]
) REFERENCES [dbo].[Company] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Company];
GO

ALTER TABLE [dbo].[Site] 
ENABLE CHANGE_TRACKING 
