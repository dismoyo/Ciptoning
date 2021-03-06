USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fLookupSOCustomer]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fLookupSOCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Customer] data as a lookup.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fLookupSOCustomer]
(
    @ID uniqueidentifier,
    @Customer nvarchar(80),
    @Address nvarchar(310),
    @Category1 nvarchar(50),
    @SiteID uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [C].[ID],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [dbo].[fAddressFormatter]([CA].[Address1], [CA].[Address2], [CA].[Address3]) [Address],
            [dbo].[fCodeNameFormatter]([CC].[Code], [CC].[Name]) [Category1],
            [C].[SalesmanID],
            [W].[ID] [WarehouseID],
            [C].[TermOfPaymentID],
            [C].[PriceGroupID],
            [C].[DiscountGroupID],
            [W].[SiteID]
        FROM
			[dbo].[Customer] [C] INNER JOIN
            [dbo].[CustomerAddress] [CA] ON ([C].[ID] = [CA].[CustomerID]) INNER JOIN
            [dbo].[CustomerCategoryInfo] [CCI] ON ([C].[ID] = [CCI].[CustomerID]) LEFT OUTER JOIN
            [dbo].[CustomerCategory] [CC] ON ([CCI].[Category1ID] = [CC].[ID]) LEFT OUTER JOIN
            [dbo].[Salesman] [S] ON ([C].[SalesmanID] = [S].[ID]) LEFT OUTER JOIN
            [dbo].[Warehouse] [W] ON ([S].[WarehouseID] = [W].[ID])
		WHERE
            ((@ID IS NULL) OR ([C].[ID] = @ID)) AND
            ((@Customer IS NULL) OR ([dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) LIKE '%' + @Customer + '%')) AND
            ((@Address IS NULL) OR ([dbo].[fAddressFormatter]([CA].[Address1], [CA].[Address2], [CA].[Address3]) LIKE '%' + @Address + '%')) AND
            ((@Category1 IS NULL) OR ([dbo].[fCodeNameFormatter]([CC].[Code], [CC].[Name]) LIKE '%' + @Category1 + '%')) AND
            ((@SiteID IS NULL) OR ([W].[SiteID] = @SiteID)) AND
            ([C].[IsDeleted] = 0)
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vLookupSOCustomer]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vLookupSOCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fLookupSOCustomer] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vLookupSOCustomer]
AS
(
    SELECT
            [ID],
            [Customer],
            [Address],
            [Category1],
            [SalesmanID],
            [WarehouseID],
            [TermOfPaymentID],
            [PriceGroupID],
            [DiscountGroupID],
            [SiteID]
        FROM
			[dbo].[fLookupSOCustomer]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
