USE [IDOS_DEV];
GO



DELETE FROM [dbo].[Invoice];
GO
DELETE FROM [dbo].[PurchaseOrder];
GO
DELETE FROM [dbo].[DeliveryOrder];
GO



DELETE FROM [dbo].[SalesOrderSwapExt];
GO
DELETE FROM [dbo].[SalesOrderSwapDetails];
GO
DELETE FROM [dbo].[SalesOrderSwapSummary];
GO
DELETE FROM [dbo].[SalesOrderSwap];
GO



DELETE FROM [dbo].[SalesOrderReturnExt];
GO
DELETE FROM [dbo].[SalesOrderReturnDetails];
GO
DELETE FROM [dbo].[SalesOrderReturnSummary];
GO
DELETE FROM [dbo].[SalesOrderReturn];
GO



DELETE FROM [dbo].[SalesOrderFOCExt];
GO
DELETE FROM [dbo].[SalesOrderFOCDetails];
GO
DELETE FROM [dbo].[SalesOrderFOCSummary];
GO
DELETE FROM [dbo].[SalesOrderFOC];
GO



DELETE FROM [dbo].[SalesOrderSampleExt];
GO
DELETE FROM [dbo].[SalesOrderSampleDetails];
GO
DELETE FROM [dbo].[SalesOrderSampleSummary];
GO
DELETE FROM [dbo].[SalesOrderSample];
GO



DELETE FROM [dbo].[SalesOrderExt];
GO
DELETE FROM [dbo].[SalesOrderDetails];
GO
DELETE FROM [dbo].[SalesOrderSummary];
GO
DELETE FROM [dbo].[SalesOrder];
GO



DELETE FROM [dbo].[StockTransferDetails];
GO
DELETE FROM [dbo].[StockTransferSummary];
GO
DELETE FROM [dbo].[StockTransfer];
GO



DELETE FROM [dbo].[StockDisposalDetails];
GO
DELETE FROM [dbo].[StockDisposalSummary];
GO
DELETE FROM [dbo].[StockDisposal];
GO



DELETE FROM [dbo].[StockChangesDetails];
GO
DELETE FROM [dbo].[StockChangesSummary];
GO
DELETE FROM [dbo].[StockChanges];
GO



DELETE FROM [dbo].[StockOpnameDetails];
GO
DELETE FROM [dbo].[StockOpnameSummary];
GO
DELETE FROM [dbo].[StockOpname];
GO



DELETE FROM [dbo].[StockReceiveDetails];
GO
DELETE FROM [dbo].[StockReceiveSummary];
GO
DELETE FROM [dbo].[StockReceive];
GO



DELETE FROM [dbo].[RoutePlan];
GO



--DELETE FROM [dbo].[CustomerCategory];
--GO
--DBCC CHECKIDENT (CustomerCategory, RESEED, 0);
--GO
--DELETE FROM [dbo].[CustomerCategoryInfo];
--GO
--DELETE FROM [dbo].[CustomerAdditionalInfo];
--GO
--DELETE FROM [dbo].[CustomerTaxAddress];
--GO
--DELETE FROM [dbo].[CustomerBillAddress];
--GO
--DELETE FROM [dbo].[CustomerAddress];
--GO
--DELETE FROM [dbo].[Customer];
--GO



--DELETE FROM [dbo].[SalesmanTarget];
--GO
--DELETE FROM [dbo].[SalesmanProduct];
--GO
--DELETE FROM [dbo].[Salesman];
--GO



DELETE FROM [dbo].[StockOnHandPeriodic];
GO
DELETE FROM [dbo].[StockTransaction];
GO



--DELETE FROM [dbo].[Warehouse];
--GO



DELETE FROM [dbo].[AutoNumberCounter];
GO



--DELETE FROM [dbo].[SiteProduct];
--GO
--DELETE FROM [dbo].[SiteAdditionalInfo];
--GO
--DELETE FROM [dbo].[SiteAddress];
--GO
--DELETE FROM [dbo].[Site];
--GO



--DELETE FROM [dbo].[CompanyAddress];
--GO
--DELETE FROM [dbo].[Company];
--GO
--DBCC CHECKIDENT (Company, RESEED, 0);
--GO



--DELETE FROM [dbo].[Area];
--GO
--DBCC CHECKIDENT (Area, RESEED, 0);
--GO



--DELETE FROM [dbo].[Region];
--GO
--DBCC CHECKIDENT (Region, RESEED, 0);
--GO



--DELETE FROM [dbo].[Territory];
--GO
--DBCC CHECKIDENT (Territory, RESEED, 0);
--GO



--DELETE FROM [dbo].[DiscountGroupProduct];
--GO
--DELETE FROM [dbo].[DiscountStrataDetails];
--GO
--DELETE FROM [dbo].[DiscountStrata];
--GO
--DELETE FROM [dbo].[DiscountGroup];
--GO



--DELETE FROM [dbo].[ProductLot];
--GO
--DBCC CHECKIDENT (ProductLot, RESEED, 0);
--GO
--DELETE FROM [dbo].[ProductPrice];
--GO
--DBCC CHECKIDENT (ProductPrice, RESEED, 0);
--GO
--DELETE FROM [dbo].[ProductAdditionalInfo];
--GO
--DELETE FROM [dbo].[Product];
--GO
--DBCC CHECKIDENT (Product, RESEED, 0);
--GO
--DELETE FROM [dbo].[ProductBrand];
--GO
--DBCC CHECKIDENT (ProductBrand, RESEED, 0);
--GO



--DELETE FROM [dbo].[Country];
--GO

--DELETE FROM [dbo].[SystemLookup];
--GO
--DBCC CHECKIDENT (SystemLookup, RESEED, 0);
--GO

--DELETE FROM [dbo].[SystemParameter];
--GO

--DELETE FROM [dbo].[User];
--GO
--DBCC CHECKIDENT ([User], RESEED, 0);
--GO
