USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SiteAdditionalInfo]
(
    [SiteID] [uniqueidentifier] NOT NULL,
    [AdditionalInfo1] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address1] DEFAULT (''),
    [AdditionalInfo2] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address2] DEFAULT (''),
    [AdditionalInfo3] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address3] DEFAULT (''),
	[AdditionalInfo4] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address4] DEFAULT (''),
    [AdditionalInfo5] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address5] DEFAULT (''),
	[AdditionalInfo6] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address6] DEFAULT (''),
    [AdditionalInfo7] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address7] DEFAULT (''),
    [AdditionalInfo8] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address8] DEFAULT (''),
	[AdditionalInfo9] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address9] DEFAULT (''),
    [AdditionalInfo10] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address10] DEFAULT ('')
    CONSTRAINT [PK_SiteAdditionalInfo] PRIMARY KEY CLUSTERED 
    (
        [SiteID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SiteAdditionalInfo] WITH CHECK ADD CONSTRAINT [FK_SiteAdditionalInfo_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[SiteAdditionalInfo] CHECK CONSTRAINT [FK_SiteAdditionalInfo_Site];
GO

ALTER TABLE [dbo].[SiteAdditionalInfo] 
ENABLE CHANGE_TRACKING 
