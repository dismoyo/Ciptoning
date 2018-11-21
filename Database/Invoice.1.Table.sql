USE [IDOS];
GO

CREATE TABLE [dbo].[Invoice]
(
    [DocumentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Invoice_DocumentID] DEFAULT (NEWID()),
    [DocumentCode] [nvarchar](30) NOT NULL,
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_Invoice_TransactionDate] DEFAULT (GETUTCDATE()),
    [RefDocumentID] [uniqueidentifier] NOT NULL,
    [RefTransactionTypeID] [int] NOT NULL,
    [DocumentStatusID] [int] NOT NULL CONSTRAINT [DF_Invoice_DocumentStatusID] DEFAULT (1),
    [PostedDate] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Invoice_CreatedDate] DEFAULT (GETUTCDATE()),
    [CreatedByUserID] [int] NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedByUserID] [int] NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED
    (
	    [DocumentID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Invoice] ON [dbo].[Invoice]
(
    [DocumentCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Invoice_Unique] ON [dbo].[Invoice]
(
    [DocumentCode] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Invoice] 
ENABLE CHANGE_TRACKING 
