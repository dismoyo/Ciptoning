USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[AuthorizationAccessToken]
(
    [ID] [uniqueidentifier] NOT NULL,
	[UserID] [int] NOT NULL,
	[DeviceID] [nvarchar](256) NOT NULL,
    [ExpiredDate] [datetime] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_AuthorizationAccessToken_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_AuthorizationAccessToken] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_AuthorizationAccessToken] ON [dbo].[AuthorizationAccessToken]
(
    [UserID] ASC,
	[DeviceID] ASC,
	[ExpiredDate] DESC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[AuthorizationAccessToken] WITH CHECK ADD CONSTRAINT [FK_AuthorizationAccessToken_User] FOREIGN KEY
(
    [UserID]
) REFERENCES [dbo].[User] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[AuthorizationAccessToken] CHECK CONSTRAINT [FK_AuthorizationAccessToken_User];
GO

ALTER TABLE [dbo].[AuthorizationAccessToken] 
ENABLE CHANGE_TRACKING
