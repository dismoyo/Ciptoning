USE [IDOS]
GO

/****** Object:  Table [dbo].[AutoNumberCounter]    Script Date: 06/01/2016 16:23:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AutoNumberCounter](
	[SiteID] [uniqueidentifier] NOT NULL,
	[SalesOrder] [int] NOT NULL,
	[SalesOrderReturn] [int] NOT NULL,
	[SalesOrderSwap] [int] NOT NULL,
	[SalesOrderSample] [int] NOT NULL,
	[SalesOrderFOC] [int] NOT NULL,
	[StockOpname] [int] NOT NULL,
	[StockChanges] [int] NOT NULL,
	[StockTransfer] [int] NOT NULL,
	[StockDisposal] [int] NOT NULL,
	[DeliveryOrder] [int] NOT NULL,
	[Invoice] [int] NOT NULL,
	[StockReceive] [int] NOT NULL,
	[Customer] [int] NOT NULL
 CONSTRAINT [PK_AutoNumberCounter] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AutoNumberCounter]  WITH CHECK ADD  CONSTRAINT [FK_AutoNumberCounter_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[Site] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AutoNumberCounter] CHECK CONSTRAINT [FK_AutoNumberCounter_Site]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [SalesOrder]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [SalesOrderReturn]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [SalesOrderSwap]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [SalesOrderSample]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [SalesOrderFOC]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [StockOpname]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [StockChanges]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [StockTransfer]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [StockDisposal]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [DeliveryOrder]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [Invoice]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [StockReceive]
GO

ALTER TABLE [dbo].[AutoNumberCounter] ADD  DEFAULT ((0)) FOR [Customer]
GO
