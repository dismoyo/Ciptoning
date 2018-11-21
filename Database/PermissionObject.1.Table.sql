USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[PermissionObject]
(
    [ID] [nvarchar](256) NOT NULL,
    [Description] [nvarchar](512) NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_PermissionObject_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_PermissionObject] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
ALTER TABLE [dbo].[PermissionObject] 
ENABLE CHANGE_TRACKING 