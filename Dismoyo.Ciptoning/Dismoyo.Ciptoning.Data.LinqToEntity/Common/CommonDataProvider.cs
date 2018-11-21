using System.Collections.Generic;

namespace Dismoyo.Ciptoning.Data
{

    public class CommonDataProvider : DefaultViewDataProvider<object>, ICommonDataProvider
    {
        
        #region Methods

        public IList<ColumnInfo> GetTableColumns(string tableSchema, string tableName)
        {
            return DefaultDataContext.GetTableColumns(tableSchema, tableName);
        }

        public IList<string> GetTablePrimaryKeyColumnNames(string tableSchema, string tableName)
        {
            return DefaultDataContext.GetTablePrimaryKeyColumnNames(tableSchema, tableName);
        }
        
        #endregion

    }

}
