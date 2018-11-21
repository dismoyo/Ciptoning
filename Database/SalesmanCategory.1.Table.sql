USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanCategory]
(
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [Category1SelectedLevel] [nvarchar](30) NOT NULL,
    [Category1SelectedLevelLabel] [nvarchar](50) NOT NULL,
    [Category2SelectedLevel] [nvarchar](30) NOT NULL,
    [Category2SelectedLevelLabel] [nvarchar](50) NOT NULL,
    [Category3SelectedLevel] [nvarchar](30) NOT NULL,
    [Category3SelectedLevelLabel] [nvarchar](50) NOT NULL,
    [Category4SelectedLevel] [nvarchar](30) NOT NULL,
    [Category4SelectedLevelLabel] [nvarchar](50) NOT NULL,
    [Category5SelectedLevel] [nvarchar](30) NOT NULL,
    [Category5SelectedLevelLabel] [nvarchar](50) NOT NULL,    
    CONSTRAINT [PK_SalesmanCategory] PRIMARY KEY CLUSTERED 
    (
        [SalesmanID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[SalesmanCategory] WITH CHECK ADD CONSTRAINT [FK_SalesmanCategory_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE CASCADE ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[SalesmanCategory] CHECK CONSTRAINT [FK_SalesmanCategory_Salesman];
GO
