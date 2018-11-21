USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spReportSellOutSummary]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spReportSellOutSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to create [dbo].[ReportSellOutSummary] data.
-- ===================================================================================

CREATE PROCEDURE [dbo].[spReportSellOutSummary]
(
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SiteID uniqueidentifier
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @date datetime = '2016-07-01'; -- iDOS 2.0 Live Start Date
    IF ((@TransactionDateFrom IS NULL) OR (@TransactionDateFrom <= @date))
        SET @TransactionDateFrom = @date;
    
    SET @date = GETUTCDATE();
    IF ((@TransactionDateTo IS NULL) OR (@TransactionDateTo >= @date))
        SET @TransactionDateTo = @date;

    SET @TransactionDateFrom = [dbo].[ConvertToFirstTimeOfDay](@TransactionDateFrom);
    SET @TransactionDateTo = [dbo].[ConvertToLastTimeOfDay](@TransactionDateTo);

    DELETE FROM
            [dbo].[ReportSellOutSummary]
        WHERE
            ([ReportDate] >= @TransactionDateFrom) AND
            ([ReportDate] <= @TransactionDateTo) AND
            ((@SiteID IS NULL) OR ([SiteID] = @SiteID));
    
    INSERT INTO
            [dbo].[ReportSellOutSummary]
        SELECT
                [dbo].[ConvertToFirstTimeOfDay]([SO].[TransactionDate]) [ReportDate],
                [SO].[DocumentID] [SODocumentID],
                [SOS].[ProductID],
                [SO].[DocumentCode] [SODocumentCode],
                NULL [TaxInvoiceCode], ---------------------------------------
                NULL [SFADocumentCode], ---------------------------------------                
                [R].[TerritoryID],
                [dbo].[fCodeNameFormatter]([SOX].[TerritoryCode], [SOX].[TerritoryName]) [Territory],
                [A].[RegionID],
                [dbo].[fCodeNameFormatter]([SOX].[RegionCode], [SOX].[RegionName]) [Region],
                [ST].[AreaID],
                [dbo].[fCodeNameFormatter]([SOX].[AreaCode], [SOX].[AreaName]) [Area],
                [ST].[CompanyID],
                [dbo].[fCodeNameFormatter]([SOX].[CompanyCode], [SOX].[CompanyName]) [Company],
                [W].[SiteID],
                [dbo].[fCodeNameFormatter]([SOX].[SiteCode], [SOX].[SiteName]) [Site],
                [SO].[WarehouseID],
                [dbo].[fCodeNameFormatter]
                (
                    [SOX].[WarehouseCode],
                    (SELECT CASE WHEN [W].[TypeID] = 1 THEN '[' + [fSL].[Name] + '] ' ELSE '' END) + [SOX].[WarehouseName]
                ) [Warehouse],
                [SO].[SalesmanID],
                [dbo].[fCodeNameFormatter]([SOX].[SalesmanCode], [SOX].[SalesmanName]) [Salesman],
                [SO].[CustomerID],
                [dbo].[fCodeNameFormatter]([SOX].[CustomerCode], [SOX].[CustomerName]) [Customer],
                (                    
                    SELECT CASE
                        WHEN (CHARINDEX(';', [SOX].[CustomerCategory1]) > 0) THEN SUBSTRING([SOX].[CustomerCategory1], 1, CHARINDEX(';', [SOX].[CustomerCategory1]) - 1)
                        ELSE ''
                    END
                ) [CategoryCustomerType],                    
                (SELECT CASE WHEN ([SO].[TermOfPaymentID] = 1) THEN [SO].[Total] ELSE NULL END) [CashPaymentAmount],
                (SELECT CASE WHEN ([SO].[TermOfPaymentID] > 1) THEN [SO].[Total] ELSE NULL END) [CreditPaymentAmount], -------------
                NULL [CreditDueDate], ----------------------------------
                NULL [TrxFormBankName], ----------------------------------
                NULL [TrxFormCode], ----------------------------------
                NULL [TrxFormDueDate], ----------------------------------
                NULL [TrxFormAmount], ----------------------------------
                NULL [AdditionalCharge], ----------------------------------
                NULL [CreditBalance], ----------------------------------
                [SO].[Total] [TotalSalesOrder],
                [PB].[ID] [ProductBrandID],
                [dbo].[fCodeNameFormatter]([PB].[Code], [PB].[Name]) [ProductBrand],
                [P].[ShortName] [ProductShortName],
                ([SOS].[Qty] * -1) [Qty]
            FROM
                [dbo].[SalesOrder] [SO] INNER JOIN
                [dbo].[SalesOrderExt] [SOX] ON ([SO].[DocumentID] = [SOX].[DocumentID]) INNER JOIN
                [dbo].[SalesOrderSummary] [SOS] ON ([SO].[DocumentID] = [SOS].[DocumentID]) INNER JOIN                                        
                [dbo].[Warehouse] [W] ON ([SO].[WarehouseID] = [W].[ID]) LEFT OUTER JOIN
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
                    'WarehouseType',
                    NULL,
                    NULL,
                    NULL
                ) [fSL] ON ([W].[TypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
                [dbo].[Site] [ST] ON ([W].[SiteID] = [ST].[ID]) LEFT OUTER JOIN
                [dbo].[Company] [CP] ON ([ST].[CompanyID] = [CP].[ID]) LEFT OUTER JOIN
                [dbo].[Area] [A] ON ([ST].[AreaID] = [A].[ID]) LEFT OUTER JOIN
                [dbo].[Region] [R] ON ([A].[RegionID] = [R].[ID]) INNER JOIN
                [dbo].[Product] [P] ON ([SOS].[ProductID] = [P].[ID]) INNER JOIN
                [dbo].[ProductBrand] [PB] ON ([P].[BrandID] = [PB].[ID])
            WHERE
                ([SO].[DocumentStatusID] = 2) AND
                ([SO].[TransactionDate] >= @TransactionDateFrom) AND
                ([SO].[TransactionDate] <= @TransactionDateTo) AND
                ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID))
END;
GO
