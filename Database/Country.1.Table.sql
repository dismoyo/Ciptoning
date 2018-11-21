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

ALTER TABLE [dbo].[Country] 
ENABLE CHANGE_TRACKING 