USE [IDOS];
GO

CREATE TABLE [dbo].[DiscountStrataDetails]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [StrataID] [int] NOT NULL,
    [Minimum] [float] NULL,
    [Maximum] [float] NULL,
    [DiscountPercentage] [float] NULL,
    CONSTRAINT [PK_DiscountStrataDetails] PRIMARY KEY CLUSTERED
    (
	    [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DiscountStrataDetails] WITH CHECK ADD CONSTRAINT [FK_DiscountStrataDetails_DiscountStrata] FOREIGN KEY
(
    [StrataID]
) REFERENCES [dbo].[DiscountStrata] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[DiscountStrataDetails] CHECK CONSTRAINT [FK_DiscountStrataDetails_DiscountStrata];
GO

ALTER TABLE [dbo].[DiscountStrataDetails] 
ENABLE CHANGE_TRACKING 
