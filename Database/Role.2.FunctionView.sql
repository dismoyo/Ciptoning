USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fRole]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fRole];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:28:57
-- Description   : Provide function to retrieve [dbo].[Role] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fRole]
(
    @ID int,
    @Name nvarchar(256),
    @Description nvarchar(512),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [R].[ID],
            [R].[Name],
            [R].[Description],
            [R].[CreatedDate],
            [R].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [R].[ModifiedDate],
            [R].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [R].[IsDeleted]
        FROM
			[dbo].[Role] [R] LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([R].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([R].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([R].[ID] = @ID)) AND
            ((@Name IS NULL) OR ([R].[Name] LIKE '%' + @Name + '%')) AND
            ((@Description IS NULL) OR ([R].[Description] LIKE '%' + @Description + '%')) AND
            ((@IsDeleted IS NULL) OR ([R].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vRole]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vRole];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:28:57
-- Description   : Provide view (model) to retrieve [dbo].[fRole] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vRole]
AS
(
    SELECT
            [ID],
            [Name],
            [Description],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fRole]
            (
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO