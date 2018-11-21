USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesmanProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesmanProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[SalesmanProduct] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesmanProduct]
(
    @SalesmanID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)   
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SP].[SalesmanID],
            [SP].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10]
        FROM
			[dbo].[SalesmanProduct] [SP] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SP].[ProductID] = [fP].[ID])
		WHERE
            ((@SalesmanID IS NULL) OR ([SP].[SalesmanID] = @SalesmanID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesmanProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesmanProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fSalesmanProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesmanProduct]
AS
(
    SELECT
            [SalesmanID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10]
        FROM
			[dbo].[fSalesmanProduct]
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
                NULL                
            )
);
GO