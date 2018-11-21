USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[User]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [GUID] [uniqueidentifier] NOT NULL,
    [Name] [nvarchar](256) NOT NULL,    
    [IsActive] [bit] NOT NULL CONSTRAINT [DF_User_IsActive] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_User_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Country]
(
    [ID] [nchar](2) NOT NULL,
    [Name] [nvarchar](128) NULL,
    [Alpha3Code] [nvarchar](3) NULL,
    [DialCode] [nvarchar](10) NULL
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ProductBrand]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductBrand_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductBrand_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_ProductBrand] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ProductBrand] ON [dbo].[ProductBrand]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductBrand_Unique] ON [dbo].[ProductBrand]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Product]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [BrandID] [int] NOT NULL,    
	[ShortName] [nvarchar](30) NOT NULL,
    [UOMLID] [int] NULL,
    [UOMMID] [int] NULL,
    [UOMSID] [int] NULL,
	[Weight] [float] NOT NULL,
	[DimensionL] [int] NULL,
	[DimensionW] [int] NULL,
	[DimensionH] [int] NULL,
	[ConversionL] [int] NULL,
	[ConversionM] [int] NULL,
	[ConversionS] [int] NULL,
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Product_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Product_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Product_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Product] ON [dbo].[Product]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_Unique] ON [dbo].[Product]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Product] WITH CHECK ADD CONSTRAINT [FK_Product_ProductBrand] FOREIGN KEY
(
    [BrandID]
) REFERENCES [dbo].[ProductBrand] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductBrand];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ProductPrice]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](20) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ValidDateFrom] [datetime] NULL,
    [ValidDateTo] [datetime] NULL,
    [PriceGroupID] [int] NOT NULL,
    [GrossPrice] [float] NOT NULL,
    [TaxPercentage] [float] NOT NULL,
    [Price] [float] NOT NULL,
    [StatusID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductPrice_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductPrice_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ProductPrice] ON [dbo].[ProductPrice]
(
    [Code] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductPrice_Unique] ON [dbo].[ProductPrice]
(
    [Code] ASC,
    [ProductID] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[ProductPrice] WITH CHECK ADD CONSTRAINT [FK_ProductPrice_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_Product];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ProductAdditionalInfo]
(
    [ProductID] [int] NOT NULL,
    [AdditionalInfo1] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address1] DEFAULT (''),
    [AdditionalInfo2] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address2] DEFAULT (''),
    [AdditionalInfo3] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address3] DEFAULT (''),
	[AdditionalInfo4] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address4] DEFAULT (''),
    [AdditionalInfo5] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address5] DEFAULT (''),
	[AdditionalInfo6] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address6] DEFAULT (''),
    [AdditionalInfo7] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address7] DEFAULT (''),
    [AdditionalInfo8] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address8] DEFAULT (''),
	[AdditionalInfo9] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address9] DEFAULT (''),
    [AdditionalInfo10] [nvarchar](100) NULL CONSTRAINT [DF_ProductAdditionalInfo_Address10] DEFAULT ('')
    CONSTRAINT [PK_ProductAdditionalInfo] PRIMARY KEY CLUSTERED 
    (
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[ProductAdditionalInfo] WITH CHECK ADD CONSTRAINT [FK_ProductAdditionalInfo_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[ProductAdditionalInfo] CHECK CONSTRAINT [FK_ProductAdditionalInfo_Product];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[ProductLot]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](20) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ExpiredDate] [datetime] NULL,
    [StatusID] [int] NOT NULL,
    [SAPCode] [nvarchar](50) NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductLot_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductLot_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_ProductLot] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_ProductLot] ON [dbo].[ProductLot]
(
    [Code] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductLot_Unique] ON [dbo].[ProductLot]
(
    [Code] ASC,
    [ProductID] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[ProductLot] WITH CHECK ADD CONSTRAINT [FK_ProductLot_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[ProductLot] CHECK CONSTRAINT [FK_ProductLot_Product];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Territory]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Territory_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Territory_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Territory] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Territory] ON [dbo].[Territory]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Territory_Unique] ON [dbo].[Territory]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Region]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [TerritoryID] [int] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Region_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Region_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Region] ON [dbo].[Region]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Region_Unique] ON [dbo].[Region]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Region] WITH CHECK ADD CONSTRAINT [FK_Region_Territory] FOREIGN KEY
(
    [TerritoryID]
) REFERENCES [dbo].[Territory] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Region] CHECK CONSTRAINT [FK_Region_Territory];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[Area]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [RegionID] [int] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Area_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Area_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Area] ON [dbo].[Area]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Area_Unique] ON [dbo].[Area]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Area] WITH CHECK ADD CONSTRAINT [FK_Area_Region] FOREIGN KEY
(
    [RegionID]
) REFERENCES [dbo].[Region] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [FK_Area_Region];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Company]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [TaxNumber] [nvarchar](20) NULL,
	[StatusID] [int] NOT NULL CONSTRAINT [DF_Company_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Company_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Company_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Company] ON [dbo].[Company]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Company_Unique] ON [dbo].[Company]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CompanyAddress]
(
    [CompanyID] [int] NOT NULL,
    [Address1] [nvarchar](100) NOT NULL,
    [Address2] [nvarchar](100) NULL CONSTRAINT [DF_CompanyAddress_Address2] DEFAULT (''),
    [Address3] [nvarchar](100) NULL CONSTRAINT [DF_CompanyAddress_Address3] DEFAULT (''),
	[City] [nvarchar](50) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryID] [nchar](2) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[Phone1] [nvarchar](20) NOT NULL,
	[Phone2] [nvarchar](20) NULL CONSTRAINT [DF_CompanyAddress_Phone2] DEFAULT (''),
	[Fax] [nvarchar](20) NULL CONSTRAINT [DF_CompanyAddress_Fax] DEFAULT (''),
	[Email] [nvarchar](256) NULL CONSTRAINT [DF_CompanyAddress_Email] DEFAULT (''),
    CONSTRAINT [PK_CompanyAddress] PRIMARY KEY CLUSTERED 
    (
        [CompanyID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CompanyAddress] WITH CHECK ADD CONSTRAINT [FK_CompanyAddress_Company] FOREIGN KEY
(
    [CompanyID]
) REFERENCES [dbo].[Company] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CompanyAddress] CHECK CONSTRAINT [FK_CompanyAddress_Company];
GO

ALTER TABLE [dbo].[CompanyAddress] WITH CHECK ADD CONSTRAINT [FK_CompanyAddress_Country] FOREIGN KEY
(
    [CountryID]
) REFERENCES [dbo].[Country] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[CompanyAddress] CHECK CONSTRAINT [FK_CompanyAddress_Country];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Site]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Site_ID] DEFAULT (NEWID()),
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[AreaID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[DistributionTypeID] [int] NOT NULL CONSTRAINT [DF_Site_DistributionTypeID] DEFAULT (1),
    [IsLotNumberEntryRequired] [bit] NOT NULL CONSTRAINT [DF_Site_IsLotNumberEntryRequired] DEFAULT (0),
    [TaxNumber] [nvarchar](20) NULL,
	[StatusID] [int] NOT NULL CONSTRAINT [DF_Site_StatusID] DEFAULT (1),
    [SAPCode] [nvarchar](50) NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Site_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Site_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Site] ON [dbo].[Site]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Site_Unique] ON [dbo].[Site]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Site] WITH CHECK ADD CONSTRAINT [FK_Site_Area] FOREIGN KEY
(
    [AreaID]
) REFERENCES [dbo].[Area] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Area];
GO

ALTER TABLE [dbo].[Site] WITH CHECK ADD CONSTRAINT [FK_Site_Company] FOREIGN KEY
(
    [CompanyID]
) REFERENCES [dbo].[Company] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Company];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SiteAdditionalInfo]
(
    [SiteID] [uniqueidentifier] NOT NULL,
    [AdditionalInfo1] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address1] DEFAULT (''),
    [AdditionalInfo2] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address2] DEFAULT (''),
    [AdditionalInfo3] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address3] DEFAULT (''),
	[AdditionalInfo4] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address4] DEFAULT (''),
    [AdditionalInfo5] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address5] DEFAULT (''),
	[AdditionalInfo6] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address6] DEFAULT (''),
    [AdditionalInfo7] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address7] DEFAULT (''),
    [AdditionalInfo8] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address8] DEFAULT (''),
	[AdditionalInfo9] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address9] DEFAULT (''),
    [AdditionalInfo10] [nvarchar](100) NULL CONSTRAINT [DF_SiteAdditionalInfo_Address10] DEFAULT ('')
    CONSTRAINT [PK_SiteAdditionalInfo] PRIMARY KEY CLUSTERED 
    (
        [SiteID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SiteAdditionalInfo] WITH CHECK ADD CONSTRAINT [FK_SiteAdditionalInfo_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[SiteAdditionalInfo] CHECK CONSTRAINT [FK_SiteAdditionalInfo_Site];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SiteAddress]
(
    [SiteID] [uniqueidentifier] NOT NULL,
    [Address1] [nvarchar](100) NOT NULL,
    [Address2] [nvarchar](100) NULL CONSTRAINT [DF_SiteAddress_Address2] DEFAULT (''),
    [Address3] [nvarchar](100) NULL CONSTRAINT [DF_SiteAddress_Address3] DEFAULT (''),
	[City] [nvarchar](50) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryID] [nchar](2) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[Phone1] [nvarchar](20) NOT NULL,
	[Phone2] [nvarchar](20) NULL CONSTRAINT [DF_SiteAddress_Phone2] DEFAULT (''),
	[Fax] [nvarchar](20) NULL CONSTRAINT [DF_SiteAddress_Fax] DEFAULT (''),
	[Email] [nvarchar](256) NULL CONSTRAINT [DF_SiteAddress_Email] DEFAULT (''),
    CONSTRAINT [PK_SiteAddress] PRIMARY KEY CLUSTERED 
    (
        [SiteID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SiteAddress] WITH CHECK ADD CONSTRAINT [FK_SiteAddress_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[SiteAddress] CHECK CONSTRAINT [FK_SiteAddress_Site];
GO

ALTER TABLE [dbo].[SiteAddress] WITH CHECK ADD CONSTRAINT [FK_SiteAddress_Country] FOREIGN KEY
(
    [CountryID]
) REFERENCES [dbo].[Country] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SiteAddress] CHECK CONSTRAINT [FK_SiteAddress_Country];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SiteProduct]
(
    [SiteID] [uniqueidentifier] NOT NULL,
	[ProductID] [int] NOT NULL,
	CONSTRAINT [PK_SiteProduct] PRIMARY KEY CLUSTERED
    (
	    [SiteID] ASC,
        [ProductID]
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SiteProduct] WITH CHECK ADD CONSTRAINT [FK_SiteProduct_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[SiteProduct] CHECK CONSTRAINT [FK_SiteProduct_Site];
GO

ALTER TABLE [dbo].[SiteProduct] WITH CHECK ADD CONSTRAINT [FK_SiteProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SiteProduct] CHECK CONSTRAINT [FK_SiteProduct_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[Warehouse]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Warehouse_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](12) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [SiteID] [uniqueidentifier] NULL,
    [TypeID] [int] NOT NULL CONSTRAINT [DF_Warehouse_TypeID] DEFAULT (1),
    [IsSOAllowed] [bit] NOT NULL CONSTRAINT [DF_Warehouse_IsSOAllowed] DEFAULT (0),
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Warehouse_StatusID] DEFAULT (1),
    [SAPCode] [nvarchar](50) NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Warehouse_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Warehouse_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Warehouse] ON [dbo].[Warehouse]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Warehouse_Unique] ON [dbo].[Warehouse]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Warehouse_Unique2] ON [dbo].[Warehouse]
(
    [SiteID] ASC,
    [TypeID] ASC
)
WHERE ([IsDeleted] = 0) AND ([TypeID] = 1)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Warehouse] WITH CHECK ADD CONSTRAINT [FK_Warehouse_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Site];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[Salesman]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Salesman_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [GroupID] [int] NOT NULL,
    [CategoryID] [int] NOT NULL,
    [Phone] [nvarchar](20) NULL,
    [SFAFlag] bit NULL,
    [SFA] [nvarchar](50) NULL,
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Salesman_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Salesman_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Salesman_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Salesman] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Salesman] ON [dbo].[Salesman]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Salesman_Unique] ON [dbo].[Salesman]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Salesman] WITH CHECK ADD CONSTRAINT [FK_Salesman_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Salesman] CHECK CONSTRAINT [FK_Salesman_Warehouse];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanProduct]
(
    [SalesmanID] [uniqueidentifier] NOT NULL,
	[ProductID] [int] NOT NULL,
	CONSTRAINT [PK_SalesmanProduct] PRIMARY KEY CLUSTERED
    (
	    [SalesmanID] ASC,
        [ProductID]
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanProduct] WITH CHECK ADD CONSTRAINT [FK_SalesmanProduct_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[SalesmanProduct] CHECK CONSTRAINT [FK_SalesmanProduct_Salesman];
GO

ALTER TABLE [dbo].[SalesmanProduct] WITH CHECK ADD CONSTRAINT [FK_SalesmanProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanProduct] CHECK CONSTRAINT [FK_SalesmanProduct_Product];
GO
USE [IDOS]
GO

/****** Object:  Table [dbo].[SalesmanTarget]    Script Date: 04/19/2016 11:54:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SalesmanTarget](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesmanID] [uniqueidentifier] NULL,
	[ProductID] [int] NOT NULL,
	[Month] [datetime] NULL,
	[TargetQty] [int] NULL,
	[TargetAmount] [int] NULL,
	[EffectiveCall] [int] NULL,
	[OutletTransaction] [int] NULL,
	[TargetNewOpenOutlet] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedByUserID] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SalesmanTarget_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[SalesmanTarget]  WITH CHECK ADD  CONSTRAINT [FK_SalesmanTarget_Salesman1] FOREIGN KEY([SalesmanID])
REFERENCES [dbo].[Salesman] ([ID])
GO

ALTER TABLE [dbo].[SalesmanTarget] CHECK CONSTRAINT [FK_SalesmanTarget_Salesman1]
GO

ALTER TABLE [dbo].[SalesmanTarget] ADD  CONSTRAINT [DF_SalesmanTarget_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[SalesmanTarget] ADD  CONSTRAINT [DF_SalesmanTarget_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

USE [IDOS];
GO

CREATE TABLE [dbo].[DiscountStrata]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [ValidDateFrom] [datetime] NULL,
    [ValidDateTo] [datetime] NULL,
    [TypeID] [int] NOT NULL CONSTRAINT [DF_DiscountStrata_TypeID] DEFAULT (1),
    [StatusID] [int] NOT NULL,    
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DiscountStrata_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_DiscountStrata_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_DiscountStrata] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_DiscountStrata] ON [dbo].[DiscountStrata]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DiscountStrata_Unique] ON [dbo].[DiscountStrata]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[DiscountStrataDetails]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [StrataID] [int] NOT NULL,
    [Minimum] [float] NULL,
    [Maximum] [float] NULL,
    [DiscountPercentage] [float] NULL,
    CONSTRAINT [PK_DiscountStrataDetails] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountStrataDetails] WITH CHECK ADD CONSTRAINT [FK_DiscountStrataDetails_DiscountStrata] FOREIGN KEY
(
    [StrataID]
) REFERENCES [dbo].[DiscountStrata] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[DiscountStrataDetails] CHECK CONSTRAINT [FK_DiscountStrataDetails_DiscountStrata];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[DiscountGroup]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](200) NULL CONSTRAINT [DF_DiscountGroup_Description] DEFAULT (''),
    [StatusID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DiscountGroup_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_DiscountGroup_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_DiscountGroup] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_DiscountGroup] ON [dbo].[DiscountGroup]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DiscountGroup_Unique] ON [dbo].[DiscountGroup]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[DiscountGroupProduct]
(
    [DiscountGroupID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [DiscountStrata1ID] [int] NULL,
    [DiscountStrata2ID] [int] NULL,
    [DiscountStrata3ID] [int] NULL,
    [DiscountStrata4ID] [int] NULL,
    [DiscountStrata5ID] [int] NULL,
    CONSTRAINT [PK_DiscountGroupProduct] PRIMARY KEY CLUSTERED
    (
	    [DiscountGroupID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountGroup];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_Product];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata1] FOREIGN KEY
(
    [DiscountStrata1ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata1];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata2] FOREIGN KEY
(
    [DiscountStrata2ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata2];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata3] FOREIGN KEY
(
    [DiscountStrata3ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata3];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata4] FOREIGN KEY
(
    [DiscountStrata4ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata4];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata5] FOREIGN KEY
(
    [DiscountStrata5ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata5];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerCategory]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [ParentID] [int] NULL,
    [Group] [nvarchar](30) NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerCategory_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_CustomerCategory_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_CustomerCategory] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_CustomerCategory] ON [dbo].[CustomerCategory]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerCategory_Unique] ON [dbo].[CustomerCategory]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Customer]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](10) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [RegisteredDate] [datetime] NOT NULL,
    [CompanyName] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CompanyName] DEFAULT (''),
    [TermOfPaymentID] [int] NOT NULL,
    [CreditLimit] [float] NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,    
    [IsTaxNumberAvailable] [bit] NOT NULL CONSTRAINT [DF_Customer_IsTaxNumberAvailable] DEFAULT (0),
    [TaxNumber] [nvarchar](20) NULL,    
    [TaxSAPCode] [nvarchar](20) NULL, 
	[StatusID] [int] NOT NULL CONSTRAINT [DF_Customer_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Customer_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Customer] ON [dbo].[Customer]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Customer_Unique] ON [dbo].[Customer]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Customer] WITH CHECK ADD CONSTRAINT [FK_Customer_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Salesman];
GO

ALTER TABLE [dbo].[Customer] WITH CHECK ADD CONSTRAINT [FK_Customer_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_DiscountGroup];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerAdditionalInfo]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [AdditionalInfo1] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address1] DEFAULT (''),
    [AdditionalInfo2] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address2] DEFAULT (''),
    [AdditionalInfo3] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address3] DEFAULT (''),
	[AdditionalInfo4] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address4] DEFAULT (''),
    [AdditionalInfo5] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address5] DEFAULT (''),
	[AdditionalInfo6] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address6] DEFAULT (''),
    [AdditionalInfo7] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address7] DEFAULT (''),
    [AdditionalInfo8] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address8] DEFAULT (''),
	[AdditionalInfo9] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address9] DEFAULT (''),
    [AdditionalInfo10] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAdditionalInfo_Address10] DEFAULT ('')
    CONSTRAINT [PK_CustomerAdditionalInfo] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerAdditionalInfo] WITH CHECK ADD CONSTRAINT [FK_CustomerAdditionalInfo_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerAdditionalInfo] CHECK CONSTRAINT [FK_CustomerAdditionalInfo_Customer];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerAddress]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [Address1] [nvarchar](100) NOT NULL,
    [Address2] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAddress_Address2] DEFAULT (''),
    [Address3] [nvarchar](100) NULL CONSTRAINT [DF_CustomerAddress_Address3] DEFAULT (''),
	[City] [nvarchar](50) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryID] [nchar](2) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[Phone1] [nvarchar](20) NOT NULL,
	[Phone2] [nvarchar](20) NULL CONSTRAINT [DF_CustomerAddress_Phone2] DEFAULT (''),
    [Phone3] [nvarchar](20) NULL CONSTRAINT [DF_CustomerAddress_Phone3] DEFAULT (''),
	[Fax] [nvarchar](20) NULL CONSTRAINT [DF_CustomerAddress_Fax] DEFAULT (''),
	[Email] [nvarchar](256) NULL CONSTRAINT [DF_CustomerAddress_Email] DEFAULT (''),
    [Longitude] [decimal](9,6) NULL,
    [Latitude] [decimal](9,6) NULL,
    CONSTRAINT [PK_CustomerAddress] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerAddress_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_Customer];
GO

ALTER TABLE [dbo].[CustomerAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerAddress_Country] FOREIGN KEY
(
    [CountryID]
) REFERENCES [dbo].[Country] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_Country];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerBillAddress]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [IsSameAsAddress] [bit] NOT NULL CONSTRAINT [DF_CustomerBillAddress_IsSameAsAddress] DEFAULT (0),
    [Name] [nvarchar](50) NULL,
    [Address1] [nvarchar](100) NULL,
    [Address2] [nvarchar](100) NULL,
    [Address3] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvince] [nvarchar](50) NULL,
	[CountryID] [nchar](2) NULL,
	[ZipCode] [nvarchar](10) NULL,
	[Phone1] [nvarchar](20) NULL,
	[Phone2] [nvarchar](20) NULL,
    [Phone3] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[Email] [nvarchar](256) NULL,
    CONSTRAINT [PK_CustomerBillAddress] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerBillAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerBillAddress_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerBillAddress] CHECK CONSTRAINT [FK_CustomerBillAddress_Customer];
GO

ALTER TABLE [dbo].[CustomerBillAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerBillAddress_Country] FOREIGN KEY
(
    [CountryID]
) REFERENCES [dbo].[Country] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[CustomerBillAddress] CHECK CONSTRAINT [FK_CustomerBillAddress_Country];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerTaxAddress]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [IsSameAsAddress] [bit] NOT NULL CONSTRAINT [DF_CustomerTaxAddress_IsSameAsAddress] DEFAULT (0),
    [IsSameAsBillAddress] [bit] NOT NULL CONSTRAINT [DF_CustomerTaxAddress_IsSameAsBillAddress] DEFAULT (0),
    [Name] [nvarchar](50) NULL,
    [Address1] [nvarchar](100) NULL,
    [Address2] [nvarchar](100) NULL,
    [Address3] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[StateProvince] [nvarchar](50) NULL,
	[CountryID] [nchar](2) NULL,
	[ZipCode] [nvarchar](10) NULL,
	[Phone1] [nvarchar](20) NULL,
	[Phone2] [nvarchar](20) NULL,
    [Phone3] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[Email] [nvarchar](256) NULL,
    CONSTRAINT [PK_CustomerTaxAddress] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerTaxAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerTaxAddress_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerTaxAddress] CHECK CONSTRAINT [FK_CustomerTaxAddress_Customer];
GO

ALTER TABLE [dbo].[CustomerTaxAddress] WITH CHECK ADD CONSTRAINT [FK_CustomerTaxAddress_Country] FOREIGN KEY
(
    [CountryID]
) REFERENCES [dbo].[Country] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[CustomerTaxAddress] CHECK CONSTRAINT [FK_CustomerTaxAddress_Country];
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerCategoryInfo]
(
    [CustomerID] [uniqueidentifier] NOT NULL,
    [Category1ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address1] DEFAULT NULL,
    [Category2ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address2] DEFAULT NULL,
    [Category3ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address3] DEFAULT NULL,
	[Category4ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address4] DEFAULT NULL,
    [Category5ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address5] DEFAULT NULL,
	[Category6ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address6] DEFAULT NULL,
    [Category7ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address7] DEFAULT NULL,
    [Category8ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address8] DEFAULT NULL,
	[Category9ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address9] DEFAULT NULL,
    [Category10ID] [int] NULL CONSTRAINT [DF_CustomerCategoryInfo_Address10] DEFAULT NULL
    CONSTRAINT [PK_CustomerCategoryInfo] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerCategoryInfo] WITH CHECK ADD CONSTRAINT [FK_CustomerCategoryInfo_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerCategoryInfo] CHECK CONSTRAINT [FK_CustomerCategoryInfo_Customer];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[PurchaseOrder]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PurchaseOrder_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrder_TransactionDate] DEFAULT (GETUTCDATE()),
    [SODocumentID] [uniqueidentifier] NOT NULL,
    [SOTransactionTypeID] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_PurchaseOrder_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrder_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[DeliveryOrder]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DeliveryOrder_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_DeliveryOrder_TransactionDate] DEFAULT (GETUTCDATE()),
    [RefDocumentID] [uniqueidentifier] NOT NULL,
    [RefTransactionTypeID] [int] NOT NULL,
    [ShipmentDate] [datetime] NULL,
    [ReceivedDate] [datetime] NULL,
    [PrintedCount] [int] NULL,
    [LastPrintedDate] [datetime] NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_DeliveryOrder_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DeliveryOrder_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_DeliveryOrder] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[Invoice]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Invoice_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_Invoice_TransactionDate] DEFAULT (GETUTCDATE()),
    [RefDocumentID] [uniqueidentifier] NOT NULL,
    [RefTransactionTypeID] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_Invoice_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Invoice_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransaction]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,    
    [TransactionDate] [datetime] NOT NULL,
    [TransactionTypeID] [int] NOT NULL,
    [DocumentCode] [nvarchar](30) NOT NULL,
    [SourceID] [uniqueidentifier] NOT NULL,
    [DestinationID] [uniqueidentifier] NULL,
    [QtyGood] [int] NOT NULL,
    [QtyHold] [int] NOT NULL,
    [QtyBad] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransaction_CreatedDate] DEFAULT (GETUTCDATE()),
    CONSTRAINT [PK_StockTransaction] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransaction] WITH CHECK ADD CONSTRAINT [FK_StockTransaction_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransaction] CHECK CONSTRAINT [FK_StockTransaction_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockOnHandPeriodic]
(
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PeriodDateID] [datetime] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyGood] DEFAULT (0),
	[QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyHold] DEFAULT (0),
	[QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyBad] DEFAULT (0),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_CreatedDate] DEFAULT (GETUTCDATE()),
    CONSTRAINT [PK_StockOnHandPeriodic] PRIMARY KEY CLUSTERED
    (
        [WarehouseID] ASC,
	    [PeriodDateID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] WITH CHECK ADD CONSTRAINT [FK_StockOnHandPeriodic_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] CHECK CONSTRAINT [FK_StockOnHandPeriodic_Warehouse];
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] WITH CHECK ADD CONSTRAINT [FK_StockOnHandPeriodic_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] CHECK CONSTRAINT [FK_StockOnHandPeriodic_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpname]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockOpname_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockOpname_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockOpname_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockOpname_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockOpname_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockOpname] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_StockOpname_Unique] ON [dbo].[StockOpname]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpname] WITH CHECK ADD CONSTRAINT [FK_StockOpname_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpname] CHECK CONSTRAINT [FK_StockOpname_Warehouse];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpnameSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyConvSBad] DEFAULT (0),    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameSummary_QtyBad] DEFAULT (0)    
    CONSTRAINT [PK_StockOpnameSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpnameSummary] WITH CHECK ADD CONSTRAINT [FK_StockOpnameSummary_StockOpname] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockOpname] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameSummary] CHECK CONSTRAINT [FK_StockOpnameSummary_StockOpname];
GO

ALTER TABLE [dbo].[StockOpnameSummary] WITH CHECK ADD CONSTRAINT [FK_StockOpnameSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameSummary] CHECK CONSTRAINT [FK_StockOpnameSummary_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockOpnameDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyConvSBad] DEFAULT (0),
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOpnameDetails_QtyBad] DEFAULT (0)
    CONSTRAINT [PK_StockOpnameDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOpnameDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockOpnameDetails_StockOpnameSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockOpnameSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockOpnameDetails] NOCHECK CONSTRAINT [FK_StockOpnameDetails_StockOpnameSummary];
GO

ALTER TABLE [dbo].[StockOpnameDetails] WITH CHECK ADD CONSTRAINT [FK_StockOpnameDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOpnameDetails] CHECK CONSTRAINT [FK_StockOpnameDetails_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockDisposal]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockDisposal_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockDisposal_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockDisposal_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockDisposal_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockDisposal_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockDisposal] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockDisposal] WITH CHECK ADD CONSTRAINT [FK_StockDisposal_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposal] CHECK CONSTRAINT [FK_StockDisposal_Warehouse];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockDisposalSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockDisposalSummary_Qty] DEFAULT (0)  
    CONSTRAINT [PK_StockDisposalSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockDisposalSummary] WITH CHECK ADD CONSTRAINT [FK_StockDisposalSummary_StockDisposal] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockDisposal] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalSummary] CHECK CONSTRAINT [FK_StockDisposalSummary_StockDisposal];
GO

ALTER TABLE [dbo].[StockDisposalSummary] WITH CHECK ADD CONSTRAINT [FK_StockDisposalSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalSummary] CHECK CONSTRAINT [FK_StockDisposalSummary_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockDisposalDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockDisposalDetails_Qty] DEFAULT (0)
    CONSTRAINT [PK_StockDisposalDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockDisposalDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockDisposalDetails_StockDisposalSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockDisposalSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockDisposalDetails] NOCHECK CONSTRAINT [FK_StockDisposalDetails_StockDisposalSummary];
GO

ALTER TABLE [dbo].[StockDisposalDetails] WITH CHECK ADD CONSTRAINT [FK_StockDisposalDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockDisposalDetails] CHECK CONSTRAINT [FK_StockDisposalDetails_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransfer]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockTransfer_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransfer_TransactionDate] DEFAULT (GETUTCDATE()),
    [SourceWarehouseID] [uniqueidentifier] NOT NULL,
    [SourcePIC] [nvarchar](50) NOT NULL,    
    [DestinationWarehouseID] [uniqueidentifier] NOT NULL,
    [DestinationPIC] [nvarchar](50) NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockTransfer_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DODocumentID] [uniqueidentifier] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockTransfer_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockTransfer_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockTransfer] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransfer] WITH CHECK ADD CONSTRAINT [FK_StockTransfer_SourceWarehouse] FOREIGN KEY
(
    [SourceWarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_SourceWarehouse];
GO

ALTER TABLE [dbo].[StockTransfer] WITH CHECK ADD CONSTRAINT [FK_StockTransfer_DestinationWarehouse] FOREIGN KEY
(
    [DestinationWarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[StockTransfer] CHECK CONSTRAINT [FK_StockTransfer_DestinationWarehouse];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransferSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyOnHandBad] DEFAULT (0),    
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyConvSBad] DEFAULT (0),    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockTransferSummary_QtyBad] DEFAULT (0)    
    CONSTRAINT [PK_StockTransferSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransferSummary] WITH CHECK ADD CONSTRAINT [FK_StockTransferSummary_StockTransfer] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockTransfer] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferSummary] CHECK CONSTRAINT [FK_StockTransferSummary_StockTransfer];
GO

ALTER TABLE [dbo].[StockTransferSummary] WITH CHECK ADD CONSTRAINT [FK_StockTransferSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferSummary] CHECK CONSTRAINT [FK_StockTransferSummary_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockTransferDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandGood] DEFAULT (0),
    [QtyOnHandHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandHold] DEFAULT (0),
    [QtyOnHandBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyOnHandBad] DEFAULT (0),
    [QtyConvLGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLGood] DEFAULT (0),
    [QtyConvMGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMGood] DEFAULT (0),
    [QtyConvSGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSGood] DEFAULT (0),
    [QtyConvLHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLHold] DEFAULT (0),
    [QtyConvMHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMHold] DEFAULT (0),
    [QtyConvSHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSHold] DEFAULT (0),
    [QtyConvLBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvLBad] DEFAULT (0),
    [QtyConvMBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvMBad] DEFAULT (0),
    [QtyConvSBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyConvSBad] DEFAULT (0),
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyGood] DEFAULT (0),
    [QtyHold] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyHold] DEFAULT (0),
    [QtyBad] [int] NOT NULL CONSTRAINT [DF_StockTransferDetails_QtyBad] DEFAULT (0)
    CONSTRAINT [PK_StockTransferDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockTransferDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockTransferDetails_StockTransferSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockTransferSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockTransferDetails] NOCHECK CONSTRAINT [FK_StockTransferDetails_StockTransferSummary];
GO

ALTER TABLE [dbo].[StockTransferDetails] WITH CHECK ADD CONSTRAINT [FK_StockTransferDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockTransferDetails] CHECK CONSTRAINT [FK_StockTransferDetails_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockChanges]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StockChanges_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_StockChanges_TransactionDate] DEFAULT (GETUTCDATE()),
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PIC] [nvarchar](50) NOT NULL,
    [OldItemStatusID] [int] NOT NULL,
    [NewItemStatusID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_StockChanges_ReferenceNumber] DEFAULT (''),
    [AttachmentFile] [nvarchar](256) NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_StockChanges_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockChanges_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_StockChanges] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChanges] WITH CHECK ADD CONSTRAINT [FK_StockChanges_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChanges] CHECK CONSTRAINT [FK_StockChanges_Warehouse];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockChangesSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
<<<<<<< .mine
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvS] DEFAULT (0),
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyOnHand] DEFAULT (0),
||||||| .r53444
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyOnHand] DEFAULT (0),
=======
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyOnHand] DEFAULT (0),    
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_QtyConvS] DEFAULT (0),
>>>>>>> .r53612
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockChangesSummary_Qty] DEFAULT (0)  
    CONSTRAINT [PK_StockChangesSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChangesSummary] WITH CHECK ADD CONSTRAINT [FK_StockChangesSummary_StockChanges] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[StockChanges] ([DocumentID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesSummary] CHECK CONSTRAINT [FK_StockChangesSummary_StockChanges];
GO

ALTER TABLE [dbo].[StockChangesSummary] WITH CHECK ADD CONSTRAINT [FK_StockChangesSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesSummary] CHECK CONSTRAINT [FK_StockChangesSummary_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[StockChangesDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_StockChangesDetails_Qty] DEFAULT (0)
    CONSTRAINT [PK_StockChangesDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockChangesDetails] WITH NOCHECK ADD CONSTRAINT [FK_StockChangesDetails_StockChangesSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[StockChangesSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[StockChangesDetails] NOCHECK CONSTRAINT [FK_StockChangesDetails_StockChangesSummary];
GO

ALTER TABLE [dbo].[StockChangesDetails] WITH CHECK ADD CONSTRAINT [FK_StockChangesDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockChangesDetails] CHECK CONSTRAINT [FK_StockChangesDetails_ProductLot];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrder]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrder_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrder_TransactionDate] DEFAULT (GETUTCDATE()),
    [PODocumentID] [uniqueidentifier] NOT NULL,    
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [ReferenceNumber] [nvarchar](30) NULL CONSTRAINT [DF_SalesOrder_ReferenceNumber] DEFAULT (''),
    [DODocumentID] [uniqueidentifier] NOT NULL,
    [InvoiceDocumentID] [uniqueidentifier] NULL,
    [TotalGrossPrice] [float] NOT NULL,    
    [TotalPrice] [float] NOT NULL,
    [TotalDiscountStrata1] [float] NULL,
    [TotalDiscountStrata2] [float] NULL,
    [TotalDiscountStrata3] [float] NULL,
    [TotalDiscountStrata4] [float] NULL,
    [TotalDiscountStrata5] [float] NULL,
    [TotalAddDiscountStrata] [float] NULL,
    [TotalTax] [float] NOT NULL,
    [Total] [float] NOT NULL,
    [TotalWeight] [float] NOT NULL,
    [TotalDimension] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_SalesOrder_DocumentStatusID] DEFAULT (1),
    [DocumentStatusReason] [nvarchar](200) NULL,
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrder_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_SalesOrder] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrder] WITH CHECK ADD CONSTRAINT [FK_SalesOrder_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrder] CHECK CONSTRAINT [FK_SalesOrder_Salesman];
GO

ALTER TABLE [dbo].[SalesOrder] WITH CHECK ADD CONSTRAINT [FK_SalesOrder_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrder] CHECK CONSTRAINT [FK_SalesOrder_Warehouse];
GO

ALTER TABLE [dbo].[SalesOrder] WITH CHECK ADD CONSTRAINT [FK_SalesOrder_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrder] CHECK CONSTRAINT [FK_SalesOrder_Customer];
GO

ALTER TABLE [dbo].[SalesOrder] WITH CHECK ADD CONSTRAINT [FK_SalesOrder_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrder] CHECK CONSTRAINT [FK_SalesOrder_DiscountGroup];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderSummary]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [PriceDate] [datetime] NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderSummary_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderSummary_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderSummary_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderSummary_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderSummary_Qty] DEFAULT (0),
    [UnitGrossPrice] [float] NOT NULL,    
    [UnitPrice] [float] NOT NULL,
    [DiscountStrata1Percentage] [float] NULL,
    [DiscountStrata2Percentage] [float] NULL,
    [DiscountStrata3Percentage] [float] NULL,
    [DiscountStrata4Percentage] [float] NULL,
    [DiscountStrata5Percentage] [float] NULL,
    [AddDiscountStrataPercentage] [float] NULL,
    [TaxPercentage] [float] NOT NULL,
    [SubtotalGrossPrice] [float] NOT NULL,    
    [SubtotalPrice] [float] NOT NULL,
    [SubtotalDiscountStrata1] [float] NOT NULL,
    [SubtotalDiscountStrata2] [float] NOT NULL,
    [SubtotalDiscountStrata3] [float] NOT NULL,
    [SubtotalDiscountStrata4] [float] NOT NULL,
    [SubtotalDiscountStrata5] [float] NOT NULL,
    [SubtotalAddDiscountStrata] [float] NOT NULL,
    [SubtotalTax] [float] NOT NULL,
    [Subtotal] [float] NOT NULL,
    [SubtotalWeight] [float] NOT NULL,
    [SubtotalDimension] [int] NOT NULL,
    CONSTRAINT [PK_SalesOrderSummary] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSummary_SalesOrder] FOREIGN KEY
(
    [DocumentID]
) REFERENCES [dbo].[SalesOrder] ([DocumentID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderSummary] CHECK CONSTRAINT [FK_SalesOrderSummary_SalesOrder];
GO

ALTER TABLE [dbo].[SalesOrderSummary] WITH CHECK ADD CONSTRAINT [FK_SalesOrderSummary_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]);
GO

ALTER TABLE [dbo].[SalesOrderSummary] CHECK CONSTRAINT [FK_SalesOrderSummary_Product];
GO
USE [IDOS];
GO

CREATE TABLE [dbo].[SalesOrderDetails]
(
    [DocumentID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHand] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyOnHand] DEFAULT (0),
    [QtyConvL] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvL] DEFAULT (0),
    [QtyConvM] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvM] DEFAULT (0),
    [QtyConvS] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_QtyConvS] DEFAULT (0),
    [Qty] [int] NOT NULL CONSTRAINT [DF_SalesOrderDetails_Qty] DEFAULT (0),
    CONSTRAINT [PK_SalesOrderDetails] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesOrderDetails] WITH NOCHECK ADD CONSTRAINT [FK_SalesOrderDetails_SalesOrderSummary] FOREIGN KEY
(
    [DocumentID],
    [ProductID]
) REFERENCES [dbo].[SalesOrderSummary] ([DocumentID], [ProductID]);
GO

ALTER TABLE [dbo].[SalesOrderDetails] NOCHECK CONSTRAINT [FK_SalesOrderDetails_SalesOrderSummary];
GO

ALTER TABLE [dbo].[SalesOrderDetails] WITH CHECK ADD CONSTRAINT [FK_SalesOrderDetails_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesOrderDetails] CHECK CONSTRAINT [FK_SalesOrderDetails_ProductLot];
GO
