USE [IDOS];
GO

CREATE TABLE [dbo].[Warehouse]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Warehouse_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](12) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [SiteID] [uniqueidentifier] NULL,
    [TypeID] [int] NOT NULL CONSTRAINT [DF_Warehouse_TypeID] DEFAULT (1),
    [IsSOAllowed] [bit] NOT NULL CONSTRAINT [DF_Warehouse_IsSOAllowed] DEFAULT (0),
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Warehouse_StatusID] DEFAULT (1),
    [SAPCode] [nvarchar](50) NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Warehouse_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Warehouse_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Warehouse] ON [dbo].[Warehouse]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Warehouse_Unique] ON [dbo].[Warehouse]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Warehouse_Unique2] ON [dbo].[Warehouse]
(
    [SiteID] ASC,
    [TypeID] ASC
)
WHERE ([IsDeleted] = 0) AND ([TypeID] = 1)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Warehouse] WITH CHECK ADD CONSTRAINT [FK_Warehouse_Site] FOREIGN KEY
(
    [SiteID]
) REFERENCES [dbo].[Site] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Site];
GO

ALTER TABLE [dbo].[Warehouse] 
ENABLE CHANGE_TRACKING 
