USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[UserNotification]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserNotification_ID] DEFAULT (NEWID()),
    [RaisedDate] [datetime] NOT NULL CONSTRAINT [DF_UserNotification_RaisedDate] DEFAULT (GETUTCDATE()),
    [UserID] [int] NOT NULL,
    [CategoryID] [int] NOT NULL,
    [HtmlMessage] [nvarchar](1024) NOT NULL,    
    [IsRead] [bit] NOT NULL,
    CONSTRAINT [PK_UserNotification] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_UserNotification] ON [dbo].[UserNotification]
(
    [UserID] ASC,
    [IsRead] ASC,
    [RaisedDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[UserNotification] 
--ENABLE CHANGE_TRACKING 
