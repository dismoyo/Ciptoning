USE [IDOS];
GO

CREATE TABLE [dbo].[StockOnHandPeriodic]
(
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [PeriodDateID] [datetime] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,    
    [QtyGood] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyGood] DEFAULT (0),
	[QtyHold] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyHold] DEFAULT (0),
	[QtyBad] [int] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_QtyBad] DEFAULT (0),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_StockOnHandPeriodic_CreatedDate] DEFAULT (GETUTCDATE()),
    CONSTRAINT [PK_StockOnHandPeriodic] PRIMARY KEY CLUSTERED
    (
        [WarehouseID] ASC,
	    [PeriodDateID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockOnHandPeriodic] ON [dbo].[StockOnHandPeriodic]
(
    [WarehouseID] ASC,
	[PeriodDateID] ASC,
    [ProductID] ASC,
    [ProductLotID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] WITH CHECK ADD CONSTRAINT [FK_StockOnHandPeriodic_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] CHECK CONSTRAINT [FK_StockOnHandPeriodic_Warehouse];
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] WITH CHECK ADD CONSTRAINT [FK_StockOnHandPeriodic_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandPeriodic] CHECK CONSTRAINT [FK_StockOnHandPeriodic_ProductLot];
GO

--ALTER TABLE [dbo].[StockOnHandPeriodic] 
--ENABLE CHANGE_TRACKING
