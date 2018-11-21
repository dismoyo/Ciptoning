USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCompanyAddress]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCompanyAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CompanyAddress] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCompanyAddress]
(
    @CompanyID int,
    @Address nvarchar(100),
    @City nvarchar(50),
    @StateProvince nvarchar(50),
    @CountryID int,
    @CountryName nvarchar(50),
    @ZipCode nvarchar(10),
    @Phone1 nvarchar(20),
    @Phone2 nvarchar(20),
    @Fax nvarchar(20),
    @Email nvarchar(256)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CA].[CompanyID],
            [CA].[Address1],
            [CA].[Address2],
            [CA].[Address3],
            [dbo].[fAddressFormatter]([CA].[Address1], [CA].[Address2], [CA].[Address3]) [Address],
            [CA].[City],
            [CA].[StateProvince],
            [CA].[CountryID],
            [fC].[Name] [CountryName],
            [CA].[ZipCode],
            [CA].[Phone1],
            [CA].[Phone2],
            [CA].[Fax],
            [CA].[Email]            
        FROM
			[dbo].[CompanyAddress] [CA] INNER JOIN
            [dbo].[fCountry]
            (
                @CountryID,
                @CountryName,
                NULL,
                NULL
            ) [fC] ON ([CA].[CountryID] = [fC].[ID])
		WHERE
            ((@CompanyID IS NULL) OR ([CA].[CompanyID] = @CompanyID)) AND
            (
                (@Address IS NULL) OR
                (
                    ([CA].[Address1] LIKE '%' + @Address + '%') OR
                    ([CA].[Address2] LIKE '%' + @Address + '%') OR
                    ([CA].[Address3] LIKE '%' + @Address + '%')
                )
            ) AND
            ((@City IS NULL) OR ([CA].[City] LIKE '%' + @City + '%')) AND
            ((@StateProvince IS NULL) OR ([CA].[StateProvince] LIKE '%' + @StateProvince + '%')) AND
            ((@ZipCode IS NULL) OR ([CA].[ZipCode] LIKE '%' + @ZipCode + '%')) AND
            ((@Phone1 IS NULL) OR ([CA].[Phone1] LIKE '%' + @Phone1 + '%')) AND
            ((@Phone2 IS NULL) OR ([CA].[Phone2] LIKE '%' + @Phone2 + '%')) AND
            ((@Fax IS NULL) OR ([CA].[Fax] LIKE '%' + @Fax + '%')) AND
            ((@Email IS NULL) OR ([CA].[Email] LIKE '%' + @Email + '%'))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCompanyAddress]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCompanyAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCompanyAddress] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCompanyAddress]
AS
(
    SELECT
            [CompanyID],
            [Address1],
            [Address2],
            [Address3],
            [Address],
            [City],
            [StateProvince],
            [CountryID],
            [CountryName],
            [ZipCode],
            [Phone1],
            [Phone2],
            [Fax],
            [Email]            
        FROM
			[dbo].[fCompanyAddress]
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
