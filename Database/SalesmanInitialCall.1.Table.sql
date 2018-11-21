USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanInitialCall]
(
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [CallDate] [datetime] NOT NULL,
    [StartOdometer] [float] NOT NULL CONSTRAINT [DF_SalesmanInitialCall_StartOdometer] DEFAULT (0),
    [EndOdometer] [float] NOT NULL CONSTRAINT [DF_SalesmanInitialCall_EndOdometer] DEFAULT (0),
    [EndOfDayPrintCount] [int] NOT NULL CONSTRAINT [DF_SalesmanInitialCall_EndOfDayPrintCount] DEFAULT (0),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesmanInitialCall_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,    
    CONSTRAINT [PK_SalesmanInitialCall] PRIMARY KEY CLUSTERED 
    (
        [SalesmanID] ASC,
        [CallDate] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanInitialCall] ON [dbo].[SalesmanInitialCall]
(
    [SalesmanID] ASC,
    [CallDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanInitialCall_CallDate] ON [dbo].[SalesmanInitialCall]
(
    [CallDate] ASC,
    [SalesmanID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[Customer] 
--ENABLE CHANGE_TRACKING 
