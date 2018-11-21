USE [IDOS];
GO

UPDATE
        [PAI]
    SET
        [PAI].[AdditionalInfo1] =
        (
            SELECT CASE WHEN [P].[BrandID] = 1 THEN
                (
                    CAST(
                    (
                        SELECT CASE
                            WHEN CHARINDEX('ml', [P].[Name]) > 0 THEN CAST(SUBSTRING([P].[Name], CHARINDEX('ml', [P].[Name]) - 4, 4) AS float)
                            WHEN CHARINDEX('15gr', [P].[Name]) > 0 THEN CAST(200 AS float)
                            WHEN CHARINDEX('37g', [P].[Name]) > 0 THEN CAST(500 AS float)
                        END
                    ) / 330
                    AS decimal(18,4))
                )
            ELSE NULL
            END
        ),
        [PAI].[AdditionalInfo2] =
        (
            SELECT CASE
                WHEN CHARINDEX(' ', [ShortName]) >= 1 THEN SUBSTRING([ShortName], 1, CHARINDEX(' ', [ShortName]))
                ELSE [ShortName]
            END
        )
    FROM
        [Product] [P] INNER JOIN
        [ProductAdditionalInfo] [PAI] ON ([P].[ID] = [PAI].[ProductID]);

SELECT
        [P].[ID],
        [P].[Code],
        [P].[Name],
        [PAI].[AdditionalInfo1],
        [PAI].[AdditionalInfo2]
    FROM
        [Product] [P] INNER JOIN
        [ProductAdditionalInfo] [PAI] ON ([P].[ID] = [PAI].[ProductID]);

