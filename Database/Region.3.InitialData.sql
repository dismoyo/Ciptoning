USE [IDOS]
GO

SET IDENTITY_INSERT [dbo].[Region] ON;
GO

INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (1, 'R01', 'SUMATERA-1', 1, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (2, 'R02', 'SUMATERA-2', 1, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (3, 'R03', 'WEST JAVA', 1, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (4, 'R04', 'SUMATERA-3', 3, DEFAULT, NULL, NULL, NULL, 0	);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (5, 'R05', 'EAST JAVA', 3, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (6, 'R06', 'PAPUA', 3, DEFAULT, NULL, NULL, NULL, 0	);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (7, 'R07', 'CENTRAL JAVA', 2, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (8, 'R08', 'BALI & NUSRA', 2, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (9, 'R09', 'KALIMANTAN', 2, DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[Region] ([ID], [Code], [Name], [TerritoryID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (10, 'R10', 'SULAWESI & MALUKU', 2, DEFAULT, NULL, NULL, NULL, 0);
GO

SET IDENTITY_INSERT [dbo].[Region] OFF;
GO
