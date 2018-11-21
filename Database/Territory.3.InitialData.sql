USE [IDOS]
GO

SET IDENTITY_INSERT [dbo].[Territory] ON;
GO

INSERT INTO [dbo].[Territory] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (1, 'T01', 'CENTRAL-1', DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Territory] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (2, 'T02', 'CENTRAL-2', DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Territory] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (3, 'T03', 'EAST', DEFAULT, NULL,	NULL, NULL,	0);
GO

SET IDENTITY_INSERT [dbo].[Territory] OFF;
GO
