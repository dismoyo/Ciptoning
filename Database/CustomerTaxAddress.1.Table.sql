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

ALTER TABLE [dbo].[CustomerTaxAddress] 
ENABLE CHANGE_TRACKING 
