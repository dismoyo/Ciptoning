USE [IDOS];
GO

CREATE TABLE [dbo].[DeliveryOrder]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DeliveryOrder_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_DeliveryOrder_TransactionDate] DEFAULT (GETUTCDATE()),
    [RefDocumentID] [uniqueidentifier] NOT NULL,
    [RefTransactionTypeID] [int] NOT NULL,
    [ShipmentDate] [datetime] NULL,
    [ReceivedDate] [datetime] NULL,
    [PrintedCount] [int] NULL,
    [LastPrintedDate] [datetime] NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_DeliveryOrder_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_DeliveryOrder_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_DeliveryOrder] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_DeliveryOrder] ON [dbo].[DeliveryOrder]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DeliveryOrder_Unique] ON [dbo].[DeliveryOrder]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[DeliveryOrder] 
ENABLE CHANGE_TRACKING 
