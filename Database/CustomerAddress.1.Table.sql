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
    [Longitude] [float] NULL,
    [Latitude] [float] NULL,
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

ALTER TABLE [dbo].[CustomerAddress] 
ENABLE CHANGE_TRACKING 
