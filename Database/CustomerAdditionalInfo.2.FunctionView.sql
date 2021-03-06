USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerAdditionalInfo]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CustomerAdditionalInfo] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerAdditionalInfo]
(
    @CustomerID uniqueidentifier,
    @AdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CAI].[CustomerID],
            [CAI].[AdditionalInfo1],
            [CAI].[AdditionalInfo2],
            [CAI].[AdditionalInfo3],
            [CAI].[AdditionalInfo4],
            [CAI].[AdditionalInfo5],
            [CAI].[AdditionalInfo6],
            [CAI].[AdditionalInfo7],
            [CAI].[AdditionalInfo8],
            [CAI].[AdditionalInfo9],
            [CAI].[AdditionalInfo10] 
        FROM
			[dbo].[CustomerAdditionalInfo] [CAI]
		WHERE
            ((@CustomerID IS NULL) OR ([CAI].[CustomerID] = @CustomerID)) AND
            (
                (@AdditionalInfo IS NULL) OR
                (
                    ([CAI].[AdditionalInfo1] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo2] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo3] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo4] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo5] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo6] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo7] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo8] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo9] LIKE '%' + @AdditionalInfo + '%') OR
                    ([CAI].[AdditionalInfo10] LIKE '%' + @AdditionalInfo + '%')
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerAdditionalInfo]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerAdditionalInfo] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerAdditionalInfo]
AS
(
    SELECT
            [CustomerID],
            [AdditionalInfo1],
            [AdditionalInfo2],
            [AdditionalInfo3],
            [AdditionalInfo4],
            [AdditionalInfo5],
            [AdditionalInfo6],
            [AdditionalInfo7],
            [AdditionalInfo8],
            [AdditionalInfo9],
            [AdditionalInfo10] 
        FROM
			[dbo].[fCustomerAdditionalInfo]
            (
                NULL,
                NULL
            )
);
GO
