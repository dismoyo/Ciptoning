USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SystemParameter]
(
    [ID] [nvarchar] (128) NOT NULL PRIMARY KEY,
    [Description] [nvarchar](256) NOT NULL,
    [Value] [nvarchar](256) NOT NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SystemParameter] ON [dbo].[SystemParameter]
(
    [ID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
ALTER TABLE [dbo].[SystemParameter] 
ENABLE CHANGE_TRACKING 