USE [IDOS]
GO

SET IDENTITY_INSERT [dbo].[ProductBrand] ON;
GO

INSERT INTO [dbo].[ProductBrand] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (1, '001', 'POCARI SWEAT', DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[ProductBrand] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (2, '002', 'SOYJOY', DEFAULT, NULL, NULL, NULL, 0);
INSERT INTO [dbo].[ProductBrand] ([ID], [Code], [Name], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (3, '003', 'IONESSENCE', DEFAULT, NULL, NULL, NULL, 0);
GO

SET IDENTITY_INSERT [dbo].[ProductBrand] OFF;
GO
