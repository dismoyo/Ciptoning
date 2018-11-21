USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[DiscountGroupProduct]
(
    [DiscountGroupID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [DiscountStrata1ID] [int] NULL,
    [DiscountStrata2ID] [int] NULL,
    [DiscountStrata3ID] [int] NULL,
    [DiscountStrata4ID] [int] NULL,
    [DiscountStrata5ID] [int] NULL,
    CONSTRAINT [PK_DiscountGroupProduct] PRIMARY KEY CLUSTERED
    (
	    [DiscountGroupID] ASC,
        [ProductID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountGroup];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_Product] FOREIGN KEY
(
    [ProductID]
) REFERENCES [dbo].[Product] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_Product];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata1] FOREIGN KEY
(
    [DiscountStrata1ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata1];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata2] FOREIGN KEY
(
    [DiscountStrata2ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata2];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata3] FOREIGN KEY
(
    [DiscountStrata3ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata3];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata4] FOREIGN KEY
(
    [DiscountStrata4ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata4];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] WITH CHECK ADD CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata5] FOREIGN KEY
(
    [DiscountStrata5ID]
) REFERENCES [dbo].[DiscountStrata] ([ID]);
GO

ALTER TABLE [dbo].[DiscountGroupProduct] CHECK CONSTRAINT [FK_DiscountGroupProduct_DiscountStrata5];
GO

ALTER TABLE [dbo].[DiscountGroupProduct] 
ENABLE CHANGE_TRACKING 
