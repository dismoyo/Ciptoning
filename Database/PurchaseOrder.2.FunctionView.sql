USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fPurchaseOrder]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fPurchaseOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[PurchaseOrder] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fPurchaseOrder]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SODocumentID uniqueidentifier,
    @SOTransactionTypeID int,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PO].[DocumentID],
            [PO].[DocumentCode],
            [PO].[TransactionDate],
            [PO].[DocumentStatusID],
            [PO].[SODocumentID],
            [PO].[SOTransactionTypeID],
            [fSL].[Name] [DocumentStatusName],
            [PO].[PostedDate],
            [PO].[CreatedDate],
            [PO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PO].[ModifiedDate],
            [PO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[PurchaseOrder] [PO] LEFT OUTER JOIN
            [dbo].[fSystemLookup]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([PO].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([PO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([PO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@SODocumentID IS NULL) OR ([PO].[SODocumentID] = @SODocumentID)) AND
            ((@SOTransactionTypeID IS NULL) OR ([PO].[SOTransactionTypeID] = @SOTransactionTypeID)) AND
            ([dbo].[ValidateMaxDate]([PO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom)) AND
            ([dbo].[ValidateMinDate]([PO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo)) AND
            ((@DocumentStatusID IS NULL) OR ([PO].[DocumentStatusID] = @DocumentStatusID)) AND
            ([dbo].[ValidateMaxDate]([PO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom)) AND
            ([dbo].[ValidateMinDate]([PO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vPurchaseOrder]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vPurchaseOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fPurchaseOrder] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vPurchaseOrder]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [SODocumentID],
            [SOTransactionTypeID],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fPurchaseOrder]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL                
            )
);
GO