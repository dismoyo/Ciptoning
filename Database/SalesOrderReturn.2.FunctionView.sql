USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderReturn]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderReturn];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderReturn] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderReturn]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @TermOfPaymentID int,
    @ReferenceNumber nvarchar(30),
    @ReasonID int,
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @InvoiceDocumentID uniqueidentifier,
    @InvoiceDocumentCode nvarchar(30),    
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @SFAInvoiceDocumentCode nvarchar(30),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOR].[DocumentID],
            [SOR].[DocumentCode],
            [SOR].[TransactionDate],
            [SOR].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SOR].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SOR].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SOR].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [SOR].[DiscountGroupID],
            [DG].[Code] [DiscountGroupCode],
            [DG].[Name] [DiscountGroupName],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description] [DiscountGroupDescription],
            [SOR].[TermOfPaymentID],
            [fSL2].[Name] [TermOfPaymentName],            
            [SOR].[ReferenceNumber],
            [SOR].[ReasonID],
            [fSL3].[Name] [ReasonName],
            [SOR].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SOR].[InvoiceDocumentID],
            [I].[DocumentCode] [InvoiceDocumentCode],
            [SOR].[RawTotalGrossPrice],    
            [SOR].[RawTotalPrice],
            [SOR].[RawTotalDiscountStrata1Amount],
            [SOR].[RawTotalDiscountStrata2Amount],
            [SOR].[RawTotalDiscountStrata3Amount],
            [SOR].[RawTotalDiscountStrata4Amount],
            [SOR].[RawTotalDiscountStrata5Amount],
            [SOR].[RawTotalAddDiscountStrataAmount],
            [SOR].[RawTotalGross],
            [SOR].[RawTotalTax],
            [SOR].[RawTotal],
            [SOR].[TotalGrossPrice],    
            [SOR].[TotalPrice],
            [SOR].[TotalDiscountStrata1Amount],
            [SOR].[TotalDiscountStrata2Amount],
            [SOR].[TotalDiscountStrata3Amount],
            [SOR].[TotalDiscountStrata4Amount],
            [SOR].[TotalDiscountStrata5Amount],
            [SOR].[TotalAddDiscountStrataAmount],
            [SOR].[TotalGross],
            [SOR].[TotalTax],
            [SOR].[Total],
            [SOR].[TotalWeight],
            [SOR].[TotalDimension],
            [SOR].[AddDiscountStrataReason],
            [SOR].[DocumentStatusID],
            [fSL4].[Name] [DocumentStatusName],
            [SOR].[DocumentStatusReason],
            [SOR].[SFAInvoiceDocumentCode],
            [SOR].[PrintCount],
            [SOR].[PostedDate],
            [SOR].[CreatedDate],
            [SOR].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SOR].[ModifiedDate],
            [SOR].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrderReturn] [SOR] INNER JOIN
            [dbo].[Salesman] [S] ON ([SOR].[SalesmanID] = [S].[ID]) INNER JOIN            
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SOR].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SOR].[CustomerID] = [C].[ID]) LEFT OUTER JOIN
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SOR].[PriceGroupID] = [fSL].[Value_Int32]) INNER JOIN
            [dbo].[DiscountGroup] [DG] ON ([SOR].[DiscountGroupID] = [DG].[ID]) LEFT OUTER JOIN
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SOR].[TermOfPaymentID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SOR].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[Invoice] [I] ON ([SOR].[InvoiceDocumentID] = [I].[DocumentID]) LEFT OUTER JOIN
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
                'SOReturnReason',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SOR].[ReasonID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
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
            ) [fSL4] ON ([SOR].[DocumentStatusID] = [fSL4].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SOR].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SOR].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOR].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SOR].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([SOR].[TransactionDate] >= [dbo].[ConvertToFirstTimeOfDay](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([SOR].[TransactionDate] <= [dbo].[ConvertToLastTimeOfDay](@TransactionDateTo))) AND
            ((@SalesmanID IS NULL) OR ([SOR].[SalesmanID] = @SalesmanID)) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND            
            ((@WarehouseID IS NULL) OR ([SOR].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SOR].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@PriceGroupID IS NULL) OR ([SOR].[PriceGroupID] = @PriceGroupID)) AND
            ((@DiscountGroupID IS NULL) OR ([SOR].[DiscountGroupID] = @DiscountGroupID)) AND
            ((@DiscountGroupCode IS NULL) OR ([DG].[Code] LIKE '%' + @DiscountGroupCode + '%')) AND
            ((@DiscountGroupName IS NULL) OR ([DG].[Name] LIKE '%' + @DiscountGroupName + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([SOR].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@ReferenceNumber IS NULL) OR ([SOR].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SOR].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@InvoiceDocumentID IS NULL) OR ([SOR].[InvoiceDocumentID] = @InvoiceDocumentID)) AND
            ((@InvoiceDocumentCode IS NULL) OR ([I].[DocumentCode] LIKE '%' + @InvoiceDocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SOR].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SOR].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@SFAInvoiceDocumentCode IS NULL) OR ([SOR].[SFAInvoiceDocumentCode] LIKE '%' + @SFAInvoiceDocumentCode + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOR].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOR].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderReturn]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderReturn];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderReturn] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderReturn]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [TermOfPaymentID],
            [TermOfPaymentName],            
            [ReferenceNumber],
            [ReasonID],
            [ReasonName],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [InvoiceDocumentID],
            [InvoiceDocumentCode],
            [RawTotalGrossPrice],    
            [RawTotalPrice],
            [RawTotalDiscountStrata1Amount],
            [RawTotalDiscountStrata2Amount],
            [RawTotalDiscountStrata3Amount],
            [RawTotalDiscountStrata4Amount],
            [RawTotalDiscountStrata5Amount],
            [RawTotalAddDiscountStrataAmount],
            [RawTotalGross],
            [RawTotalTax],
            [RawTotal],
            [TotalGrossPrice],    
            [TotalPrice],
            [TotalDiscountStrata1Amount],
            [TotalDiscountStrata2Amount],
            [TotalDiscountStrata3Amount],
            [TotalDiscountStrata4Amount],
            [TotalDiscountStrata5Amount],
            [TotalAddDiscountStrataAmount],
            [TotalGross],
            [TotalTax],
            [Total],
            [TotalWeight],
            [TotalDimension],
            [AddDiscountStrataReason],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [SFAInvoiceDocumentCode],
            [PrintCount],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrderReturn]
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
