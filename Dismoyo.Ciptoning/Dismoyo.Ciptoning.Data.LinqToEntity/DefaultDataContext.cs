using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{

    public static class DefaultDataContext
    {

        #region Constants

        public static string DataContextKey = "DefaultDataContext";

        #endregion

        #region Properties

        public static StoreFunctionsDataContext DataContext
        {
            get
            {
                if (HttpContext.Current == null)
                    return NewDataContext;

                if (HttpContext.Current.Items[DataContextKey] == null)
                {
                    var dataContext = NewDataContext;
                    dataContext.Database.Log = (query) =>
                    {
#if DEBUG
                        Console.WriteLine(query);
#endif
                    };

                    HttpContext.Current.Items[DataContextKey] = dataContext;
                }

                return (StoreFunctionsDataContext)HttpContext.Current.Items[DataContextKey];
            }
        }

        public static StoreFunctionsDataContext NewDataContext
        {
            get
            {
                return new StoreFunctionsDataContext();
            }
        }

        #endregion

        #region Methods

        public static DateTime GetDBServerDateTime()
        {
            return DataContext.Database.SqlQuery<DateTime>("SELECT GETDATE();").Single();
        }

        public static DateTime GetDBServerUtcDateTime()
        {
            return DateTime.SpecifyKind(DataContext.Database.SqlQuery<DateTime>("SELECT GETUTCDATE();").Single(), DateTimeKind.Utc);
        }

        public static int GetAutoNumberCounter(Guid siteID, int typeID)
        {
            return DataContext.Database.SqlQuery<int>(
                "EXEC [dbo].[spGetAutoNumberCounter] @SiteID = @siteID, @TypeID = @typeID;",
            CreateSqlParameter("siteID", typeof(Guid), siteID),
            CreateSqlParameter("typeID", typeof(int), typeID)).Single();
        }

        public static DataTable GetDataTable(string query, SqlParameter[] sqlParams)
        {
            var dataTable = new DataTable();

            var conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings[DataConfiguration.DefaultConnectionStringName].ConnectionString);
            var cmd = new SqlCommand(query, conn);
            cmd.CommandTimeout = int.Parse(
                ConfigurationManager.AppSettings[DataConfiguration.DefaultDataContextCommandTimeoutName]);

            if (sqlParams.Length > 0)
            {
                foreach (var p in sqlParams)
                {
                    if (p.Value == null)
                    {
                        p.IsNullable = true;
                        p.Value = DBNull.Value;
                    }
                }

                cmd.Parameters.AddRange(sqlParams);
            }

            try
            {
                conn.Open();

                var reader = cmd.ExecuteReader();

                for (int i = 0; i < reader.FieldCount; i++)
                    dataTable.Columns.Add(reader.GetName(i), reader.GetFieldType(i));

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        var row = dataTable.NewRow();
                        for (int i = 0; i < reader.FieldCount; i++)
                            row[i] = reader.GetValue(i);

                        dataTable.Rows.Add(row);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn.State != ConnectionState.Closed)
                    conn.Close();
            }

            return dataTable;
        }



        public static void SalesOrderExt(Guid documentID)
        {
            DataContext.Database.ExecuteSqlCommand(
                "EXEC [dbo].[spSalesOrderExt] @DocumentID = @documentID;",
            CreateSqlParameter("documentID", typeof(Guid), documentID));
        }

        public static void SalesOrderReturnExt(Guid documentID)
        {
            DataContext.Database.ExecuteSqlCommand(
                "EXEC [dbo].[spSalesOrderReturnExt] @DocumentID = @documentID;",
            CreateSqlParameter("documentID", typeof(Guid), documentID));
        }

        public static void SalesOrderFOCExt(Guid documentID)
        {
            DataContext.Database.ExecuteSqlCommand(
                "EXEC [dbo].[spSalesOrderFOCExt] @DocumentID = @documentID;",
            CreateSqlParameter("documentID", typeof(Guid), documentID));
        }

        public static void SalesOrderSampleExt(Guid documentID)
        {
            DataContext.Database.ExecuteSqlCommand(
                "EXEC [dbo].[spSalesOrderSampleExt] @DocumentID = @documentID;",
            CreateSqlParameter("documentID", typeof(Guid), documentID));
        }

        public static void SalesOrderSwapExt(Guid documentID)
        {
            DataContext.Database.ExecuteSqlCommand(
                "EXEC [dbo].[spSalesOrderSwapExt] @DocumentID = @documentID;",
            CreateSqlParameter("documentID", typeof(Guid), documentID));
        }

        public static List<ColumnInfo> GetTableColumns(string tableSchema, string tableName)
        {
            return DataContext.Database.SqlQuery<ColumnInfo>(@"
                SELECT
                        [TABLE_SCHEMA],
                        [TABLE_NAME],
                        [COLUMN_NAME],
                        [ORDINAL_POSITION],
                        [COLUMN_DEFAULT],
                        [IS_NULLABLE],                            
                        [DATA_TYPE],
                        [CHARACTER_MAXIMUM_LENGTH],
                        [NUMERIC_PRECISION],
                        [NUMERIC_SCALE]                            
                    FROM
                        [INFORMATION_SCHEMA].[COLUMNS]
                    WHERE
                        [TABLE_SCHEMA] = @tableSchema AND
                        [TABLE_NAME] = @tableName
                    ORDER BY
                        [ORDINAL_POSITION];
            ",
            CreateSqlParameter("tableSchema", typeof(string), tableSchema),
            CreateSqlParameter("tableName", typeof(string), tableName)).ToList();
        }

        public static List<string> GetTablePrimaryKeyColumnNames(string tableSchema, string tableName)
        {
            return DataContext.Database.SqlQuery<string>(@"
                SELECT
                        [COLUMN_NAME]
                    FROM
                        [INFORMATION_SCHEMA].[KEY_COLUMN_USAGE]
                    WHERE
                        [TABLE_SCHEMA] = @tableSchema AND
                        [TABLE_NAME] = @tableName
                    ORDER BY
                        [ORDINAL_POSITION];
            ",
            CreateSqlParameter("tableSchema", typeof(string), tableSchema),
            CreateSqlParameter("tableName", typeof(string), tableName)).ToList();
        }


        public static ObjectParameter CreateParameter(string name, Type valueType, object value)
        {
            return (value != null) ? new ObjectParameter(name, value) : new ObjectParameter(name, valueType);
        }

        public static SqlParameter CreateSqlParameter(string name, Type valueType, object value)
        {
            return (value != null) ? new SqlParameter(name, value) : new SqlParameter(name, valueType);
        }

        #endregion

    }

}
