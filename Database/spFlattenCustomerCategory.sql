USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spFlattenCustomerCategory]') AND type IN ( N'P'))
    DROP PROCEDURE [dbo].[spFlattenCustomerCategory];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 7 Jun 2016 23:32:11
-- Description   : Provide procedure to flatten customer category.
-- 
-- ===================================================================================

CREATE PROCEDURE [dbo].[spFlattenCustomerCategory]
(
    @CategoryID int,
    @FlattenCategory nvarchar(512) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @FlattenCategory = '';
    DECLARE @ParentID int = @CategoryID;
    
    WHILE (@ParentID IS NOT NULL)
    BEGIN
        SELECT
                @FlattenCategory = @FlattenCategory + [Category] + ';',
                @ParentID = [ParentID]
            FROM
                [dbo].[fCustomerCategory]
                (
                    @ParentID,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL
                );
    END;

    RETURN;
END;
GO
