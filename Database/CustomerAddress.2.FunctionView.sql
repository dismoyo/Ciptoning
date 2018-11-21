USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerAddress]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CustomerAddress] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerAddress]
(
    @CustomerID uniqueidentifier,
    @Address nvarchar(100),
    @City nvarchar(50),
    @StateProvince nvarchar(50),
    @CountryID int,
    @CountryName nvarchar(50),
    @ZipCode nvarchar(10),
    @Phone1 nvarchar(20),
    @Phone2 nvarchar(20),
    @Phone3 nvarchar(20),
    @Fax nvarchar(20),
    @Email nvarchar(256)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CA].[CustomerID],
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
            [CA].[Phone3],
            [CA].[Fax],
            [CA].[Email],
            [CA].[Longitude],
            [CA].[Latitude]
        FROM
			[dbo].[CustomerAddress] [CA] INNER JOIN
            [dbo].[fCountry]
            (
                @CountryID,
                @CountryName,
                NULL,
                NULL
            ) [fC] ON ([CA].[CountryID] = [fC].[ID])
		WHERE
            ((@CustomerID IS NULL) OR ([CA].[CustomerID] = @CustomerID)) AND
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
            ((@Phone3 IS NULL) OR ([CA].[Phone3] LIKE '%' + @Phone3 + '%')) AND
            ((@Fax IS NULL) OR ([CA].[Fax] LIKE '%' + @Fax + '%')) AND
            ((@Email IS NULL) OR ([CA].[Email] LIKE '%' + @Email + '%'))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerAddress]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerAddress] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerAddress]
AS
(
    SELECT
            [CustomerID],
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
            [Phone3],
            [Fax],
            [Email],
            [Longitude],
            [Latitude]
        FROM
			[dbo].[fCustomerAddress]
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
                NULL
            )
);
GO