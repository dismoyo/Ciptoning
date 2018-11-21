DECLARE @objectName AS nvarchar(100) = 'RoutePlanCustomer';
DECLARE @script AS varchar(MAX) = '';

SET @script = '
        #region Custom Methods

        [WebGet]
        public IQueryable<v' + @objectName + '> f' + @objectName + 's() // Fix the Name if plural convention was wrong!!
        {
            return CurrentDataSource.f' + @objectName + '(';

SELECT
        @script = @script + '
                (' + parameter + ')GetQueryFilterParameterValue("' + REPLACE(parameter2, '@', '') + '"),'
    FROM
        (
            SELECT DISTINCT
                    (
                        SELECT CASE
                            WHEN t.system_type_id = 35 OR t.system_type_id = 99 OR t.system_type_id = 167 OR t.system_type_id = 175 OR t.system_type_id = 231 OR t.system_type_id = 239 THEN 'string'
                            WHEN t.system_type_id = 104 THEN 'bool?'
                            WHEN t.system_type_id = 48 THEN 'byte?'
                            WHEN t.system_type_id = 52 THEN 'short?'
                            WHEN t.system_type_id = 56 THEN 'int?'
                            WHEN t.system_type_id = 56 THEN 'long?'
                            WHEN t.system_type_id = 62 OR t.system_type_id = 106 THEN 'double?'
                            WHEN t.system_type_id = 36 THEN 'Guid?'
                            WHEN t.system_type_id = 40 OR t.system_type_id = 41 OR t.system_type_id = 42 OR t.system_type_id = 43 OR t.system_type_id = 58 OR t.system_type_id = 61 THEN 'DateTime?'
                        END
                    ) [parameter],
                    p.name [parameter2],
                    p.parameter_id
                FROM
                    sys.parameters p INNER JOIN
                    sys.types t ON p.system_type_id = t.system_type_id
                WHERE
                    p.object_id = OBJECT_ID('f' + @objectName)                
        ) [sql]
    ORDER BY
        parameter_id;

PRINT STUFF(@script, LEN(@script), 1, '') + ');
        }
        
        #endregion'
