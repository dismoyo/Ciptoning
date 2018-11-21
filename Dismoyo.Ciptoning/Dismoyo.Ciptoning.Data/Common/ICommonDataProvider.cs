using System.Collections.Generic;
using Dismoyo.Data;

namespace Dismoyo.Ciptoning.Data
{

    #region Classes

    public class ColumnInfo
    {

        #region Properties

        public string TABLE_SCHEMA { get; set; }
        public string TABLE_NAME { get; set; }
        public string COLUMN_NAME { get; set; }
        public int? ORDINAL_POSITION { get; set; }
        public string COLUMN_DEFAULT { get; set; }
        public string IS_NULLABLE { get; set; }
        public string DATA_TYPE { get; set; }
        public int? CHARACTER_MAXIMUM_LENGTH { get; set; }
        public byte? NUMERIC_PRECISION { get; set; }
        public int? NUMERIC_SCALE { get; set; }

        #endregion

    }

    #endregion

    public interface ICommonDataProvider : IDataProvider<object>
    {

        #region Methods

        IList<ColumnInfo> GetTableColumns(string tableSchema, string tableName);
        IList<string> GetTablePrimaryKeyColumnNames(string tableSchema, string tableName);

        #endregion

    }

}
