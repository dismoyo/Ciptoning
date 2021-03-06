USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCountry]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCountry];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:16:32
-- Description   : Provide function to retrieve [dbo].[Country] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCountry]
(
    @ID nchar(2),
    @Name nvarchar(128),
    @Alpha3Code nvarchar(3),
    @DialCode nvarchar(10)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [C].[ID],
            [C].[Name],
            [C].[Alpha3Code],
            [C].[DialCode]
        FROM
			[dbo].[Country] [C]
		WHERE
            ((@ID IS NULL) OR ([C].[ID] = @ID)) AND
            ((@Name IS NULL) OR ([C].[Name] LIKE '%' + @Name + '%')) AND
            ((@Alpha3Code IS NULL) OR ([C].[Alpha3Code] LIKE '%' + @Alpha3Code + '%')) AND
            ((@DialCode IS NULL) OR ([C].[DialCode] LIKE '%' + @DialCode + '%'))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCountry]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCountry];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:16:32
-- Description   : Provide view (model) to retrieve [dbo].[fCountry] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCountry]
AS
(
    SELECT
            [ID],
            [Name],
            [Alpha3Code],
            [DialCode]
        FROM
			[dbo].[fCountry]
            (
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
