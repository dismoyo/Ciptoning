USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDeliveryOrder]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDeliveryOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[DeliveryOrder] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDeliveryOrder]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @RefDocumentID uniqueidentifier,
    @RefTransactionTypeID int,
    @ShipmentDateFrom datetime,
    @ShipmentDateTo datetime,
    @ReceivedDateFrom datetime,
    @ReceivedDateTo datetime,
    @LastPrintedDateFrom datetime,
    @LastPrintedDateTo datetime,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [DO].[DocumentID],
            [DO].[DocumentCode],
            [DO].[TransactionDate],
            [DO].[RefDocumentID],
            [DO].[RefTransactionTypeID],
            [fSL].[Name] [RefTransactionTypeName],
            [DO].[ShipmentDate],
            [DO].[ReceivedDate],
            [DO].[PrintedCount],
            [DO].[LastPrintedDate],
            [DO].[DocumentStatusID],
            [fSL2].[Name] [DocumentStatusName],
            [DO].[PostedDate],
            [DO].[CreatedDate],
            [DO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [DO].[ModifiedDate],
            [DO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[DeliveryOrder] [DO] LEFT OUTER JOIN
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
                'DORefTransactionType',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([DO].[RefTransactionTypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
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
            ) [fSL2] ON ([DO].[DocumentStatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([DO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([DO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([DO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@RefDocumentID IS NULL) OR ([DO].[RefDocumentID] = @RefDocumentID)) AND
            ((@RefTransactionTypeID IS NULL) OR ([DO].[RefTransactionTypeID] = @RefTransactionTypeID)) AND
            ((@ShipmentDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[ShipmentDate]) >= [dbo].[ValidateMinDate](@ShipmentDateFrom))) AND
            ((@ShipmentDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[ShipmentDate]) <= [dbo].[ValidateMaxDate](@ShipmentDateTo))) AND
            ((@ReceivedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[ReceivedDate]) >= [dbo].[ValidateMinDate](@ReceivedDateFrom))) AND
            ((@ReceivedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[ReceivedDate]) <= [dbo].[ValidateMaxDate](@ReceivedDateTo))) AND
            ((@LastPrintedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[LastPrintedDate]) >= [dbo].[ValidateMinDate](@LastPrintedDateFrom))) AND
            ((@LastPrintedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[LastPrintedDate]) <= [dbo].[ValidateMaxDate](@LastPrintedDateTo))) AND
            ((@DocumentStatusID IS NULL) OR ([DO].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDeliveryOrder]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDeliveryOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fDeliveryOrder] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDeliveryOrder]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [RefDocumentID],
            [RefTransactionTypeID],
            [RefTransactionTypeName],
            [ShipmentDate],
            [ReceivedDate],
            [PrintedCount],
            [LastPrintedDate],
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
			[dbo].[fDeliveryOrder]
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
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
