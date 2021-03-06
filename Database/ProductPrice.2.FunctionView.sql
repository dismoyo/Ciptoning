USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProductPrice]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProductPrice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[ProductPrice] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProductPrice]
(
    @ID int,
    @Code nvarchar(20),
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ValidDateFrom datetime,
    @ValidDateTo datetime,
    @PriceGroupID int,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PP].[ID],
            [PP].[Code],
            [PP].[ProductID],
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
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            [PP].[ValidDateFrom],
            [PP].[ValidDateTo],
            [PP].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [PP].[GrossPrice],
            [PP].[TaxPercentage],
            [PP].[Price],
            [PP].[StatusID],
            [fSL2].[Name] [StatusName],
            [PP].[CreatedDate],
            [PP].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PP].[ModifiedDate],
            [PP].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [PP].[IsDeleted]
        FROM
			[dbo].[ProductPrice] [PP] INNER JOIN
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
            ) [fP] ON ([PP].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
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
            ) [fSL] ON ([PP].[PriceGroupID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
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
                'ProductPriceStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([PP].[StatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PP].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PP].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([PP].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([PP].[Code] LIKE '%' + @Code + '%')) AND
            (
                ([dbo].[ValidateMaxDate]([PP].[ValidDateFrom]) >= [dbo].[ValidateMinDate](@ValidDateFrom)) OR
                ([dbo].[ValidateMinDate]([PP].[ValidDateTo]) <= [dbo].[ValidateMaxDate](@ValidDateTo))
            ) AND
            ((@PriceGroupID IS NULL) OR ([PP].[PriceGroupID] = @PriceGroupID)) AND
            ((@StatusID IS NULL) OR ([PP].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([PP].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProductPrice]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProductPrice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fProductPrice] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProductPrice]
AS
(
    SELECT
            [ID],
            [Code],
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
            [ProductAdditionalInfo10],
            [ValidDateFrom],
            [ValidDateTo],
            [PriceGroupID],
            [PriceGroupName],
            [GrossPrice],
            [TaxPercentage],
            [Price],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fProductPrice]
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
                NULL
            )
);
GO
