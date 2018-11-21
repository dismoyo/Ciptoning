USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCodeNameFormatter]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCodeNameFormatter];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-02-18
-- Description:	 Return string in a code name format.
--
-- ==========================================================================================
CREATE FUNCTION [dbo].[fCodeNameFormatter]
(
    @code nvarchar(30),
    @name nvarchar(50)
)
RETURNS nvarchar(60)
AS
BEGIN
	RETURN (@code + ' - ' + @name);
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fAddressFormatter]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fAddressFormatter];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Return string in an address format.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[fAddressFormatter]
(
    @address1 nvarchar(100),
    @address2 nvarchar(100),
    @address3 nvarchar(100)
)
RETURNS nvarchar(300)
AS
BEGIN
	RETURN
    (
        ISNULL(@address1, '') +
        (SELECT CASE WHEN (LEN(ISNULL(@address2, '')) > 0) THEN  '. ' ELSE '' END) + ISNULL(@address2, '') +
        (SELECT CASE WHEN (LEN(ISNULL(@address3, '')) > 0) THEN  '. ' ELSE '' END) + ISNULL(@address3, '')
    );
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertLocalToUTC]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertLocalToUTC];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert from local datetime to UTC datetime.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertLocalToUTC]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN DATEADD(mi, DATEDIFF(mi, GETDATE(), GETUTCDATE()), @value);
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToFirstTimeOfDay]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToFirstTimeOfDay];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the first time of day.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToFirstTimeOfDay]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN DATEADD(dd, 0, DATEDIFF(dd, 0, @value));
END;
GO


IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToFirstDayOfMonth]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToFirstDayOfMonth];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the first day of month.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToFirstDayOfMonth]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN DATEADD(MONTH, DATEDIFF(MONTH, 0, @value), 0);
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToLastTimeOfDay]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToLastTimeOfDay];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the last time of day.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToLastTimeOfDay]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	DECLARE @ticks int = DATEDIFF(dd, -1, @value);
	DECLARE @maxTicks int = DATEDIFF(dd, 0, [dbo].[GetMaxDate]());

	IF (@ticks > @maxTicks)
		RETURN [dbo].[GetMaxDate]();

	RETURN DATEADD(ms, -3, @ticks);
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToLastDayOfMonth]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToLastDayOfMonth];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the last day of month.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToLastDayOfMonth]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	DECLARE @month int = DATEDIFF(m, 0, @value) + 1;
	DECLARE @maxMonth int = DATEDIFF(m, 0, [dbo].[GetMaxDate]());
	
	IF (@month > @maxMonth)
		RETURN [dbo].[GetMaxDate]();
	
	RETURN DATEADD(ms,-3, DATEADD(mm, @month, 0));
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[GetMaxDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[GetMaxDate];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Return maximum datetime value.
-- ==========================================================================================
CREATE FUNCTION [dbo].[GetMaxDate]
(
)
RETURNS datetime
AS
BEGIN
	RETURN '9999-12-31 23:59:59.997';
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[GetMinDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[GetMinDate];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Return minimum datetime value.
-- ==========================================================================================
CREATE FUNCTION [dbo].[GetMinDate]
(
)
RETURNS datetime
AS
BEGIN
	RETURN '1900-01-01 00:00:00.000';
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ValidateDateOut]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ValidateDateOut];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	Validate @DateOut value. Return maximum date if @DateIn is greater
--              than @DateOut. Otherwise return @DateOut.
-- ==========================================================================================
CREATE FUNCTION [dbo].[ValidateDateOut]
(
	@DateIn datetime,
	@DateOut datetime
)
RETURNS datetime
AS
BEGIN
	SET @DateIn = [dbo].[ValidateMinDate](@DateIn);
	SET @DateOut = [dbo].[ValidateMaxDate](@DateOut);

	RETURN CASE WHEN (@DateIn > @DateOut) THEN [dbo].[GetMaxDate]() ELSE @DateOut END;
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ValidateMaxDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ValidateMaxDate];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	Return maximum datetime value if @value is null. Otherwise return @value.
--
-- ==========================================================================================
CREATE FUNCTION [dbo].[ValidateMaxDate]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN ISNULL(@value, [dbo].[GetMaxDate]());
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ValidateMinDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ValidateMinDate];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	Return minimum datetime value if @value is null. Otherwise return @value.
--
-- ==========================================================================================
CREATE FUNCTION [dbo].[ValidateMinDate]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN ISNULL(@value, [dbo].[GetMinDate]());
END;
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[IsBetweenDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[IsBetweenDate];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	Return true if Filter date is in range between the date begin and end.
--              Otherwise return false.
-- ==========================================================================================
CREATE FUNCTION [dbo].[IsBetweenDate]
(
	@DateFilterFrom datetime,
	@DateFilterTo datetime,
	@DateBegin datetime,
	@DateEnd datetime
)
RETURNS bit
AS
BEGIN
	RETURN
	( 
		CASE
			WHEN
				(@DateFilterTo >= @DateBegin) AND (@DateFilterFrom <= @DateEnd)
				THEN 1
			ELSE
				0
		END
	);
END;
GO
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSystemLookup]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSystemLookup];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 16 Mar 2016 10:55:43
-- Description   : Provide function to retrieve [dbo].[SystemLookup] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSystemLookup]
(
    @ID int,
    @Name nvarchar(128),
    @Value_Boolean bit,
    @Value_Int32 int,
    @Value_Double float,
    @Value_String nvarchar(512),
    @Value_Guid uniqueidentifier,
    @Value_DateTime datetime2,
    @ParentID int,
    @Group nvarchar(128),
    @SortIndex int,
    @IsActive bit,
    @IsAuthorization bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SL].[ID],
            [SL].[Name],
            [SL].[Value_Boolean],
            [SL].[Value_Int32],
            [SL].[Value_Double],
            [SL].[Value_String],
            [SL].[Value_Guid],
            [SL].[Value_DateTime],
            [SL].[ParentID],
            [SL].[Group],
            [SL].[SortIndex],
            [SL].[IsActive],
            [SL].[IsAuthorization],
            [SL].[CreatedDate],
            [SL].[ModifiedDate]
        FROM
			[dbo].[SystemLookup] [SL]
		WHERE
            ((@ID IS NULL) OR ([SL].[ID] = @ID)) AND
            ((@Name IS NULL) OR ([SL].[Name] LIKE '%' + @Name + '%')) AND
            ((@Value_Boolean IS NULL) OR ([SL].[Value_Boolean] = @Value_Boolean)) AND
            ((@Value_Int32 IS NULL) OR ([SL].[Value_Int32] = @Value_Int32)) AND
            ((@Value_Double IS NULL) OR ([SL].[Value_Double] = @Value_Double)) AND
            ((@Value_String IS NULL) OR ([SL].[Value_String] = @Value_String)) AND
            ((@Value_Guid IS NULL) OR ([SL].[Value_Guid] = @Value_Guid)) AND
            ((@Value_DateTime IS NULL) OR ([SL].[Value_DateTime] = @Value_DateTime)) AND
            ((@ParentID IS NULL) OR ([SL].[ParentID] = @ParentID)) AND
            ((@Group IS NULL) OR ([SL].[Group] = @Group)) AND
            ((@SortIndex IS NULL) OR ([SL].[SortIndex] = @SortIndex)) AND
            ((@IsActive IS NULL) OR ([SL].[IsActive] = @IsActive)) AND
            ((@IsAuthorization IS NULL) OR ([SL].[IsAuthorization] = @IsAuthorization))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSystemLookup]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSystemLookup];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 16 Mar 2016 10:55:43
-- Description   : Provide view (model) to retrieve [dbo].[fSystemLookup] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSystemLookup]
AS
(
    SELECT
            [ID],
            [Name],
            [Value_Boolean],
            [Value_Int32],
            [Value_Double],
            [Value_String],
            [Value_Guid],
            [Value_DateTime],
            [ParentID],
            [Group],
            [SortIndex],
            [IsActive],
            [IsAuthorization],
            [CreatedDate],
            [ModifiedDate]
        FROM
			[dbo].[fSystemLookup]
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
                NULL,
                NULL
            )
);
GO
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProductBrand]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProductBrand];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[ProductBrand] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProductBrand]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PB].[ID],
            [PB].[Code],
            [PB].[Name],
            [dbo].[fCodeNameFormatter]([PB].[Code], [PB].[Name]) [Brand],
            [PB].[CreatedDate],
            [PB].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PB].[ModifiedDate],
            [PB].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [PB].[IsDeleted]
        FROM
			[dbo].[ProductBrand] [PB] LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PB].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PB].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([PB].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([PB].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([PB].[Name] LIKE '%' + @Name + '%')) AND
            ((@IsDeleted IS NULL) OR ([PB].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProductBrand]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProductBrand];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fProductBrand] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProductBrand]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Brand],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fProductBrand]
            (
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProductAdditionalInfo]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProductAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[ProductAdditionalInfo] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProductAdditionalInfo]
(
    @ProductID int,
    @AdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PAI].[ProductID],
            [PAI].[AdditionalInfo1],
            [PAI].[AdditionalInfo2],
            [PAI].[AdditionalInfo3],
            [PAI].[AdditionalInfo4],
            [PAI].[AdditionalInfo5],
            [PAI].[AdditionalInfo6],
            [PAI].[AdditionalInfo7],
            [PAI].[AdditionalInfo8],
            [PAI].[AdditionalInfo9],
            [PAI].[AdditionalInfo10] 
        FROM
			[dbo].[ProductAdditionalInfo] [PAI]
		WHERE
            ((@ProductID IS NULL) OR ([PAI].[ProductID] = @ProductID)) AND
            (
                (@AdditionalInfo IS NULL) OR
                (
                    ([PAI].[AdditionalInfo1] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo2] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo3] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo4] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo5] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo6] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo7] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo8] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo9] LIKE '%' + @AdditionalInfo + '%') OR
                    ([PAI].[AdditionalInfo10] LIKE '%' + @AdditionalInfo + '%')
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProductAdditionalInfo]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProductAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fProductAdditionalInfo] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProductAdditionalInfo]
AS
(
    SELECT
            [ProductID],
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
			[dbo].[fProductAdditionalInfo]
            (
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:12:32
-- Description   : Provide function to retrieve [dbo].[Product] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProduct]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @BrandID int,
    @BrandCode nvarchar(10),
    @BrandName nvarchar(50),
    @ShortName nvarchar(30),
    @StatusID int,
    @AdditionalInfo nvarchar(100),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [P].[ID],
            [P].[Code],
            [P].[Name],
            [dbo].[fCodeNameFormatter]([P].[Code], [P].[Name]) [Product],
            [P].[BrandID],
            [fPB].[Code] [BrandCode],
            [fPB].[Name] [BrandName],
            [fPB].[Brand],
            [P].[ShortName],
            [P].[UOMLID],
            [fSL1].[Name] [UOMLName],
            [P].[UOMMID],
            [fSL2].[Name] [UOMMName],
            [P].[UOMSID],
            [fSL3].[Name] [UOMSName],
            [P].[Weight],
            [P].[DimensionL],
            [P].[DimensionW],
            [P].[DimensionH],
            [P].[ConversionL],
            [P].[ConversionM],
            [P].[ConversionS],
            [P].[StatusID],
            [fSL4].[Name] [StatusName],
            [fPAI].[AdditionalInfo1],
            [fPAI].[AdditionalInfo2],
            [fPAI].[AdditionalInfo3],
            [fPAI].[AdditionalInfo4],
            [fPAI].[AdditionalInfo5],
            [fPAI].[AdditionalInfo6],
            [fPAI].[AdditionalInfo7],
            [fPAI].[AdditionalInfo8],
            [fPAI].[AdditionalInfo9],
            [fPAI].[AdditionalInfo10],
            [P].[CreatedDate],
            [P].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [P].[ModifiedDate],
            [P].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [P].[IsDeleted]
        FROM
			[dbo].[Product] [P] INNER JOIN
            [dbo].[fProductBrand]
            (
                @BrandID,
                @BrandCode,
                @BrandName,
                NULL
            ) [fPB] ON ([P].[BrandID] = [fPB].[ID]) INNER JOIN
            [dbo].[fProductAdditionalInfo]
            (
                @ID,
                @AdditionalInfo
            ) [fPAI] ON ([P].[ID] = [fPAI].[ProductID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductUOM',
                NULL,
                NULL,
                NULL
            ) [fSL1] ON ([P].[UOMLID] = [fSL1].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductUOM',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([P].[UOMMID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductUOM',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([P].[UOMSID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductStatus',
                NULL,
                NULL,
                NULL
            ) [fSL4] ON ([P].[StatusID] = [fSL4].[Value_Int32]) LEFT OUTER JOIN        
            [dbo].[User] [CU] ON ([P].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([P].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([P].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([P].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([P].[Name] LIKE '%' + @Name + '%')) AND
            ((@ShortName IS NULL) OR ([P].[ShortName] LIKE '%' + @ShortName + '%')) AND
            ((@StatusID IS NULL) OR ([P].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([P].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:12:32
-- Description   : Provide view (model) to retrieve [dbo].[fProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProduct]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Product],
            [BrandID],
            [BrandCode],
            [BrandName],
            [Brand],
            [ShortName],
            [UOMLID],
            [UOMLName],
            [UOMMID],
            [UOMMName],
            [UOMSID],
            [UOMSName],
            [Weight],
            [DimensionL],
            [DimensionW],
            [DimensionH],
            [ConversionL],
            [ConversionM],
            [ConversionS],
            [StatusID],
            [StatusName],
            [AdditionalInfo1],
            [AdditionalInfo2],
            [AdditionalInfo3],
            [AdditionalInfo4],
            [AdditionalInfo5],
            [AdditionalInfo6],
            [AdditionalInfo7],
            [AdditionalInfo8],
            [AdditionalInfo9],
            [AdditionalInfo10],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fProduct]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProductPrice]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProductPrice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[ProductPrice] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProductPrice]
(
    @ID int,
    @Code nvarchar(20),
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ValidDateFrom datetime,
    @ValidDateTo datetime,
    @PriceGroupID int,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PP].[ID],
            [PP].[Code],
            [PP].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            [PP].[ValidDateFrom],
            [PP].[ValidDateTo],
            [PP].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [PP].[GrossPrice],
            [PP].[TaxPercentage],
            [PP].[Price],
            [PP].[StatusID],
            [fSL2].[Name] [StatusName],
            [PP].[CreatedDate],
            [PP].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PP].[ModifiedDate],
            [PP].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [PP].[IsDeleted]
        FROM
			[dbo].[ProductPrice] [PP] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([PP].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([PP].[PriceGroupID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([PP].[StatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PP].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PP].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([PP].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([PP].[Code] LIKE '%' + @Code + '%')) AND
            (
                ([dbo].[ValidateMaxDate]([PP].[ValidDateFrom]) >= [dbo].[ValidateMinDate](@ValidDateFrom)) OR
                ([dbo].[ValidateMinDate]([PP].[ValidDateTo]) <= [dbo].[ValidateMaxDate](@ValidDateTo))
            ) AND
            ((@PriceGroupID IS NULL) OR ([PP].[PriceGroupID] = @PriceGroupID)) AND
            ((@StatusID IS NULL) OR ([PP].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([PP].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProductPrice]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProductPrice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fProductPrice] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProductPrice]
AS
(
    SELECT
            [ID],
            [Code],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ValidDateFrom],
            [ValidDateTo],
            [PriceGroupID],
            [PriceGroupName],
            [GrossPrice],
            [TaxPercentage],
            [Price],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fProductPrice]
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
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fProductLot]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fProductLot];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[ProductLot] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fProductLot]
(
    @ID int,
    @Code nvarchar(20),
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ExpiredDateFrom datetime,
    @ExpiredDateTo datetime,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PL].[ID],
            [PL].[Code],
            [PL].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            [PL].[ExpiredDate],
            [dbo].[fCodeNameFormatter]([PL].[Code], CONVERT(VARCHAR(26), [PL].[ExpiredDate], 23)) [ProductLot],
            [PL].[StatusID],
            [fSL].[Name] [StatusName],
            [PL].[SAPCode],
            [PL].[CreatedDate],
            [PL].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PL].[ModifiedDate],
            [PL].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [PL].[IsDeleted]
        FROM
			[dbo].[ProductLot] [PL] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,        
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([PL].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductLotStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([PL].[StatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PL].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PL].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([PL].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([PL].[Code] LIKE '%' + @Code + '%')) AND
            ([dbo].[ValidateMaxDate]([PL].[ExpiredDate]) >= [dbo].[ValidateMinDate](@ExpiredDateFrom)) AND
            ([dbo].[ValidateMinDate]([PL].[ExpiredDate]) <= [dbo].[ValidateMaxDate](@ExpiredDateTo)) AND
            ((@StatusID IS NULL) OR ([PL].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([PL].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vProductLot]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vProductLot];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fProductLot] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vProductLot]
AS
(
    SELECT
            [ID],
            [Code],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ExpiredDate],
            [ProductLot],
            [StatusID],
            [StatusName],
            [SAPCode],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fProductLot]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDiscountGroup]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDiscountGroup];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[DiscountGroup] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDiscountGroup]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @Description nvarchar(200),
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [DG].[ID],
            [DG].[Code],
            [DG].[Name],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description],
            [DG].[StatusID],
            [fSL].[Name] [StatusName],
            [DG].[CreatedDate],
            [DG].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [DG].[ModifiedDate],
            [DG].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [DG].[IsDeleted]
        FROM
			[dbo].[DiscountGroup] [DG] LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DiscountGroupStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([DG].[StatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([DG].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([DG].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([DG].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([DG].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([DG].[Name] LIKE '%' + @Name + '%')) AND
            ((@Description IS NULL) OR ([DG].[Description] LIKE '%' + @Description + '%')) AND
            ((@StatusID IS NULL) OR ([DG].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([DG].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDiscountGroup]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDiscountGroup];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fDiscountGroup] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDiscountGroup]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [DiscountGroup],
            [Description],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fDiscountGroup]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDiscountStrata]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDiscountStrata];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[DiscountStrata] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDiscountStrata]
(
    @ID int,
    @Code nvarchar(20),
    @Name nvarchar(50),
    @ValidDateFrom datetime,
    @ValidDateTo datetime,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [DS].[ID],
            [DS].[Code],
            [DS].[Name],
            [dbo].[fCodeNameFormatter]([DS].[Code], [DS].[Name]) [DiscountStrata],
            [DS].[ValidDateFrom],
            [DS].[ValidDateTo],
            [DS].[StatusID],
            [fSL].[Name] [StatusName],
            [DS].[CreatedDate],
            [DS].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [DS].[ModifiedDate],
            [DS].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [DS].[IsDeleted]
        FROM
			[dbo].[DiscountStrata] [DS] LEFT OUTER JOIN            
            [dbo].[fSystemLookup]
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
                'DiscountStrataStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([DS].[StatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([DS].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([DS].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([DS].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([DS].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([DS].[Name] LIKE '%' + @Name + '%')) AND
            (
                ([dbo].[ValidateMaxDate]([DS].[ValidDateFrom]) >= [dbo].[ValidateMinDate](@ValidDateFrom)) OR
                ([dbo].[ValidateMinDate]([DS].[ValidDateTo]) <= [dbo].[ValidateMaxDate](@ValidDateTo))
            ) AND
            ((@StatusID IS NULL) OR ([DS].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([DS].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDiscountStrata]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDiscountStrata];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fDiscountStrata] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDiscountStrata]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [DiscountStrata],
            [ValidDateFrom],
            [ValidDateTo],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fDiscountStrata]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDiscountStrataDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDiscountStrataDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[DiscountStrataDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDiscountStrataDetails]
(
    @ID int,
    @StrataID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [DSD].[ID],
            [DSD].[StrataID],
            [DSD].[Minimum],
            [DSD].[Maximum],
            [DSD].[DiscountPercentage]
        FROM
			[dbo].[DiscountStrataDetails] [DSD]            
		WHERE
            ((@ID IS NULL) OR ([DSD].[ID] = @ID)) AND
            ((@StrataID IS NULL) OR ([DSD].[StrataID] = @StrataID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDiscountStrataDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDiscountStrataDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fDiscountStrataDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDiscountStrataDetails]
AS
(
    SELECT
            [ID],
            [StrataID],
            [Minimum],
            [Maximum],
            [DiscountPercentage]
        FROM
			[dbo].[fDiscountStrataDetails]
            (
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDiscountGroupProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDiscountGroupProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[DiscountGroupProduct] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDiscountGroupProduct]
(
    @DiscountGroupID int,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @DiscountStrataID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PD].[DiscountGroupID],
            [PD].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            [PD].[DiscountStrata1ID],
            [fDS1].[Code] [DiscountStrata1Code],
            [fDS1].[Name] [DiscountStrata1Name],
            [fDS1].[DiscountStrata] [DiscountStrata1],
            [fDS1].[ValidDateFrom] [DiscountStrata1ValidDateFrom],
            [fDS1].[ValidDateTo] [DiscountStrata1ValidDateTo],
            [fDS1].[StatusID] [DiscountStrata1StatusID],
            [fDS1].[StatusName] [DiscountStrata1StatusName],
            [PD].[DiscountStrata2ID],
            [fDS2].[Code] [DiscountStrata2Code],
            [fDS2].[Name] [DiscountStrata2Name],
            [fDS2].[DiscountStrata] [DiscountStrata2],
            [fDS2].[ValidDateFrom] [DiscountStrata2ValidDateFrom],
            [fDS2].[ValidDateTo] [DiscountStrata2ValidDateTo],
            [fDS2].[StatusID] [DiscountStrata2StatusID],
            [fDS2].[StatusName] [DiscountStrata2StatusName],
            [PD].[DiscountStrata3ID],
            [fDS3].[Code] [DiscountStrata3Code],
            [fDS3].[Name] [DiscountStrata3Name],
            [fDS3].[DiscountStrata] [DiscountStrata3],
            [fDS3].[ValidDateFrom] [DiscountStrata3ValidDateFrom],
            [fDS3].[ValidDateTo] [DiscountStrata3ValidDateTo],
            [fDS3].[StatusID] [DiscountStrata3StatusID],
            [fDS3].[StatusName] [DiscountStrata3StatusName],
            [PD].[DiscountStrata4ID],
            [fDS4].[Code] [DiscountStrata4Code],
            [fDS4].[Name] [DiscountStrata4Name],
            [fDS4].[DiscountStrata] [DiscountStrata4],
            [fDS4].[ValidDateFrom] [DiscountStrata4ValidDateFrom],
            [fDS4].[ValidDateTo] [DiscountStrata4ValidDateTo],
            [fDS4].[StatusID] [DiscountStrata4StatusID],
            [fDS4].[StatusName] [DiscountStrata4StatusName],
            [PD].[DiscountStrata5ID],
            [fDS5].[Code] [DiscountStrata5Code],
            [fDS5].[Name] [DiscountStrata5Name],
            [fDS5].[DiscountStrata] [DiscountStrata5],
            [fDS5].[ValidDateFrom] [DiscountStrata5ValidDateFrom],
            [fDS5].[ValidDateTo] [DiscountStrata5ValidDateTo],
            [fDS5].[StatusID] [DiscountStrata5StatusID],
            [fDS5].[StatusName] [DiscountStrata5StatusName]
        FROM
			[dbo].[DiscountGroupProduct] [PD] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([PD].[ProductID] = [fP].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS1] ON ([PD].[DiscountStrata1ID] = [fDS1].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS2] ON ([PD].[DiscountStrata2ID] = [fDS2].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS3] ON ([PD].[DiscountStrata3ID] = [fDS3].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS4] ON ([PD].[DiscountStrata4ID] = [fDS4].[ID]) LEFT OUTER JOIN
            [dbo].[fDiscountStrata]
            (
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            ) [fDS5] ON ([PD].[DiscountStrata5ID] = [fDS5].[ID])
		WHERE
            (
                (@DiscountStrataID IS NULL) OR
                (
                    ([PD].[DiscountStrata1ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata2ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata3ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata4ID] = @DiscountStrataID) OR
                    ([PD].[DiscountStrata5ID] = @DiscountStrataID)
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDiscountGroupProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDiscountGroupProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fDiscountGroupProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDiscountGroupProduct]
AS
(
    SELECT
            [DiscountGroupID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [DiscountStrata1ID],
            [DiscountStrata1Code],
            [DiscountStrata1Name],
            [DiscountStrata1],
            [DiscountStrata1ValidDateFrom],
            [DiscountStrata1ValidDateTo],
            [DiscountStrata1StatusID],
            [DiscountStrata1StatusName],
            [DiscountStrata2ID],
            [DiscountStrata2Code],
            [DiscountStrata2Name],
            [DiscountStrata2],
            [DiscountStrata2ValidDateFrom],
            [DiscountStrata2ValidDateTo],
            [DiscountStrata2StatusID],
            [DiscountStrata2StatusName],
            [DiscountStrata3ID],
            [DiscountStrata3Code],
            [DiscountStrata3Name],
            [DiscountStrata3],
            [DiscountStrata3ValidDateFrom],
            [DiscountStrata3ValidDateTo],
            [DiscountStrata3StatusID],
            [DiscountStrata3StatusName],
            [DiscountStrata4ID],
            [DiscountStrata4Code],
            [DiscountStrata4Name],
            [DiscountStrata4],
            [DiscountStrata4ValidDateFrom],
            [DiscountStrata4ValidDateTo],
            [DiscountStrata4StatusID],
            [DiscountStrata4StatusName],
            [DiscountStrata5ID],
            [DiscountStrata5Code],
            [DiscountStrata5Name],
            [DiscountStrata5],
            [DiscountStrata5ValidDateFrom],
            [DiscountStrata5ValidDateTo],
            [DiscountStrata5StatusID],
            [DiscountStrata5StatusName]
        FROM
			[dbo].[fDiscountGroupProduct]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fTerritory]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fTerritory];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[Territory] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fTerritory]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [T].[ID],
            [T].[Code],
            [T].[Name],
            [dbo].[fCodeNameFormatter]([T].[Code], [T].[Name]) [Territory],
            [T].[CreatedDate],
            [T].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [T].[ModifiedDate],
            [T].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [T].[IsDeleted]
        FROM
			[dbo].[Territory] [T] LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([T].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([T].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([T].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([T].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([T].[Name] LIKE '%' + @Name + '%')) AND
            ((@IsDeleted IS NULL) OR ([T].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vTerritory]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vTerritory];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fTerritory] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vTerritory]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Territory],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fTerritory]
            (
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fRegion]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fRegion];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:12:32
-- Description   : Provide function to retrieve [dbo].[Region] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fRegion]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [R].[ID],
            [R].[Code],
            [R].[Name],
            [dbo].[fCodeNameFormatter]([R].[Code], [R].[Name]) [Region],
            [R].[TerritoryID],
            [fT].[Code] [TerritoryCode],
            [fT].[Name] [TerritoryName],
            [fT].[Territory],
            [R].[CreatedDate],
            [R].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [R].[ModifiedDate],
            [R].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [R].[IsDeleted]
        FROM
			[dbo].[Region] [R] INNER JOIN
            [dbo].[fTerritory]
            (
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                NULL
            ) [fT] ON ([R].[TerritoryID] = [fT].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([R].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([R].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([R].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([R].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([R].[Name] LIKE '%' + @Name + '%')) AND
            ((@IsDeleted IS NULL) OR ([R].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vRegion]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vRegion];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:12:32
-- Description   : Provide view (model) to retrieve [dbo].[fRegion] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vRegion]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fRegion]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fArea]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fArea];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:14:36
-- Description   : Provide function to retrieve [dbo].[Area] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fArea]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [A].[ID],
            [A].[Code],
            [A].[Name],
            [dbo].[fCodeNameFormatter]([A].[Code], [A].[Name]) [Area],
            [A].[RegionID],
            [fR].[Code] [RegionCode],
            [fR].[Name] [RegionName],
            [fR].[Region],
            [fR].[TerritoryID],
            [fR].[TerritoryCode],
            [fR].[TerritoryName],
            [fR].[Territory],
            [A].[CreatedDate],
            [A].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [A].[ModifiedDate],
            [A].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [A].[IsDeleted]
        FROM
			[dbo].[Area] [A] INNER JOIN
            [dbo].[fRegion]
            (
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                NULL
            ) [fR] ON ([A].[RegionID] = [fR].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([A].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([A].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([A].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([A].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([A].[Name] LIKE '%' + @Name + '%')) AND
            ((@IsDeleted IS NULL) OR ([A].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vArea]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vArea];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:14:36
-- Description   : Provide view (model) to retrieve [dbo].[fArea] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vArea]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fArea]
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
                NULL
            )
);
GO
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCompany]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCompany];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Company] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCompany]
(
    @ID int,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @Address nvarchar(100),
    @City nvarchar(50),
    @StateProvince nvarchar(50),
    @CountryID int,
    @CountryName nvarchar(50),
    @ZipCode nvarchar(10),
    @Phone1 nvarchar(20),
    @Phone2 nvarchar(20),
    @Fax nvarchar(20),
    @Email nvarchar(256),
    @TaxNumber nvarchar(20),
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [C].[ID],
            [C].[Code],
            [C].[Name],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Company],
            [fCA].[Address1],
            [fCA].[Address2],
            [fCA].[Address3],
            [fCA].[Address],
            [fCA].[City],
            [fCA].[StateProvince],
            [fCA].[CountryID],
            [fCA].[CountryName],
            [fCA].[ZipCode],
            [fCA].[Phone1],
            [fCA].[Phone2],
            [fCA].[Fax],
            [fCA].[Email],
            [C].[TaxNumber],
            [C].[StatusID],
            [fSL].[Name] [StatusName],
            [C].[CreatedDate],
            [C].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [C].[ModifiedDate],
            [C].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [C].[IsDeleted]
        FROM
			[dbo].[Company] [C] INNER JOIN
            [dbo].[fCompanyAddress]
            (
                @ID,
                @Address,
                @City,
                @StateProvince,
                @CountryID,
                @CountryName,
                @ZipCode,
                @Phone1,
                @Phone2,
                @Fax,
                @Email
            ) [fCA] ON ([C].[ID] = [fCA].[CompanyID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CompanyStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([C].[StatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([C].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([C].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR (@ID = [C].[ID])) AND
            ((@Code IS NULL) OR ([C].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([C].[Name] LIKE '%' + @Name + '%')) AND
            ((@TaxNumber IS NULL) OR ([C].[TaxNumber] LIKE '%' + @TaxNumber + '%')) AND                        
            ((@StatusID IS NULL) OR ([C].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([C].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCompany]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCompany];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCompany] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCompany]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Company],
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
            [Email],
            [TaxNumber],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fCompany]
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
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSiteAddress]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSiteAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[SiteAddress] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSiteAddress]
(
    @SiteID uniqueidentifier,
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
            [SA].[SiteID],
            [SA].[Address1],
            [SA].[Address2],
            [SA].[Address3],
            [dbo].[fAddressFormatter]([SA].[Address1], [SA].[Address2], [SA].[Address3]) [Address],
            [SA].[City],
            [SA].[StateProvince],
            [SA].[CountryID],
            [fC].[Name] [CountryName],
            [SA].[ZipCode],
            [SA].[Phone1],
            [SA].[Phone2],
            [SA].[Fax],
            [SA].[Email]            
        FROM
			[dbo].[SiteAddress] [SA] INNER JOIN
            [dbo].[fCountry]
            (
                @CountryID,
                @CountryName,
                NULL,
                NULL
            ) [fC] ON ([SA].[CountryID] = [fC].[ID])
		WHERE
            ((@SiteID IS NULL) OR ([SA].[SiteID] = @SiteID)) AND
            (
                (@Address IS NULL) OR
                (
                    ([SA].[Address1] LIKE '%' + @Address + '%') OR
                    ([SA].[Address2] LIKE '%' + @Address + '%') OR
                    ([SA].[Address3] LIKE '%' + @Address + '%')
                )
            ) AND
            ((@City IS NULL) OR ([SA].[City] LIKE '%' + @City + '%')) AND
            ((@StateProvince IS NULL) OR ([SA].[StateProvince] LIKE '%' + @StateProvince + '%')) AND
            ((@ZipCode IS NULL) OR ([SA].[ZipCode] LIKE '%' + @ZipCode + '%')) AND
            ((@Phone1 IS NULL) OR ([SA].[Phone1] LIKE '%' + @Phone1 + '%')) AND
            ((@Phone2 IS NULL) OR ([SA].[Phone2] LIKE '%' + @Phone2 + '%')) AND
            ((@Fax IS NULL) OR ([SA].[Fax] LIKE '%' + @Fax + '%')) AND
            ((@Email IS NULL) OR ([SA].[Email] LIKE '%' + @Email + '%'))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSiteAddress]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSiteAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSiteAddress] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSiteAddress]
AS
(
    SELECT
            [SiteID],
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
			[dbo].[fSiteAddress]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSiteAdditionalInfo]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSiteAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[SiteAdditionalInfo] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSiteAdditionalInfo]
(
    @SiteID uniqueidentifier,
    @AdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SAI].[SiteID],
            [SAI].[AdditionalInfo1],
            [SAI].[AdditionalInfo2],
            [SAI].[AdditionalInfo3],
            [SAI].[AdditionalInfo4],
            [SAI].[AdditionalInfo5],
            [SAI].[AdditionalInfo6],
            [SAI].[AdditionalInfo7],
            [SAI].[AdditionalInfo8],
            [SAI].[AdditionalInfo9],
            [SAI].[AdditionalInfo10] 
        FROM
			[dbo].[SiteAdditionalInfo] [SAI]
		WHERE
            ((@SiteID IS NULL) OR ([SAI].[SiteID] = @SiteID)) AND
            (
                (@AdditionalInfo IS NULL) OR
                (
                    ([SAI].[AdditionalInfo1] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo2] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo3] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo4] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo5] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo6] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo7] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo8] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo9] LIKE '%' + @AdditionalInfo + '%') OR
                    ([SAI].[AdditionalInfo10] LIKE '%' + @AdditionalInfo + '%')
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSiteAdditionalInfo]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSiteAdditionalInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSiteAdditionalInfo] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSiteAdditionalInfo]
AS
(
    SELECT
            [SiteID],
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
			[dbo].[fSiteAdditionalInfo]
            (
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSite]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSite];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Site] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSite]
(
    @ID uniqueidentifier,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @DistributionTypeID int,
    @IsLotNumberEntryRequired bit,
    @Address nvarchar(100),
    @City nvarchar(50),
    @StateProvince nvarchar(50),
    @CountryID int,
    @CountryName nvarchar(50),
    @ZipCode nvarchar(10),
    @Phone1 nvarchar(20),
    @Phone2 nvarchar(20),
    @Fax nvarchar(20),
    @Email nvarchar(256),
    @TaxNumber nvarchar(20),
    @StatusID int,
    @AdditionalInfo nvarchar(100),
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [S].[ID],
            [S].[Code],
            [S].[Name],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Site],
            [S].[AreaID],
            [fA].[Code] [AreaCode],
            [fA].[Name] [AreaName],
            [fA].[Area],
            [fA].[RegionID] [RegionID],
            [fA].[RegionCode] [RegionCode],
            [fA].[RegionName] [RegionName],
            [fA].[Region],
            [fA].[TerritoryID] [TerritoryID],
            [fA].[TerritoryCode] [TerritoryCode],
            [fA].[TerritoryName] [TerritoryName],
            [fA].[Territory],
            [fC].[ID] [CompanyID],
            [fC].[Code] [CompanyCode],
            [fC].[Name] [CompanyName],
            [fC].[Company],
            [S].[DistributionTypeID],
            [fSL].[Name] [DistributionTypeName],
            [S].[IsLotNumberEntryRequired],
            [fSA].[Address1],
            [fSA].[Address2],
            [fSA].[Address3],
            [fSA].[Address],
            [fSA].[City],
            [fSA].[StateProvince],
            [fSA].[CountryID],
            [fSA].[CountryName],
            [fSA].[ZipCode],
            [fSA].[Phone1],
            [fSA].[Phone2],
            [fSA].[Fax],
            [fSA].[Email],
            [fSAI].[AdditionalInfo1],
            [fSAI].[AdditionalInfo2],
            [fSAI].[AdditionalInfo3],
            [fSAI].[AdditionalInfo4],
            [fSAI].[AdditionalInfo5],
            [fSAI].[AdditionalInfo6],
            [fSAI].[AdditionalInfo7],
            [fSAI].[AdditionalInfo8],
            [fSAI].[AdditionalInfo9],
            [fSAI].[AdditionalInfo10],
            [S].[TaxNumber],
            [S].[StatusID],
            [fSL2].[Name] [StatusName],
            [S].[SAPCode],
            [S].[CreatedDate],
            [S].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [S].[ModifiedDate],
            [S].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [S].[IsDeleted]
        FROM
			[dbo].[Site] [S] INNER JOIN
            [dbo].[fArea]
            (
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                NULL
            ) [fA] ON ([S].[AreaID] = [fA].[ID]) INNER JOIN
            [dbo].[fCompany]
            (
                @CompanyID,
                @CompanyCode,
                @CompanyName,
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
                NULL,
                NULL
            ) [fC] ON ([S].[CompanyID] = [fC].[ID]) INNER JOIN
            [dbo].[fSiteAddress]
            (
                @ID,
                @Address,
                @City,
                @StateProvince,
                @CountryID,
                @CountryName,
                @ZipCode,
                @Phone1,
                @Phone2,
                @Fax,
                @Email
            ) [fSA] ON ([S].[ID] = [fSA].[SiteID]) INNER JOIN
            [dbo].[fSiteAdditionalInfo]
            (
                @ID,
                @AdditionalInfo
            ) [fSAI] ON ([S].[ID] = [fSAI].[SiteID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SiteDistributionType',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([S].[DistributionTypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SiteStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([S].[StatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([S].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([S].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR (@ID = [S].[ID])) AND
            ((@Code IS NULL) OR ([S].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([S].[Name] LIKE '%' + @Name + '%')) AND
            ((@DistributionTypeID IS NULL) OR ([S].[DistributionTypeID] = @DistributionTypeID)) AND
            ((@IsLotNumberEntryRequired IS NULL) OR ([S].[IsLotNumberEntryRequired] = @IsLotNumberEntryRequired)) AND
            ((@TaxNumber IS NULL) OR ([S].[TaxNumber] LIKE '%' + @TaxNumber + '%')) AND
            ((@StatusID IS NULL) OR ([S].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([S].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSite]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSite];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSite] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSite]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Site],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [DistributionTypeID],
            [DistributionTypeName],
            [IsLotNumberEntryRequired],
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
            [Email],
            [AdditionalInfo1],
            [AdditionalInfo2],
            [AdditionalInfo3],
            [AdditionalInfo4],
            [AdditionalInfo5],
            [AdditionalInfo6],
            [AdditionalInfo7],
            [AdditionalInfo8],
            [AdditionalInfo9],
            [AdditionalInfo10],
            [TaxNumber],
            [StatusID],
            [StatusName],
            [SAPCode],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fSite]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSiteProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSiteProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[SiteProduct] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSiteProduct]
(
    @SiteID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)   
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SP].[SiteID],
            [SP].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10]
        FROM
			[dbo].[SiteProduct] [SP] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SP].[ProductID] = [fP].[ID])
		WHERE
            ((@SiteID IS NULL) OR ([SP].[SiteID] = @SiteID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSiteProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSiteProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fSiteProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSiteProduct]
AS
(
    SELECT
            [SiteID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10]
        FROM
			[dbo].[fSiteProduct]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fWarehouse]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fWarehouse];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:14:36
-- Description   : Provide function to retrieve [dbo].[Warehouse] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fWarehouse]
(
    @ID uniqueidentifier,
    @Code nvarchar(10),
    @Name nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @TypeID int,
    @IsSOAllowed bit,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [W].[ID],
            [W].[Code],
            [W].[Name],
            [dbo].[fCodeNameFormatter]
            (
                [W].[Code],
                (SELECT CASE WHEN [W].[TypeID] = 1 THEN '[' + [fSL].[Name] + '] ' ELSE '' END) + [W].[Name]
            ) [Warehouse],
            [W].[SiteID],
            [fS].[Code] [SiteCode],
            [fS].[Name] [SiteName],
            [fS].[Site],
            [fS].[AreaID],
            [fS].[AreaCode],
            [fS].[AreaName],
            [fS].[Area],            
            [fS].[RegionID],
            [fS].[RegionCode],
            [fS].[RegionName],
            [fS].[Region],
            [fS].[TerritoryID],
            [fS].[TerritoryCode],
            [fS].[TerritoryName],
            [fS].[Territory],
            [fS].[CompanyID],
            [fS].[CompanyCode],
            [fS].[CompanyName],
            [fS].[Company],
            [fS].[DistributionTypeID] [SiteDistributionTypeID],
            [fS].[DistributionTypeName] [SiteDistributionTypeName],
            [fS].[IsLotNumberEntryRequired] [IsSiteLotNumberEntryRequired],
            [W].[TypeID],
            [fSL].[Name] [TypeName],
            [W].[IsSOAllowed],
            [W].[StatusID],
            [fSL2].[Name] [StatusName],
            [W].[SAPCode],
            [W].[CreatedDate],
            [W].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [W].[ModifiedDate],
            [W].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [W].[IsDeleted]
        FROM
			[dbo].[Warehouse] [W] INNER JOIN
            [dbo].[fSite]
            (
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
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
                NULL,
                NULL,
                NULL
            ) [fS] ON ([W].[SiteID] = [fS].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'WarehouseType',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([W].[TypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'WarehouseStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([W].[StatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([W].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([W].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([W].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([W].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([W].[Name] LIKE '%' + @Name + '%')) AND
            ((@TypeID IS NULL) OR ([W].[TypeID] = @TypeID)) AND
            ((@IsSOAllowed IS NULL) OR ([W].[IsSOAllowed] = @IsSOAllowed)) AND
            ((@StatusID IS NULL) OR ([W].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([W].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vWarehouse]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vWarehouse];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:14:36
-- Description   : Provide view (model) to retrieve [dbo].[fWarehouse] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vWarehouse]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],
            [TypeID],            
            [TypeName],
            [IsSOAllowed],
            [StatusID],            
            [StatusName],
            [SAPCode],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fWarehouse]
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
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesman]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesman];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Salesman] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesman]
(
    @ID uniqueidentifier,
    @Code nvarchar(20),
    @Name nvarchar(50),
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @GroupID int,
    @CategoryID int,
    @Phone nvarchar(20),
    @SFA nvarchar(50),
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [S].[ID],
            [S].[Code],
            [S].[Name],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [S].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [S].[GroupID],
            [fSL].[Name] [GroupName],
            [S].[CategoryID],
            [fSL2].[Name] [CategoryName],
            [S].[Phone],
            [S].[SFAFlag],
            [S].[SFA],
            [S].[StatusID],
            [fSL3].[Name] [StatusName],
            [S].[CreatedDate],
            [S].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [S].[ModifiedDate],
            [S].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [S].[IsDeleted]
        FROM
			[dbo].[Salesman] [S] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([S].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SalesmanGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([S].[GroupID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SalesmanCategory',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([S].[CategoryID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SalesmanStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([S].[StatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([S].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([S].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR (@ID = [S].[ID])) AND
            ((@Code IS NULL) OR ([S].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([S].[Name] LIKE '%' + @Name + '%')) AND
            ((@GroupID IS NULL) OR ([S].[GroupID] = @GroupID)) AND
            ((@CategoryID IS NULL) OR ([S].[CategoryID] = @CategoryID)) AND
            ((@Phone IS NULL) OR ([S].[Phone] LIKE '%' + @Phone + '%')) AND
            ((@SFA IS NULL) OR ([S].[SFA] LIKE '%' + @SFA + '%')) AND
            ((@StatusID IS NULL) OR ([S].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([S].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesman]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesman];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fSalesman] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesman]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [GroupID],
            [GroupName],
            [CategoryID],
            [CategoryName],
            [Phone],
            [SFAFlag],
            [SFA],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fSalesman]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesmanProduct]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesmanProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:31
-- Description   : Provide function to retrieve [dbo].[SalesmanProduct] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesmanProduct]
(
    @SalesmanID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)   
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SP].[SalesmanID],
            [SP].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10]
        FROM
			[dbo].[SalesmanProduct] [SP] INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SP].[ProductID] = [fP].[ID])
		WHERE
            ((@SalesmanID IS NULL) OR ([SP].[SalesmanID] = @SalesmanID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesmanProduct]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesmanProduct];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fSalesmanProduct] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesmanProduct]
AS
(
    SELECT
            [SalesmanID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10]
        FROM
			[dbo].[fSalesmanProduct]
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
                NULL                
            )
);
GO
USE [IDOS_TRACKING]
GO
/****** Object:  UserDefinedFunction [dbo].[fSalesmanTarget]    Script Date: 5/26/2016 9:56:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesmanTarget]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesmanTarget];
GO

CREATE FUNCTION [dbo].[fSalesmanTarget]
(
  @ID            INT,
  @Code          NVARCHAR(10),
  @Name          NVARCHAR(50),
  @SalesmanID    uniqueidentifier,
  @Month         INT,
  @SalesmanCode  NVARCHAR(10),
  @SalesmanName  NVARCHAR(50),
  @WarehouseID   uniqueidentifier,
  @WarehouseCode nvarchar(10),
  @WarehouseName nvarchar(50),
  @ProductID     INT,
  @ProductCode   NVARCHAR(10),
  @ProductName    NVARCHAR(50),
  @TerritoryID   INT,
  @TerritoryCode NVARCHAR(10),
  @TerritoryName NVARCHAR(50),
  @RegionID      INT,
  @RegionCode    NVARCHAR(10),
  @RegionName    NVARCHAR(50),
  @AreaID        INT,
  @AreaCode      NVARCHAR(10),
  @AreaName      NVARCHAR(50),
  @CompanyID     INT,
  @CompanyCode   NVARCHAR(10),
  @CompanyName   NVARCHAR(50),
  @SiteID        uniqueidentifier,
  @SiteCode      NVARCHAR(10),
  @SiteName      NVARCHAR(50),
  @IsDeleted     BIT
)
RETURNS TABLE
AS RETURN
(
	SELECT	
		CAST(ROW_NUMBER() OVER(ORDER BY [DATA].[Month])AS INT)  [RowNumber]
	  , [DATA].[ID]
	  , [DATA].[Month]
	  , [DATA].[SalesmanID]
	  , [DATA].[TargetQty]
	  , [DATA].[TargetAmount]
	  , [DATA].[EffectiveCall]
	  , [DATA].[OutletTransaction]
	  , [DATA].[TargetNewOpenOutlet]
	  , [DATA].[TerritoryID]
	  , [DATA].[RegionID]
	  , [DATA].[AreaID]
	  , [DATA].[CompanyID]
	  , [DATA].[SiteID]
	  , [DATA].[ProductID]
	  , [DATA].[ProductCode]
	  , [DATA].[ProductName]
	  , [DATA].[Product]
	  , [DATA].[CreatedDate]
	  , [DATA].[CreatedByUserID]
	  , [DATA].[CreatedByUserName]
	  , [DATA].[ModifiedDate]
	  , [DATA].[ModifiedByUserID]
	  , [DATA].[ModifiedByUserName]
	  , [DATA].[IsDeleted]
	FROM
	(
		SELECT 
			  NULL [ID]
			, NULL [Month]
			, [fSLP].[SalesmanID]
			, NULL [TargetQty]
			, NULL [TargetAmount]
			, NULL [EffectiveCall]
			, NULL [OutletTransaction]
			, NULL [TargetNewOpenOutlet]
			, [fS].[TerritoryID]
			, [fS].[RegionID]
			, [fS].[AreaID]
			, [fS].[CompanyID]
			, [fS].[SiteID]
			, [fSLP]. [ProductID]
			, [fSLP]. [ProductCode]
			, [fSLP]. [ProductName]
			, [fSLP].[Product]
			, NULL [CreatedDate]
			, NULL [CreatedByUserID]
			, NULL [CreatedByUserName]
			, NULL [ModifiedDate]
			, NULL [ModifiedByUserID]
			, NULL [ModifiedByUserName]
			, NULL [IsDeleted]
		FROM [dbo].[fSalesmanProduct]( 
				@SalesmanID,
				@ProductID,
				@ProductCode,
				@ProductName,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL) [fSLP]
			LEFT OUTER JOIN [dbo].[fSalesman](
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
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
			) [fS] ON [fS].[ID] = [fSLP].[SalesmanID]
		UNION ALL
		SELECT
			  [SLT].[ID]
			, [SLP].[Month]
			, [SLP].[SalesmanID]
			, [SLT].[TargetQty]
			, [SLT].[TargetAmount]
			, [SLT].[EffectiveCall]
			, [SLT].[OutletTransaction]
			, [SLT].[TargetNewOpenOutlet]
			, [SLP].[TerritoryID]
			, [SLP].[RegionID]
			, [SLP].[AreaID]
			, [SLP].[CompanyID]
			, [SLP].[SiteID]
			, [SLP].[ProductID]
			, [SLP].[ProductCode]
			, [SLP].[ProductName]
			, [SLP].[Product]
			, [SLT].[CreatedDate]
			, [SLT].[CreatedByUserID]
			, [SLT].[CreatedByUserName]
			, [SLT].[ModifiedDate] [ModifiedDate]
			, [SLT].[ModifiedByUserID]
			, [SLT].[ModifiedByUserName]
			, [SLT].[IsDeleted]
		FROM
		(
			SELECT 
					[SLT].[ID]
				, CAST([SLT].[Month] AS date) [Month]
				, [SLT].[SalesmanID]
				, [SLT].[ProductID]
				, [SLT].[TargetQty]
				, [SLT].[TargetAmount]
				, [SLT].[EffectiveCall]
				, [SLT].[OutletTransaction]
				, [SLT].[TargetNewOpenOutlet]
				, [SLT].[CreatedDate]
				, [CUSR].[ID] [CreatedByUserID]
				, [CUSR].[Name] [CreatedByUserName]
				, [SLT].[ModifiedDate] [ModifiedDate]
				, [MUSR].[ID] [ModifiedByUserID]
				, [MUSR].[Name] [ModifiedByUserName]
				, [SLT].[IsDeleted]
			FROM [dbo].[SalesmanTarget] [SLT]
			LEFT OUTER JOIN [dbo].[User] [CUSR] ON ([SLT].[CreatedByUserID] = [CUSR].[ID])
			LEFT OUTER JOIN [dbo].[User] [MUSR] ON ([SLT].[ModifiedByUserID] = [MUSR].[ID])
			WHERE [SLT].[IsDeleted] <> 1
		) [SLT]
		RIGHT JOIN
		(
			SELECT
				[fSLP].[SalesmanID]
				, [fS].[TerritoryID]
				, [fS].[RegionID]
				, [fS].[AreaID]
				, [fS].[CompanyID]
				, [fS].[SiteID]
				, [fSLP]. [ProductID]
				, [fSLP]. [ProductCode]
				, [fSLP]. [ProductName]
				, [fSLP].[Product]
				, [TM].[Month]
			FROM [dbo].[fSalesmanProduct]( 
					@SalesmanID,
					@ProductID,
					@ProductCode,
					@ProductName,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL) [fSLP]
			LEFT OUTER JOIN [dbo].[fSalesman](
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
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL
				) [fS] ON [fS].[ID] = [fSLP].[SalesmanID],
			(
				SELECT DISTINCT [SalesmanID],cast([Month] AS date) Month 
				FROM [SalesmanTarget] 
				WHERE [IsDeleted] <> 1
			) [TM]
			WHERE [TM].[SalesmanID] = [fSLP].[SalesmanID]
		)  [SLP] ON [SLP].[SalesmanID] = [SLT].[SalesmanID] AND [SLP].[ProductID] = [SLT].[ProductID] AND [SLP].[Month] = [SLT].[Month]
		WHERE ((@ID IS NULL) OR ([SLT].[ID] = @ID))
			AND ((@IsDeleted IS NULL) OR ([SLT].[IsDeleted] = @IsDeleted))
			AND [SLP].[SalesmanID] IS NOT NULL
	) [DATA]
);
GO



USE [IDOS]
GO

/****** Object:  View [dbo].[vSalesmanTarget]    Script Date: 7/12/2016 3:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesmanTarget]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesmanTarget];
GO

CREATE VIEW [dbo].[vSalesmanTarget]
AS
SELECT
		  [RowNumber]
		, [ID]
		, [Month]
		, [SalesmanID]
		, [TargetQty]
		, [TargetAmount]
		, [EffectiveCall]
		, [OutletTransaction]
		, [TargetNewOpenOutlet]
		, [TerritoryID]
		, [RegionID]
		, [AreaID]
		, [CompanyID]
		, [SiteID]
		, [ProductID]
		, [ProductCode]
		, [ProductName]
		, [Product]
        , [CreatedDate]
        , [CreatedByUserID]
        , [CreatedByUserName]
        , [ModifiedDate]
        , [ModifiedByUserID]
        , [ModifiedByUserName]
        , [IsDeleted]
	FROM 
		[dbo].[fSalesmanTarget]
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
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
        ) 
GO





USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerCategory]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [dbo].[fCustomerCategory];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 16 Mar 2016 10:55:43
-- Description   : Provide function to retrieve [dbo].[CustomerCategory] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerCategory]
(
        @ID int,
        @Code nvarchar(10),
        @Name nvarchar(50),
		@ParentID int,
		@ParentCode nvarchar(10),
		@ParentName nvarchar(50),
		@Group nvarchar(20),
        @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CC].[ID],
            [CC].[Code],
            [CC].[Name],
            [dbo].[fCodeNameFormatter]([CC].[Code], [CC].[Name]) [Category],
			[CC2].[ParentID],
			[CC2].[Code] [ParentCode],
			[CC2].[Name] [ParentName],
			[dbo].[fCodeNameFormatter]([CC2].[Code], [CC2].[Name]) [Parent],
			[CC].[Group],
            [CC].[CreatedDate],
            [CC].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [CC].[ModifiedDate],
            [CC].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [CC].[IsDeleted]
        FROM
			[dbo].[CustomerCategory] [CC] LEFT OUTER JOIN
			[dbo].[CustomerCategory] [CC2] ON ([CC].[ParentID] = [CC2].[ID]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([CC].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([CC].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([CC].[ID] = @ID)) AND
            ((@Code IS NULL) OR ([CC].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([CC].[Name] LIKE '%' + @Name + '%')) AND
            ((@ParentID IS NULL) OR ([CC].[ParentID] = @ParentID)) AND
            ((@ParentCode IS NULL) OR ([CC2].[Code] = @ParentCode)) AND
            ((@ParentName IS NULL) OR ([CC2].[Name] = @ParentName)) AND			
            ((@Group IS NULL) OR ([CC].[Group] = @Group)) AND
            ((@IsDeleted IS NULL) OR ([CC].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerCategory]') AND type IN ( N'V' ))
	DROP VIEW [dbo].[vCustomerCategory];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 16 Mar 2016 10:55:43
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerCategory] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerCategory]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Category],
			[ParentID],
            [ParentCode],
            [ParentName],
			[Parent],
			[Group],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fCustomerCategory]
            (
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerBillAddress]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerBillAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CustomerBillAddress] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerBillAddress]
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
            [CBA].[CustomerID],
            [CBA].[IsSameAsAddress],
            [CBA].[Name],
            [CBA].[Address1],
            [CBA].[Address2],
            [CBA].[Address3],
            [dbo].[fAddressFormatter]([CBA].[Address1], [CBA].[Address2], [CBA].[Address3]) [Address],
            [CBA].[City],
            [CBA].[StateProvince],
            [CBA].[CountryID],
            [fC].[Name] [CountryName],
            [CBA].[ZipCode],
            [CBA].[Phone1],
            [CBA].[Phone2],
            [CBA].[Phone3],
            [CBA].[Fax],
            [CBA].[Email]
        FROM
			[dbo].[CustomerBillAddress] [CBA] LEFT OUTER JOIN
            [dbo].[fCountry]
            (
                @CountryID,
                @CountryName,
                NULL,
                NULL
            ) [fC] ON ([CBA].[CountryID] = [fC].[ID])
		WHERE
            ((@CustomerID IS NULL) OR ([CBA].[CustomerID] = @CustomerID)) AND
            (
                (@Address IS NULL) OR
                (
                    ([CBA].[Address1] LIKE '%' + @Address + '%') OR
                    ([CBA].[Address2] LIKE '%' + @Address + '%') OR
                    ([CBA].[Address3] LIKE '%' + @Address + '%')
                )
            ) AND
            ((@City IS NULL) OR ([CBA].[City] LIKE '%' + @City + '%')) AND
            ((@StateProvince IS NULL) OR ([CBA].[StateProvince] LIKE '%' + @StateProvince + '%')) AND
            ((@CountryID IS NULL) OR ([CBA].[CountryID] = @CountryID)) AND
            ((@ZipCode IS NULL) OR ([CBA].[ZipCode] LIKE '%' + @ZipCode + '%')) AND
            ((@Phone1 IS NULL) OR ([CBA].[Phone1] LIKE '%' + @Phone1 + '%')) AND
            ((@Phone2 IS NULL) OR ([CBA].[Phone2] LIKE '%' + @Phone2 + '%')) AND
            ((@Phone3 IS NULL) OR ([CBA].[Phone3] LIKE '%' + @Phone3 + '%')) AND
            ((@Fax IS NULL) OR ([CBA].[Fax] LIKE '%' + @Fax + '%')) AND
            ((@Email IS NULL) OR ([CBA].[Email] LIKE '%' + @Email + '%'))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerBillAddress]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerBillAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerBillAddress] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerBillAddress]
AS
(
    SELECT
            [CustomerID],
            [IsSameAsAddress],
            [Name],
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
            [Email]
        FROM
			[dbo].[fCustomerBillAddress]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerTaxAddress]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerTaxAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CustomerTaxAddress] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerTaxAddress]
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
            [CTA].[CustomerID],
            [CTA].[IsSameAsAddress],
            [CTA].[IsSameAsBillAddress],
            [CTA].[Name],
            [CTA].[Address1],
            [CTA].[Address2],
            [CTA].[Address3],
            [dbo].[fAddressFormatter]([CTA].[Address1], [CTA].[Address2], [CTA].[Address3]) [Address],
            [CTA].[City],
            [CTA].[StateProvince],
            [CTA].[CountryID],
            [fC].[Name] [CountryName],
            [CTA].[ZipCode],
            [CTA].[Phone1],
            [CTA].[Phone2],
            [CTA].[Phone3],
            [CTA].[Fax],
            [CTA].[Email]
           
        FROM
			[dbo].[CustomerTaxAddress] [CTA] LEFT OUTER JOIN
            [dbo].[fCountry]
            (
                @CountryID,
                @CountryName,
                NULL,
                NULL
            ) [fC] ON ([CTA].[CountryID] = [fC].[ID])
		WHERE
            ((@CustomerID IS NULL) OR ([CTA].[CustomerID] = @CustomerID)) AND
            (
                (@Address IS NULL) OR
                (
                    ([CTA].[Address1] LIKE '%' + @Address + '%') OR
                    ([CTA].[Address2] LIKE '%' + @Address + '%') OR
                    ([CTA].[Address3] LIKE '%' + @Address + '%')
                )
            ) AND
            ((@City IS NULL) OR ([CTA].[City] LIKE '%' + @City + '%')) AND
            ((@StateProvince IS NULL) OR ([CTA].[StateProvince] LIKE '%' + @StateProvince + '%')) AND
            ((@CountryID IS NULL) OR ([CTA].[CountryID] = @CountryID)) AND
            ((@ZipCode IS NULL) OR ([CTA].[ZipCode] LIKE '%' + @ZipCode + '%')) AND
            ((@Phone1 IS NULL) OR ([CTA].[Phone1] LIKE '%' + @Phone1 + '%')) AND
            ((@Phone2 IS NULL) OR ([CTA].[Phone2] LIKE '%' + @Phone2 + '%')) AND
            ((@Phone3 IS NULL) OR ([CTA].[Phone3] LIKE '%' + @Phone3 + '%')) AND
            ((@Fax IS NULL) OR ([CTA].[Fax] LIKE '%' + @Fax + '%')) AND
            ((@Email IS NULL) OR ([CTA].[Email] LIKE '%' + @Email + '%'))            
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerTaxAddress]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerTaxAddress];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerTaxAddress] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerTaxAddress]
AS
(
    SELECT
            [CustomerID],
            [IsSameAsAddress],
            [IsSameAsBillAddress],
            [Name],
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
            [Email]
        FROM
			[dbo].[fCustomerTaxAddress]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomerCategoryInfo]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomerCategoryInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[CustomerCategoryInfo] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomerCategoryInfo]
(
    @CustomerID uniqueidentifier,
    @CategoryID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [CCI].[CustomerID],
            [CCI].[Category1ID],
            [CC1].[Code] [Category1Code],
            [CC1].[Name] [Category1Name],
            [CC1].[Category] [Category1],
            [CCI].[Category2ID],
            [CC2].[Code] [Category2Code],
            [CC2].[Name] [Category2Name],
            [CC2].[Category] [Category2],
            [CCI].[Category3ID],
            [CC3].[Code] [Category3Code],
            [CC3].[Name] [Category3Name],
            [CC3].[Category] [Category3],
            [CCI].[Category4ID],
            [CC4].[Code] [Category4Code],
            [CC4].[Name] [Category4Name],
            [CC4].[Category] [Category4],            
            [CCI].[Category5ID],
            [CC5].[Code] [Category5Code],
            [CC5].[Name] [Category5Name],
            [CC5].[Category] [Category5],
            [CCI].[Category6ID],
            [CC6].[Code] [Category6Code],
            [CC6].[Name] [Category6Name],
            [CC6].[Category] [Category6],
            [CCI].[Category7ID],
            [CC7].[Code] [Category7Code],
            [CC7].[Name] [Category7Name],
            [CC7].[Category] [Category7],
            [CCI].[Category8ID],
            [CC8].[Code] [Category8Code],
            [CC8].[Name] [Category8Name],
            [CC8].[Category] [Category8],
            [CCI].[Category9ID],
            [CC9].[Code] [Category9Code],
            [CC9].[Name] [Category9Name],
            [CC9].[Category] [Category9],
            [CCI].[Category10ID] ,
            [CC10].[Code] [Category10Code],
            [CC10].[Name] [Category10Name],
            [CC10].[Category] [Category10]      
        FROM
			[dbo].[CustomerCategoryInfo] [CCI] LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC1] ON ([CCI].[Category1ID] = [CC1].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC2] ON ([CCI].[Category2ID] = [CC2].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC3] ON ([CCI].[Category3ID] = [CC3].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC4] ON ([CCI].[Category4ID] = [CC4].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC5] ON ([CCI].[Category5ID] = [CC5].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC6] ON ([CCI].[Category6ID] = [CC6].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC7] ON ([CCI].[Category7ID] = [CC7].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC8] ON ([CCI].[Category8ID] = [CC8].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC9] ON ([CCI].[Category9ID] = [CC9].[ID]) LEFT OUTER JOIN
            [dbo].[fCustomerCategory] (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) [CC10] ON ([CCI].[Category10ID] = [CC10].[ID])
		WHERE
            ((@CustomerID IS NULL) OR ([CCI].[CustomerID] = @CustomerID)) AND
            (
                (@CategoryID IS NULL) OR
                (
                    ([CCI].[Category1ID] = @CategoryID ) OR
                    ([CCI].[Category2ID] = @CategoryID ) OR
                    ([CCI].[Category3ID] = @CategoryID ) OR
                    ([CCI].[Category4ID] = @CategoryID ) OR
                    ([CCI].[Category5ID] = @CategoryID ) OR
                    ([CCI].[Category6ID] = @CategoryID ) OR
                    ([CCI].[Category7ID] = @CategoryID ) OR
                    ([CCI].[Category8ID] = @CategoryID ) OR
                    ([CCI].[Category9ID] = @CategoryID ) OR
                    ([CCI].[Category10ID] = @CategoryID )
                )
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomerCategoryInfo]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomerCategoryInfo];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomerCategoryInfo] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomerCategoryInfo]
AS
(
    SELECT
            [CustomerID],
            [Category1ID],
            [Category1Code],
            [Category1Name],
            [Category1],            
            [Category2ID],
            [Category2Code],
            [Category2Name],
            [Category2],
            [Category3ID],
            [Category3Code],
            [Category3Name],
            [Category3],
            [Category4ID],
            [Category4Code],
            [Category4Name],
            [Category4],
            [Category5ID],
            [Category5Code],
            [Category5Name],
            [Category5],
            [Category6ID],
            [Category6Code],
            [Category6Name],
            [Category6],
            [Category7ID],
            [Category7Code],
            [Category7Name],
            [Category7],
            [Category8ID],
            [Category8Code],
            [Category8Name],
            [Category8],
            [Category9ID],
            [Category9Code],
            [Category9Name],
            [Category9],
            [Category10ID],
            [Category10Code],
            [Category10Name],
            [Category10]            
        FROM
			[dbo].[fCustomerCategoryInfo]
            (
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fCustomer]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide function to retrieve [dbo].[Customer] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fCustomer]
(
    @ID uniqueidentifier,
    @Code nvarchar(20),
    @Name nvarchar(50),
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(20),
    @SalesmanName nvarchar(50),
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @SalesmanGroupID int,
    @SalesmanCategoryID int,
    @SalesmanStatusID int,
    @TermOfPaymentID int,
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @DiscountGroupDescription nvarchar(200),
    @DiscountGroupStatusID int,
    @IsTaxNumberAvailable bit,
    @TaxNumber nvarchar(20),
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
    @Email nvarchar(256),
    @AdditionalInfo nvarchar(100),
    @CategoryID int,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [C].[ID],
            [C].[Code],
            [C].[Name],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [C].[SalesmanID],
            [fS].[Code] [SalesmanCode],
            [fS].[Name] [SalesmanName],
            [fS].[Salesman],
            [fS].[WarehouseID],
            [fS].[WarehouseCode],
            [fS].[WarehouseName],
            [fS].[Warehouse],
            [fS].[SiteID],
            [fS].[SiteCode],
            [fS].[SiteName],
            [fS].[Site],
            [fS].[CompanyID],
            [fS].[CompanyCode],
            [fS].[CompanyName],
            [fS].[Company],
            [fS].[AreaID],
            [fS].[AreaCode],
            [fS].[AreaName],
            [fS].[Area],
            [fS].[RegionID],
            [fS].[RegionCode],
            [fS].[RegionName],
            [fS].[Region],
            [fS].[TerritoryID],
            [fS].[TerritoryCode],
            [fS].[TerritoryName],
            [fS].[Territory],
            [fS].[SiteDistributionTypeID],
            [fS].[SiteDistributionTypeName],            
            [fS].[WarehouseTypeID],
            [fS].[WarehouseTypeName],
            [fS].[GroupID] [SalesmanGroupID],
            [fS].[GroupName] [SalesmanGroupName],
            [fS].[CategoryID] [SalesmanCategoryID],
            [fS].[CategoryName] [SalesmanCategoryName],
            [fS].[Phone] [SalesmanPhoneID],
            [fS].[SFA] [SalesmanSFA],
            [fS].[StatusID] [SalesmanStatusID],
            [fS].[StatusName] [SalesmanStatusName],
            [fS].[IsDeleted] [IsSalesmanDeleted],
            [C].[RegisteredDate],
            [C].[TermOfPaymentID],
            [fSL].[Name] [TermOfPaymentName],
            [C].[CreditLimit],
            [C].[PriceGroupID],
            [fSL2].[Name] [PriceGroupName],
            [C].[DiscountGroupID],
            [fDG].[Code] [DiscountGroupCode],
            [fDG].[Name] [DiscountGroupName],
            [fDG].[DiscountGroup],
            [fDG].[Description] [DiscountGroupDescription],
            [fDG].[StatusID] [DiscountGroupStatusID],
            [fDG].[StatusName] [DiscountGroupStatusName],
            [C].[IsTaxNumberAvailable],
            [C].[TaxSAPCode],
            [C].[TaxNumber],
            [fCA].[Address1],
            [fCA].[Address2],
            [fCA].[Address3],
            [fCA].[Address],
            [fCA].[City],
            [fCA].[StateProvince],
            [fCA].[CountryID],
            [fCA].[CountryName],
            [fCA].[ZipCode],
            [fCA].[Phone1],
            [fCA].[Phone2],
            [fCA].[Phone3],
            [fCA].[Fax],
            [fCA].[Email],
            [fCA].[Longitude],
            [fCA].[Latitude],
            [fCBA].[IsSameAsAddress] [IsBillSameAsAddress],
            [fCBA].[Name] [BillName],
            [fCBA].[Address1] [BillAddress1],
            [fCBA].[Address2] [BillAddress2],
            [fCBA].[Address3] [BillAddress3],
            [fCBA].[Address] [BillAddress],
            [fCBA].[City] [BillCity],
            [fCBA].[StateProvince] [BillStateProvince],
            [fCBA].[CountryID] [BillCountryID],
            [fCBA].[CountryName] [BillCountryName],
            [fCBA].[ZipCode] [BillZipCode],
            [fCBA].[Phone1] [BillPhone1],
            [fCBA].[Phone2] [BillPhone2],
            [fCBA].[Phone3] [BillPhone3],
            [fCBA].[Fax] [BillFax],
            [fCBA].[Email] [BillEmail],
            [fCTA].[IsSameAsAddress] [IsTaxSameAsAddress],
            [fCTA].[IsSameAsBillAddress] [IsTaxSameAsBillAddress],
            [fCTA].[Name] [TaxName],
            [fCTA].[Address1] [TaxAddress1],
            [fCTA].[Address2] [TaxAddress2],
            [fCTA].[Address3] [TaxAddress3],
            [fCTA].[Address] [TaxAddress],
            [fCTA].[City] [TaxCity],
            [fCTA].[StateProvince] [TaxStateProvince],
            [fCTA].[CountryID] [TaxCountryID],
            [fCTA].[CountryName] [TaxCountryName],
            [fCTA].[ZipCode] [TaxZipCode],
            [fCTA].[Phone1] [TaxPhone1],
            [fCTA].[Phone2] [TaxPhone2],
            [fCTA].[Phone3] [TaxPhone3],
            [fCTA].[Fax] [TaxFax],
            [fCTA].[Email] [TaxEmail],
            [fCAI].[AdditionalInfo1],
            [fCAI].[AdditionalInfo2],
            [fCAI].[AdditionalInfo3],
            [fCAI].[AdditionalInfo4],
            [fCAI].[AdditionalInfo5],
            [fCAI].[AdditionalInfo6],
            [fCAI].[AdditionalInfo7],
            [fCAI].[AdditionalInfo8],
            [fCAI].[AdditionalInfo9],
            [fCAI].[AdditionalInfo10],
            [fCCI].[Category1ID],
            [fCCI].[Category1Code],
            [fCCI].[Category1Name],
            [fCCI].[Category1],
            [fCCI].[Category2ID],
            [fCCI].[Category2Code],
            [fCCI].[Category2Name],
            [fCCI].[Category2],
            [fCCI].[Category3ID],
            [fCCI].[Category3Code],
            [fCCI].[Category3Name],
            [fCCI].[Category3],
            [fCCI].[Category4ID],
            [fCCI].[Category4Code],
            [fCCI].[Category4Name],
            [fCCI].[Category4],
            [fCCI].[Category5ID],
            [fCCI].[Category5Code],
            [fCCI].[Category5Name],
            [fCCI].[Category5],
            [fCCI].[Category6ID],
            [fCCI].[Category6Code],
            [fCCI].[Category6Name],
            [fCCI].[Category6],
            [fCCI].[Category7ID],
            [fCCI].[Category7Code],
            [fCCI].[Category7Name],
            [fCCI].[Category7],
            [fCCI].[Category8ID],
            [fCCI].[Category8Code],
            [fCCI].[Category8Name],
            [fCCI].[Category8],
            [fCCI].[Category9ID],
            [fCCI].[Category9Code],
            [fCCI].[Category9Name],
            [fCCI].[Category9],
            [fCCI].[Category10ID],
            [fCCI].[Category10Code],
            [fCCI].[Category10Name],
            [fCCI].[Category10],
            [C].[StatusID],
            [fSL3].[Name] [StatusName],
            [C].[CreatedDate],
            [C].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [C].[ModifiedDate],
            [C].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [C].[IsDeleted]
        FROM
			[dbo].[Customer] [C] INNER JOIN
            [dbo].[fSalesman]
            (
                @SalesmanID,
                @SalesmanCode,
                @SalesmanName,
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,    
                @SiteDistributionTypeID,
				NULL,
                @WarehouseTypeID,
                @SalesmanGroupID,
                @SalesmanCategoryID,
                NULL,
                NULL,
                @SalesmanStatusID,
                NULL
            ) [fS] ON ([C].[SalesmanID] = [fS].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([C].[TermOfPaymentID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([C].[PriceGroupID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[fDiscountGroup]
            (
                @DiscountGroupID,
                @DiscountGroupCode,
                @DiscountGroupName,
                @DiscountGroupDescription,
                @DiscountGroupStatusID,
                NULL
            ) [fDG] ON ([C].[DiscountGroupID] = [fDG].[ID]) INNER JOIN
            [dbo].[fCustomerAddress]
            (
                @ID,
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
            ) [fCA] ON ([C].[ID] = [fCA].[CustomerID]) INNER JOIN
            [dbo].[fCustomerBillAddress]
            (
                @ID,
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
            ) [fCBA] ON ([C].[ID] = [fCBA].[CustomerID]) INNER JOIN
            [dbo].[fCustomerTaxAddress]
            (
                @ID,
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
            ) [fCTA] ON ([C].[ID] = [fCTA].[CustomerID]) INNER JOIN
            [dbo].[fCustomerAdditionalInfo]
            (
                @ID,
                @AdditionalInfo
            ) [fCAI] ON ([C].[ID] = [fCAI].[CustomerID])INNER JOIN
            [dbo].[fCustomerCategoryInfo]
            (
                @ID,
                @CategoryID
            ) [fCCI] ON ([C].[ID] = [fCCI].[CustomerID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([C].[StatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([C].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([C].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR (@ID = [C].[ID])) AND
            ((@Code IS NULL) OR ([C].[Code] LIKE '%' + @Code + '%')) AND
            ((@Name IS NULL) OR ([C].[Name] LIKE '%' + @Name + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([C].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@IsTaxNumberAvailable IS NULL) OR ([C].[IsTaxNumberAvailable] = @IsTaxNumberAvailable)) AND
            ((@TaxNumber IS NULL) OR ([C].[TaxNumber] LIKE '%' + @TaxNumber + '%')) AND
            (
                (@Address IS NULL) OR
                (
                    ([fCA].[Address1] LIKE '%' + @Address + '%') OR
                    ([fCA].[Address2] LIKE '%' + @Address + '%') OR
                    ([fCA].[Address3] LIKE '%' + @Address + '%') OR
                    ([fCBA].[Address1] LIKE '%' + @Address + '%') OR
                    ([fCBA].[Address2] LIKE '%' + @Address + '%') OR
                    ([fCBA].[Address3] LIKE '%' + @Address + '%') OR
                    ([fCTA].[Address1] LIKE '%' + @Address + '%') OR
                    ([fCTA].[Address2] LIKE '%' + @Address + '%') OR
                    ([fCTA].[Address3] LIKE '%' + @Address + '%')
                )
            ) AND
            (
                (@City IS NULL) OR
                (
                    ([fCA].[City] LIKE '%' + @City + '%') OR
                    ([fCBA].[City] LIKE '%' + @City + '%') OR
                    ([fCTA].[City] LIKE '%' + @City + '%')
                )
            ) AND
            (
                (@StateProvince IS NULL) OR
                (
                    ([fCA].[StateProvince] LIKE '%' + @StateProvince + '%') OR
                    ([fCBA].[StateProvince] LIKE '%' + @StateProvince + '%') OR
                    ([fCTA].[StateProvince] LIKE '%' + @StateProvince + '%')
                )
            ) AND
            (
                (@ZipCode IS NULL) OR
                (
                    ([fCA].[ZipCode] LIKE '%' + @ZipCode + '%') OR
                    ([fCBA].[ZipCode] LIKE '%' + @ZipCode + '%') OR
                    ([fCTA].[ZipCode] LIKE '%' + @ZipCode + '%')
                )
            ) AND
            (
                (@Phone1 IS NULL) OR
                (
                    ([fCA].[Phone1] LIKE '%' + @Phone1 + '%') OR
                    ([fCBA].[Phone1] LIKE '%' + @Phone1 + '%') OR
                    ([fCTA].[Phone1] LIKE '%' + @Phone1 + '%')
                )
            ) AND
            (
                (@Phone2 IS NULL) OR
                (
                    ([fCA].[Phone2] LIKE '%' + @Phone2 + '%') OR
                    ([fCBA].[Phone2] LIKE '%' + @Phone2 + '%') OR
                    ([fCTA].[Phone2] LIKE '%' + @Phone2 + '%')
                )
            ) AND
            (
                (@Phone3 IS NULL) OR
                (
                    ([fCA].[Phone3] LIKE '%' + @Phone3 + '%') OR
                    ([fCBA].[Phone3] LIKE '%' + @Phone3 + '%') OR
                    ([fCTA].[Phone3] LIKE '%' + @Phone3 + '%')
                )
            ) AND
            (
                (@Fax IS NULL) OR
                (
                    ([fCA].[Fax] LIKE '%' + @Fax + '%') OR
                    ([fCBA].[Fax] LIKE '%' + @Fax + '%') OR
                    ([fCTA].[Fax] LIKE '%' + @Fax + '%')
                )
            ) AND
            (
                (@Email IS NULL) OR
                (
                    ([fCA].[Email] LIKE '%' + @Email + '%') OR
                    ([fCBA].[Email] LIKE '%' + @Email + '%') OR
                    ([fCTA].[Email] LIKE '%' + @Email + '%')
                )
            ) AND
            ((@StatusID IS NULL) OR ([C].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([C].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vCustomer]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vCustomer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 17 Mar 2016 20:37:01
-- Description   : Provide view (model) to retrieve [dbo].[fCustomer] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vCustomer]
AS
(
    SELECT
            [ID],
            [Code],
            [Name],
            [Customer],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],            
            [WarehouseTypeID],
            [WarehouseTypeName],
            [SalesmanGroupID],
            [SalesmanGroupName],
            [SalesmanCategoryID],
            [SalesmanCategoryName],
            [SalesmanPhoneID],
            [SalesmanSFA],
            [SalesmanStatusID],
            [SalesmanStatusName],
            [IsSalesmanDeleted],
            [RegisteredDate],
            [TermOfPaymentID],
            [TermOfPaymentName],
            [CreditLimit],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [DiscountGroupStatusID],
            [DiscountGroupStatusName],
            [IsTaxNumberAvailable],
            [TaxSAPCode],
            [TaxNumber],
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
            [Latitude],
            [IsBillSameAsAddress],
            [BillName],
            [BillAddress1],
            [BillAddress2],
            [BillAddress3],
            [BillAddress],
            [BillCity],
            [BillStateProvince],
            [BillCountryID],
            [BillCountryName],
            [BillZipCode],
            [BillPhone1],
            [BillPhone2],
            [BillPhone3],
            [BillFax],
            [BillEmail],
            [IsTaxSameAsAddress],
            [IsTaxSameAsBillAddress],
            [TaxName],
            [TaxAddress1],
            [TaxAddress2],
            [TaxAddress3],
            [TaxAddress],
            [TaxCity],
            [TaxStateProvince],
            [TaxCountryID],
            [TaxCountryName],
            [TaxZipCode],
            [TaxPhone1],
            [TaxPhone2],
            [TaxPhone3],
            [TaxFax],
            [TaxEmail],
            [AdditionalInfo1],
            [AdditionalInfo2],
            [AdditionalInfo3],
            [AdditionalInfo4],
            [AdditionalInfo5],
            [AdditionalInfo6],
            [AdditionalInfo7],
            [AdditionalInfo8],
            [AdditionalInfo9],
            [AdditionalInfo10],
            [Category1ID],
            [Category1Code],
            [Category1Name],
            [Category1],
            [Category2ID],
            [Category2Code],
            [Category2Name],
            [Category2],
            [Category3ID],
            [Category3Code],
            [Category3Name],
            [Category3],
            [Category4ID],
            [Category4Code],
            [Category4Name],
            [Category4],
            [Category5ID],
            [Category5Code],
            [Category5Name],
            [Category5],
            [Category6ID],
            [Category6Code],
            [Category6Name],
            [Category6],
            [Category7ID],
            [Category7Code],
            [Category7Name],
            [Category7],
            [Category8ID],
            [Category8Code],
            [Category8Name],
            [Category8],
            [Category9ID],
            [Category9Code],
            [Category9Name],
            [Category9],
            [Category10ID],
            [Category10Code],
            [Category10Name],
            [Category10],
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fCustomer]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fDeliveryOrder]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fDeliveryOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[DeliveryOrder] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fDeliveryOrder]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @RefDocumentID uniqueidentifier,
    @RefTransactionTypeID int,
    @ShipmentDateFrom datetime,
    @ShipmentDateTo datetime,
    @ReceivedDateFrom datetime,
    @ReceivedDateTo datetime,
    @LastPrintedDateFrom datetime,
    @LastPrintedDateTo datetime,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [DO].[DocumentID],
            [DO].[DocumentCode],
            [DO].[TransactionDate],
            [DO].[RefDocumentID],
            [DO].[RefTransactionTypeID],
            [fSL].[Name] [RefTransactionTypeName],
            [DO].[ShipmentDate],
            [DO].[ReceivedDate],
            [DO].[PrintedCount],
            [DO].[LastPrintedDate],
            [DO].[DocumentStatusID],
            [fSL2].[Name] [DocumentStatusName],
            [DO].[PostedDate],
            [DO].[CreatedDate],
            [DO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [DO].[ModifiedDate],
            [DO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[DeliveryOrder] [DO] LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DORefTransactionType',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([DO].[RefTransactionTypeID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([DO].[DocumentStatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([DO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([DO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([DO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@RefDocumentID IS NULL) OR ([DO].[RefDocumentID] = @RefDocumentID)) AND
            ((@RefTransactionTypeID IS NULL) OR ([DO].[RefTransactionTypeID] = @RefTransactionTypeID)) AND
            ((@ShipmentDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[ShipmentDate]) >= [dbo].[ValidateMinDate](@ShipmentDateFrom))) AND
            ((@ShipmentDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[ShipmentDate]) <= [dbo].[ValidateMaxDate](@ShipmentDateTo))) AND
            ((@ReceivedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[ReceivedDate]) >= [dbo].[ValidateMinDate](@ReceivedDateFrom))) AND
            ((@ReceivedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[ReceivedDate]) <= [dbo].[ValidateMaxDate](@ReceivedDateTo))) AND
            ((@LastPrintedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[LastPrintedDate]) >= [dbo].[ValidateMinDate](@LastPrintedDateFrom))) AND
            ((@LastPrintedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[LastPrintedDate]) <= [dbo].[ValidateMaxDate](@LastPrintedDateTo))) AND
            ((@DocumentStatusID IS NULL) OR ([DO].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([DO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([DO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vDeliveryOrder]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vDeliveryOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fDeliveryOrder] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vDeliveryOrder]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [RefDocumentID],
            [RefTransactionTypeID],
            [RefTransactionTypeName],
            [ShipmentDate],
            [ReceivedDate],
            [PrintedCount],
            [LastPrintedDate],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fDeliveryOrder]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fPurchaseOrder]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fPurchaseOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[PurchaseOrder] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fPurchaseOrder]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SODocumentID uniqueidentifier,
    @SOTransactionTypeID int,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [PO].[DocumentID],
            [PO].[DocumentCode],
            [PO].[TransactionDate],
            [PO].[DocumentStatusID],
            [PO].[SODocumentID],
            [PO].[SOTransactionTypeID],
            [fSL].[Name] [DocumentStatusName],
            [PO].[PostedDate],
            [PO].[CreatedDate],
            [PO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [PO].[ModifiedDate],
            [PO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[PurchaseOrder] [PO] LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([PO].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([PO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([PO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([PO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([PO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@SODocumentID IS NULL) OR ([PO].[SODocumentID] = @SODocumentID)) AND
            ((@SOTransactionTypeID IS NULL) OR ([PO].[SOTransactionTypeID] = @SOTransactionTypeID)) AND
            ([dbo].[ValidateMaxDate]([PO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom)) AND
            ([dbo].[ValidateMinDate]([PO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo)) AND
            ((@DocumentStatusID IS NULL) OR ([PO].[DocumentStatusID] = @DocumentStatusID)) AND
            ([dbo].[ValidateMaxDate]([PO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom)) AND
            ([dbo].[ValidateMinDate]([PO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vPurchaseOrder]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vPurchaseOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fPurchaseOrder] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vPurchaseOrder]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [SODocumentID],
            [SOTransactionTypeID],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fPurchaseOrder]
            (
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fInvoice]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fInvoice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[Invoice] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fInvoice]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @RefDocumentID uniqueidentifier,
    @RefTransactionTypeID int,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [I].[DocumentID],
            [I].[DocumentCode],
            [I].[TransactionDate],
            [I].[DocumentStatusID],
            [I].[RefDocumentID],
            [I].[RefTransactionTypeID],
            [fSL].[Name] [DocumentStatusName],
            [I].[PostedDate],
            [I].[CreatedDate],
            [I].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [I].[ModifiedDate],
            [I].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[Invoice] [I] LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([I].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([I].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([I].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([I].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([I].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@RefDocumentID IS NULL) OR ([I].[RefDocumentID] = @RefDocumentID)) AND
            ((@RefTransactionTypeID IS NULL) OR ([I].[RefTransactionTypeID] = @RefTransactionTypeID)) AND
            ([dbo].[ValidateMaxDate]([I].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom)) AND
            ([dbo].[ValidateMinDate]([I].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo)) AND
            ((@DocumentStatusID IS NULL) OR ([I].[DocumentStatusID] = @DocumentStatusID)) AND
            ([dbo].[ValidateMaxDate]([I].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom)) AND
            ([dbo].[ValidateMinDate]([I].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vInvoice]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vInvoice];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fInvoice] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vInvoice]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [RefDocumentID],
            [RefTransactionTypeID],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fInvoice]
            (
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOnHandPreCalc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOnHandPreCalc];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockOnHandPreCalc] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOnHandPreCalc]
(
    @IsSourceWarehouseID bit,
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseIsSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),    
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            MIN([TransactionDate]) [TransactionDate],
            SUM([QtyGood]) [QtyTransactionGood],
            SUM([QtyHold]) [QtyTransactionHold],
            SUM([QtyBad]) [QtyTransactionBad]
        FROM
            (
                SELECT
                        ISNULL
                        (
                            (SELECT CASE @IsSourceWarehouseID WHEN 1 THEN [vST].[SourceID] ELSE [vST].[DestinationID] END),
                            [vSOHP].[WarehouseID]
                        ) [WarehouseID],
                        ISNULL([vST].[ProductID], [vSOHP].[ProductID]) [ProductID],
                        ISNULL([vST].[ProductLotID], [vSOHP].[ProductLotID]) [ProductLotID],
                        ISNULL([PeriodDateID], [vST].[TransactionDate]) [TransactionDate],
                        [vST].[QtyGood] * (SELECT CASE @IsSourceWarehouseID WHEN 1 THEN 1 ELSE -1 END) [QtyGood],
                        [vST].[QtyHold] * (SELECT CASE @IsSourceWarehouseID WHEN 1 THEN 1 ELSE -1 END) [QtyHold],
                        [vST].[QtyBad] * (SELECT CASE @IsSourceWarehouseID WHEN 1 THEN 1 ELSE -1 END) [QtyBad],
                        ISNULL([vSOHP].[QtyGood], 0) [QtyPeriodOnHandGood],
                        ISNULL([vSOHP].[QtyHold], 0) [QtyPeriodOnHandHold],
                        ISNULL([vSOHP].[QtyBad], 0) [QtyPeriodOnHandBad]
                    FROM
                        (
			                SELECT
                                    [vSOHP].[WarehouseID],
                                    [vSOHP].[PeriodDateID],
                                    [vSOHP].[ProductID],
                                    [vSOHP].[ProductLotID],
                                    [vSOHP].[QtyGood],
                                    [vSOHP].[QtyHold],
                                    [vSOHP].[QtyBad]
                                FROM
                                    [dbo].[StockOnHandPeriodic] [vSOHP] INNER JOIN
                                    (
                                        SELECT
                                                [ssvSOHP].[WarehouseID],
                                                MAX([ssvSOHP].[PeriodDateID]) [PeriodDateID],
                                                [ssvSOHP].[ProductID],
                                                [ssvSOHP].[ProductLotID]                                    
                                            FROM
                                                [dbo].[StockOnHandPeriodic] [ssvSOHP] INNER JOIN
                                                [dbo].[fWarehouse]
                                                (
                                                    @WarehouseID,
                                                    @WarehouseCode,
                                                    @WarehouseName,
                                                    @SiteID,
                                                    @SiteCode,
                                                    @SiteName,
                                                    @AreaID,
                                                    @AreaCode,
                                                    @AreaName,
                                                    @RegionID,
                                                    @RegionCode,
                                                    @RegionName,
                                                    @TerritoryID,
                                                    @TerritoryCode,
                                                    @TerritoryName,
                                                    @CompanyID,
                                                    @CompanyCode,
                                                    @CompanyName,
                                                    @SiteDistributionTypeID,
                                                    @IsSiteLotNumberEntryRequired,
                                                    @WarehouseTypeID,
                                                    @IsWarehouseIsSOAllowed,
                                                    @WarehouseStatusID,
                                                    @IsWarehouseDeleted
                                                ) [fW] ON ([ssvSOHP].[WarehouseID] = [fw].[ID]) INNER JOIN
                                                [dbo].[fProductLot]
                                                (
                                                    @ProductLotID,
                                                    @ProductLotCode,
                                                    @ProductID,
                                                    @ProductCode,
                                                    @ProductName,
                                                    @ProductBrandID,
                                                    @ProductBrandCode,
                                                    @ProductBrandName,
                                                    @ProductShortName,
                                                    @ProductStatusID,
                                                    @ProductAdditionalInfo,
                                                    @ProductLotExpiredDateFrom,
                                                    @ProductLotExpiredDateTo,
                                                    @ProductLotStatusID,
                                                    @IsProductLotDeleted
                                                ) [fPL] ON ([ssvSOHP].[ProductLotID] = [fPL].[ID])
                                            WHERE            
                                                ((@WarehouseID IS NULL) OR ([ssvSOHP].[WarehouseID] = @WarehouseID)) AND
                                                ([ssvSOHP].[PeriodDateID] <= [dbo].[ConvertToFirstTimeOfDay]([dbo].[ValidateMinDate](@TransactionDate))) AND
                                                ((@ProductID IS NULL) OR ([ssvSOHP].[ProductID] = @ProductID)) AND
                                                ((@ProductLotID IS NULL) OR ([ssvSOHP].[ProductLotID] = @ProductLotID))                                    
                                            GROUP BY
                                                [ssvSOHP].[WarehouseID],
                                                [ssvSOHP].[ProductID],
                                                [ssvSOHP].[ProductLotID]
                                    ) [svSOHP] ON
                                    (
                                        ([vSOHP].[WarehouseID] = [svSOHP].[WarehouseID]) AND
                                        ([vSOHP].[PeriodDateID] = [svSOHP].[PeriodDateID]) AND
                                        ([vSOHP].[ProductID] = [svSOHP].[ProductID]) AND
                                        ([vSOHP].[ProductLotID] = [svSOHP].[ProductLotID])
                                    )
                        ) [vSOHP] FULL OUTER JOIN
                        [dbo].[StockTransaction] [vST] ON
                        (
                            (
                                ((@IsSourceWarehouseID = 1) AND ([vSOHP].[WarehouseID] = [vST].[SourceID])) OR
                                ((@IsSourceWarehouseID = 0) AND ([vSOHP].[WarehouseID] = [vST].[DestinationID]))
                            ) AND
                            ([vSOHP].[ProductID] = [vST].[ProductID]) AND
                            ([vSOHP].[ProductLotID] = [vST].[ProductLotID])
                        )
                    WHERE
                        (
                            (@IsSourceWarehouseID = 1) AND
                            (
                                ((@WarehouseID IS NULL) OR ([vST].[SourceID] = @WarehouseID)) AND
                                (
                                    ([vST].[TransactionTypeID] = 1) OR -- Sales Order
                                    ([vST].[TransactionTypeID] = 3) OR -- Sales Order Swap
                                    ([vST].[TransactionTypeID] = 4) OR -- Sales Order Sample
                                    ([vST].[TransactionTypeID] = 5) OR -- Sales Order FOC
                                    ([vST].[TransactionTypeID] = 6) OR -- Stock Opname
                                    ([vST].[TransactionTypeID] = 7) OR -- Stock Changes
                                    ([vST].[TransactionTypeID] = 8) OR -- Stock Transfer
                                    ([vST].[TransactionTypeID] = 9)    -- Stock Disposal
                                )
                            ) OR                        
                            (@IsSourceWarehouseID = 0) AND
                            (
                                ((@WarehouseID IS NULL) OR ([vST].[DestinationID] = @WarehouseID)) AND
                                ([vST].[DestinationID] IS NOT NULL) AND
                                (
                                    ([vST].[TransactionTypeID] = 2) OR -- Sales Order Return
                                    ([vST].[TransactionTypeID] = 8) OR -- Stock Transfer
                                    ([vST].[TransactionTypeID] = 12)   -- Stock Receive
                                )
                            )
                        ) AND
                        ((@ProductID IS NULL) OR ([vST].[ProductID] = @ProductID)) AND
                        ((@ProductLotID IS NULL) OR ([vST].[ProductLotID] = @ProductLotID)) AND
                        ([dbo].[ValidateMaxDate]([vST].[TransactionDate]) >= [dbo].[ConvertToFirstTimeOfDay]([dbo].[ValidateMinDate]([vSOHP].[PeriodDateID]))) AND
                        ((@TransactionDate IS NULL) OR ([dbo].[ValidateMinDate]([vST].[TransactionDate]) <= [dbo].[ConvertToFirstTimeOfDay]([dbo].[ValidateMaxDate](@TransactionDate))))
                        
            ) [vSTSOHP]
        GROUP BY
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad]
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOnHandCalc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOnHandCalc];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockOnHandCalc] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOnHandCalc]
(
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            SUM([QtyTransactionGood]) [QtyTransactionGood],
            SUM([QtyTransactionHold]) [QtyTransactionHold],
            SUM([QtyTransactionBad]) [QtyTransactionBad]
        FROM
            (
                SELECT
                        [WarehouseID],
                        [ProductID],
                        [ProductLotID],
                        [TransactionDate],
                        [QtyPeriodOnHandGood],
                        [QtyPeriodOnHandHold],
                        [QtyPeriodOnHandBad],
                        [QtyTransactionGood],
                        [QtyTransactionHold],
                        [QtyTransactionBad]
                    FROM
                        [dbo].[fStockOnHandPreCalc]
                        (
                            1, -- Source
                            @WarehouseID,
                            @TransactionDate,
                            @ProductID,
                            @ProductLotID,
                            @WarehouseCode,
                            @WarehouseName,
                            @SiteID,
                            @SiteCode,
                            @SiteName,
                            @AreaID,
                            @AreaCode,
                            @AreaName,
                            @RegionID,
                            @RegionCode,
                            @RegionName,
                            @TerritoryID,
                            @TerritoryCode,
                            @TerritoryName,
                            @CompanyID,
                            @CompanyCode,
                            @CompanyName,
                            @SiteDistributionTypeID,
                            @IsSiteLotNumberEntryRequired,
                            @WarehouseTypeID,
                            @IsWarehouseSOAllowed,
                            @WarehouseStatusID,
                            @IsWarehouseDeleted,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            @ProductLotCode,
                            @ProductLotExpiredDateFrom,
                            @ProductLotExpiredDateTo,
                            @ProductLotStatusID,
                            @IsProductLotDeleted
                        ) [fSOHPCSrc]
                UNION ALL
                SELECT
                        [WarehouseID],
                        [ProductID],
                        [ProductLotID],
                        [TransactionDate],
                        [QtyPeriodOnHandGood],
                        [QtyPeriodOnHandHold],
                        [QtyPeriodOnHandBad],
                        [QtyTransactionGood],
                        [QtyTransactionHold],
                        [QtyTransactionBad]
                    FROM
                        [dbo].[fStockOnHandPreCalc]
                        (
                            0, -- Destination
                            @WarehouseID,
                            @TransactionDate,
                            @ProductID,
                            @ProductLotID,
                            @WarehouseCode,
                            @WarehouseName,
                            @SiteID,
                            @SiteCode,
                            @SiteName,
                            @AreaID,
                            @AreaCode,
                            @AreaName,
                            @RegionID,
                            @RegionCode,
                            @RegionName,
                            @TerritoryID,
                            @TerritoryCode,
                            @TerritoryName,
                            @CompanyID,
                            @CompanyCode,
                            @CompanyName,
                            @SiteDistributionTypeID,
                            @IsSiteLotNumberEntryRequired,
                            @WarehouseTypeID,
                            @IsWarehouseSOAllowed,
                            @WarehouseStatusID,
                            @IsWarehouseDeleted,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            @ProductLotCode,
                            @ProductLotExpiredDateFrom,
                            @ProductLotExpiredDateTo,
                            @ProductLotStatusID,
                            @IsProductLotDeleted
                        ) [fSOHPCDest]
            ) [fSOHPC]
        GROUP BY
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad]
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOnHandAll]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOnHandAll];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockOnHandAll] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOnHandAll]
(    
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [vWPL].[WarehouseID],
            [vWPL].[ProductID],
            [vWPL].[ProductLotID],
            ISNULL([fSOHC].[QtyPeriodOnHandGood], 0) [QtyPeriodOnHandGood],
            ISNULL([fSOHC].[QtyPeriodOnHandHold], 0) [QtyPeriodOnHandHold],
            ISNULL([fSOHC].[QtyPeriodOnHandBad], 0) [QtyPeriodOnHandBad],
            ISNULL([fSOHC].[QtyTransactionGood], 0) [QtyTransactionGood],
            ISNULL([fSOHC].[QtyTransactionHold], 0) [QtyTransactionHold],
            ISNULL([fSOHC].[QtyTransactionBad], 0) [QtyTransactionBad],
            ISNULL([fSOHC].[QtyPeriodOnHandGood], 0) + ISNULL([fSOHC].[QtyTransactionGood], 0) [QtyOnHandGood],
            ISNULL([fSOHC].[QtyPeriodOnHandHold], 0) + ISNULL([fSOHC].[QtyTransactionHold], 0) [QtyOnHandHold],
            ISNULL([fSOHC].[QtyPeriodOnHandBad], 0) + ISNULL([fSOHC].[QtyTransactionBad], 0) [QtyOnHandBad],
            [vWPL].[ProductCode],
            [vWPL].[ProductName],
            [vWPL].[Product],
            [vWPL].[ProductBrandID],
            [vWPL].[ProductBrandCode],
            [vWPL].[ProductBrandName],
            [vWPL].[ProductBrand],
            [vWPL].[ProductShortName],
            [vWPL].[ProductUOMLID],
            [vWPL].[ProductUOMMID],
            [vWPL].[ProductUOMSID],
            [vWPL].[ProductUOMLName],
            [vWPL].[ProductUOMMName],
            [vWPL].[ProductUOMSName],
            [vWPL].[ProductWeight],
            [vWPL].[ProductDimensionL],
            [vWPL].[ProductDimensionW],
            [vWPL].[ProductDimensionH],
            [vWPL].[ProductConversionL],
            [vWPL].[ProductConversionM],
            [vWPL].[ProductConversionS],
            [vWPL].[ProductStatusID],
            [vWPL].[ProductStatusName],
            [vWPL].[ProductAdditionalInfo1],
            [vWPL].[ProductAdditionalInfo2],
            [vWPL].[ProductAdditionalInfo3],
            [vWPL].[ProductAdditionalInfo4],
            [vWPL].[ProductAdditionalInfo5],
            [vWPL].[ProductAdditionalInfo6],
            [vWPL].[ProductAdditionalInfo7],
            [vWPL].[ProductAdditionalInfo8],
            [vWPL].[ProductAdditionalInfo9],
            [vWPL].[ProductAdditionalInfo10],
            [vWPL].[ProductLotCode],
            [vWPL].[ProductLotExpiredDate],
            [vWPL].[ProductLot],
            [vWPL].[ProductLotStatusID],
            [vWPL].[ProductLotStatusName],
            [vWPL].[IsProductLotCodeDeleted]
        FROM
            (
                SELECT
                        [fW].[ID] [WarehouseID],
                        [fW].[Code] [WarehouseCode],
                        [fW].[Name] [WarehouseName],
                        [fW].[Warehouse],
                        [fW].[SiteID],
                        [fW].[SiteCode],
                        [fW].[SiteName],
                        [fW].[Site],
                        [fW].[AreaID],
                        [fW].[AreaCode],
                        [fW].[AreaName],
                        [fW].[Area],
                        [fW].[RegionID],
                        [fW].[RegionCode],
                        [fW].[RegionName],
                        [fW].[Region],
                        [fW].[TerritoryID],
                        [fW].[TerritoryCode],
                        [fW].[TerritoryName],
                        [fW].[Territory],
                        [fW].[CompanyID],
                        [fW].[CompanyCode],
                        [fW].[CompanyName],
                        [fW].[Company],
                        [fW].[SiteDistributionTypeID],
                        [fW].[SiteDistributionTypeName],
                        [fW].[IsSiteLotNumberEntryRequired],
                        [fW].[TypeID] [WarehouseTypeID],
                        [fW].[TypeName] [WarehouseTypeName],
                        [fW].[StatusID] [WarehouseStatusID],
                        [fW].[StatusName] [WarehouseStatusName],
                        [fW].[IsDeleted] [IsWarehouseDeleted],
                        [fPL].[ProductID],
                        [fPL].[ID] [ProductLotID],
                        [fPL].[ProductCode],
                        [fPL].[ProductName],
                        [fPL].[Product],
                        [fPL].[ProductBrandID],
                        [fPL].[ProductBrandCode],
                        [fPL].[ProductBrandName],
                        [fPL].[ProductBrand],
                        [fPL].[ProductShortName],
                        [fPL].[ProductUOMLID],
                        [fPL].[ProductUOMMID],
                        [fPL].[ProductUOMSID],
                        [fPL].[ProductUOMLName],
                        [fPL].[ProductUOMMName],
                        [fPL].[ProductUOMSName],
                        [fPL].[ProductWeight],
                        [fPL].[ProductDimensionL],
                        [fPL].[ProductDimensionW],
                        [fPL].[ProductDimensionH],
                        [fPL].[ProductConversionL],
                        [fPL].[ProductConversionM],
                        [fPL].[ProductConversionS],
                        [fPL].[ProductStatusID],
                        [fPL].[ProductStatusName],
                        [fPL].[ProductAdditionalInfo1],
                        [fPL].[ProductAdditionalInfo2],
                        [fPL].[ProductAdditionalInfo3],
                        [fPL].[ProductAdditionalInfo4],
                        [fPL].[ProductAdditionalInfo5],
                        [fPL].[ProductAdditionalInfo6],
                        [fPL].[ProductAdditionalInfo7],
                        [fPL].[ProductAdditionalInfo8],
                        [fPL].[ProductAdditionalInfo9],
                        [fPL].[ProductAdditionalInfo10],
                        [fPL].[Code] [ProductLotCode],
                        [fPL].[ExpiredDate] [ProductLotExpiredDate],
                        [fPL].[ProductLot] [ProductLot],
                        [fPL].[StatusID] [ProductLotStatusID],
                        [fPL].[StatusName] [ProductLotStatusName],
                        [fPL].[IsDeleted] [IsProductLotCodeDeleted]
                    FROM
                        [dbo].[fWarehouse]
                        (
                            @WarehouseID,
                            @WarehouseCode,
                            @WarehouseName,
                            @SiteID,
                            @SiteCode,
                            @SiteName,
                            @AreaID,
                            @AreaCode,
                            @AreaName,
                            @RegionID,
                            @RegionCode,
                            @RegionName,
                            @TerritoryID,
                            @TerritoryCode,
                            @TerritoryName,
                            @CompanyID,
                            @CompanyCode,
                            @CompanyName,
                            @SiteDistributionTypeID,
                            @IsSiteLotNumberEntryRequired,
                            @WarehouseTypeID,
                            @IsWarehouseSOAllowed,
                            @WarehouseStatusID,
                            @IsWarehouseDeleted
                        ) [fW],
                        [dbo].[fProductLot]
                        (
                            @ProductLotID,
                            @ProductLotCode,
                            @ProductID,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,                        
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            @ProductLotExpiredDateFrom,
                            @ProductLotExpiredDateTo,
                            @ProductLotStatusID,
                            @IsProductLotDeleted
                        ) [fPL]
            ) [vWPL] LEFT OUTER JOIN
            [dbo].[fStockOnHandCalc]
            (
                @WarehouseID,
                @TransactionDate,
                @ProductID,
                @ProductLotID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                @IsWarehouseSOAllowed,
                @WarehouseStatusID,
                @IsWarehouseDeleted,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                @IsProductLotDeleted
            ) [fSOHC] ON
            (
                [vWPL].[WarehouseID] = [fSOHC].[WarehouseID] AND
                [vWPL].[ProductID] = [fSOHC].[ProductID] AND
                [vWPL].[ProductLotID] = [fSOHC].[ProductLotID]
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOnHandAll]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOnHandAll];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fStockOnHandAll] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOnHandAll]
AS
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            [QtyTransactionGood],
            [QtyTransactionHold],
            [QtyTransactionBad],
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLot],
            [ProductLotStatusID],
            [ProductLotStatusName],
            [IsProductLotCodeDeleted]
        FROM
			[dbo].[fStockOnHandAll]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOnHandAvailable]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOnHandAvailable];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockOnHandAvailable] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOnHandAvailable]
(    
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [fSOHC].[WarehouseID],
            [fSOHC].[ProductID],
            [fSOHC].[ProductLotID],
            [fSOHC].[QtyPeriodOnHandGood],
            [fSOHC].[QtyPeriodOnHandHold],
            [fSOHC].[QtyPeriodOnHandBad],
            [fSOHC].[QtyTransactionGood],
            [fSOHC].[QtyTransactionHold],
            [fSOHC].[QtyTransactionBad],
            [fSOHC].[QtyPeriodOnHandGood] + [fSOHC].[QtyTransactionGood] [QtyOnHandGood],
            [fSOHC].[QtyPeriodOnHandHold] + [fSOHC].[QtyTransactionHold] [QtyOnHandHold],
            [fSOHC].[QtyPeriodOnHandBad] + [fSOHC].[QtyTransactionBad] [QtyOnHandBad],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],        
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[ExpiredDate] [ProductLotExpiredDate],
            [fPL].[ProductLot] [ProductLot],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            [fPL].[IsDeleted] [IsProductLotCodeDeleted]
        FROM            
            [dbo].[fStockOnHandCalc]
            (
                @WarehouseID,
                @TransactionDate,
                @ProductID,
                @ProductLotID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                @IsWarehouseSOAllowed,
                @WarehouseStatusID,
                @IsWarehouseDeleted,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                @IsProductLotDeleted
            ) [fSOHC] INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,                
                @ProductLotStatusID,
                @IsProductLotDeleted
            ) [fPL] ON
            (
                [fSOHC].[ProductID] = [fPL].[ProductID] AND
                [fSOHC].[ProductLotID] = [fPL].[ID]
            )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOnHandAvailable]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOnHandAvailable];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fStockOnHandAvailable] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOnHandAvailable]
AS
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            [QtyTransactionGood],
            [QtyTransactionHold],
            [QtyTransactionBad],
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLot],
            [ProductLotStatusID],
            [ProductLotStatusName],
            [IsProductLotCodeDeleted]
        FROM
			[dbo].[fStockOnHandAvailable]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOpname]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOpname];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockOpname] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOpname]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @PIC nvarchar(50),
    @ReferenceNumber nvarchar(30),
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SO].[DocumentID],
            [SO].[DocumentCode],
            [SO].[TransactionDate],
            [SO].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [SO].[PIC],
            [SO].[ReferenceNumber],
            [SO].[AttachmentFile],
            [SO].[DocumentStatusID],
            [fSL].[Name] [DocumentStatusName],
            [SO].[PostedDate],
            [SO].[CreatedDate],
            [SO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SO].[ModifiedDate],
            [SO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockOpname] [SO] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SO].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SO].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@WarehouseID IS NULL) OR ([SO].[WarehouseID] = @WarehouseID)) AND
            ((@PIC IS NULL) OR ([SO].[PIC] LIKE '%' + @PIC + '%')) AND
            ((@ReferenceNumber IS NULL) OR ([SO].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SO].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOpname]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOpname];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockOpname] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOpname]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [PIC],
            [ReferenceNumber],
            [AttachmentFile],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockOpname]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOpnameSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOpnameSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockOpnameSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOpnameSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOS].[DocumentID],            
            [SOS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOS].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandHold], 0) ELSE [SOS].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandBad], 0) ELSE [SOS].[QtyOnHandBad] END) [QtyOnHandBad],
            [SOS].[QtyConvLGood],
            [SOS].[QtyConvMGood],
            [SOS].[QtyConvSGood],
            [SOS].[QtyConvLHold],
            [SOS].[QtyConvMHold],
            [SOS].[QtyConvSHold],
            [SOS].[QtyConvLBad],
            [SOS].[QtyConvMBad],
            [SOS].[QtyConvSBad],
            [SOS].[QtyGood],
            [SOS].[QtyHold],
            [SOS].[QtyBad],
            (CAST([SOS].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([SOS].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSGood] AS nvarchar(10))) [QtyOpnameConvGood],
            (CAST([SOS].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSHold] AS nvarchar(10))) [QtyOpnameConvHold],
            (CAST([SOS].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvSBad] AS nvarchar(10))) [QtyOpnameConvBad],
            ([SOS].[QtyOnHandGood] + [SOS].[QtyGood]) [QtyOpnameGood],
            ([SOS].[QtyOnHandHold] + [SOS].[QtyHold]) [QtyOpnameHold],
            ([SOS].[QtyOnHandBad] + [SOS].[QtyBad]) [QtyOpnameBad]
        FROM
			[dbo].[StockOpnameSummary] [SOS] INNER JOIN
            [dbo].[StockOpname] [SO] ON ([SOS].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SO].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOpnameSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOpnameSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockOpnameSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOpnameSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [QtyConvLGood],
            [QtyConvMGood],
            [QtyConvSGood],
            [QtyConvLHold],
            [QtyConvMHold],
            [QtyConvSHold],
            [QtyConvLBad],
            [QtyConvMBad],
            [QtyConvSBad],
            [QtyGood],
            [QtyHold],
            [QtyBad],
            [QtyOpnameConvGood],
            [QtyOpnameConvHold],
            [QtyOpnameConvBad],
            [QtyOpnameGood],
            [QtyOpnameHold],
            [QtyOpnameBad]
        FROM
			[dbo].[fStockOpnameSummary]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockOpnameDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockOpnameDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockOpnameDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockOpnameDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOD].[DocumentID],
            [SOD].[ProductID],
            [SOD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[ExpiredDate] [ProductLotExpiredDate],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOD].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandHold], 0) ELSE [SOD].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandBad], 0) ELSE [SOD].[QtyOnHandBad] END) [QtyOnHandBad],            
            [SOD].[QtyConvLGood],
            [SOD].[QtyConvMGood],
            [SOD].[QtyConvSGood],
            [SOD].[QtyConvLHold],
            [SOD].[QtyConvMHold],
            [SOD].[QtyConvSHold],
            [SOD].[QtyConvLBad],
            [SOD].[QtyConvMBad],
            [SOD].[QtyConvSBad],
            [SOD].[QtyGood],
            [SOD].[QtyHold],
            [SOD].[QtyBad],
            (CAST([SOD].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([SOD].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSGood] AS nvarchar(10))) [QtyOpnameConvGood],
            (CAST([SOD].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSHold] AS nvarchar(10))) [QtyOpnameConvHold],
            (CAST([SOD].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvSBad] AS nvarchar(10))) [QtyOpnameConvBad],
            ([SOD].[QtyOnHandGood] + [SOD].[QtyGood]) [QtyOpnameGood],
            ([SOD].[QtyOnHandHold] + [SOD].[QtyHold]) [QtyOpnameHold],
            ([SOD].[QtyOnHandBad] + [SOD].[QtyBad]) [QtyOpnameBad]
        FROM
			[dbo].[StockOpnameDetails] [SOD] INNER JOIN
            [dbo].[StockOpname] [SO] ON ([SOD].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SO].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOD].[ProductID] = [fSOHA].[ProductID] AND
                [SOD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockOpnameDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockOpnameDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockOpnameDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockOpnameDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],            
            [QtyConvLGood],
            [QtyConvMGood],
            [QtyConvSGood],
            [QtyConvLHold],
            [QtyConvMHold],
            [QtyConvSHold],
            [QtyConvLBad],
            [QtyConvMBad],
            [QtyConvSBad],
            [QtyGood],
            [QtyHold],
            [QtyBad],
            [QtyOpnameConvGood],
            [QtyOpnameConvHold],
            [QtyOpnameConvBad],
            [QtyOpnameGood],
            [QtyOpnameHold],
            [QtyOpnameBad]
        FROM
			[dbo].[fStockOpnameDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockChanges]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockChanges];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockChanges] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockChanges]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @PIC nvarchar(50),
    @OldItemStatusID int,
    @NewItemStatusID int,
    @ReferenceNumber nvarchar(30),
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SC].[DocumentID],
            [SC].[DocumentCode],
            [SC].[TransactionDate],
            [SC].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],            
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SC].[PIC],
            [SC].[OldItemStatusID],
            [fSL].[Name] [OldItemStatusName],
            [SC].[NewItemStatusID],
            [fSL2].[Name] [NewItemStatusName],
            [SC].[ReferenceNumber],
            [SC].[AttachmentFile],
            [SC].[DocumentStatusID],
            [fSL3].[Name] [DocumentStatusName],
            [SC].[PostedDate],
            [SC].[CreatedDate],
            [SC].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SC].[ModifiedDate],
            [SC].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockChanges] [SC] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SC].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductItemStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SC].[OldItemStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductItemStatus',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SC].[NewItemStatusID] = [fSL2].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SC].[DocumentStatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SC].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SC].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SC].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SC].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SC].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SC].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@WarehouseID IS NULL) OR ([SC].[WarehouseID] = @WarehouseID)) AND
            ((@PIC IS NULL) OR ([SC].[PIC] LIKE '%' + @PIC + '%')) AND
            ((@OldItemStatusID IS NULL) OR ([SC].[OldItemStatusID] = @OldItemStatusID)) AND
            ((@NewItemStatusID IS NULL) OR ([SC].[NewItemStatusID] = @NewItemStatusID)) AND
            ((@ReferenceNumber IS NULL) OR ([SC].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SC].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SC].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SC].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockChanges]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockChanges];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockChanges] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockChanges]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],            
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [PIC],
            [OldItemStatusID],
            [OldItemStatusName],
            [NewItemStatusID],
            [NewItemStatusName],
            [ReferenceNumber],
            [AttachmentFile],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockChanges]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockChangesSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockChangesSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockChangesSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockChangesSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SCS].[DocumentID],            
            [SCS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (
                SELECT CASE
                    WHEN [SC].[DocumentStatusID] = 1 THEN
                        (
                            SELECT CASE
                                WHEN [SC].[OldItemStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0)
                                WHEN [SC].[OldItemStatusID] = 2 THEN ISNULL([SOHA].[QtyOnHandHold], 0)
                                WHEN [SC].[OldItemStatusID] = 3 THEN ISNULL([SOHA].[QtyOnHandBad], 0)
                            END
                        )
                    ELSE
                        [SCS].[QtyOnHand]
                END
            ) [QtyOnHand],
            [SCS].[QtyConvL],
            [SCS].[QtyConvM],
            [SCS].[QtyConvS],
            [SCS].[Qty],
            (CAST([SCS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SCS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SCS].[QtyConvS] AS nvarchar(10))) [QtyChangesConv],
            ([SCS].[Qty] * -1) [QtyChanges]
        FROM
			[dbo].[StockChangesSummary] [SCS] INNER JOIN
            [dbo].[StockChanges] [SC] ON ([SCS].[DocumentID] = [SC].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SC].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SCS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SCS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SCS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SCS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockChangesSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockChangesSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockChangesSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockChangesSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],            
            [Qty],
            [QtyChangesConv],
            [QtyChanges]
        FROM
			[dbo].[fStockChangesSummary]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockChangesDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockChangesDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockChangesDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockChangesDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SCD].[DocumentID],
            [SCD].[ProductID],
            [SCD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (
                SELECT CASE
                    WHEN [SC].[DocumentStatusID] = 1 THEN
                        (
                            SELECT CASE
                                WHEN [SC].[OldItemStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0)
                                WHEN [SC].[OldItemStatusID] = 2 THEN ISNULL([fSOHA].[QtyOnHandHold], 0)
                                WHEN [SC].[OldItemStatusID] = 3 THEN ISNULL([fSOHA].[QtyOnHandBad], 0)
                            END
                        )
                    ELSE
                        [SCD].[QtyOnHand]
                END
            ) [QtyOnHand],
            [SCD].[QtyConvL],
            [SCD].[QtyConvM],
            [SCD].[QtyConvS],
            [SCD].[Qty],
            (CAST([SCD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SCD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SCD].[QtyConvS] AS nvarchar(10))) [QtyChangesConv],
            ([SCD].[Qty] * -1) [QtyChanges]
        FROM
			[dbo].[StockChangesDetails] [SCD] INNER JOIN
            [dbo].[StockChanges] [SC] ON ([SCD].[DocumentID] = [SC].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SC].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SCD].[ProductID] = [fSOHA].[ProductID] AND
                [SCD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SCD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SCD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SCD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SCD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockChangesDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockChangesDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockChangesDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockChangesDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyChangesConv],
            [QtyChanges]
        FROM
			[dbo].[fStockChangesDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockTransfer]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockTransfer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockTransfer] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockTransfer]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SourceWarehouseID uniqueidentifier,
    @SourceWarehouseCode nvarchar(10),
    @SourceWarehouseName nvarchar(50),
    @SourceSiteID uniqueidentifier,
    @SourceSiteCode nvarchar(10),
    @SourceSiteName nvarchar(50),
    @SourceCompanyID int,
    @SourceCompanyCode nvarchar(10),
    @SourceCompanyName nvarchar(50),
    @SourceAreaID int,
    @SourceAreaCode nvarchar(10),
    @SourceAreaName nvarchar(50),
    @SourceRegionID int,
    @SourceRegionCode nvarchar(10),
    @SourceRegionName nvarchar(50),
    @SourceTerritoryID int,
    @SourceTerritoryCode nvarchar(10),
    @SourceTerritoryName nvarchar(50),    
    @SourceSiteDistributionTypeID int,
    @IsSourceSiteLotNumberEntryRequired bit,
    @SourceWarehouseTypeID int,
    @SourcePIC nvarchar(50),
    @DestinationWarehouseID uniqueidentifier,
    @DestinationWarehouseCode nvarchar(10),
    @DestinationWarehouseName nvarchar(50),
    @DestinationSiteID uniqueidentifier,
    @DestinationSiteCode nvarchar(10),
    @DestinationSiteName nvarchar(50),
    @DestinationCompanyID int,
    @DestinationCompanyCode nvarchar(10),
    @DestinationCompanyName nvarchar(50),
    @DestinationAreaID int,
    @DestinationAreaCode nvarchar(10),
    @DestinationAreaName nvarchar(50),
    @DestinationRegionID int,
    @DestinationRegionCode nvarchar(10),
    @DestinationRegionName nvarchar(50),
    @DestinationTerritoryID int,
    @DestinationTerritoryCode nvarchar(10),
    @DestinationTerritoryName nvarchar(50),    
    @DestinationSiteDistributionTypeID int,
    @DestinationWarehouseTypeID int,
    @IsDestinationSiteLotNumberEntryRequired bit,
    @DestinationPIC nvarchar(50),
    @ReferenceNumber nvarchar(30),
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [ST].[DocumentID],
            [ST].[DocumentCode],
            [ST].[TransactionDate],
            [ST].[SourceWarehouseID],
            [fWSrc].[Code] [SourceWarehouseCode],
            [fWSrc].[Name] [SourceWarehouseName],
            [fWSrc].[Warehouse] [SourceWarehouse],
            [fWSrc].[SiteID] [SourceSiteID],
            [fWSrc].[SiteCode] [SourceSiteCode],
            [fWSrc].[SiteName] [SourceSiteName],
            [fWSrc].[Site] [SourceSite],
            [fWSrc].[CompanyID] [SourceCompanyID],
            [fWSrc].[CompanyCode] [SourceCompanyCode],
            [fWSrc].[CompanyName] [SourceCompanyName],
            [fWSrc].[Company] [SourceCompany],
            [fWSrc].[AreaID] [SourceAreaID],
            [fWSrc].[AreaCode] [SourceAreaCode],
            [fWSrc].[AreaName] [SourceAreaName],
            [fWSrc].[Area] [SourceArea],
            [fWSrc].[RegionID] [SourceRegionID],
            [fWSrc].[RegionCode] [SourceRegionCode],
            [fWSrc].[RegionName] [SourceRegionName],
            [fWSrc].[Region] [SourceRegion],
            [fWSrc].[TerritoryID] [SourceTerritoryID],
            [fWSrc].[TerritoryCode] [SourceTerritoryCode],
            [fWSrc].[TerritoryName] [SourceTerritoryName],
            [fWSrc].[Territory] [SourceTerritory],
            [fWSrc].[SiteDistributionTypeID] [SourceSiteDistributionTypeID],
            [fWSrc].[SiteDistributionTypeName] [SourceSiteDistributionTypeName],
            [fWSrc].[IsSiteLotNumberEntryRequired] [IsSourceSiteLotNumberEntryRequired],
            [fWSrc].[TypeID] [SourceWarehouseTypeID],
            [fWSrc].[TypeName] [SourceWarehouseTypeName],
            [ST].[SourcePIC],
            [ST].[DestinationWarehouseID],
            [fWDest].[Code] [DestinationWarehouseCode],
            [fWDest].[Name] [DestinationWarehouseName],
            [fWDest].[Warehouse] [DestinationWarehouse],
            [fWDest].[SiteID] [DestinationSiteID],
            [fWDest].[SiteCode] [DestinationSiteCode],
            [fWDest].[SiteName] [DestinationSiteName],
            [fWDest].[Site] [DestinationSite],
            [fWDest].[CompanyID] [DestinationCompanyID],
            [fWDest].[CompanyCode] [DestinationCompanyCode],
            [fWDest].[CompanyName] [DestinationCompanyName],
            [fWDest].[Company] [DestinationCompany],
            [fWDest].[AreaID] [DestinationAreaID],
            [fWDest].[AreaCode] [DestinationAreaCode],
            [fWDest].[AreaName] [DestinationAreaName],
            [fWDest].[Area] [DestinationArea],
            [fWDest].[RegionID] [DestinationRegionID],
            [fWDest].[RegionCode] [DestinationRegionCode],
            [fWDest].[RegionName] [DestinationRegionName],
            [fWDest].[Region] [DestinationRegion],
            [fWDest].[TerritoryID] [DestinationTerritoryID],
            [fWDest].[TerritoryCode] [DestinationTerritoryCode],
            [fWDest].[TerritoryName] [DestinationTerritoryName],
            [fWDest].[Territory] [DestinationTerritory],
            [fWDest].[SiteDistributionTypeID] [DestinationSiteDistributionTypeID],
            [fWDest].[SiteDistributionTypeName] [DestinationSiteDistributionTypeName],
            [fWDest].[IsSiteLotNumberEntryRequired] [IsDestinationSiteLotNumberEntryRequired],
            [fWDest].[TypeID] [DestinationWarehouseTypeID],
            [fWDest].[TypeName] [DestinationWarehouseTypeName],
            [ST].[DestinationPIC],
            [ST].[ReferenceNumber],
            [ST].[AttachmentFile],
            [ST].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [ST].[DocumentStatusID],
            [fSL].[Name] [DocumentStatusName],
            [ST].[PostedDate],
            [ST].[CreatedDate],
            [ST].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [ST].[ModifiedDate],
            [ST].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockTransfer] [ST] INNER JOIN
            [dbo].[fWarehouse]
            (
                @SourceWarehouseID,
                @SourceWarehouseCode,
                @SourceWarehouseName,
                @SourceSiteID,
                @SourceSiteCode,
                @SourceSiteName,
                @SourceAreaID,
                @SourceAreaCode,
                @SourceAreaName,
                @SourceRegionID,
                @SourceRegionCode,
                @SourceRegionName,
                @SourceTerritoryID,
                @SourceTerritoryCode,
                @SourceTerritoryName,
                @SourceCompanyID,
                @SourceCompanyCode,
                @SourceCompanyName,
                @SourceSiteDistributionTypeID,
                @IsSourceSiteLotNumberEntryRequired,
                @SourceWarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fWSrc] ON ([ST].[SourceWarehouseID] = [fWSrc].[ID]) INNER JOIN
            [dbo].[fWarehouse]
            (
                @DestinationWarehouseID,
                @DestinationWarehouseCode,
                @DestinationWarehouseName,
                @DestinationSiteID,
                @DestinationSiteCode,
                @DestinationSiteName,
                @DestinationAreaID,
                @DestinationAreaCode,
                @DestinationAreaName,
                @DestinationRegionID,
                @DestinationRegionCode,
                @DestinationRegionName,
                @DestinationTerritoryID,
                @DestinationTerritoryCode,
                @DestinationTerritoryName,
                @DestinationCompanyID,
                @DestinationCompanyCode,
                @DestinationCompanyName,
                @DestinationSiteDistributionTypeID,
                @IsDestinationSiteLotNumberEntryRequired,
                @DestinationWarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fWDest] ON ([ST].[DestinationWarehouseID] = [fWDest].[ID]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([ST].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([ST].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([ST].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([ST].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([ST].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([ST].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ([dbo].[ValidateMaxDate]([ST].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom)) AND
            ([dbo].[ValidateMinDate]([ST].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo)) AND
            ((@SourceWarehouseID IS NULL) OR ([ST].[SourceWarehouseID] = @SourceWarehouseID)) AND
            ((@SourcePIC IS NULL) OR ([ST].[SourcePIC] LIKE '%' + @SourcePIC + '%')) AND
            ((@DestinationWarehouseID IS NULL) OR ([ST].[DestinationWarehouseID] = @DestinationWarehouseID)) AND
            ((@DestinationPIC IS NULL) OR ([ST].[DestinationPIC] LIKE '%' + @DestinationPIC + '%')) AND
            ((@ReferenceNumber IS NULL) OR ([ST].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([ST].[DODocumentID] = @DODocumentID)) AND            
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([ST].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([ST].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([ST].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockTransfer]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockTransfer];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockTransfer] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockTransfer]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [SourceWarehouseID],
            [SourceWarehouseCode],
            [SourceWarehouseName],
            [SourceWarehouse],
            [SourceSiteID],
            [SourceSiteCode],
            [SourceSiteName],
            [SourceSite],
            [SourceCompanyID],
            [SourceCompanyCode],
            [SourceCompanyName],
            [SourceCompany],
            [SourceAreaID],
            [SourceAreaCode],
            [SourceAreaName],
            [SourceArea],
            [SourceRegionID],
            [SourceRegionCode],
            [SourceRegionName],
            [SourceRegion],
            [SourceTerritoryID],
            [SourceTerritoryCode],
            [SourceTerritoryName],
            [SourceTerritory],
            [SourceSiteDistributionTypeID],
            [SourceSiteDistributionTypeName],
            [IsSourceSiteLotNumberEntryRequired],
            [SourceWarehouseTypeID],
            [SourceWarehouseTypeName],
            [SourcePIC],
            [DestinationWarehouseID],
            [DestinationWarehouseCode],
            [DestinationWarehouseName],
            [DestinationWarehouse],
            [DestinationSiteID],
            [DestinationSiteCode],
            [DestinationSiteName],
            [DestinationSite],
            [DestinationCompanyID],
            [DestinationCompanyCode],
            [DestinationCompanyName],
            [DestinationCompany],
            [DestinationAreaID],
            [DestinationAreaCode],
            [DestinationAreaName],
            [DestinationArea],
            [DestinationRegionID],
            [DestinationRegionCode],
            [DestinationRegionName],
            [DestinationRegion],
            [DestinationTerritoryID],
            [DestinationTerritoryCode],
            [DestinationTerritoryName],
            [DestinationTerritory],
            [DestinationSiteDistributionTypeID],
            [DestinationSiteDistributionTypeName],            
            [DestinationWarehouseTypeID],
            [DestinationWarehouseTypeName],
            [IsDestinationSiteLotNumberEntryRequired],
            [DestinationPIC],
            [ReferenceNumber],
            [AttachmentFile],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockTransfer]
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
                NULL,
                NULL,
                NULL,
                NULL,
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockTransferSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockTransferSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockTransferSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockTransferSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [STS].[DocumentID],            
            [STS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [STS].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandHold], 0) ELSE [STS].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandBad], 0) ELSE [STS].[QtyOnHandBad] END) [QtyOnHandBad],
            [STS].[QtyConvLGood],
            [STS].[QtyConvMGood],
            [STS].[QtyConvSGood],
            [STS].[QtyConvLHold],
            [STS].[QtyConvMHold],
            [STS].[QtyConvSHold],
            [STS].[QtyConvLBad],
            [STS].[QtyConvMBad],
            [STS].[QtyConvSBad],
            [STS].[QtyGood],
            [STS].[QtyHold],
            [STS].[QtyBad],
            (CAST([STS].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([STS].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([STS].[QtyConvSGood] AS nvarchar(10))) [QtyTransferConvGood],
            (CAST([STS].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([STS].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([STS].[QtyConvSHold] AS nvarchar(10))) [QtyTransferConvHold],
            (CAST([STS].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([STS].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([STS].[QtyConvSBad] AS nvarchar(10))) [QtyTransferConvBad],
            ([STS].[QtyGood] * -1) [QtyTransferGood],
            ([STS].[QtyHold] * -1) [QtyTransferHold],
            ([STS].[QtyBad] * -1) [QtyTransferBad]
        FROM
			[dbo].[StockTransferSummary] [STS] INNER JOIN
            [dbo].[StockTransfer] [ST] ON ([STS].[DocumentID] = [ST].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [ST].[SourceWarehouseID] = [SOHA].[WarehouseID] AND
                [STS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([STS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([STS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([STS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockTransferSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockTransferSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockTransferSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockTransferSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],        
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [QtyConvLGood],
            [QtyConvMGood],
            [QtyConvSGood],
            [QtyConvLHold],
            [QtyConvMHold],
            [QtyConvSHold],
            [QtyConvLBad],
            [QtyConvMBad],
            [QtyConvSBad],
            [QtyGood],
            [QtyHold],
            [QtyBad],
            [QtyTransferConvGood],
            [QtyTransferConvHold],
            [QtyTransferConvBad],
            [QtyTransferGood],
            [QtyTransferHold],
            [QtyTransferBad]
        FROM
			[dbo].[fStockTransferSummary]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockTransferDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockTransferDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockTransferDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockTransferDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),    
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [STD].[DocumentID],
            [STD].[ProductID],
            [STD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[ExpiredDate] [ProductLotExpiredDate],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [STD].[QtyOnHandGood] END) [QtyOnHandGood],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandHold], 0) ELSE [STD].[QtyOnHandHold] END) [QtyOnHandHold],
            (SELECT CASE WHEN [ST].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandBad], 0) ELSE [STD].[QtyOnHandBad] END) [QtyOnHandBad],                       
            [STD].[QtyConvLGood],
            [STD].[QtyConvMGood],
            [STD].[QtyConvSGood],
            [STD].[QtyConvLHold],
            [STD].[QtyConvMHold],
            [STD].[QtyConvSHold],
            [STD].[QtyConvLBad],
            [STD].[QtyConvMBad],
            [STD].[QtyConvSBad],
            [STD].[QtyGood],
            [STD].[QtyHold],
            [STD].[QtyBad],
            (CAST([STD].[QtyConvLGood] AS nvarchar(10)) + '/' +  CAST([STD].[QtyConvMGood] AS nvarchar(10)) + '/' + CAST([STD].[QtyConvSGood] AS nvarchar(10))) [QtyTransferConvGood],
            (CAST([STD].[QtyConvLHold] AS nvarchar(10)) + '/' + CAST([STD].[QtyConvMHold] AS nvarchar(10)) + '/' + CAST([STD].[QtyConvSHold] AS nvarchar(10))) [QtyTransferConvHold],
            (CAST([STD].[QtyConvLBad] AS nvarchar(10)) + '/' + CAST([STD].[QtyConvMBad] AS nvarchar(10)) + '/' + CAST([STD].[QtyConvSBad] AS nvarchar(10))) [QtyTransferConvBad],            
            ([STD].[QtyGood] * -1) [QtyTransferGood],
            ([STD].[QtyHold] * -1) [QtyTransferHold],
            ([STD].[QtyBad] * -1) [QtyTransferBad]
        FROM
			[dbo].[StockTransferDetails] [STD] INNER JOIN
            [dbo].[StockTransfer] [ST] ON ([STD].[DocumentID] = [ST].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [ST].[SourceWarehouseID] = [fSOHA].[WarehouseID] AND
                [STD].[ProductID] = [fSOHA].[ProductID] AND
                [STD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,            
                @ProductShortName,            
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([STD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([STD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([STD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([STD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockTransferDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockTransferDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockTransferDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockTransferDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],            
            [QtyConvLGood],
            [QtyConvMGood],
            [QtyConvSGood],
            [QtyConvLHold],
            [QtyConvMHold],
            [QtyConvSHold],
            [QtyConvLBad],
            [QtyConvMBad],
            [QtyConvSBad],
            [QtyGood],
            [QtyHold],
            [QtyBad],
            [QtyTransferConvGood],
            [QtyTransferConvHold],
            [QtyTransferConvBad],
            [QtyTransferGood],
            [QtyTransferHold],
            [QtyTransferBad]
        FROM
			[dbo].[fStockTransferDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockDisposal]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockDisposal];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockDisposal] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockDisposal]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @PIC nvarchar(50),
    @ReferenceNumber nvarchar(30),
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SD].[DocumentID],
            [SD].[DocumentCode],
            [SD].[TransactionDate],
            [SD].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],            
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SD].[PIC],
            [SD].[ReferenceNumber],
            [SD].[AttachmentFile],
            [SD].[DocumentStatusID],
            [fSL].[Name] [DocumentStatusName],
            [SD].[PostedDate],
            [SD].[CreatedDate],
            [SD].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SD].[ModifiedDate],
            [SD].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockDisposal] [SD] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SD].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SD].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SD].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SD].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SD].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SD].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SD].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SD].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@WarehouseID IS NULL) OR ([SD].[WarehouseID] = @WarehouseID)) AND
            ((@PIC IS NULL) OR ([SD].[PIC] LIKE '%' + @PIC + '%')) AND
            ((@ReferenceNumber IS NULL) OR ([SD].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SD].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SD].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SD].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockDisposal]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockDisposal];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockDisposal] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockDisposal]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],            
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [PIC],
            [ReferenceNumber],
            [AttachmentFile],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockDisposal]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockDisposalSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockDisposalSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockDisposalSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockDisposalSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SDS].[DocumentID],            
            [SDS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],        
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SD].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandBad], 0) ELSE [SDS].[QtyOnHand] END) [QtyOnHand],
            [SDS].[QtyConvL],
            [SDS].[QtyConvM],
            [SDS].[QtyConvS],
            [SDS].[Qty],
            (CAST([SDS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SDS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SDS].[QtyConvS] AS nvarchar(10))) [QtyDisposalConv],
            ([SDS].[Qty] * -1) [QtyDisposal]
        FROM
			[dbo].[StockDisposalSummary] [SDS] INNER JOIN
            [dbo].[StockDisposal] [SD] ON ([SDS].[DocumentID] = [SD].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SD].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SDS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SDS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SDS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SDS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockDisposalSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockDisposalSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockDisposalSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockDisposalSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],            
            [Qty],
            [QtyDisposalConv],
            [QtyDisposal]
        FROM
			[dbo].[fStockDisposalSummary]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockDisposalDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockDisposalDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockDisposalDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockDisposalDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SDD].[DocumentID],
            [SDD].[ProductID],
            [SDD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SD].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandBad], 0) ELSE [SDD].[QtyOnHand] END) [QtyOnHand],
            [SDD].[QtyConvL],
            [SDD].[QtyConvM],
            [SDD].[QtyConvS],
            [SDD].[Qty],
            (CAST([SDD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SDD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SDD].[QtyConvS] AS nvarchar(10))) [QtyDisposalConv],
            ([SDD].[Qty] * -1) [QtyDisposal]
        FROM
			[dbo].[StockDisposalDetails] [SDD] INNER JOIN
            [dbo].[StockDisposal] [SD] ON ([SDD].[DocumentID] = [SD].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SD].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SDD].[ProductID] = [fSOHA].[ProductID] AND
                [SDD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SDD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SDD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SDD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SDD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockDisposalDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockDisposalDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockDisposalDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockDisposalDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],        
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyDisposalConv],
            [QtyDisposal]
        FROM
			[dbo].[fStockDisposalDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockReceiveSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockReceiveSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockReceiveSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockReceiveSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SRS].[DocumentID],            
            [SRS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],        
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SR].[DocumentStatusID] = 1 THEN ISNULL([SOOHA].[QtyOnHandGood], 0) ELSE [SRS].[QtyOnHand] END) [QtyOnHand],
            [SRS].[QtyConvL],
            [SRS].[QtyConvM],
            [SRS].[QtyConvS],
            [SRS].[Qty],
            (CAST([SRS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SRS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SRS].[QtyConvS] AS nvarchar(10))) [QtyReceiveConv],
            ([SRS].[Qty] * -1) [QtyReceive]
        FROM
			[dbo].[StockReceiveSummary] [SRS] INNER JOIN
            [dbo].[StockReceive] [SR] ON ([SRS].[DocumentID] = [SR].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOOHA] ON
            (
                [SR].[WarehouseID] = [SOOHA].[WarehouseID] AND
                [SRS].[ProductID] = [SOOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SRS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SRS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SRS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockReceiveSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockReceiveSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockReceiveSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockReceiveSummary]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],            
            [Qty],
            [QtyReceiveConv],
            [QtyReceive]
        FROM
			[dbo].[fStockReceiveSummary]
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
                NULL                
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockReceive]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockReceive];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[StockReceive] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockReceive]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @PIC nvarchar(50),
    @ReferenceNumber nvarchar(30),
    @DocumentStatusID int,
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SR].[DocumentID],
            [SR].[DocumentCode],
            [SR].[TransactionDate],
            [SR].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [SR].[PIC],
            [SR].[ReferenceNumber],
            [SR].[AttachmentFile],
            [SR].[DocumentStatusID],
            [fSL].[Name] [DocumentStatusName],
            [SR].[PostedDate],
            [SR].[CreatedDate],
            [SR].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SR].[ModifiedDate],
            [SR].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[StockReceive] [SR] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SR].[WarehouseID] = [fW].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SR].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SR].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SR].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SR].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SR].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SR].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SR].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@WarehouseID IS NULL) OR ([SR].[WarehouseID] = @WarehouseID)) AND
            ((@PIC IS NULL) OR ([SR].[PIC] LIKE '%' + @PIC + '%')) AND
            ((@ReferenceNumber IS NULL) OR ([SR].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SR].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SR].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SR].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockReceive]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockReceive];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockReceive] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockReceive]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],            
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [PIC],
            [ReferenceNumber],
            [AttachmentFile],
            [DocumentStatusID],
            [DocumentStatusName],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fStockReceive]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockReceiveDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockReceiveDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[StockReceiveDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockReceiveDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SRD].[DocumentID],
            [SRD].[ProductID],
            [SRD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SR].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SRD].[QtyOnHand] END) [QtyOnHand],
            [SRD].[QtyConvL],
            [SRD].[QtyConvM],
            [SRD].[QtyConvS],
            [SRD].[Qty],
            (CAST([SRD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SRD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SRD].[QtyConvS] AS nvarchar(10))) [QtyReceiveConv],
            ([SRD].[Qty] * -1) [QtyReceive]
        FROM
			[dbo].[StockReceiveDetails] [SRD] INNER JOIN
            [dbo].[StockReceive] [SR] ON ([SRD].[DocumentID] = [SR].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SR].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SRD].[ProductID] = [fSOHA].[ProductID] AND
                [SRD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SRD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SRD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SRD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SRD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockReceiveDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockReceiveDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fStockReceiveDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockReceiveDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],        
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyReceiveConv],
            [QtyReceive]
        FROM
			[dbo].[fStockReceiveDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrder]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrder] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrder]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @PODocumentID uniqueidentifier,
    @PODocumentCode nvarchar(30),
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @TermOfPaymentID int,
    @ReferenceNumber nvarchar(30),
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @InvoiceDocumentID uniqueidentifier,
    @InvoiceDocumentCode nvarchar(30),    
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SO].[DocumentID],
            [SO].[DocumentCode],
            [SO].[TransactionDate],
            [SO].[PODocumentID],
            [PO].[DocumentCode] [PODocumentCode],
            [PO].[TransactionDate] [POTransactionDate],
            [SO].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SO].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SO].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SO].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [SO].[DiscountGroupID],
            [DG].[Code] [DiscountGroupCode],
            [DG].[Name] [DiscountGroupName],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description] [DiscountGroupDescription],
            [SO].[TermOfPaymentID],
            [fSL2].[Name] [TermOfPaymentName],            
            [SO].[ReferenceNumber],
            [SO].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SO].[InvoiceDocumentID],
            [I].[DocumentCode] [InvoiceDocumentCode],
            [SO].[RawTotalGrossPrice],    
            [SO].[RawTotalPrice],
            [SO].[RawTotalDiscountStrata1Amount],
            [SO].[RawTotalDiscountStrata2Amount],
            [SO].[RawTotalDiscountStrata3Amount],
            [SO].[RawTotalDiscountStrata4Amount],
            [SO].[RawTotalDiscountStrata5Amount],
            [SO].[RawTotalAddDiscountStrataAmount],
            [SO].[RawTotalGross],
            [SO].[RawTotalTax],
            [SO].[RawTotal],
            [SO].[TotalGrossPrice],    
            [SO].[TotalPrice],
            [SO].[TotalDiscountStrata1Amount],
            [SO].[TotalDiscountStrata2Amount],
            [SO].[TotalDiscountStrata3Amount],
            [SO].[TotalDiscountStrata4Amount],
            [SO].[TotalDiscountStrata5Amount],
            [SO].[TotalAddDiscountStrataAmount],
            [SO].[TotalGross],
            [SO].[TotalTax],
            [SO].[Total],
            [SO].[TotalWeight],
            [SO].[TotalDimension],
            [SO].[AddDiscountStrataReason],
            [SO].[DocumentStatusID],
            [fSL3].[Name] [DocumentStatusName],
            [SO].[DocumentStatusReason],
            [SO].[PostedDate],
            [SO].[CreatedDate],
            [SO].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SO].[ModifiedDate],
            [SO].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrder] [SO] LEFT OUTER JOIN
            [dbo].[PurchaseOrder] [PO] ON ([SO].[PODocumentID] = [PO].[DocumentID]) INNER JOIN
            [dbo].[Salesman] [S] ON ([SO].[SalesmanID] = [S].[ID]) INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SO].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SO].[CustomerID] = [C].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SO].[PriceGroupID] = [fSL].[Value_Int32]) INNER JOIN
            [dbo].[DiscountGroup] [DG] ON ([SO].[DiscountGroupID] = [DG].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SO].[TermOfPaymentID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SO].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[Invoice] [I] ON ([SO].[InvoiceDocumentID] = [I].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SO].[DocumentStatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SO].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SO].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SO].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SO].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SO].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SO].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@PODocumentID IS NULL) OR ([SO].[PODocumentID] = @PODocumentID)) AND
            ((@PODocumentCode IS NULL) OR ([PO].[DocumentCode] LIKE '%' + @PODocumentCode + '%')) AND
            ((@SalesmanID IS NULL) OR (@SalesmanID = [S].[ID])) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND            
            ((@WarehouseID IS NULL) OR ([SO].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SO].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@PriceGroupID IS NULL) OR ([SO].[PriceGroupID] = @PriceGroupID)) AND
            ((@DiscountGroupID IS NULL) OR ([SO].[DiscountGroupID] = @DiscountGroupID)) AND
            ((@DiscountGroupCode IS NULL) OR ([DG].[Code] LIKE '%' + @DiscountGroupCode + '%')) AND
            ((@DiscountGroupName IS NULL) OR ([DG].[Name] LIKE '%' + @DiscountGroupName + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([SO].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@ReferenceNumber IS NULL) OR ([SO].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SO].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@InvoiceDocumentID IS NULL) OR ([SO].[InvoiceDocumentID] = @InvoiceDocumentID)) AND
            ((@InvoiceDocumentCode IS NULL) OR ([I].[DocumentCode] LIKE '%' + @InvoiceDocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SO].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SO].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SO].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SO].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrder]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrder];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrder] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrder]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [PODocumentID],
            [PODocumentCode],
            [POTransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [TermOfPaymentID],
            [TermOfPaymentName],            
            [ReferenceNumber],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [InvoiceDocumentID],
            [InvoiceDocumentCode],
            [RawTotalGrossPrice],    
            [RawTotalPrice],
            [RawTotalDiscountStrata1Amount],
            [RawTotalDiscountStrata2Amount],
            [RawTotalDiscountStrata3Amount],
            [RawTotalDiscountStrata4Amount],
            [RawTotalDiscountStrata5Amount],
            [RawTotalAddDiscountStrataAmount],
            [RawTotalGross],
            [RawTotalTax],
            [RawTotal],
            [TotalGrossPrice],    
            [TotalPrice],
            [TotalDiscountStrata1Amount],
            [TotalDiscountStrata2Amount],
            [TotalDiscountStrata3Amount],
            [TotalDiscountStrata4Amount],
            [TotalDiscountStrata5Amount],
            [TotalAddDiscountStrataAmount],
            [TotalGross],
            [TotalTax],
            [Total],
            [TotalWeight],
            [TotalDimension],
            [AddDiscountStrataReason],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrder]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockTransactionSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockTransactionSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve summary of
--                 [dbo].[StockTransactionSummary] data.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockTransactionSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @TransactionTypeID int,
    @DocumentCode nvarchar(30),
    @SourceID uniqueidentifier,
    @DestinationID uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
    (
        SELECT
                [WarehouseID],
                [ProductID],
                [ProductLotID],
                SUM([QtyGood]) [SumQtyGood],
                SUM([QtyHold]) [SumQtyHold],
                SUM([QtyBad]) [SumQtyBad]
            FROM
            (
                SELECT
                        (
                            SELECT CASE
                                WHEN
                                    ([TransactionTypeID] = 2) OR  -- Sales Order Return
                                    ([TransactionTypeID] = 8)     -- Stock Transfer
                                THEN
                                    [DestinationID]
                                ELSE
                                    [SourceID]
                            END
                        ) [WarehouseID],
                        [ProductID],
                        [ProductLotID],
                        [QtyGood],
                        [QtyHold],
                        [QtyBad]
                    FROM
			            [dbo].[StockTransaction]
                    WHERE
                    ((@DocumentID IS NULL) OR ([DocumentID] = @DocumentID)) AND
                    ((@ProductID IS NULL) OR ([ProductID] = @ProductID)) AND
                    ((@ProductLotID IS NULL) OR ([ProductLotID] = @ProductLotID)) AND
                    ((@TransactionDateFrom IS NULL) OR ([TransactionDate] >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
                    ((@TransactionDateTo IS NULL) OR ([TransactionDate] <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
                    ((@DocumentCode IS NULL) OR ([DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
                    (
                        ((@SourceID IS NULL) OR ([SourceID] = @SourceID)) OR
                        ((@DestinationID IS NULL) OR ([DestinationID] = @DestinationID))
                    )                            
            ) [svST]
            GROUP BY
                [WarehouseID],
                [ProductID],
                [ProductLotID]
    )
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockTransactionSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockTransactionSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fStockTransactionSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockTransactionSummary]
AS
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [SumQtyGood],
            [SumQtyHold],
            [SumQtyBad]
        FROM
			[dbo].[fStockTransactionSummary]
            (
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOS].[DocumentID],            
            [SOS].[ProductID],
            [SOS].[PriceDate],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOS].[QtyOnHand] END) [QtyOnHand],
            [SOS].[QtyConvL],
            [SOS].[QtyConvM],
            [SOS].[QtyConvS],
            [SOS].[Qty],
            (CAST([SOS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOS].[Qty] * -1) [QtyOrder],
            [SOS].[UnitGrossPrice],    
            [SOS].[UnitPrice],
            [SOS].[DiscountStrata1Percentage],
            [SOS].[DiscountStrata2Percentage],
            [SOS].[DiscountStrata3Percentage],
            [SOS].[DiscountStrata4Percentage],
            [SOS].[DiscountStrata5Percentage],
            [SOS].[AddDiscountStrataPercentage],
            [SOS].[TaxPercentage],
            [SOS].[RawSubtotalGrossPrice],
            [SOS].[RawSubtotalPrice],
            [SOS].[RawSubtotalDiscountStrata1],
            ([SOS].[RawSubtotalPrice] - [SOS].[RawSubtotalDiscountStrata1]) [RawDiscountStrata1Amount],            
            [SOS].[RawSubtotalDiscountStrata2],
            ([SOS].[RawSubtotalDiscountStrata1] - [SOS].[RawSubtotalDiscountStrata2]) [RawDiscountStrata2Amount],
            [SOS].[RawSubtotalDiscountStrata3],
            ([SOS].[RawSubtotalDiscountStrata2] - [SOS].[RawSubtotalDiscountStrata3]) [RawDiscountStrata3Amount],
            [SOS].[RawSubtotalDiscountStrata4],
            ([SOS].[RawSubtotalDiscountStrata3] - [SOS].[RawSubtotalDiscountStrata4]) [RawDiscountStrata4Amount],
            [SOS].[RawSubtotalDiscountStrata5],
            ([SOS].[RawSubtotalDiscountStrata4] - [SOS].[RawSubtotalDiscountStrata5]) [RawDiscountStrata5Amount],
            ([SOS].[RawSubtotalDiscountStrata5] - [SOS].[RawSubtotal]) [RawAddDiscountStrataAmount],
            [SOS].[RawSubtotalGross],
            [SOS].[RawSubtotalTax],
            [SOS].[RawSubtotal],
            [SOS].[SubtotalGrossPrice],
            [SOS].[SubtotalPrice],
            [SOS].[SubtotalDiscountStrata1],
            ([SOS].[SubtotalPrice] - [SOS].[SubtotalDiscountStrata1]) [DiscountStrata1Amount],            
            [SOS].[SubtotalDiscountStrata2],
            ([SOS].[SubtotalDiscountStrata1] - [SOS].[SubtotalDiscountStrata2]) [DiscountStrata2Amount],
            [SOS].[SubtotalDiscountStrata3],
            ([SOS].[SubtotalDiscountStrata2] - [SOS].[SubtotalDiscountStrata3]) [DiscountStrata3Amount],
            [SOS].[SubtotalDiscountStrata4],
            ([SOS].[SubtotalDiscountStrata3] - [SOS].[SubtotalDiscountStrata4]) [DiscountStrata4Amount],
            [SOS].[SubtotalDiscountStrata5],
            ([SOS].[SubtotalDiscountStrata4] - [SOS].[SubtotalDiscountStrata5]) [DiscountStrata5Amount],
            ([SOS].[SubtotalDiscountStrata5] - [SOS].[Subtotal]) [AddDiscountStrataAmount],
            [SOS].[SubtotalGross],
            [SOS].[SubtotalTax],
            [SOS].[Subtotal],
            [SOS].[SubtotalWeight],
            [SOS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderSummary] [SOS] INNER JOIN
            [dbo].[SalesOrder] [SO] ON ([SOS].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SO].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [PriceDate],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [UnitGrossPrice],    
            [UnitPrice],
            [DiscountStrata1Percentage],
            [DiscountStrata2Percentage],
            [DiscountStrata3Percentage],
            [DiscountStrata4Percentage],
            [DiscountStrata5Percentage],
            [AddDiscountStrataPercentage],
            [TaxPercentage],
            [RawSubtotalGrossPrice],
            [RawSubtotalPrice],
            [RawSubtotalDiscountStrata1],
            [RawDiscountStrata1Amount],
            [RawSubtotalDiscountStrata2],
            [RawDiscountStrata2Amount],
            [RawSubtotalDiscountStrata3],
            [RawDiscountStrata3Amount],
            [RawSubtotalDiscountStrata4],
            [RawDiscountStrata4Amount],
            [RawSubtotalDiscountStrata5],
            [RawDiscountStrata5Amount],
            [RawAddDiscountStrataAmount],
            [RawSubtotalGross],
            [RawSubtotalTax],
            [RawSubtotal],
            [SubtotalGrossPrice],
            [SubtotalPrice],
            [SubtotalDiscountStrata1],
            [DiscountStrata1Amount],
            [SubtotalDiscountStrata2],
            [DiscountStrata2Amount],
            [SubtotalDiscountStrata3],
            [DiscountStrata3Amount],
            [SubtotalDiscountStrata4],
            [DiscountStrata4Amount],
            [SubtotalDiscountStrata5],
            [DiscountStrata5Amount],
            [AddDiscountStrataAmount],
            [SubtotalGross],
            [SubtotalTax],
            [Subtotal],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderSummary]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOD].[DocumentID],
            [SOD].[ProductID],
            [SOD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SO].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOD].[QtyOnHand] END) [QtyOnHand],
            [SOD].[QtyConvL],
            [SOD].[QtyConvM],
            [SOD].[QtyConvS],
            [SOD].[Qty],
            (CAST([SOD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderDetails] [SOD] INNER JOIN
            [dbo].[SalesOrder] [SO] ON ([SOD].[DocumentID] = [SO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SO].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOD].[ProductID] = [fSOHA].[ProductID] AND
                [SOD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderFOC]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderFOC];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderFOC] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderFOC]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @PODocumentID uniqueidentifier,
    @PODocumentCode nvarchar(30),
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @TermOfPaymentID int,
    @ReferenceNumber nvarchar(30),
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @InvoiceDocumentID uniqueidentifier,
    @InvoiceDocumentCode nvarchar(30),    
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOFOC].[DocumentID],
            [SOFOC].[DocumentCode],
            [SOFOC].[TransactionDate],
            [SOFOC].[PODocumentID],
            [PO].[DocumentCode] [PODocumentCode],
            [PO].[TransactionDate] [POTransactionDate],
            [SOFOC].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SOFOC].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SOFOC].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SOFOC].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [SOFOC].[DiscountGroupID],
            [DG].[Code] [DiscountGroupCode],
            [DG].[Name] [DiscountGroupName],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description] [DiscountGroupDescription],
            [SOFOC].[TermOfPaymentID],
            [fSL2].[Name] [TermOfPaymentName],            
            [SOFOC].[ReferenceNumber],
            [SOFOC].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SOFOC].[InvoiceDocumentID],
            [I].[DocumentCode] [InvoiceDocumentCode],
            [SOFOC].[RawTotalGrossPrice],    
            [SOFOC].[RawTotalPrice],
            [SOFOC].[RawTotalDiscountStrata1Amount],
            [SOFOC].[RawTotalDiscountStrata2Amount],
            [SOFOC].[RawTotalDiscountStrata3Amount],
            [SOFOC].[RawTotalDiscountStrata4Amount],
            [SOFOC].[RawTotalDiscountStrata5Amount],
            [SOFOC].[RawTotalAddDiscountStrataAmount],
            [SOFOC].[RawTotalGross],
            [SOFOC].[RawTotalTax],
            [SOFOC].[RawTotal],
            [SOFOC].[TotalGrossPrice],    
            [SOFOC].[TotalPrice],
            [SOFOC].[TotalDiscountStrata1Amount],
            [SOFOC].[TotalDiscountStrata2Amount],
            [SOFOC].[TotalDiscountStrata3Amount],
            [SOFOC].[TotalDiscountStrata4Amount],
            [SOFOC].[TotalDiscountStrata5Amount],
            [SOFOC].[TotalAddDiscountStrataAmount],
            [SOFOC].[TotalGross],
            [SOFOC].[TotalTax],
            [SOFOC].[Total],
            [SOFOC].[TotalWeight],
            [SOFOC].[TotalDimension],
            [SOFOC].[AddDiscountStrataReason],
            [SOFOC].[DocumentStatusID],
            [fSL3].[Name] [DocumentStatusName],
            [SOFOC].[DocumentStatusReason],
            [SOFOC].[PostedDate],
            [SOFOC].[CreatedDate],
            [SOFOC].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SOFOC].[ModifiedDate],
            [SOFOC].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrderFOC] [SOFOC] LEFT OUTER JOIN
            [dbo].[PurchaseOrder] [PO] ON ([SOFOC].[PODocumentID] = [PO].[DocumentID]) INNER JOIN
            [dbo].[Salesman] [S] ON ([SOFOC].[SalesmanID] = [S].[ID]) INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SOFOC].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SOFOC].[CustomerID] = [C].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SOFOC].[PriceGroupID] = [fSL].[Value_Int32]) INNER JOIN
            [dbo].[DiscountGroup] [DG] ON ([SOFOC].[DiscountGroupID] = [DG].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SOFOC].[TermOfPaymentID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SOFOC].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[Invoice] [I] ON ([SOFOC].[InvoiceDocumentID] = [I].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SOFOC].[DocumentStatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SOFOC].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SOFOC].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOFOC].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SOFOC].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOFOC].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOFOC].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@PODocumentID IS NULL) OR ([SOFOC].[PODocumentID] = @PODocumentID)) AND
            ((@PODocumentCode IS NULL) OR ([PO].[DocumentCode] LIKE '%' + @PODocumentCode + '%')) AND
            ((@SalesmanID IS NULL) OR ([SOFOC].[SalesmanID] = @SalesmanID)) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND
            ((@WarehouseID IS NULL) OR ([SOFOC].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SOFOC].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@PriceGroupID IS NULL) OR ([SOFOC].[PriceGroupID] = @PriceGroupID)) AND
            ((@DiscountGroupID IS NULL) OR ([SOFOC].[DiscountGroupID] = @DiscountGroupID)) AND
            ((@DiscountGroupCode IS NULL) OR ([DG].[Code] LIKE '%' + @DiscountGroupCode + '%')) AND
            ((@DiscountGroupName IS NULL) OR ([DG].[Name] LIKE '%' + @DiscountGroupName + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([SOFOC].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@ReferenceNumber IS NULL) OR ([SOFOC].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SOFOC].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@InvoiceDocumentID IS NULL) OR ([SOFOC].[InvoiceDocumentID] = @InvoiceDocumentID)) AND
            ((@DocumentStatusID IS NULL) OR ([SOFOC].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SOFOC].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOFOC].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOFOC].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderFOC]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderFOC];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderFOC] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderFOC]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [PODocumentID],
            [PODocumentCode],
            [POTransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [TermOfPaymentID],
            [TermOfPaymentName],            
            [ReferenceNumber],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [InvoiceDocumentID],
            [InvoiceDocumentCode],
            [RawTotalGrossPrice],    
            [RawTotalPrice],
            [RawTotalDiscountStrata1Amount],
            [RawTotalDiscountStrata2Amount],
            [RawTotalDiscountStrata3Amount],
            [RawTotalDiscountStrata4Amount],
            [RawTotalDiscountStrata5Amount],
            [RawTotalAddDiscountStrataAmount],
            [RawTotalGross],
            [RawTotalTax],
            [RawTotal],
            [TotalGrossPrice],    
            [TotalPrice],
            [TotalDiscountStrata1Amount],
            [TotalDiscountStrata2Amount],
            [TotalDiscountStrata3Amount],
            [TotalDiscountStrata4Amount],
            [TotalDiscountStrata5Amount],
            [TotalAddDiscountStrataAmount],
            [TotalGross],
            [TotalTax],
            [Total],
            [TotalWeight],
            [TotalDimension],
            [AddDiscountStrataReason],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrderFOC]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderFOCSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderFOCSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderFOCSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderFOCSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOFOCS].[DocumentID],            
            [SOFOCS].[ProductID],
            [SOFOCS].[PriceDate],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SOFOC].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOFOCS].[QtyOnHand] END) [QtyOnHand],
            [SOFOCS].[QtyConvL],
            [SOFOCS].[QtyConvM],
            [SOFOCS].[QtyConvS],
            [SOFOCS].[Qty],
            (CAST([SOFOCS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOFOCS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOFOCS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOFOCS].[Qty] * -1) [QtyOrder],
            [SOFOCS].[UnitGrossPrice],    
            [SOFOCS].[UnitPrice],
            [SOFOCS].[DiscountStrata1Percentage],
            [SOFOCS].[DiscountStrata2Percentage],
            [SOFOCS].[DiscountStrata3Percentage],
            [SOFOCS].[DiscountStrata4Percentage],
            [SOFOCS].[DiscountStrata5Percentage],
            [SOFOCS].[AddDiscountStrataPercentage],
            [SOFOCS].[TaxPercentage],
            [SOFOCS].[RawSubtotalGrossPrice],
            [SOFOCS].[RawSubtotalPrice],
            [SOFOCS].[RawSubtotalDiscountStrata1],
            ([SOFOCS].[RawSubtotalPrice] - [SOFOCS].[RawSubtotalDiscountStrata1]) [RawDiscountStrata1Amount],            
            [SOFOCS].[RawSubtotalDiscountStrata2],
            ([SOFOCS].[RawSubtotalDiscountStrata1] - [SOFOCS].[RawSubtotalDiscountStrata2]) [RawDiscountStrata2Amount],
            [SOFOCS].[RawSubtotalDiscountStrata3],
            ([SOFOCS].[RawSubtotalDiscountStrata2] - [SOFOCS].[RawSubtotalDiscountStrata3]) [RawDiscountStrata3Amount],
            [SOFOCS].[RawSubtotalDiscountStrata4],
            ([SOFOCS].[RawSubtotalDiscountStrata3] - [SOFOCS].[RawSubtotalDiscountStrata4]) [RawDiscountStrata4Amount],
            [SOFOCS].[RawSubtotalDiscountStrata5],
            ([SOFOCS].[RawSubtotalDiscountStrata4] - [SOFOCS].[RawSubtotalDiscountStrata5]) [RawDiscountStrata5Amount],
            ([SOFOCS].[RawSubtotalDiscountStrata5] - [SOFOCS].[RawSubtotal]) [RawAddDiscountStrataAmount],
            [SOFOCS].[RawSubtotalGross],
            [SOFOCS].[RawSubtotalTax],
            [SOFOCS].[RawSubtotal],
            [SOFOCS].[SubtotalGrossPrice],
            [SOFOCS].[SubtotalPrice],
            [SOFOCS].[SubtotalDiscountStrata1],
            ([SOFOCS].[SubtotalPrice] - [SOFOCS].[SubtotalDiscountStrata1]) [DiscountStrata1Amount],            
            [SOFOCS].[SubtotalDiscountStrata2],
            ([SOFOCS].[SubtotalDiscountStrata1] - [SOFOCS].[SubtotalDiscountStrata2]) [DiscountStrata2Amount],
            [SOFOCS].[SubtotalDiscountStrata3],
            ([SOFOCS].[SubtotalDiscountStrata2] - [SOFOCS].[SubtotalDiscountStrata3]) [DiscountStrata3Amount],
            [SOFOCS].[SubtotalDiscountStrata4],
            ([SOFOCS].[SubtotalDiscountStrata3] - [SOFOCS].[SubtotalDiscountStrata4]) [DiscountStrata4Amount],
            [SOFOCS].[SubtotalDiscountStrata5],
            ([SOFOCS].[SubtotalDiscountStrata4] - [SOFOCS].[SubtotalDiscountStrata5]) [DiscountStrata5Amount],
            ([SOFOCS].[SubtotalDiscountStrata5] - [SOFOCS].[Subtotal]) [AddDiscountStrataAmount],
            [SOFOCS].[SubtotalGross],
            [SOFOCS].[SubtotalTax],
            [SOFOCS].[Subtotal],
            [SOFOCS].[SubtotalWeight],
            [SOFOCS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderFOCSummary] [SOFOCS] INNER JOIN
            [dbo].[SalesOrderFOC] [SOFOC] ON ([SOFOCS].[DocumentID] = [SOFOC].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SOFOC].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOFOCS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOFOCS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOFOCS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOFOCS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderFOCSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderFOCSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderFOCSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderFOCSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [PriceDate],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [UnitGrossPrice],    
            [UnitPrice],
            [DiscountStrata1Percentage],
            [DiscountStrata2Percentage],
            [DiscountStrata3Percentage],
            [DiscountStrata4Percentage],
            [DiscountStrata5Percentage],
            [AddDiscountStrataPercentage],
            [TaxPercentage],
            [RawSubtotalGrossPrice],
            [RawSubtotalPrice],
            [RawSubtotalDiscountStrata1],
            [RawDiscountStrata1Amount],
            [RawSubtotalDiscountStrata2],
            [RawDiscountStrata2Amount],
            [RawSubtotalDiscountStrata3],
            [RawDiscountStrata3Amount],
            [RawSubtotalDiscountStrata4],
            [RawDiscountStrata4Amount],
            [RawSubtotalDiscountStrata5],
            [RawDiscountStrata5Amount],
            [RawAddDiscountStrataAmount],
            [RawSubtotalGross],
            [RawSubtotalTax],
            [RawSubtotal],
            [SubtotalGrossPrice],
            [SubtotalPrice],
            [SubtotalDiscountStrata1],
            [DiscountStrata1Amount],
            [SubtotalDiscountStrata2],
            [DiscountStrata2Amount],
            [SubtotalDiscountStrata3],
            [DiscountStrata3Amount],
            [SubtotalDiscountStrata4],
            [DiscountStrata4Amount],
            [SubtotalDiscountStrata5],
            [DiscountStrata5Amount],
            [AddDiscountStrataAmount],
            [SubtotalGross],
            [SubtotalTax],
            [Subtotal],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderFOCSummary]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderFOCDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderFOCDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderFOCDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderFOCDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOFOCD].[DocumentID],
            [SOFOCD].[ProductID],
            [SOFOCD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SOFOC].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOFOCD].[QtyOnHand] END) [QtyOnHand],
            [SOFOCD].[QtyConvL],
            [SOFOCD].[QtyConvM],
            [SOFOCD].[QtyConvS],
            [SOFOCD].[Qty],
            (CAST([SOFOCD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOFOCD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOFOCD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOFOCD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderFOCDetails] [SOFOCD] INNER JOIN
            [dbo].[SalesOrderFOC] [SOFOC] ON ([SOFOCD].[DocumentID] = [SOFOC].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SOFOC].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOFOCD].[ProductID] = [fSOHA].[ProductID] AND
                [SOFOCD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOFOCD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOFOCD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOFOCD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOFOCD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderFOCDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderFOCDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderFOCDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderFOCDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderFOCDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSample]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSample];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSample] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSample]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @PODocumentID uniqueidentifier,
    @PODocumentCode nvarchar(30),
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @TermOfPaymentID int,
    @ReferenceNumber nvarchar(30),
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @InvoiceDocumentID uniqueidentifier,
    @InvoiceDocumentCode nvarchar(30),    
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOS].[DocumentID],
            [SOS].[DocumentCode],
            [SOS].[TransactionDate],
            [SOS].[PODocumentID],
            [PO].[DocumentCode] [PODocumentCode],
            [PO].[TransactionDate] [POTransactionDate],
            [SOS].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SOS].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SOS].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SOS].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [SOS].[DiscountGroupID],
            [DG].[Code] [DiscountGroupCode],
            [DG].[Name] [DiscountGroupName],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description] [DiscountGroupDescription],
            [SOS].[TermOfPaymentID],
            [fSL2].[Name] [TermOfPaymentName],            
            [SOS].[ReferenceNumber],
            [SOS].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SOS].[InvoiceDocumentID],
            [I].[DocumentCode] [InvoiceDocumentCode],
            [SOS].[RawTotalGrossPrice],    
            [SOS].[RawTotalPrice],
            [SOS].[RawTotalDiscountStrata1Amount],
            [SOS].[RawTotalDiscountStrata2Amount],
            [SOS].[RawTotalDiscountStrata3Amount],
            [SOS].[RawTotalDiscountStrata4Amount],
            [SOS].[RawTotalDiscountStrata5Amount],
            [SOS].[RawTotalAddDiscountStrataAmount],
            [SOS].[RawTotalGross],
            [SOS].[RawTotalTax],
            [SOS].[RawTotal],
            [SOS].[TotalGrossPrice],    
            [SOS].[TotalPrice],
            [SOS].[TotalDiscountStrata1Amount],
            [SOS].[TotalDiscountStrata2Amount],
            [SOS].[TotalDiscountStrata3Amount],
            [SOS].[TotalDiscountStrata4Amount],
            [SOS].[TotalDiscountStrata5Amount],
            [SOS].[TotalAddDiscountStrataAmount],
            [SOS].[TotalGross],
            [SOS].[TotalTax],
            [SOS].[Total],
            [SOS].[TotalWeight],
            [SOS].[TotalDimension],
            [SOS].[AddDiscountStrataReason],
            [SOS].[DocumentStatusID],
            [fSL3].[Name] [DocumentStatusName],
            [SOS].[DocumentStatusReason],
            [SOS].[PostedDate],
            [SOS].[CreatedDate],
            [SOS].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SOS].[ModifiedDate],
            [SOS].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrderSample] [SOS] LEFT OUTER JOIN
            [dbo].[PurchaseOrder] [PO] ON ([SOS].[PODocumentID] = [PO].[DocumentID]) INNER JOIN
            [dbo].[Salesman] [S] ON ([SOS].[SalesmanID] = [S].[ID]) INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SOS].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SOS].[CustomerID] = [C].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SOS].[PriceGroupID] = [fSL].[Value_Int32]) INNER JOIN
            [dbo].[DiscountGroup] [DG] ON ([SOS].[DiscountGroupID] = [DG].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SOS].[TermOfPaymentID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SOS].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[Invoice] [I] ON ([SOS].[InvoiceDocumentID] = [I].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SOS].[DocumentStatusID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SOS].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SOS].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOS].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SOS].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOS].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOS].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@PODocumentID IS NULL) OR ([SOS].[PODocumentID] = @PODocumentID)) AND
            ((@PODocumentCode IS NULL) OR ([PO].[DocumentCode] LIKE '%' + @PODocumentCode + '%')) AND
            ((@SalesmanID IS NULL) OR ([SOS].[SalesmanID] = @SalesmanID)) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND            
            ((@WarehouseID IS NULL) OR ([SOS].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SOS].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@PriceGroupID IS NULL) OR ([SOS].[PriceGroupID] = @PriceGroupID)) AND
            ((@DiscountGroupID IS NULL) OR ([SOS].[DiscountGroupID] = @DiscountGroupID)) AND
            ((@DiscountGroupCode IS NULL) OR ([DG].[Code] LIKE '%' + @DiscountGroupCode + '%')) AND
            ((@DiscountGroupName IS NULL) OR ([DG].[Name] LIKE '%' + @DiscountGroupName + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([SOS].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@ReferenceNumber IS NULL) OR ([SOS].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SOS].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@InvoiceDocumentID IS NULL) OR ([SOS].[InvoiceDocumentID] = @InvoiceDocumentID)) AND
            ((@InvoiceDocumentCode IS NULL) OR ([I].[DocumentCode] LIKE '%' + @InvoiceDocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SOS].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SOS].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOS].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOS].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSample]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSample];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSample] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSample]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [PODocumentID],
            [PODocumentCode],
            [POTransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [TermOfPaymentID],
            [TermOfPaymentName],            
            [ReferenceNumber],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [InvoiceDocumentID],
            [InvoiceDocumentCode],
            [TotalGrossPrice],    
            [RawTotalGrossPrice],    
            [RawTotalPrice],
            [RawTotalDiscountStrata1Amount],
            [RawTotalDiscountStrata2Amount],
            [RawTotalDiscountStrata3Amount],
            [RawTotalDiscountStrata4Amount],
            [RawTotalDiscountStrata5Amount],
            [RawTotalAddDiscountStrataAmount],
            [RawTotalGross],
            [RawTotalTax],
            [RawTotal],
            [TotalPrice],
            [TotalDiscountStrata1Amount],
            [TotalDiscountStrata2Amount],
            [TotalDiscountStrata3Amount],
            [TotalDiscountStrata4Amount],
            [TotalDiscountStrata5Amount],
            [TotalAddDiscountStrataAmount],
            [TotalGross],
            [TotalTax],
            [Total],
            [TotalWeight],
            [TotalDimension],
            [AddDiscountStrataReason],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrderSample]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSampleSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSampleSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSampleSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSampleSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOSS].[DocumentID],            
            [SOSS].[ProductID],
            [SOSS].[PriceDate],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SOS].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOSS].[QtyOnHand] END) [QtyOnHand],
            [SOSS].[QtyConvL],
            [SOSS].[QtyConvM],
            [SOSS].[QtyConvS],
            [SOSS].[Qty],
            (CAST([SOSS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOSS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOSS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOSS].[Qty] * -1) [QtyOrder],
            [SOSS].[UnitGrossPrice],    
            [SOSS].[UnitPrice],
            [SOSS].[DiscountStrata1Percentage],
            [SOSS].[DiscountStrata2Percentage],
            [SOSS].[DiscountStrata3Percentage],
            [SOSS].[DiscountStrata4Percentage],
            [SOSS].[DiscountStrata5Percentage],
            [SOSS].[AddDiscountStrataPercentage],
            [SOSS].[TaxPercentage],
            [SOSS].[RawSubtotalGrossPrice],
            [SOSS].[RawSubtotalPrice],
            [SOSS].[RawSubtotalDiscountStrata1],
            ([SOSS].[RawSubtotalPrice] - [SOSS].[RawSubtotalDiscountStrata1]) [RawDiscountStrata1Amount],            
            [SOSS].[RawSubtotalDiscountStrata2],
            ([SOSS].[RawSubtotalDiscountStrata1] - [SOSS].[RawSubtotalDiscountStrata2]) [RawDiscountStrata2Amount],
            [SOSS].[RawSubtotalDiscountStrata3],
            ([SOSS].[RawSubtotalDiscountStrata2] - [SOSS].[RawSubtotalDiscountStrata3]) [RawDiscountStrata3Amount],
            [SOSS].[RawSubtotalDiscountStrata4],
            ([SOSS].[RawSubtotalDiscountStrata3] - [SOSS].[RawSubtotalDiscountStrata4]) [RawDiscountStrata4Amount],
            [SOSS].[RawSubtotalDiscountStrata5],
            ([SOSS].[RawSubtotalDiscountStrata4] - [SOSS].[RawSubtotalDiscountStrata5]) [RawDiscountStrata5Amount],
            ([SOSS].[RawSubtotalDiscountStrata5] - [SOSS].[RawSubtotal]) [RawAddDiscountStrataAmount],
            [SOSS].[RawSubtotalGross],
            [SOSS].[RawSubtotalTax],
            [SOSS].[RawSubtotal],
            [SOSS].[SubtotalGrossPrice],
            [SOSS].[SubtotalPrice],
            [SOSS].[SubtotalDiscountStrata1],
            ([SOSS].[SubtotalPrice] - [SOSS].[SubtotalDiscountStrata1]) [DiscountStrata1Amount],            
            [SOSS].[SubtotalDiscountStrata2],
            ([SOSS].[SubtotalDiscountStrata1] - [SOSS].[SubtotalDiscountStrata2]) [DiscountStrata2Amount],
            [SOSS].[SubtotalDiscountStrata3],
            ([SOSS].[SubtotalDiscountStrata2] - [SOSS].[SubtotalDiscountStrata3]) [DiscountStrata3Amount],
            [SOSS].[SubtotalDiscountStrata4],
            ([SOSS].[SubtotalDiscountStrata3] - [SOSS].[SubtotalDiscountStrata4]) [DiscountStrata4Amount],
            [SOSS].[SubtotalDiscountStrata5],
            ([SOSS].[SubtotalDiscountStrata4] - [SOSS].[SubtotalDiscountStrata5]) [DiscountStrata5Amount],
            ([SOSS].[SubtotalDiscountStrata5] - [SOSS].[Subtotal]) [AddDiscountStrataAmount],
            [SOSS].[SubtotalGross],
            [SOSS].[SubtotalTax],
            [SOSS].[Subtotal],
            [SOSS].[SubtotalWeight],
            [SOSS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderSampleSummary] [SOSS] INNER JOIN
            [dbo].[SalesOrderSample] [SOS] ON ([SOSS].[DocumentID] = [SOS].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SOS].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOSS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOSS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOSS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOSS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSampleSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSampleSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSampleSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSampleSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [PriceDate],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [UnitGrossPrice],    
            [UnitPrice],
            [DiscountStrata1Percentage],
            [DiscountStrata2Percentage],
            [DiscountStrata3Percentage],
            [DiscountStrata4Percentage],
            [DiscountStrata5Percentage],
            [AddDiscountStrataPercentage],
            [TaxPercentage],
            [RawSubtotalGrossPrice],
            [RawSubtotalPrice],
            [RawSubtotalDiscountStrata1],
            [RawDiscountStrata1Amount],
            [RawSubtotalDiscountStrata2],
            [RawDiscountStrata2Amount],
            [RawSubtotalDiscountStrata3],
            [RawDiscountStrata3Amount],
            [RawSubtotalDiscountStrata4],
            [RawDiscountStrata4Amount],
            [RawSubtotalDiscountStrata5],
            [RawDiscountStrata5Amount],
            [RawAddDiscountStrataAmount],
            [RawSubtotalGross],
            [RawSubtotalTax],
            [RawSubtotal],
            [SubtotalGrossPrice],
            [SubtotalPrice],
            [SubtotalDiscountStrata1],
            [DiscountStrata1Amount],
            [SubtotalDiscountStrata2],
            [DiscountStrata2Amount],
            [SubtotalDiscountStrata3],
            [DiscountStrata3Amount],
            [SubtotalDiscountStrata4],
            [DiscountStrata4Amount],
            [SubtotalDiscountStrata5],
            [DiscountStrata5Amount],
            [AddDiscountStrataAmount],
            [SubtotalGross],
            [SubtotalTax],
            [Subtotal],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderSampleSummary]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSampleDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSampleDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderSampleDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSampleDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOSD].[DocumentID],
            [SOSD].[ProductID],
            [SOSD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SOS].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOSD].[QtyOnHand] END) [QtyOnHand],
            [SOSD].[QtyConvL],
            [SOSD].[QtyConvM],
            [SOSD].[QtyConvS],
            [SOSD].[Qty],
            (CAST([SOSD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOSD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOSD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOSD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderSampleDetails] [SOSD] INNER JOIN
            [dbo].[SalesOrderSample] [SOS] ON ([SOSD].[DocumentID] = [SOS].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SOS].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOSD].[ProductID] = [fSOHA].[ProductID] AND
                [SOSD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOSD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOSD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOSD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOSD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSampleDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSampleDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSampleDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSampleDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderSampleDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderReturn]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderReturn];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderReturn] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderReturn]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @PriceGroupID int,
    @DiscountGroupID int,
    @DiscountGroupCode nvarchar(10),
    @DiscountGroupName nvarchar(50),
    @TermOfPaymentID int,
    @ReferenceNumber nvarchar(30),
    @ReasonID int,
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @InvoiceDocumentID uniqueidentifier,
    @InvoiceDocumentCode nvarchar(30),    
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOR].[DocumentID],
            [SOR].[DocumentCode],
            [SOR].[TransactionDate],
            [SOR].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SOR].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SOR].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SOR].[PriceGroupID],
            [fSL].[Name] [PriceGroupName],
            [SOR].[DiscountGroupID],
            [DG].[Code] [DiscountGroupCode],
            [DG].[Name] [DiscountGroupName],
            [dbo].[fCodeNameFormatter]([DG].[Code], [DG].[Name]) [DiscountGroup],
            [DG].[Description] [DiscountGroupDescription],
            [SOR].[TermOfPaymentID],
            [fSL2].[Name] [TermOfPaymentName],            
            [SOR].[ReferenceNumber],
            [SOR].[ReasonID],
            [fSL3].[Name] [ReasonName],
            [SOR].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SOR].[InvoiceDocumentID],
            [I].[DocumentCode] [InvoiceDocumentCode],
            [SOR].[RawTotalGrossPrice],    
            [SOR].[RawTotalPrice],
            [SOR].[RawTotalDiscountStrata1Amount],
            [SOR].[RawTotalDiscountStrata2Amount],
            [SOR].[RawTotalDiscountStrata3Amount],
            [SOR].[RawTotalDiscountStrata4Amount],
            [SOR].[RawTotalDiscountStrata5Amount],
            [SOR].[RawTotalAddDiscountStrataAmount],
            [SOR].[RawTotalGross],
            [SOR].[RawTotalTax],
            [SOR].[RawTotal],
            [SOR].[TotalGrossPrice],    
            [SOR].[TotalPrice],
            [SOR].[TotalDiscountStrata1Amount],
            [SOR].[TotalDiscountStrata2Amount],
            [SOR].[TotalDiscountStrata3Amount],
            [SOR].[TotalDiscountStrata4Amount],
            [SOR].[TotalDiscountStrata5Amount],
            [SOR].[TotalAddDiscountStrataAmount],
            [SOR].[TotalGross],
            [SOR].[TotalTax],
            [SOR].[Total],
            [SOR].[TotalWeight],
            [SOR].[TotalDimension],
            [SOR].[AddDiscountStrataReason],
            [SOR].[DocumentStatusID],
            [fSL4].[Name] [DocumentStatusName],
            [SOR].[DocumentStatusReason],
            [SOR].[PostedDate],
            [SOR].[CreatedDate],
            [SOR].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SOR].[ModifiedDate],
            [SOR].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrderReturn] [SOR] INNER JOIN
            [dbo].[Salesman] [S] ON ([SOR].[SalesmanID] = [S].[ID]) INNER JOIN            
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SOR].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SOR].[CustomerID] = [C].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'ProductPriceGroup',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SOR].[PriceGroupID] = [fSL].[Value_Int32]) INNER JOIN
            [dbo].[DiscountGroup] [DG] ON ([SOR].[DiscountGroupID] = [DG].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'CustomerTermOfPayment',
                NULL,
                NULL,
                NULL
            ) [fSL2] ON ([SOR].[TermOfPaymentID] = [fSL2].[Value_Int32]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SOR].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN
            [dbo].[Invoice] [I] ON ([SOR].[InvoiceDocumentID] = [I].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'SOReturnReason',
                NULL,
                NULL,
                NULL
            ) [fSL3] ON ([SOR].[ReasonID] = [fSL3].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL4] ON ([SOR].[DocumentStatusID] = [fSL4].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SOR].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SOR].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOR].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SOR].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOR].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOR].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@SalesmanID IS NULL) OR ([SOR].[SalesmanID] = @SalesmanID)) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND            
            ((@WarehouseID IS NULL) OR ([SOR].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SOR].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@PriceGroupID IS NULL) OR ([SOR].[PriceGroupID] = @PriceGroupID)) AND
            ((@DiscountGroupID IS NULL) OR ([SOR].[DiscountGroupID] = @DiscountGroupID)) AND
            ((@DiscountGroupCode IS NULL) OR ([DG].[Code] LIKE '%' + @DiscountGroupCode + '%')) AND
            ((@DiscountGroupName IS NULL) OR ([DG].[Name] LIKE '%' + @DiscountGroupName + '%')) AND
            ((@TermOfPaymentID IS NULL) OR ([SOR].[TermOfPaymentID] = @TermOfPaymentID)) AND
            ((@ReferenceNumber IS NULL) OR ([SOR].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SOR].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@InvoiceDocumentID IS NULL) OR ([SOR].[InvoiceDocumentID] = @InvoiceDocumentID)) AND
            ((@InvoiceDocumentCode IS NULL) OR ([I].[DocumentCode] LIKE '%' + @InvoiceDocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SOR].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SOR].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOR].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOR].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderReturn]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderReturn];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderReturn] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderReturn]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [PriceGroupID],
            [PriceGroupName],
            [DiscountGroupID],
            [DiscountGroupCode],
            [DiscountGroupName],
            [DiscountGroup],
            [DiscountGroupDescription],
            [TermOfPaymentID],
            [TermOfPaymentName],            
            [ReferenceNumber],
            [ReasonID],
            [ReasonName],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [InvoiceDocumentID],
            [InvoiceDocumentCode],
            [RawTotalGrossPrice],    
            [RawTotalPrice],
            [RawTotalDiscountStrata1Amount],
            [RawTotalDiscountStrata2Amount],
            [RawTotalDiscountStrata3Amount],
            [RawTotalDiscountStrata4Amount],
            [RawTotalDiscountStrata5Amount],
            [RawTotalAddDiscountStrataAmount],
            [RawTotalGross],
            [RawTotalTax],
            [RawTotal],
            [TotalGrossPrice],    
            [TotalPrice],
            [TotalDiscountStrata1Amount],
            [TotalDiscountStrata2Amount],
            [TotalDiscountStrata3Amount],
            [TotalDiscountStrata4Amount],
            [TotalDiscountStrata5Amount],
            [TotalAddDiscountStrataAmount],
            [TotalGross],
            [TotalTax],
            [Total],
            [TotalWeight],
            [TotalDimension],
            [AddDiscountStrataReason],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrderReturn]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderReturnSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderReturnSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderReturnSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderReturnSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SORS].[DocumentID],            
            [SORS].[ProductID],
            [SORS].[PriceDate],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SOR].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandHold], 0) ELSE [SORS].[QtyOnHand] END) [QtyOnHand],
            [SORS].[QtyConvL],
            [SORS].[QtyConvM],
            [SORS].[QtyConvS],
            [SORS].[Qty],
            (CAST([SORS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SORS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SORS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SORS].[Qty] * -1) [QtyOrder],
            [SORS].[UnitGrossPrice],    
            [SORS].[UnitPrice],
            [SORS].[DiscountStrata1Percentage],
            [SORS].[DiscountStrata2Percentage],
            [SORS].[DiscountStrata3Percentage],
            [SORS].[DiscountStrata4Percentage],
            [SORS].[DiscountStrata5Percentage],
            [SORS].[AddDiscountStrataPercentage],
            [SORS].[TaxPercentage],
            [SORS].[RawSubtotalGrossPrice],
            [SORS].[RawSubtotalPrice],
            [SORS].[RawSubtotalDiscountStrata1],
            ([SORS].[RawSubtotalPrice] - [SORS].[RawSubtotalDiscountStrata1]) [RawDiscountStrata1Amount],            
            [SORS].[RawSubtotalDiscountStrata2],
            ([SORS].[RawSubtotalDiscountStrata1] - [SORS].[RawSubtotalDiscountStrata2]) [RawDiscountStrata2Amount],
            [SORS].[RawSubtotalDiscountStrata3],
            ([SORS].[RawSubtotalDiscountStrata2] - [SORS].[RawSubtotalDiscountStrata3]) [RawDiscountStrata3Amount],
            [SORS].[RawSubtotalDiscountStrata4],
            ([SORS].[RawSubtotalDiscountStrata3] - [SORS].[RawSubtotalDiscountStrata4]) [RawDiscountStrata4Amount],
            [SORS].[RawSubtotalDiscountStrata5],
            ([SORS].[RawSubtotalDiscountStrata4] - [SORS].[RawSubtotalDiscountStrata5]) [RawDiscountStrata5Amount],
            ([SORS].[RawSubtotalDiscountStrata5] - [SORS].[RawSubtotal]) [RawAddDiscountStrataAmount],
            [SORS].[RawSubtotalGross],
            [SORS].[RawSubtotalTax],
            [SORS].[RawSubtotal],
            [SORS].[SubtotalGrossPrice],
            [SORS].[SubtotalPrice],
            [SORS].[SubtotalDiscountStrata1],
            ([SORS].[SubtotalPrice] - [SORS].[SubtotalDiscountStrata1]) [DiscountStrata1Amount],            
            [SORS].[SubtotalDiscountStrata2],
            ([SORS].[SubtotalDiscountStrata1] - [SORS].[SubtotalDiscountStrata2]) [DiscountStrata2Amount],
            [SORS].[SubtotalDiscountStrata3],
            ([SORS].[SubtotalDiscountStrata2] - [SORS].[SubtotalDiscountStrata3]) [DiscountStrata3Amount],
            [SORS].[SubtotalDiscountStrata4],
            ([SORS].[SubtotalDiscountStrata3] - [SORS].[SubtotalDiscountStrata4]) [DiscountStrata4Amount],
            [SORS].[SubtotalDiscountStrata5],
            ([SORS].[SubtotalDiscountStrata4] - [SORS].[SubtotalDiscountStrata5]) [DiscountStrata5Amount],
            ([SORS].[SubtotalDiscountStrata5] - [SORS].[Subtotal]) [AddDiscountStrataAmount],
            [SORS].[SubtotalGross],
            [SORS].[SubtotalTax],
            [SORS].[Subtotal],
            [SORS].[SubtotalWeight],
            [SORS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderReturnSummary] [SORS] INNER JOIN
            [dbo].[SalesOrderReturn] [SOR] ON ([SORS].[DocumentID] = [SOR].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SOR].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SORS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SORS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SORS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SORS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderReturnSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderReturnSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderReturnSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderReturnSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [PriceDate],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [UnitGrossPrice],    
            [UnitPrice],
            [DiscountStrata1Percentage],
            [DiscountStrata2Percentage],
            [DiscountStrata3Percentage],
            [DiscountStrata4Percentage],
            [DiscountStrata5Percentage],
            [AddDiscountStrataPercentage],
            [TaxPercentage],
            [RawSubtotalGrossPrice],
            [RawSubtotalPrice],
            [RawSubtotalDiscountStrata1],
            [RawDiscountStrata1Amount],
            [RawSubtotalDiscountStrata2],
            [RawDiscountStrata2Amount],
            [RawSubtotalDiscountStrata3],
            [RawDiscountStrata3Amount],
            [RawSubtotalDiscountStrata4],
            [RawDiscountStrata4Amount],
            [RawSubtotalDiscountStrata5],
            [RawDiscountStrata5Amount],
            [RawAddDiscountStrataAmount],
            [RawSubtotalGross],
            [RawSubtotalTax],
            [RawSubtotal],
            [SubtotalGrossPrice],
            [SubtotalPrice],
            [SubtotalDiscountStrata1],
            [DiscountStrata1Amount],
            [SubtotalDiscountStrata2],
            [DiscountStrata2Amount],
            [SubtotalDiscountStrata3],
            [DiscountStrata3Amount],
            [SubtotalDiscountStrata4],
            [DiscountStrata4Amount],
            [SubtotalDiscountStrata5],
            [DiscountStrata5Amount],
            [AddDiscountStrataAmount],
            [SubtotalGross],
            [SubtotalTax],
            [Subtotal],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderReturnSummary]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderReturnDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderReturnDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderReturnDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderReturnDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SORD].[DocumentID],
            [SORD].[ProductID],
            [SORD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SOR].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandHold], 0) ELSE [SORD].[QtyOnHand] END) [QtyOnHand],
            [SORD].[QtyConvL],
            [SORD].[QtyConvM],
            [SORD].[QtyConvS],
            [SORD].[Qty],
            (CAST([SORD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SORD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SORD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SORD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderReturnDetails] [SORD] INNER JOIN
            [dbo].[SalesOrderReturn] [SOR] ON ([SORD].[DocumentID] = [SOR].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SOR].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SORD].[ProductID] = [fSOHA].[ProductID] AND
                [SORD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SORD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SORD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SORD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SORD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderReturnDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderReturnDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderReturnDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderReturnDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderReturnDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSwap]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSwap];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSwap] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSwap]
(
    @DocumentID uniqueidentifier,
    @DocumentCode nvarchar(30),
    @TransactionDateFrom datetime,
    @TransactionDateTo datetime,
    @SalesmanID uniqueidentifier,
    @SalesmanCode nvarchar(10),
    @SalesmanName nvarchar(50),    
    @WarehouseID uniqueidentifier,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),    
    @SiteDistributionTypeID int,
    @WarehouseTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @CustomerID uniqueidentifier,
    @CustomerCode nvarchar(10),
    @CustomerName nvarchar(50),
    @ReferenceNumber nvarchar(30),
    @DODocumentID uniqueidentifier,
    @DODocumentCode nvarchar(30),
    @DOShipmentDateFrom datetime,
    @DOShipmentDateTo datetime,
    @DOReceivedDateFrom datetime,
    @DOReceivedDateTo datetime,
    @DOLastPrintedDateFrom datetime,
    @DOLastPrintedDateTo datetime,
    @DocumentStatusID int,
    @DocumentStatusReason nvarchar(200),
    @PostedDateFrom datetime,
    @PostedDateTo datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOS].[DocumentID],
            [SOS].[DocumentCode],
            [SOS].[TransactionDate],
            [SOS].[SalesmanID],
            [S].[Code] [SalesmanCode],
            [S].[Name] [SalesmanName],
            [dbo].[fCodeNameFormatter]([S].[Code], [S].[Name]) [Salesman],
            [SOS].[WarehouseID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[TypeID] [WarehouseTypeID],
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [SOS].[CustomerID],
            [C].[Code] [CustomerCode],
            [C].[Name] [CustomerName],
            [dbo].[fCodeNameFormatter]([C].[Code], [C].[Name]) [Customer],
            [SOS].[ReferenceNumber],
            [SOS].[AttachmentFile],            
            [SOS].[DODocumentID],
            [DO].[DocumentCode] [DODocumentCode],
            [DO].[ShipmentDate] [DOShipmentDate],
            [DO].[ReceivedDate] [DOReceivedDate],
            [DO].[PrintedCount] [DOPrintedCount],
            [DO].[LastPrintedDate] [DOLastPrintedDate],
            [SOS].[TotalWeight],
            [SOS].[TotalDimension],
            [SOS].[DocumentStatusID],
            [fSL].[Name] [DocumentStatusName],
            [SOS].[DocumentStatusReason],
            [SOS].[PostedDate],
            [SOS].[CreatedDate],
            [SOS].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [SOS].[ModifiedDate],
            [SOS].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName]
        FROM
			[dbo].[SalesOrderSwap] [SOS] INNER JOIN
            [dbo].[Salesman] [S] ON ([SOS].[SalesmanID] = [S].[ID]) INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @WarehouseTypeID,
                @IsSiteLotNumberEntryRequired,
                NULL,
                NULL,
                NULL
            ) [fW] ON ([SOS].[WarehouseID] = [fW].[ID]) INNER JOIN
            [dbo].[Customer] [C] ON ([SOS].[CustomerID] = [C].[ID]) INNER JOIN
            [dbo].[DeliveryOrder] [DO] ON ([SOS].[DODocumentID] = [DO].[DocumentID]) LEFT OUTER JOIN            
            [dbo].[fSystemLookup]
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
                'DocumentStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([SOS].[DocumentStatusID] = [fSL].[Value_Int32]) LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([SOS].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([SOS].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOS].[DocumentID] = @DocumentID)) AND
            ((@DocumentCode IS NULL) OR ([SOS].[DocumentCode] LIKE '%' + @DocumentCode + '%')) AND
            ((@TransactionDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOS].[TransactionDate]) >= [dbo].[ValidateMinDate](@TransactionDateFrom))) AND
            ((@TransactionDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOS].[TransactionDate]) <= [dbo].[ValidateMaxDate](@TransactionDateTo))) AND
            ((@SalesmanID IS NULL) OR ([SOS].[SalesmanID] = @SalesmanID)) AND
            ((@SalesmanCode IS NULL) OR ([S].[Code] LIKE '%' + @SalesmanCode + '%')) AND
            ((@SalesmanName IS NULL) OR ([S].[Name] LIKE '%' + @SalesmanName + '%')) AND            
            ((@WarehouseID IS NULL) OR ([SOS].[WarehouseID] = @WarehouseID)) AND
            ((@CustomerID IS NULL) OR ([SOS].[CustomerID] = @CustomerID)) AND
            ((@CustomerCode IS NULL) OR ([C].[Code] LIKE '%' + @CustomerCode + '%')) AND
            ((@CustomerName IS NULL) OR ([C].[Name] LIKE '%' + @CustomerName + '%')) AND
            ((@ReferenceNumber IS NULL) OR ([SOS].[ReferenceNumber] LIKE '%' + @ReferenceNumber + '%')) AND
            ((@DODocumentID IS NULL) OR ([SOS].[DODocumentID] = @DODocumentID)) AND
            ((@DODocumentCode IS NULL) OR ([DO].[DocumentCode] LIKE '%' + @DODocumentCode + '%')) AND
            ((@DocumentStatusID IS NULL) OR ([SOS].[DocumentStatusID] = @DocumentStatusID)) AND
            ((@DocumentStatusReason IS NULL) OR ([SOS].[DocumentStatusReason] LIKE '%' + @DocumentStatusReason + '%')) AND
            ((@PostedDateFrom IS NULL) OR ([dbo].[ValidateMaxDate]([SOS].[PostedDate]) >= [dbo].[ValidateMinDate](@PostedDateFrom))) AND
            ((@PostedDateTo IS NULL) OR ([dbo].[ValidateMinDate]([SOS].[PostedDate]) <= [dbo].[ValidateMaxDate](@PostedDateTo)))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSwap]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSwap];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSwap] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSwap]
AS
(
    SELECT
            [DocumentID],
            [DocumentCode],
            [TransactionDate],
            [SalesmanID],
            [SalesmanCode],
            [SalesmanName],
            [Salesman],
            [WarehouseID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [WarehouseTypeID],
            [WarehouseTypeName],
            [IsSiteLotNumberEntryRequired],
            [CustomerID],
            [CustomerCode],
            [CustomerName],
            [Customer],
            [ReferenceNumber],
            [AttachmentFile],
            [DODocumentID],
            [DODocumentCode],
            [DOShipmentDate],
            [DOReceivedDate],
            [DOPrintedCount],
            [DOLastPrintedDate],
            [TotalWeight],
            [TotalDimension],
            [DocumentStatusID],
            [DocumentStatusName],
            [DocumentStatusReason],
            [PostedDate],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName]
        FROM
			[dbo].[fSalesOrderSwap]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSwapSummary]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSwapSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide function to retrieve [dbo].[SalesOrderSwapSummary] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSwapSummary]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOSS].[DocumentID],            
            [SOSS].[ProductID],
            [fP].[Code] [ProductCode],
            [fP].[Name] [ProductName],
            [fP].[Product],
            [fP].[BrandID] [ProductBrandID],
            [fP].[BrandCode] [ProductBrandCode],
            [fP].[BrandName] [ProductBrandName],
            [fP].[Brand] [ProductBrand],
            [fP].[ShortName] [ProductShortName],
            [fP].[UOMLID] [ProductUOMLID],
            [fP].[UOMMID] [ProductUOMMID],
            [fP].[UOMSID] [ProductUOMSID],
            [fP].[UOMLName] [ProductUOMLName],
            [fP].[UOMMName] [ProductUOMMName],
            [fP].[UOMSName] [ProductUOMSName],
            [fP].[Weight] [ProductWeight],
            [fP].[DimensionL] [ProductDimensionL],
            [fP].[DimensionW] [ProductDimensionW],
            [fP].[DimensionH] [ProductDimensionH],
            [fP].[ConversionL] [ProductConversionL],
            [fP].[ConversionM] [ProductConversionM],
            [fP].[ConversionS] [ProductConversionS],
            [fP].[StatusID] [ProductStatusID],
            [fP].[StatusName] [ProductStatusName],
            [fP].[AdditionalInfo1] [ProductAdditionalInfo1],
            [fP].[AdditionalInfo2] [ProductAdditionalInfo2],
            [fP].[AdditionalInfo3] [ProductAdditionalInfo3],
            [fP].[AdditionalInfo4] [ProductAdditionalInfo4],
            [fP].[AdditionalInfo5] [ProductAdditionalInfo5],
            [fP].[AdditionalInfo6] [ProductAdditionalInfo6],
            [fP].[AdditionalInfo7] [ProductAdditionalInfo7],
            [fP].[AdditionalInfo8] [ProductAdditionalInfo8],
            [fP].[AdditionalInfo9] [ProductAdditionalInfo9],
            [fP].[AdditionalInfo10] [ProductAdditionalInfo10],
            (SELECT CASE WHEN [SOS].[DocumentStatusID] = 1 THEN ISNULL([SOHA].[QtyOnHandGood], 0) ELSE [SOSS].[QtyOnHand] END) [QtyOnHand],
            [SOSS].[QtyConvL],
            [SOSS].[QtyConvM],
            [SOSS].[QtyConvS],
            [SOSS].[Qty],
            (CAST([SOSS].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOSS].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOSS].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOSS].[Qty] * -1) [QtyOrder],
            [SOSS].[SubtotalWeight],
            [SOSS].[SubtotalDimension]
        FROM
			[dbo].[SalesOrderSwapSummary] [SOSS] INNER JOIN
            [dbo].[SalesOrderSwap] [SOS] ON ([SOSS].[DocumentID] = [SOS].[DocumentID]) LEFT OUTER JOIN
            (
                SELECT
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID],
                        SUM([fSOHA].[QtyOnHandGood]) [QtyOnHandGood],
                        SUM([fSOHA].[QtyOnHandHold]) [QtyOnHandHold],
                        SUM([fSOHA].[QtyOnHandBad]) [QtyOnHandBad]
                    FROM
                        [dbo].[fStockOnHandAvailable]
                        (
                            NULL,
                            NULL,
                            @ProductID,
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
                            NULL,
                            NULL,
                            @ProductCode,
                            @ProductName,
                            @ProductBrandID,
                            @ProductBrandCode,
                            @ProductBrandName,
                            @ProductShortName,
                            @ProductStatusID,
                            @ProductAdditionalInfo,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL                
                        ) [fSOHA]
                    GROUP BY
                        [fSOHA].[WarehouseID],
                        [fSOHA].[ProductID]
            ) [SOHA] ON
            (
                [SOS].[WarehouseID] = [SOHA].[WarehouseID] AND
                [SOSS].[ProductID] = [SOHA].[ProductID]
            ) INNER JOIN
            [dbo].[fProduct]
            (
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                NULL
            ) [fP] ON ([SOSS].[ProductID] = [fP].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOSS].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOSS].[ProductID] = @ProductID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSwapSummary]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSwapSummary];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 23:32:11
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSwapSummary] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSwapSummary]
AS
(
    SELECT
            [DocumentID],            
            [ProductID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [QtyOnHand],
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder],
            [SubtotalWeight],
            [SubtotalDimension]
        FROM
			[dbo].[fSalesOrderSwapSummary]
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
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fSalesOrderSwapDetails]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fSalesOrderSwapDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide function to retrieve [dbo].[SalesOrderSwapDetails] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fSalesOrderSwapDetails]
(
    @DocumentID uniqueidentifier,
    @ProductID int,
    @ProductLotID int,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [SOSD].[DocumentID],
            [SOSD].[ProductID],
            [SOSD].[ProductLotID],
            [fPL].[ProductCode],
            [fPL].[ProductName],
            [fPL].[Product],
            [fPL].[ProductBrandID],
            [fPL].[ProductBrandCode],
            [fPL].[ProductBrandName],
            [fPL].[ProductBrand],
            [fPL].[ProductShortName],
            [fPL].[ProductUOMLID],
            [fPL].[ProductUOMMID],
            [fPL].[ProductUOMSID],
            [fPL].[ProductUOMLName],
            [fPL].[ProductUOMMName],
            [fPL].[ProductUOMSName],
            [fPL].[ProductWeight],
            [fPL].[ProductDimensionL],
            [fPL].[ProductDimensionW],
            [fPL].[ProductDimensionH],
            [fPL].[ProductConversionL],
            [fPL].[ProductConversionM],
            [fPL].[ProductConversionS],
            [fPL].[ProductStatusID],
            [fPL].[ProductStatusName],
            [fPL].[ProductAdditionalInfo1],
            [fPL].[ProductAdditionalInfo2],
            [fPL].[ProductAdditionalInfo3],
            [fPL].[ProductAdditionalInfo4],
            [fPL].[ProductAdditionalInfo5],
            [fPL].[ProductAdditionalInfo6],
            [fPL].[ProductAdditionalInfo7],
            [fPL].[ProductAdditionalInfo8],
            [fPL].[ProductAdditionalInfo9],
            [fPL].[ProductAdditionalInfo10],
            [fPL].[Code] [ProductLotCode],
            [fPL].[StatusID] [ProductLotStatusID],
            [fPL].[StatusName] [ProductLotStatusName],
            (SELECT CASE WHEN [SOS].[DocumentStatusID] = 1 THEN ISNULL([fSOHA].[QtyOnHandGood], 0) ELSE [SOSD].[QtyOnHand] END) [QtyOnHand],
            [SOSD].[QtyConvL],
            [SOSD].[QtyConvM],
            [SOSD].[QtyConvS],
            [SOSD].[Qty],
            (CAST([SOSD].[QtyConvL] AS nvarchar(10)) + '/' +  CAST([SOSD].[QtyConvM] AS nvarchar(10)) + '/' + CAST([SOSD].[QtyConvS] AS nvarchar(10))) [QtyOrderConv],
            ([SOSD].[Qty] * -1) [QtyOrder]
        FROM
			[dbo].[SalesOrderSwapDetails] [SOSD] INNER JOIN
            [dbo].[SalesOrderSwap] [SOS] ON ([SOSD].[DocumentID] = [SOS].[DocumentID]) LEFT OUTER JOIN
            [dbo].[fStockOnHandAvailable]
            (
                NULL,
                NULL,
                @ProductID,
                @ProductLotID,
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
                NULL,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,
                @ProductLotStatusID,
                NULL
            ) [fSOHA] ON
            (
                [SOS].[WarehouseID] = [fSOHA].[WarehouseID] AND
                [SOSD].[ProductID] = [fSOHA].[ProductID] AND
                [SOSD].[ProductLotID] = [fSOHA].[ProductLotID]
            ) INNER JOIN
            [dbo].[fProductLot]
            (
                @ProductLotID,
                @ProductLotCode,
                @ProductID,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                NULL
            ) [fPL] ON ([SOSD].[ProductLotID] = [fPL].[ID])
		WHERE
            ((@DocumentID IS NULL) OR ([SOSD].[DocumentID] = @DocumentID)) AND
            ((@ProductID IS NULL) OR ([SOSD].[ProductID] = @ProductID)) AND
            ((@ProductLotID IS NULL) OR ([SOSD].[ProductLotID] = @ProductLotID))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vSalesOrderSwapDetails]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vSalesOrderSwapDetails];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:14:40
-- Description   : Provide view (model) to retrieve [dbo].[fSalesOrderSwapDetails] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vSalesOrderSwapDetails]
AS
(
    SELECT
            [DocumentID],
            [ProductID],
            [ProductLotID],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],            
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotStatusID],
            [ProductLotStatusName],            
            [QtyOnHand],            
            [QtyConvL],
            [QtyConvM],
            [QtyConvS],
            [Qty],
            [QtyOrderConv],
            [QtyOrder]
        FROM
			[dbo].[fSalesOrderSwapDetails]
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
                NULL,
                NULL,
                NULL,
                NULL
            )
);
GO
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fStockView]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fStockView];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[StockView] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fStockView]
(    
    @WarehouseID uniqueidentifier,
    @TransactionDate datetime,
    @ProductID int,
    @ProductLotID int,
    @WarehouseCode nvarchar(10),
    @WarehouseName nvarchar(50),
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @WarehouseTypeID int,
    @IsWarehouseSOAllowed bit,
    @WarehouseStatusID int,
    @IsWarehouseDeleted bit,
    @ProductCode nvarchar(10),
    @ProductName nvarchar(50),
    @ProductBrandID int,
    @ProductBrandCode nvarchar(10),
    @ProductBrandName nvarchar(50),
    @ProductPack nvarchar(50),
    @ProductShortName nvarchar(30),
    @ProductUOM nvarchar(20),
    @ProductStatusID int,
    @ProductAdditionalInfo nvarchar(100),
    @ProductLotCode nvarchar(20),
    @ProductLotExpiredDateFrom datetime,
    @ProductLotExpiredDateTo datetime,    
    @ProductLotStatusID int,
    @IsProductLotDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT
            [fSOHA].[WarehouseID],
            [fSOHA].[ProductID],
            [fSOHA].[ProductLotID],
            [fW].[Code] [WarehouseCode],
            [fW].[Name] [WarehouseName],
            [fW].[Warehouse],
            [fW].[SiteID],
            [fW].[SiteCode],
            [fW].[SiteName],
            [fW].[Site],
            [fW].[AreaID],
            [fW].[AreaCode],
            [fW].[AreaName],
            [fW].[Area],
            [fW].[RegionID],
            [fW].[RegionCode],
            [fW].[RegionName],
            [fW].[Region],
            [fW].[TerritoryID],
            [fW].[TerritoryCode],
            [fW].[TerritoryName],
            [fW].[Territory],
            [fW].[CompanyID],
            [fW].[CompanyCode],
            [fW].[CompanyName],
            [fW].[Company],
            [fW].[SiteDistributionTypeID],
            [fW].[SiteDistributionTypeName],
            [fW].[IsSiteLotNumberEntryRequired],
            [fW].[TypeID] [WarehouseTypeID],            
            [fW].[TypeName] [WarehouseTypeName],
            [fW].[IsSOAllowed] [IsWarehouseSOAllowed],
            [fW].[StatusID] [WarehouseStatusID],
            [fW].[StatusName] [WarehouseStatusName],            
            [fW].[IsDeleted] [IsWarehouseDeleted],
            [fSOHA].[QtyPeriodOnHandGood],
            [fSOHA].[QtyPeriodOnHandHold],
            [fSOHA].[QtyPeriodOnHandBad],
            [fSOHA].[QtyTransactionGood],
            [fSOHA].[QtyTransactionHold],
            [fSOHA].[QtyTransactionBad],
            [fSOHA].[QtyOnHandGood],
            [fSOHA].[QtyOnHandHold],
            [fSOHA].[QtyOnHandBad],
            [fSOHA].[ProductCode],
            [fSOHA].[ProductName],
            [fSOHA].[Product],
            [fSOHA].[ProductBrandID],
            [fSOHA].[ProductBrandCode],
            [fSOHA].[ProductBrandName],
            [fSOHA].[ProductBrand],
            [fSOHA].[ProductShortName],
            [fSOHA].[ProductUOMLID],
            [fSOHA].[ProductUOMMID],
            [fSOHA].[ProductUOMSID],
            [fSOHA].[ProductUOMLName],
            [fSOHA].[ProductUOMMName],
            [fSOHA].[ProductUOMSName],
            [fSOHA].[ProductWeight],
            [fSOHA].[ProductDimensionL],
            [fSOHA].[ProductDimensionW],
            [fSOHA].[ProductDimensionH],
            [fSOHA].[ProductConversionL],
            [fSOHA].[ProductConversionM],
            [fSOHA].[ProductConversionS],
            [fSOHA].[ProductStatusID],
            [fSOHA].[ProductStatusName],
            [fSOHA].[ProductAdditionalInfo1],
            [fSOHA].[ProductAdditionalInfo2],
            [fSOHA].[ProductAdditionalInfo3],
            [fSOHA].[ProductAdditionalInfo4],
            [fSOHA].[ProductAdditionalInfo5],
            [fSOHA].[ProductAdditionalInfo6],
            [fSOHA].[ProductAdditionalInfo7],
            [fSOHA].[ProductAdditionalInfo8],
            [fSOHA].[ProductAdditionalInfo9],
            [fSOHA].[ProductAdditionalInfo10],
            [fSOHA].[ProductLotCode],
            [fSOHA].[ProductLotExpiredDate],
            [fSOHA].[ProductLot],
            [fSOHA].[ProductLotStatusID],
            [fSOHA].[ProductLotStatusName],
            [fSOHA].[IsProductLotCodeDeleted]
        FROM            
            [dbo].[fStockOnHandAvailable]
            (
                @WarehouseID,
                @TransactionDate,
                @ProductID,
                @ProductLotID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                @IsWarehouseSOAllowed,
                @WarehouseStatusID,
                @IsWarehouseDeleted,
                @ProductCode,
                @ProductName,
                @ProductBrandID,
                @ProductBrandCode,
                @ProductBrandName,
                @ProductShortName,
                @ProductStatusID,
                @ProductAdditionalInfo,
                @ProductLotCode,
                @ProductLotExpiredDateFrom,
                @ProductLotExpiredDateTo,    
                @ProductLotStatusID,
                @IsProductLotDeleted
            ) [fSOHA] INNER JOIN
            [dbo].[fWarehouse]
            (
                @WarehouseID,
                @WarehouseCode,
                @WarehouseName,
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
                @WarehouseTypeID,
                @IsWarehouseSOAllowed,
                @WarehouseStatusID,
                @IsWarehouseDeleted
            ) [fW] ON ([fSOHA].[WarehouseID] = [fW].[ID])
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vStockView]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vStockView];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 20 Mar 2016 22:02:32
-- Description   : Provide view (model) to retrieve [dbo].[fStockView] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vStockView]
AS
(
    SELECT
            [WarehouseID],
            [ProductID],
            [ProductLotID],
            [WarehouseCode],
            [WarehouseName],
            [Warehouse],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],
            [WarehouseTypeID],            
            [WarehouseTypeName],
            [IsWarehouseSOAllowed],
            [WarehouseStatusID],
            [WarehouseStatusName],
            [QtyPeriodOnHandGood],
            [QtyPeriodOnHandHold],
            [QtyPeriodOnHandBad],
            [QtyTransactionGood],
            [QtyTransactionHold],
            [QtyTransactionBad],
            [QtyOnHandGood],
            [QtyOnHandHold],
            [QtyOnHandBad],
            [ProductCode],
            [ProductName],
            [Product],
            [ProductBrandID],
            [ProductBrandCode],
            [ProductBrandName],
            [ProductBrand],
            [ProductShortName],
            [ProductUOMLID],
            [ProductUOMMID],
            [ProductUOMSID],
            [ProductUOMLName],
            [ProductUOMMName],
            [ProductUOMSName],
            [ProductWeight],
            [ProductDimensionL],
            [ProductDimensionW],
            [ProductDimensionH],
            [ProductConversionL],
            [ProductConversionM],
            [ProductConversionS],
            [ProductStatusID],
            [ProductStatusName],
            [ProductAdditionalInfo1],
            [ProductAdditionalInfo2],
            [ProductAdditionalInfo3],
            [ProductAdditionalInfo4],
            [ProductAdditionalInfo5],
            [ProductAdditionalInfo6],
            [ProductAdditionalInfo7],
            [ProductAdditionalInfo8],
            [ProductAdditionalInfo9],
            [ProductAdditionalInfo10],
            [ProductLotCode],
            [ProductLotExpiredDate],
            [ProductLot],
            [ProductLotStatusID],
            [ProductLotStatusName],
            [IsProductLotCodeDeleted]
        FROM
			[dbo].[fStockView]
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
USE [IDOS];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[fUser]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[fUser];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide function to retrieve [dbo].[User] data.
--
-- NOTE: This Function is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE FUNCTION [dbo].[fUser]
(
    @ID int,
    @Name nvarchar(256),
    @IsHeadOffice bit,
    @SiteID uniqueidentifier,
    @SiteCode nvarchar(10),
    @SiteName nvarchar(50),
    @AreaID int,
    @AreaCode nvarchar(10),
    @AreaName nvarchar(50),
    @RegionID int,
    @RegionCode nvarchar(10),
    @RegionName nvarchar(50),
    @TerritoryID int,
    @TerritoryCode nvarchar(10),
    @TerritoryName nvarchar(50),
    @CompanyID int,
    @CompanyCode nvarchar(10),
    @CompanyName nvarchar(50),
    @SiteDistributionTypeID int,
    @IsSiteLotNumberEntryRequired bit,
    @StatusID int,
    @IsDeleted bit
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
            [U].[ID],
            [U].[Name],
            [U].[Password],
            [U].[IsHeadOffice],
            [U].[SiteID],
            [fS].[Code] [SiteCode],
            [fS].[Name] [SiteName],
            [fS].[Site],
            [fS].[AreaID],
            [fS].[AreaCode],
            [fS].[AreaName],
            [fS].[Area],            
            [fS].[RegionID],
            [fS].[RegionCode],
            [fS].[RegionName],
            [fS].[Region],
            [fS].[TerritoryID],
            [fS].[TerritoryCode],
            [fS].[TerritoryName],
            [fS].[Territory],
            [fS].[CompanyID],
            [fS].[CompanyCode],
            [fS].[CompanyName],
            [fS].[Company],
            [fS].[DistributionTypeID] [SiteDistributionTypeID],
            [fS].[DistributionTypeName] [SiteDistributionTypeName],
            [fS].[IsLotNumberEntryRequired] [IsSiteLotNumberEntryRequired],            
            [U].[StatusID],
            [fSL].[Name] [StatusName],
            [U].[CreatedDate],
            [U].[CreatedByUserID],
            [CU].[Name] [CreatedByUserName],
            [U].[ModifiedDate],
            [U].[ModifiedByUserID],
            [MU].[Name] [ModifiedByUserName],
            [U].[IsDeleted]
        FROM
			[dbo].[User] [U] LEFT OUTER JOIN
            [dbo].[fSite]
            (
                @SiteID,
                @SiteCode,
                @SiteName,
                @AreaID,
                @AreaCode,
                @AreaName,
                @RegionID,
                @RegionCode,
                @RegionName,
                @TerritoryID,
                @TerritoryCode,
                @TerritoryName,
                @CompanyID,
                @CompanyCode,
                @CompanyName,
                @SiteDistributionTypeID,
                @IsSiteLotNumberEntryRequired,
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
                NULL,
                NULL,
                NULL
            ) [fS] ON ([U].[SiteID] = [fS].[ID]) LEFT OUTER JOIN
            [dbo].[fSystemLookup]
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
                'UserStatus',
                NULL,
                NULL,
                NULL
            ) [fSL] ON ([U].[StatusID] = [fSL].[Value_Int32])  LEFT OUTER JOIN
            [dbo].[User] [CU] ON ([U].[CreatedByUserID] = [CU].[ID]) LEFT OUTER JOIN
            [dbo].[User] [MU] ON ([U].[ModifiedByUserID] = [MU].[ID])
		WHERE
            ((@ID IS NULL) OR ([U].[ID] = @ID)) AND
            ((@Name IS NULL) OR ([U].[Name] = @Name)) AND
            ((@IsHeadOffice IS NULL) OR ([U].[IsHeadOffice] = @IsHeadOffice)) AND
            ((@SiteID IS NULL) OR ([U].[SiteID] = @SiteID)) AND
            ((@StatusID IS NULL) OR ([U].[StatusID] = @StatusID)) AND
            ((@IsDeleted IS NULL) OR ([U].[IsDeleted] = @IsDeleted))
);
GO



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[vUser]') AND type IN ( N'V' ))
    DROP VIEW [dbo].[vUser];
GO

-- ===================================================================================
-- Author        : System
-- Created date  : 18 Mar 2016 00:11:40
-- Description   : Provide view (model) to retrieve [dbo].[fUser] data.
--
-- NOTE: This View is initially generated by system and can be modified following
--       the requirement.
-- ===================================================================================

CREATE VIEW [dbo].[vUser]
AS
(
    SELECT
            [ID],
            [Name],
            [Password],
            [IsHeadOffice],
            [SiteID],
            [SiteCode],
            [SiteName],
            [Site],
            [AreaID],
            [AreaCode],
            [AreaName],
            [Area],
            [RegionID],
            [RegionCode],
            [RegionName],
            [Region],
            [TerritoryID],
            [TerritoryCode],
            [TerritoryName],
            [Territory],
            [CompanyID],
            [CompanyCode],
            [CompanyName],
            [Company],
            [SiteDistributionTypeID],
            [SiteDistributionTypeName],
            [IsSiteLotNumberEntryRequired],            
            [StatusID],
            [StatusName],
            [CreatedDate],
            [CreatedByUserID],
            [CreatedByUserName],
            [ModifiedDate],
            [ModifiedByUserID],
            [ModifiedByUserName],
            [IsDeleted]
        FROM
			[dbo].[fUser]
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
