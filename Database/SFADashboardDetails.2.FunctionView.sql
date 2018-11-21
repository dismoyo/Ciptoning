USE [IDOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSFADashboardDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSFADashboardDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 14 Des 2016 11:20:01
-- Description   : -
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSFADashboardDetails]
(
    @SalesmanID uniqueidentifier,
	@TransactionDate Date
)
RETURNS TABLE 
AS
RETURN 
(
	WITH 
		RO
		AS
		(
			SELECT count(1) TotalRO
			  FROM [dbo].[Customer]
			  where SalesmanID = @SalesmanID
			  and RegisteredDate < [dbo].converttofirstdayofmonth(@TransactionDate)
			  and StatusID > 0
			  and ISDeleted = 0
		)	
		SELECT
			@SalesmanID SalesmanID
			, @TransactionDate TransactionDate
			, a.ID ProductID
			, b.AdditionalInfo2 [ProductGroup]
			, ISNULL([SalesOrderQty], 0) SalesOrderQty
			, ISNULL([CustomerTransaction] * (SELECT TotalRO FROM RO)/100, 0) TargetCustomerTransaction
			, ISNULL([CustomerTransaction] * (SELECT TotalRO FROM RO)/100 * [EffectiveCall], 0) TargetEC
			, ISNULL(TotalOtProduct, 0) ActualCustomerTransaction
			, ISNULL(TotalEcProduct, 0) ActualEC
		FROM 
			[dbo].[Product] a
		left join 
			[dbo].[ProductAdditionalInfo] b
			on a.ID = b.ProductID
		left join 
			[dbo].[SalesmanProductTarget] c
			on a.ID = c.ProductID
		left join 
			(
				SELECT az.ProductID, count(1) TotalOtProduct FROM (
					SELECT a.ProductID
					  FROM [dbo].[SalesOrderSummary] a
					  join [dbo].[SalesOrder] b on a.DocumentID = b.DocumentID
					  where MONTH(b.CreatedDate) = MONTH(@TransactionDate)
					  and YEAR(b.CreatedDate) = YEAR(@TransactionDate)
					  and b.CreatedDate <> @TransactionDate
					  and b.SalesmanID = @SalesmanID
					  group by a.ProductID, b.CustomerID
				) az group by az.ProductID
			) TotalOt
			on TotalOt.ProductID = a.ID
		left join 
			(
				SELECT az.ProductID, count(1) TotalEcProduct FROM (
					SELECT a.ProductID
					  FROM [dbo].[SalesOrderSummary] a
					  join [dbo].[SalesOrder] b on a.DocumentID = b.DocumentID
					  where MONTH(b.CreatedDate) = MONTH(@TransactionDate)
					  and YEAR(b.CreatedDate) = YEAR(@TransactionDate)
					  and b.CreatedDate <> @TransactionDate
					  and b.SalesmanID = @SalesmanID
					  group by a.ProductID, b.CustomerID, TransactionDate
				) az group by az.ProductID
			) TotalEc
			on TotalEc.ProductID = a.ID
		where c.SalesmanID = @SalesmanID
		  and MONTH(c.PeriodID) = MONTH(@TransactionDate)
		  and YEAR(c.PeriodID) = YEAR(@TransactionDate)
);

GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSFADashboardDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSFADashboardDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSFADashboardDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSFADashboardDetails]
AS
(
    SELECT
			SalesmanID
			, TransactionDate
			, ProductID
			, ProductGroup 
			, SalesOrderQty
			, TargetCustomerTransaction
			, TargetEC
			, ActualCustomerTransaction
			, ActualEC
        FROM
			[dbo].[fSFADashboardDetails]
            (
                NULL,
                NULL
            )
);
GO
