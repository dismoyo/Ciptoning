USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSystemParameter]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSystemParameter];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[SystemParameter] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSystemParameter]
(
    @ID int,
    @Value nvarchar(10)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SP].[ID],
            [SP].[Description],
            [SP].[Value],
            [SP].[ModifiedDate],
            [SP].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SystemParameter] [SP] LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SP].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([SP].[ID] = @ID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSystemParameter]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSystemParameter];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fSystemParameter] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSystemParameter]
AS
(
    SELECT
            [ID],
            [Description],
            [Value],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSystemParameter]
            (
                NULL,
                NULL
            )
);
GO
