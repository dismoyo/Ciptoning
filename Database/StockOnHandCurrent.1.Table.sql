USE [IDOS];
GO

CREATE TABLE [dbo].[StockOnHandCurrent]
(
    [WarehouseID] [uniqueidentifier] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductLotID] [int] NOT NULL,
    [QtyOnHandGood] [int] NOT NULL,
    [QtyOnHandHold] [int] NOT NULL,
    [QtyOnHandBad] [int] NOT NULL
    CONSTRAINT [PK_StockOnHandCurrent] PRIMARY KEY CLUSTERED
    (
	    [WarehouseID] ASC,
        [ProductID] ASC,
        [ProductLotID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_StockOnHandCurrent] ON [dbo].[StockOnHandCurrent]
(
    [WarehouseID] ASC,
    [ProductID] ASC,
    [ProductLotID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[StockOnHandCurrent] WITH CHECK ADD CONSTRAINT [FK_StockOnHandCurrent_Warehouse] FOREIGN KEY
(
    [WarehouseID]
) REFERENCES [dbo].[Warehouse] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandCurrent] CHECK CONSTRAINT [FK_StockOnHandCurrent_Warehouse];
GO

ALTER TABLE [dbo].[StockOnHandCurrent] WITH CHECK ADD CONSTRAINT [FK_StockOnHandCurrent_ProductLot] FOREIGN KEY
(
    [ProductLotID]
) REFERENCES [dbo].[ProductLot] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[StockOnHandCurrent] CHECK CONSTRAINT [FK_StockOnHandCurrent_ProductLot];
GO
