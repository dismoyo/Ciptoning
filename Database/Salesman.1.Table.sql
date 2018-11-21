USE [IDOS];
GO

CREATE TABLE [dbo].[Salesman]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Salesman_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](20) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [GroupID] [int] NOT NULL,
    [CategoryID] [int] NOT NULL,
    [Phone] [nvarchar](20) NULL,
    [SFAFlag] bit NULL,
    [SFA] [nvarchar](50) NULL,
    [StatusID] [int] NOT NULL CONSTRAINT [DF_Salesman_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Salesman_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Salesman_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Salesman] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Salesman] ON [dbo].[Salesman]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Salesman_Unique] ON [dbo].[Salesman]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--CREATE UNIQUE NONCLUSTERED INDEX [IX_Salesman_Unique2] ON [dbo].[Salesman]
--(
--    [WarehouseID] ASC,
--    [CategoryID] ASC
--)
--WHERE ([IsDeleted] = 0) AND (([CategoryID] = 1) OR ([CategoryID] = 5))
--WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
--GO

ALTER TABLE [dbo].[Salesman] WITH CHECK ADD CONSTRAINT [FK_Salesman_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[Salesman] CHECK CONSTRAINT [FK_Salesman_Warehouse];
GO

ALTER TABLE [dbo].[Salesman] 
ENABLE CHANGE_TRACKING 