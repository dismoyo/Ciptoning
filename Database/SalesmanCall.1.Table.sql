USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE [dbo].[SalesmanCall]
(
    [ID] [uniqueidentifier] NOT NULL,
    [SalesmanID] [uniqueidentifier] NOT NULL,
    [CallDate] [datetime] NOT NULL,
    [CustomerID] [uniqueidentifier] NOT NULL,
    [IsInRoute] [bit] NOT NULL,    
    [MerchandiseDisplayActivityNote] [nvarchar] (250) NOT NULL CONSTRAINT [DF_SalesmanCall_MerchandiseDisplayActivityNote] DEFAULT (''),
    [PromoMaterialActivityNote] [nvarchar] (250) NOT NULL CONSTRAINT [DF_SalesmanCall_PromoMaterialActivityNote] DEFAULT (''),
    [StatusID] [int] NOT NULL,
    [IsTransactionPaid] [bit] NOT NULL,
    [NoTransactionReasonID] [int] NOT NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesmanCall_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,    
    CONSTRAINT [PK_SalesmanCall] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanCall] ON [dbo].[SalesmanCall]
(
    [SalesmanID] ASC,
    [CallDate] ASC,
    [CustomerID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanCall_CallDate] ON [dbo].[SalesmanCall]
(
    [CallDate] ASC,
    [SalesmanID] ASC,
    [CustomerID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_SalesmanCall_Customer] ON [dbo].[SalesmanCall]
(
    [CustomerID] ASC,
    [SalesmanID] ASC,
    [CallDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

--ALTER TABLE [dbo].[Customer] 
--ENABLE CHANGE_TRACKING
