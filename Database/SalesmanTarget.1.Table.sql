USE [IDOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SalesmanTarget]
(
	[SalesmanID] [uniqueidentifier] NOT NULL,    
	[PeriodID] [date] NOT NULL,
    [SalesOrderAmount] [float] NOT NULL,
    [NewCustomer] [int] NOT NULL,
	[Visibility] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesmanTarget_CreatedDate] DEFAULT (GETUTCDATE()),
	[CreatedByUserID] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedByUserID] [int] NULL,	
    CONSTRAINT [PK_SalesmanTarget] PRIMARY KEY CLUSTERED
    (
	    [SalesmanID],
        [PeriodID]        
    ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanTarget] ON [dbo].[SalesmanTarget]
(
    [SalesmanID] ASC,
    [PeriodID] ASC    
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanTargetPeriod] ON [dbo].[SalesmanTarget]
(
    [PeriodID] ASC,
    [SalesmanID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanTarget] WITH CHECK ADD CONSTRAINT [FK_SalesmanTarget_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanTarget] CHECK CONSTRAINT [FK_SalesmanTarget_Salesman];
GO

--ALTER TABLE [dbo].[SalesmanTarget] 
--ENABLE CHANGE_TRACKING 
