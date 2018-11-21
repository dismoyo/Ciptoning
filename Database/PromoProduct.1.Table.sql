USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[PromoProduct]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](20) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ValidDateFrom] [datetime] NULL,
    [ValidDateTo] [datetime] NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [StatusID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_PromoProduct_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_PromoProduct_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_PromoProduct] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_PromoProduct] ON [dbo].[PromoProduct]
(
    [Code] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_PromoProduct_Unique] ON [dbo].[PromoProduct]
(
    [Code] ASC,
    [ProductID] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[PromoProduct] WITH CHECK ADD CONSTRAINT [FK_PromoProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[PromoProduct] CHECK CONSTRAINT [FK_PromoProduct_Product];
GO

--ALTER TABLE [dbo].[PromoProduct] 
--ENABLE CHANGE_TRACKING 
