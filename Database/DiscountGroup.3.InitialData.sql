USE [IDOS];
GO

SET IDENTITY_INSERT [dbo].[DiscountGroup] ON;
GO

INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (1, N'Disc_Rtl', N'Discount Retail', N'Discount Retail', 1, CAST(0x0000A5F700808A40 AS DateTime), 1, NULL, 1, 0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (2, N'Disc_SG', N'Discount Semi Grosir', N'Discount Semi Grosir', 2, CAST(0x0000A5F700827670 AS DateTime), 1, NULL, NULL, 0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (3, N'Disc_Gr', N'Discount Grosir', N'Discount Grosir', 3, CAST(0x0000A5F700827670 AS DateTime), 1, NULL, NULL, 0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (4, N'Disc_SO', N'Discount Star Outlet', N'Discount Star Outlet', 4, CAST(0x0000A5F700827670 AS DateTime), 1, NULL, NULL, 0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (5, N'Disc_MM', N'Discount Modern Market', N'Discount Modern Market', 5, CAST(0x0000A5F700827670 AS DateTime), 1, NULL, NULL, 0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (6, N'Disc_d711', N'Discount 7-ELEVEN', N'Discount 7-ELEVEN',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (7, N'Disc_dBhi', N'Discount Bhineka', N'Discount Bhineka',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (8, N'Disc_dBlan', N'Discount Blanja', N'Discount Blanja',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (9, N'Disc_dCirc', N'Discount Circle-K', N'Discount Circle-K',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (10, N'Disc_dDanD', N'Discount DanDan', N'Discount DanDan',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (11, N'Disc_dElev', N'Discount Elevenia', N'Discount Elevenia',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (12, N'Disc_dFHal', N'Discount Foodhall', N'Discount Foodhall',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (13, N'Disc_dFmly', N'Discount FAMILY', N'Discount FAMILY',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (14, N'Disc_dHERO', N'Discount HERO', N'Discount HERO',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (15, N'Disc_dHRDC', N'Discount HERO DC', N'Discount HERO DC',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (16, N'Disc_dIDMG', N'Discount IDM GO', N'Discount IDM GO',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (17, N'Disc_dIndG', N'Discount INDOGROSIR', N'Discount INDOGROSIR',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (18, N'Disc_dIndo', N'Discount INDOMARET', N'Discount INDOMARET',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (19, N'Disc_DiOL', N'Discount Online Shop', N'Discount Online Shop',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (20, N'Disc_dMata', N'Discount Mataharimal', N'Discount Mataharimal',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (21, N'Disc_dMDI', N'Discount ALFAMIDI', N'Discount ALFAMIDI',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (22, N'Disc_dPRFD', N'Discount Primafood', N'Discount Primafood',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (23, N'Disc_dQ10', N'Discount Qoo10', N'Discount Qoo10',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (24, N'Disc_dRBP', N'Discount dRBP', N'Discount dRBP',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (25, N'Disc_dSAT', N'Discount ALFAMART', N'Discount ALFAMART',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (26, N'Disc_dTHE', N'Discount THE', N'Discount THE',1,GETDATE(),1,NULL,NULL,0);
INSERT [dbo].[DiscountGroup] ([ID], [Code], [Name], [Description], [StatusID], [CreatedDate], [CreatedByUserID], [ModifiedDate], [ModifiedByUserID], [IsDeleted]) VALUES (27, N'Disc_dYMRT', N'Discount YOMART', N'Discount YOMART',1,GETDATE(),1,NULL,NULL,0);
GO

SET IDENTITY_INSERT [dbo].[DiscountGroup] OFF;
GO
