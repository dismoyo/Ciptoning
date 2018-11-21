USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[PromoMaterialActivity]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PromoMaterialActivity_ID] DEFAULT (NEWID()),
    [ActivityDate] [datetime] NOT NULL,
    [SalesmanCallID] [uniqueidentifier] NOT NULL,
    [AttachmentFile] [nvarchar](256) NULL,
    [CreatedDate] [datetime] NULL,
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_PromoMaterialActivity] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_PromoMaterialActivity] ON [dbo].[PromoMaterialActivity]
(
    [SalesmanCallID] ASC,
    [ActivityDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[PromoMaterialActivity] WITH CHECK ADD CONSTRAINT [FK_PromoMaterialActivity_SalesmanCall] FOREIGN KEY
(
    [SalesmanCallID]
) REFERENCES [dbo].[SalesmanCall] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[PromoMaterialActivity] CHECK CONSTRAINT [FK_PromoMaterialActivity_SalesmanCall];
GO

--ALTER TABLE [dbo].[SalesOrderExt] 
--ENABLE CHANGE_TRACKING 
