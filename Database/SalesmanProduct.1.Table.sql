USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanProduct]
(
    [SalesmanID] [uniqueidentifier] NOT NULL,
	[ProductID] [int] NOT NULL,
	CONSTRAINT [PK_SalesmanProduct] PRIMARY KEY CLUSTERED
    (
	    [SalesmanID] ASC,
        [ProductID]
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanProduct] WITH CHECK ADD CONSTRAINT [FK_SalesmanProduct_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[SalesmanProduct] CHECK CONSTRAINT [FK_SalesmanProduct_Salesman];
GO

ALTER TABLE [dbo].[SalesmanProduct] WITH CHECK ADD CONSTRAINT [FK_SalesmanProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]) ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanProduct] CHECK CONSTRAINT [FK_SalesmanProduct_Product];
GO

ALTER TABLE [dbo].[SalesmanProduct] 
ENABLE CHANGE_TRACKING 
