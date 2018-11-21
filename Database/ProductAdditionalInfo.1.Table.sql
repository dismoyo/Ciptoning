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

ALTER TABLE [dbo].[ProductAdditionalInfo] 
ENABLE CHANGE_TRACKING 
