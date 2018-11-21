USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fPermissionObject]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fPermissionObject];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:31:56
-- Description   : Provide function to retrieve [dbo].[PermissionObject] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fPermissionObject]
(
    @ID nvarchar(256),
    @Description nvarchar(512)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PO].[ID],
            [PO].[Description],
            [PO].[CreatedDate],
            [CU].[ID] [CreatedByUserID],
            [CU].[Name] [CreatedByUserName]
        FROM
			[dbo].[PermissionObject] [PO] LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PO].[CreatedByUserID] = [CU].[ID])
		WHERE
            ((@ID IS NULL) OR ([PO].[ID] = @ID)) AND
            ((@Description IS NULL) OR ([PO].[Description] LIKE '%' + @Description + '%'))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vPermissionObject]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vPermissionObject];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 26 Jul 2016 22:31:56
-- Description   : Provide view (model) to retrieve [dbo].[fPermissionObject] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vPermissionObject]
AS
(
    SELECT
            [ID],
            [Description],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName]
        FROM
			[dbo].[fPermissionObject]
            (
                NULL,
                NULL
            )
);
GO