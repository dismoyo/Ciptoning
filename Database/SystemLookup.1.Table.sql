USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SystemLookup]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](128) NOT NULL,
    [Value_Boolean] [bit] NULL,
    [Value_Int32] [int] NULL,
    [Value_Double] [float] NULL,
    [Value_String] [nvarchar](512) NULL,
    [Value_Guid] [uniqueidentifier] NULL,
    [Value_DateTime] [datetime2](7) NULL,
    [ParentID] [int] NULL,
    [Group] [nvarchar](128) NOT NULL,
    [SortIndex] [int] NOT NULL CONSTRAINT [DF_SystemLookup_SortIndex]  DEFAULT (1),
    [IsActive] [bit] NOT NULL CONSTRAINT [DF__SystemLoo__IsAct__6497E884]  DEFAULT (1),
    [IsAuthorization] [bit] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SystemLookup_CreatedDate] DEFAULT (GETUTCDATE()),
    [ModifiedDate] [datetime] NULL,
    CONSTRAINT [PK_SystemLookup] PRIMARY KEY CLUSTERED
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SystemLookup] ON [dbo].[SystemLookup]
(
    [Group] ASC,
    [Value_Int32]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SystemLookup2] ON [dbo].[SystemLookup]
(
    [Group] ASC,
    [Value_Guid] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SystemLookup3] ON [dbo].[SystemLookup]
(
    [Group] ASC,
    [Value_DateTime] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SystemLookup] 
ENABLE CHANGE_TRACKING
