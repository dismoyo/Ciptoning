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

ALTER TABLE [dbo].[CompanyAddress] 
ENABLE CHANGE_TRACKING 
