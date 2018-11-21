USE [IDOS_DEV];
GO

CREATE TABLE [dbo].[MyTempTable]
(   
    [ID] int NOT NULL,
    [Code] nvarchar(50) NULL,
    [Number] int NOT NULL,    
    [Category] nvarchar(512) NULL,
    CONSTRAINT [PK_MyTempTable] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


INSERT INTO
        [dbo].[MyTempTable]
    SELECT
            [ID],
            [Code],
            1 [Number],
            NULL [Category]
        FROM [dbo].[CustomerCategory] WHERE [Group] = 'GTCustomerType'
    UNION ALL
    SELECT
            [ID],
            [Code],
            2 [Number],
            NULL [Category]
        FROM [dbo].[CustomerCategory] WHERE [Group] = 'MTCustomerGroup'
    UNION ALL
    SELECT
            [ID],
            [Code],
            3 [Number],
            NULL [Category]
        FROM [dbo].[CustomerCategory] WHERE [Group] = 'Location'
    UNION ALL
    SELECT
            [ID],
            [Code],
            4 [Number],
            NULL [Category]
        FROM [dbo].[CustomerCategory] WHERE [Group] = 'Channel';

DECLARE @ID int = 204;
DECLARE @Category nvarchar(512);

DECLARE Cur CURSOR FOR SELECT [ID] FROM [dbo].[MyTempTable];
OPEN Cur;  
FETCH NEXT FROM Cur INTO @ID
  
WHILE @@FETCH_STATUS = 0
BEGIN  
    EXEC [dbo].[spFlattenCustomerCategory] @ID, @Category OUTPUT;

    UPDATE [dbo].[MyTempTable] SET [Category] = @Category WHERE [ID] = @ID;

    FETCH NEXT FROM Cur INTO @ID
END;  
CLOSE Cur;  
DEALLOCATE Cur; 

    UPDATE [SOX] SET
        [CustomerCategory1] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category1ID]),
        [CustomerCategory2] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category2ID]),
        [CustomerCategory3] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category3ID]),
        [CustomerCategory4] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category4ID])
    --SELECT
    --    [CCI].[Category4ID],
    --    [SOX].[CustomerCategory4]
    FROM
        [dbo].[SalesOrderExt] [SOX] INNER JOIN
        [dbo].[SalesOrder] [SO] ON ([SOX].[DocumentID] = [SO].[DocumentID]) INNER JOIN
        [dbo].[CustomerCategoryInfo] [CCI] ON ([SO].[CustomerID] = [CCI].[CustomerID])

    UPDATE [SORX] SET
        [CustomerCategory1] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category1ID]),
        [CustomerCategory2] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category2ID]),
        [CustomerCategory3] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category3ID]),
        [CustomerCategory4] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category4ID])
    --SELECT
    --    [CCI].[Category4ID],
    --    [SORX].[CustomerCategory4]
    FROM
        [dbo].[SalesOrderReturnExt] [SORX] INNER JOIN
        [dbo].[SalesOrderReturn] [SOR] ON ([SORX].[DocumentID] = [SOR].[DocumentID]) INNER JOIN
        [dbo].[CustomerCategoryInfo] [CCI] ON ([SOR].[CustomerID] = [CCI].[CustomerID])

    UPDATE [SOFOCX] SET
        [CustomerCategory1] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category1ID]),
        [CustomerCategory2] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category2ID]),
        [CustomerCategory3] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category3ID]),
        [CustomerCategory4] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category4ID])
    --SELECT
    --    [CCI].[Category4ID],
    --    [SOFOCX].[CustomerCategory4]
    FROM
        [dbo].[SalesOrderFOCExt] [SOFOCX] INNER JOIN
        [dbo].[SalesOrderFOC] [SOFOC] ON ([SOFOCX].[DocumentID] = [SOFOC].[DocumentID]) INNER JOIN
        [dbo].[CustomerCategoryInfo] [CCI] ON ([SOFOC].[CustomerID] = [CCI].[CustomerID])

    UPDATE [SOSX] SET
        [CustomerCategory1] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category1ID]),
        [CustomerCategory2] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category2ID]),
        [CustomerCategory3] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category3ID]),
        [CustomerCategory4] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category4ID])
    --SELECT
    --    [CCI].[Category4ID],
    --    [SOSX].[CustomerCategory4]
    FROM
        [dbo].[SalesOrderSampleExt] [SOSX] INNER JOIN
        [dbo].[SalesOrderSample] [SOS] ON ([SOSX].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
        [dbo].[CustomerCategoryInfo] [CCI] ON ([SOS].[CustomerID] = [CCI].[CustomerID])

    UPDATE [SOSX] SET
        [CustomerCategory1] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category1ID]),
        [CustomerCategory2] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category2ID]),
        [CustomerCategory3] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category3ID]),
        [CustomerCategory4] = (SELECT [Category] FROM [dbo].[MyTempTable] WHERE [ID] = [CCI].[Category4ID])
    --SELECT
    --    [CCI].[Category4ID],
    --    [SOSX].[CustomerCategory4]
    FROM
        [dbo].[SalesOrderSwapExt] [SOSX] INNER JOIN
        [dbo].[SalesOrderSwap] [SOS] ON ([SOSX].[DocumentID] = [SOS].[DocumentID]) INNER JOIN
        [dbo].[CustomerCategoryInfo] [CCI] ON ([SOS].[CustomerID] = [CCI].[CustomerID])


    --UPDATE [dbo].[SalesOrderExt] SET
    --    [CustomerCategory1] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory1]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 1 AND [Code] = RTRIM(SUBSTRING([CustomerCategory1], 1, CHARINDEX('-', [CustomerCategory1]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory2] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory2]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 2 AND [Code] = RTRIM(SUBSTRING([CustomerCategory2], 1, CHARINDEX('-', [CustomerCategory2]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory3] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory3]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 3 AND [Code] = RTRIM(SUBSTRING([CustomerCategory3], 1, CHARINDEX('-', [CustomerCategory3]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory4] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory4]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 4 AND [Code] = RTRIM(SUBSTRING([CustomerCategory4], 1, CHARINDEX('-', [CustomerCategory4]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    );

    --UPDATE [dbo].[SalesOrderReturnExt] SET
    --    [CustomerCategory1] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory1]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 1 AND [Code] = RTRIM(SUBSTRING([CustomerCategory1], 1, CHARINDEX('-', [CustomerCategory1]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory2] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory2]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 2 AND [Code] = RTRIM(SUBSTRING([CustomerCategory2], 1, CHARINDEX('-', [CustomerCategory2]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory3] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory3]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 3 AND [Code] = RTRIM(SUBSTRING([CustomerCategory3], 1, CHARINDEX('-', [CustomerCategory3]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory4] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory4]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 4 AND [Code] = RTRIM(SUBSTRING([CustomerCategory4], 1, CHARINDEX('-', [CustomerCategory4]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    );
    
    --UPDATE [dbo].[SalesOrderFOCExt] SET
    --    [CustomerCategory1] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory1]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 1 AND [Code] = RTRIM(SUBSTRING([CustomerCategory1], 1, CHARINDEX('-', [CustomerCategory1]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory2] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory2]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 2 AND [Code] = RTRIM(SUBSTRING([CustomerCategory2], 1, CHARINDEX('-', [CustomerCategory2]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory3] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory3]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 3 AND [Code] = RTRIM(SUBSTRING([CustomerCategory3], 1, CHARINDEX('-', [CustomerCategory3]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory4] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory4]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 4 AND [Code] = RTRIM(SUBSTRING([CustomerCategory4], 1, CHARINDEX('-', [CustomerCategory4]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    );

    --UPDATE [dbo].[SalesOrderSampleExt] SET
    --    [CustomerCategory1] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory1]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 1 AND [Code] = RTRIM(SUBSTRING([CustomerCategory1], 1, CHARINDEX('-', [CustomerCategory1]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory2] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory2]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 2 AND [Code] = RTRIM(SUBSTRING([CustomerCategory2], 1, CHARINDEX('-', [CustomerCategory2]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory3] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory3]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 3 AND [Code] = RTRIM(SUBSTRING([CustomerCategory3], 1, CHARINDEX('-', [CustomerCategory3]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory4] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory4]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 4 AND [Code] = RTRIM(SUBSTRING([CustomerCategory4], 1, CHARINDEX('-', [CustomerCategory4]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    );

    --UPDATE [dbo].[SalesOrderSwapExt] SET
    --    [CustomerCategory1] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory1]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 1 AND [Code] = RTRIM(SUBSTRING([CustomerCategory1], 1, CHARINDEX('-', [CustomerCategory1]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory2] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory2]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 2 AND [Code] = RTRIM(SUBSTRING([CustomerCategory2], 1, CHARINDEX('-', [CustomerCategory2]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory3] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory3]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 3 AND [Code] = RTRIM(SUBSTRING([CustomerCategory3], 1, CHARINDEX('-', [CustomerCategory3]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    ),
    --    [CustomerCategory4] =
    --    (
    --        SELECT CASE WHEN CHARINDEX('-', [CustomerCategory4]) > 0 THEN
    --                (
    --                    SELECT [Category] FROM [dbo].[MyTempTable]
    --                        WHERE [Number] = 4 AND [Code] = RTRIM(SUBSTRING([CustomerCategory4], 1, CHARINDEX('-', [CustomerCategory4]) - 1))
    --                )
    --                ELSE
    --                    ''
    --                END
    --    );

DROP TABLE [dbo].[MyTempTable];

--SELECT [CustomerCategory1], [CustomerCategory2] FROM [SalesOrderExt]
--SELECT [CustomerCategory1], [CustomerCategory2] FROM [SalesOrderReturnExt]
--SELECT [CustomerCategory1], [CustomerCategory2] FROM [SalesOrderFOCExt]
--SELECT [CustomerCategory1], [CustomerCategory2] FROM [SalesOrderSampleExt]
--SELECT [CustomerCategory1], [CustomerCategory2] FROM [SalesOrderSwapExt]

--SELECT
--        [CCI].[Category1ID],
--        [CC1].[Code] + ' - ' + [CC1].[Name] [Category1Code],
--        [CC1].[ParentID],
--        [CC1P].[Code] + ' - ' + [CC1P].[Name] [Category1ParentCode],
--        [CC1P].[ParentID],
--        [CC1PP].[Code] + ' - ' + [CC1PP].[Name] [Category1ParentParentCode],
--        [CCI].[Category2ID],
--        [CC2].[Code] + ' - ' + [CC2].[Name] [Category2Code],
--        [CCI].[Category3ID],
--        [CC3].[Code] + ' - ' + [CC3].[Name] [Category3Code],
--        [CCI].[Category4ID],
--        [CC4].[Code] + ' - ' + [CC4].[Name] [Category4Code]
--    FROM
--        [dbo].[CustomerCategoryInfo] [CCI] INNER JOIN
--        [dbo].[CustomerCategory] [CC1] ON ([CCI].[Category1ID] = [CC1].[ID]) INNER JOIN
--        [dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID]) INNER JOIN
--        [dbo].[CustomerCategory] [CC3] ON ([CCI].[Category3ID] = [CC3].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC4] ON ([CCI].[Category4ID] = [CC4].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC1P] ON ([CC1].[ParentID] = [CC1P].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC1PP] ON ([CC1P].[ParentID] = [CC1PP].[ID])
--    WHERE        
--        [CC2].[Name] LIKE '%ALFAMART%'

--UPDATE [dbo].[CustomerCategory] SET [IsDeleted] = 1 WHERE [Code] = '4.1'

--UPDATE [CCI]
--    SET [CCI].[Category4ID] = (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.5')
--    FROM
--        [dbo].[CustomerCategoryInfo] [CCI] INNER JOIN
--        [dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID])
--    WHERE
--        [CC2].[Name] LIKE '%ALFAMART%'
    
--UPDATE [CCI]
--    SET [CCI].[Category4ID] = (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.6')
--    FROM
--        [dbo].[CustomerCategoryInfo] [CCI] INNER JOIN
--        [dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID])
--    WHERE
--        [CC2].[Name] LIKE '%INDOMARET%'
        
--UPDATE [CCI]
--    SET [CCI].[Category4ID] = (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.7')
--    FROM
--        [dbo].[CustomerCategoryInfo] [CCI] INNER JOIN
--        [dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID])
--    WHERE
--        [CC2].[Name] LIKE '%ALFAMIDI%'

--UPDATE [CCI]
--    SET [CCI].[Category4ID] =
--    (
--            SELECT CASE WHEN [CCI].[Category2ID] = (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '2.3.1') THEN
--                (
--                    SELECT CASE
--                        WHEN [CC1PP].[Code] = '1.1.1' THEN (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.4')
--                        WHEN [CC1PP].[Code] = '1.2.1' THEN (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.2')
--                        WHEN [CC1PP].[Code] = '1.2.2' THEN (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.3')
--                    END
--                )
--                ELSE
--                    (SELECT [ID] FROM [dbo].[CustomerCategory] WHERE [Code] = '4.4')
--            END
--        )
--    --SELECT
--    --    [CC1].[Name][CustomerCategory1],
--    --    [CC1PP].[Code],
--    --    [CC1PP].[Name][CustomerCategory1ParentParent],
--    --    [CC2].[Name][CustomerCategory2],
--    --    [CC4].[Code] [Category4Code],
--    --    [CC4].[Name] [Category4]
--    FROM
--        [dbo].[CustomerCategoryInfo] [CCI] INNER JOIN
--        [dbo].[CustomerCategory] [CC1] ON ([CCI].[Category1ID] = [CC1].[ID]) INNER JOIN
--        [dbo].[CustomerCategory] [CC2] ON ([CCI].[Category2ID] = [CC2].[ID]) INNER JOIN
--        [dbo].[CustomerCategory] [CC3] ON ([CCI].[Category3ID] = [CC3].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC4] ON ([CCI].[Category4ID] = [CC4].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC1P] ON ([CC1].[ParentID] = [CC1P].[ID]) LEFT OUTER JOIN
--        [dbo].[CustomerCategory] [CC1PP] ON ([CC1P].[ParentID] = [CC1PP].[ID])
--    WHERE
--        [CC2].[Name] NOT LIKE '%ALFAMART%' AND
--        [CC2].[Name] NOT LIKE '%INDOMARET%' AND
--        [CC2].[Name] NOT LIKE '%ALFAMIDI%'
