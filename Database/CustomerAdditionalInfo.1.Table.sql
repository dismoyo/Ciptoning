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

ALTER TABLE [dbo].[CustomerAdditionalInfo] 
ENABLE CHANGE_TRACKING 
