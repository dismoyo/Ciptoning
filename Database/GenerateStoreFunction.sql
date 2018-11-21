DECLARE @objectName AS nvarchar(100) = 'StockView';
DECLARE @script AS varchar(MAX) = '';
DECLARE @script2 AS varchar(MAX) = '';
DECLARE @script3 AS varchar(MAX) = '';

SET @script = 
'using ISID.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace AIO.IDOS2.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region f' + @objectName + '

        [DbFunction("StoreFunctionsDataContext", "f' + @objectName + '")]
        public IQueryable<v' + @objectName + '> f' + @objectName + '(';

SELECT
        @script = @script + '
            ' + parameter + ' ' + REPLACE(parameter2, '@', 'p_') + ',',
			
        @script2 = @script2 + '
                    ' + parameter2 + ',',
			
        @script3 = @script3 + '
                ' + 'Parameter("' + REPLACE(parameter2, '@', '') + '"' + ', typeof(' + parameter + '), ' + REPLACE(parameter2, '@', 'p_') + '),'
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

PRINT STUFF(@script, LEN(@script), 1, '') + ')
        {
            return OrderQuery<v' + @objectName + '>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<v' + @objectName + '>(string.Format(@"
                [{0}].[f' + @objectName + ']
                ( ' + STUFF(@script2, LEN(@script2), 1, '') + '
                )", GetType().Name),';
PRINT REPLACE(STUFF(@script3, LEN(@script3), 1, ''), 'Parameter', 'DefaultDataContext.CreateParameter') + '));
        }
        
        #endregion
    
    }
    
}'
