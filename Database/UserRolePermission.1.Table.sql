USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[UserRolePermission]
(
    [PermissionObjectID] [nvarchar](256) NOT NULL,
    [UserRoleID] [int] NOT NULL,
    [IsUser] [bit] NOT NULL CONSTRAINT [DF_UserRolePermission_IsUser] DEFAULT (0),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_UserRolePermission_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_UserRolePermission] PRIMARY KEY CLUSTERED 
    (
        [PermissionObjectID] ASC,
        [UserRoleID] ASC,
        [IsUser] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_UserRolePermission] ON [dbo].[UserRolePermission]
(
    [PermissionObjectID] ASC,
    [UserRoleID] ASC,
    [IsUser] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[UserRolePermission] WITH CHECK ADD CONSTRAINT [FK_UserRolePermission_PermissionObject] FOREIGN KEY
(
    [PermissionObjectID]
) REFERENCES [dbo].[PermissionObject] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[UserRolePermission] CHECK CONSTRAINT [FK_UserRolePermission_PermissionObject];
GO
ALTER TABLE [dbo].[UserRolePermission] 
ENABLE CHANGE_TRACKING 