USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[MerchandiseDisplayActivity]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_MerchandiseDisplayActivity_ID] DEFAULT (NEWID()),
    [ActivityDate] [datetime] NOT NULL,
    [SalesmanCallID] [uniqueidentifier] NOT NULL,
    [AttachmentFile] [nvarchar](256) NULL,
    [CreatedDate] [datetime] NULL,
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_MerchandiseDisplayActivity] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_MerchandiseDisplayActivity] ON [dbo].[MerchandiseDisplayActivity]
(
    [SalesmanCallID] ASC,
    [ActivityDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[MerchandiseDisplayActivity] WITH CHECK ADD CONSTRAINT [FK_MerchandiseDisplayActivity_SalesmanCall] FOREIGN KEY
(
    [SalesmanCallID]
) REFERENCES [dbo].[SalesmanCall] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[MerchandiseDisplayActivity] CHECK CONSTRAINT [FK_MerchandiseDisplayActivity_SalesmanCall];
GO

--ALTER TABLE [dbo].[SalesOrderExt] 
--ENABLE CHANGE_TRACKING 
