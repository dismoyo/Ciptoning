USE [IDOS]
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[RoutePlan]
(
	[SalesmanID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[WeekID] [int] NOT NULL,
	[DayID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_RoutePlan_CreatedDate]  DEFAULT (GETUTCDATE()),
	[CreatedByUserID] [int] NULL,
	CONSTRAINT [PK_RoutePlan_1] PRIMARY KEY CLUSTERED 
    (
	    [SalesmanID] ASC,
	    [CustomerID] ASC,
	    [WeekID] ASC,
	    [DayID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[RoutePlan]  WITH CHECK ADD  CONSTRAINT [FK_RoutePlan_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[RoutePlan] CHECK CONSTRAINT [FK_RoutePlan_Salesman];
GO

ALTER TABLE [dbo].[RoutePlan]  WITH CHECK ADD  CONSTRAINT [FK_RoutePlan_Customer] FOREIGN KEY
(
    [CustomerID]
) REFERENCES [dbo].[Customer] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[RoutePlan] CHECK CONSTRAINT [FK_RoutePlan_Customer];
GO

ALTER TABLE [dbo].[RoutePlan] 
ENABLE CHANGE_TRACKING 