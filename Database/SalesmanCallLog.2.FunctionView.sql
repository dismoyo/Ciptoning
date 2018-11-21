USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesmanCallLog]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesmanCallLog];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesmanCallLog] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesmanCallLog]
(
    @ID uniqueidentifier,
    @SalesmanID uniqueidentifier,
    @CallDateFrom datetime,
    @CallDateTo datetime,
    @CustomerID uniqueidentifier,
    @CheckedDateFrom datetime,
    @CheckedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SCL].[ID],
            [SCL].[SalesmanCallID],            
            [SC].[SalesmanID],
            [SC].[CallDate],
            [SC].[CustomerID],
            [SCL].[CheckedDate],
            [SCL].[CheckedLongitude],
            [SCL].[CheckedLatitude],
            [SCL].[IsCheckedIn],
            [SCL].[CreatedDate],
            [SCL].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName]
        FROM
			[dbo].[SalesmanCallLog] [SCL] INNER JOIN
            [dbo].[SalesmanCall] [SC] ON ([SCL].[SalesmanCallID] = [SC].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SCL].[CreatedByUserID] = [CU].[ID])
		WHERE
            ((@SalesmanID IS NULL) OR (@SalesmanID = [SC].[ID])) AND
            ((@CallDateFrom IS NULL) OR ([dbo].[ConvertToFirstTimeOfDay]([SC].[CallDate]) >= [dbo].[ConvertToFirstTimeOfDay](@CallDateFrom))) AND
            ((@CallDateTo IS NULL) OR ([dbo].[ConvertToLastTimeOfDay]([SC].[CallDate]) <= [dbo].[ConvertToLastTimeOfDay](@CallDateTo))) AND
            ((@CustomerID IS NULL) OR ([SC].[CustomerID] = @CustomerID)) AND
            ((@CheckedDateFrom IS NULL) OR ([SCL].[CheckedDate] >= [dbo].[ConvertToFirstTimeOfDay](@CheckedDateFrom))) AND
            ((@CheckedDateTo IS NULL) OR ([SCL].[CheckedDate] <= [dbo].[ConvertToLastTimeOfDay](@CheckedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesmanCallLog]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesmanCallLog];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesmanCallLog] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesmanCallLog]
AS
(
    SELECT
            [ID],
            [SalesmanCallID],            
            [SalesmanID],
            [CallDate],
            [CustomerID],
            [CheckedDate],
            [CheckedLongitude],
            [CheckedLatitude],
            [IsCheckedIn],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName]
        FROM
			[dbo].[fSalesmanCallLog]
            (
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
