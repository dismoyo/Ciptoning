USE [IDOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
 
CREATE TABLE [dbo].[SalesmanProductTarget]
(
	[SalesmanID] [uniqueidentifier] NOT NULL,    
	[PeriodID] [date] NOT NULL,
    [ProductID] [int] NOT NULL,    
	[SalesOrderQty] [int] NOT NULL,
    [EffectiveCall] [float] NOT NULL,
	[CustomerTransaction] [float] NOT NULL,
    CONSTRAINT [PK_SalesmanProductTarget] PRIMARY KEY CLUSTERED
    (
	    [SalesmanID],
        [PeriodID],    
	    [ProductID]        
    ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanProductTarget] ON [dbo].[SalesmanProductTarget]
(
    [SalesmanID] ASC,
    [PeriodID] ASC,
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanProductTargetPeriod] ON [dbo].[SalesmanProductTarget]
(
    [PeriodID] ASC,
    [SalesmanID] ASC,    
    [ProductID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanProductTarget] WITH CHECK ADD CONSTRAINT [FK_SalesmanProductTarget_SalesmanTarget] FOREIGN KEY
(
    [SalesmanID],
    [PeriodID]
) REFERENCES [dbo].[SalesmanTarget] ([SalesmanID], [PeriodID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanProductTarget] CHECK CONSTRAINT [FK_SalesmanProductTarget_SalesmanTarget];
GO

ALTER TABLE [dbo].[SalesmanProductTarget] WITH CHECK ADD CONSTRAINT [FK_SalesmanProductTarget_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanProductTarget] CHECK CONSTRAINT [FK_SalesmanProductTarget_Product];
GO

--ALTER TABLE [dbo].[SalesmanProductTarget] 
--ENABLE CHANGE_TRACKING 
