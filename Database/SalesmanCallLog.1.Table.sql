USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanCallLog]
(
    [ID] [uniqueidentifier] NOT NULL,
    [SalesmanCallID] [uniqueidentifier] NOT NULL,
    [CheckedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesmanCallLog_CheckedInDate] DEFAULT (GETUTCDATE()),
    [CheckedLongitude] [decimal](9,6) NULL,
    [CheckedLatitude] [decimal](9,6) NULL,
    [IsCheckedIn] [bit] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesmanCallLog_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,    
    CONSTRAINT [PK_SalesmanCallLog] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanCallLog] ON [dbo].[SalesmanCallLog]
(
    [SalesmanCallID] ASC,
    [CheckedDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanCallLog] WITH CHECK ADD CONSTRAINT [FK_SalesmanCallLog_SalesmanCall] FOREIGN KEY
(
    [SalesmanCallID]
) REFERENCES [dbo].[SalesmanCall] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanCallLog] CHECK CONSTRAINT [FK_SalesmanCallLog_SalesmanCall];
GO

--ALTER TABLE [dbo].[Customer] 
--ENABLE CHANGE_TRACKING
