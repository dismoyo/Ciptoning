USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[Customer]
(
    [ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_ID] DEFAULT (NEWID()),
    [Code] [nvarchar](20) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [RegisteredDate] [datetime] NOT NULL,
    [TermOfPaymentID] [int] NOT NULL,
    [CreditLimit] [float] NULL,
    [PriceGroupID] [int] NOT NULL,
    [DiscountGroupID] [int] NOT NULL,    
    [IsTaxNumberAvailable] [bit] NOT NULL CONSTRAINT [DF_Customer_IsTaxNumberAvailable] DEFAULT (0),
    [TaxNumber] [nvarchar](20) NULL,    
    [TaxSAPCode] [nvarchar](20) NULL, 
    [Photo] [nvarchar](256) NULL, 
	[StatusID] [int] NOT NULL CONSTRAINT [DF_Customer_StatusID] DEFAULT (1),
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    [IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Customer_IsDeleted] DEFAULT (0),
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Customer] ON [dbo].[Customer]
(
    [Code] ASC,
    [Name] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Customer_Unique] ON [dbo].[Customer]
(
    [Code] ASC,
    [IsDeleted] ASC
)
WHERE ([IsDeleted] = 0)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Customer] WITH CHECK ADD CONSTRAINT [FK_Customer_Salesman] FOREIGN KEY
(
    [SalesmanID]
) REFERENCES [dbo].[Salesman] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Salesman];
GO

ALTER TABLE [dbo].[Customer] WITH CHECK ADD CONSTRAINT [FK_Customer_DiscountGroup] FOREIGN KEY
(
    [DiscountGroupID]
) REFERENCES [dbo].[DiscountGroup] ([ID]) ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_DiscountGroup];
GO

ALTER TABLE [dbo].[Customer] 
ENABLE CHANGE_TRACKING 
