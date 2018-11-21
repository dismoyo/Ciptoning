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


ALTER TABLE [dbo].[ProductLot] 
ENABLE CHANGE_TRACKING 