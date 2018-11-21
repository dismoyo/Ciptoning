USE [IDOS];
GO

CREATE TABLE [dbo].[PurchaseOrder]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PurchaseOrder_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrder_TransactionDate] DEFAULT (GETUTCDATE()),
    [SODocumentID] [uniqueidentifier] NOT NULL,
    [SOTransactionTypeID] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_PurchaseOrder_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrder_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[PurchaseOrder] 
ENABLE CHANGE_TRACKING 
