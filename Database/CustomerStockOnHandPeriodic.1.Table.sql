USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[CustomerStockOnHandPeriodic]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomerStockOnHandPeriodic_ID] DEFAULT (NEWID()),
    [PeriodDate] [datetime] NOT NULL,
    [SalesmanCallID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [Qty] [int] NOT NULL CONSTRAINT [DF_CustomerStockOnHandPeriodic_Qty] DEFAULT (0),
    [CreatedDate] [datetime] NULL,
    [CreatedByUserID] [int] NULL,
    CONSTRAINT [PK_CustomerStockOnHandPeriodic] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_CustomerStockOnHandPeriodic] ON [dbo].[CustomerStockOnHandPeriodic]
(
    [SalesmanCallID] ASC,
    [PeriodDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[CustomerStockOnHandPeriodic] WITH CHECK ADD CONSTRAINT [FK_CustomerStockOnHandPeriodic_SalesmanCall] FOREIGN KEY
(
    [SalesmanCallID]
) REFERENCES [dbo].[SalesmanCall] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[CustomerStockOnHandPeriodic] CHECK CONSTRAINT [FK_CustomerStockOnHandPeriodic_SalesmanCall];
GO

--ALTER TABLE [dbo].[SalesOrderExt] 
--ENABLE CHANGE_TRACKING 
