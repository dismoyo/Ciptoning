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
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToFirstDayOfYear]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToFirstDayOfYear];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the first day of year.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToFirstDayOfYear]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	RETURN DATEADD(MONTH, DATEDIFF(YEAR, 0, @value), 0);
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
    WHERE object_id = OBJECT_ID(N'[dbo].[ConvertToLastDayOfYear]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[ConvertToLastDayOfYear];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to convert a date time value to the last day of year.
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[ConvertToLastDayOfYear]
(
	@value datetime
)
RETURNS datetime
AS
BEGIN
	DECLARE @year int = DATEDIFF(yyyy, 0, @value) + 1;
	DECLARE @maxYear int = DATEDIFF(yyyy, 0, [dbo].[GetMaxDate]());
	
	IF (@year > @maxYear)
		RETURN [dbo].[GetMaxDate]();
	
	RETURN DATEADD(ms,-3, DATEADD(yyyy, @year, 0));
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



IF EXISTS(SELECT * FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[SearchText]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[SearchText];
GO

-- ==========================================================================================
-- Author:		 
-- Created date: 2016-03-17
-- Description:	 Provide function to search text by keywords (split by Space character).
-- 
-- ==========================================================================================
CREATE FUNCTION [dbo].[SearchText]
(
	@text nvarchar(MAX),
    @keywords nvarchar(MAX)
)
RETURNS bit
AS
BEGIN
    DECLARE @keywordsLen int;

    SET @keywordsLen = LEN(@keywords);
    IF (@keywordsLen = 0)
        RETURN 1;
    ELSE
    BEGIN
        IF (LEN(@text) = 0)
            RETURN 0;
        ELSE
        BEGIN
            DECLARE @pos int;
            DECLARE @nextPos int;
            DECLARE @value nvarchar(MAX);
    
    
            SET @pos = 1;
            SET @nextPos = CHARINDEX(' ', @keywords, @pos + 1);
    
            IF (@nextPos = 0)
                SET @nextPos = @keywordsLen + 1;

            WHILE ((@nextPos - @pos) > 0)
            BEGIN
                IF (@nextPos = 0)
                    SET @nextPos = @keywordsLen + 1;

                SET @value = LTRIM(RTRIM(SUBSTRING(@keywords, @pos, @nextPos - @pos)));

                IF ((LEN(@value) > 0) AND (CHARINDEX(@value, @text, 1) > 0))
                    RETURN 1;

                SET @pos = @nextPos + 1;
                SET @nextPos = CHARINDEX(' ', @keywords, @pos + 1);

                IF (@nextPos = 0)
                    SET @nextPos = @keywordsLen + 1;
            END
        END
    END
    
	RETURN 0;
END;
GO
