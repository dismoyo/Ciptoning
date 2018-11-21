USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spRoutePlanCurrentWeek]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spRoutePlanCurrentWeek];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide procedure to update route plan current week.
-- ===================================================================================

CREATE PROCEDURE [dbo].[spRoutePlanCurrentWeek]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[SystemParameter]
    SET
        [Value] = (CASE WHEN [Value] = 1 THEN 2 ELSE 1 END),
        [ModifiedDate] = GETUTCDATE(),
        [ModifiedByUserID] = NULL
    WHERE
        [ID] = 'RoutePlan.CurrentWeek';
END;
GO
