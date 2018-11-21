USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDiscountGroupProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDiscountGroupProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[DiscountGroupProduct] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDiscountGroupProduct]
(
    @DiscountGroupID int,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @DiscountStrataID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PD].[DiscountGroupID],
            [PD].[ProductID],
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
            [PD].[DiscountStrata1ID],
            [fDS1].[Code] [DiscountStrata1Code],
            [fDS1].[Name] [DiscountStrata1Name],
            [fDS1].[DiscountStrata] [DiscountStrata1],
            [fDS1].[ValidDateFrom] [DiscountStrata1ValidDateFrom],
            [fDS1].[ValidDateTo] [DiscountStrata1ValidDateTo],
            [fDS1].[StatusID] [DiscountStrata1StatusID],
            [fDS1].[StatusName] [DiscountStrata1StatusName],
            [PD].[DiscountStrata2ID],
            [fDS2].[Code] [DiscountStrata2Code],
            [fDS2].[Name] [DiscountStrata2Name],
            [fDS2].[DiscountStrata] [DiscountStrata2],
            [fDS2].[ValidDateFrom] [DiscountStrata2ValidDateFrom],
            [fDS2].[ValidDateTo] [DiscountStrata2ValidDateTo],
            [fDS2].[StatusID] [DiscountStrata2StatusID],
            [fDS2].[StatusName] [DiscountStrata2StatusName],
            [PD].[DiscountStrata3ID],
            [fDS3].[Code] [DiscountStrata3Code],
            [fDS3].[Name] [DiscountStrata3Name],
            [fDS3].[DiscountStrata] [DiscountStrata3],
            [fDS3].[ValidDateFrom] [DiscountStrata3ValidDateFrom],
            [fDS3].[ValidDateTo] [DiscountStrata3ValidDateTo],
            [fDS3].[StatusID] [DiscountStrata3StatusID],
            [fDS3].[StatusName] [DiscountStrata3StatusName],
            [PD].[DiscountStrata4ID],
            [fDS4].[Code] [DiscountStrata4Code],
            [fDS4].[Name] [DiscountStrata4Name],
            [fDS4].[DiscountStrata] [DiscountStrata4],
            [fDS4].[ValidDateFrom] [DiscountStrata4ValidDateFrom],
            [fDS4].[ValidDateTo] [DiscountStrata4ValidDateTo],
            [fDS4].[StatusID] [DiscountStrata4StatusID],
            [fDS4].[StatusName] [DiscountStrata4StatusName],
            [PD].[DiscountStrata5ID],
            [fDS5].[Code] [DiscountStrata5Code],
            [fDS5].[Name] [DiscountStrata5Name],
            [fDS5].[DiscountStrata] [DiscountStrata5],
            [fDS5].[ValidDateFrom] [DiscountStrata5ValidDateFrom],
            [fDS5].[ValidDateTo] [DiscountStrata5ValidDateTo],
            [fDS5].[StatusID] [DiscountStrata5StatusID],
            [fDS5].[StatusName] [DiscountStrata5StatusName]
        FROM
			[dbo].[DiscountGroupProduct] [PD] INNER JOIN
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
            ) [fP] ON ([PD].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS1] ON ([PD].[DiscountStrata1ID] = [fDS1].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS2] ON ([PD].[DiscountStrata2ID] = [fDS2].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS3] ON ([PD].[DiscountStrata3ID] = [fDS3].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS4] ON ([PD].[DiscountStrata4ID] = [fDS4].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS5] ON ([PD].[DiscountStrata5ID] = [fDS5].[ID])
		WHERE
            (
                (@DiscountStrataID IS NULL) OR
                (
                    ([PD].[DiscountStrata1ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata2ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata3ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata4ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata5ID] = @DiscountStrataID)
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDiscountGroupProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDiscountGroupProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fDiscountGroupProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDiscountGroupProduct]
AS
(
    SELECT
            [DiscountGroupID],
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
            [DiscountStrata1ID],
            [DiscountStrata1Code],
            [DiscountStrata1Name],
            [DiscountStrata1],
            [DiscountStrata1ValidDateFrom],
            [DiscountStrata1ValidDateTo],
            [DiscountStrata1StatusID],
            [DiscountStrata1StatusName],
            [DiscountStrata2ID],
            [DiscountStrata2Code],
            [DiscountStrata2Name],
            [DiscountStrata2],
            [DiscountStrata2ValidDateFrom],
            [DiscountStrata2ValidDateTo],
            [DiscountStrata2StatusID],
            [DiscountStrata2StatusName],
            [DiscountStrata3ID],
            [DiscountStrata3Code],
            [DiscountStrata3Name],
            [DiscountStrata3],
            [DiscountStrata3ValidDateFrom],
            [DiscountStrata3ValidDateTo],
            [DiscountStrata3StatusID],
            [DiscountStrata3StatusName],
            [DiscountStrata4ID],
            [DiscountStrata4Code],
            [DiscountStrata4Name],
            [DiscountStrata4],
            [DiscountStrata4ValidDateFrom],
            [DiscountStrata4ValidDateTo],
            [DiscountStrata4StatusID],
            [DiscountStrata4StatusName],
            [DiscountStrata5ID],
            [DiscountStrata5Code],
            [DiscountStrata5Name],
            [DiscountStrata5],
            [DiscountStrata5ValidDateFrom],
            [DiscountStrata5ValidDateTo],
            [DiscountStrata5StatusID],
            [DiscountStrata5StatusName]
        FROM
			[dbo].[fDiscountGroupProduct]
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
                NULL
            )
);
GO
