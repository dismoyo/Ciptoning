using System;
using System.Collections.Generic;
using System.Linq;

namespace Dismoyo.Data
{

    public interface IDataProvider<TClass>
        where TClass : class, new()
    {

        #region Properties

        bool UseUniqueDataSource { get; set; }
        bool SuppressError { get; set; }
        
        #endregion

        #region Methods

        IQueryable<TClass> GetData();
        TClass GetData(params object[] primaryKeys);
        void InsertData(TClass obj);
        void InsertData(TClass obj, bool useTransaction);
        void UpdateData(TClass obj);
        void UpdateData(TClass obj, bool useTransaction);
        void DeleteData(TClass obj);
        void DeleteData(TClass obj, bool useTransaction);

        event EventHandler<BeginOperationDataEventArgs<TClass>> BeginInsertData;
        event EventHandler<BeginOperationDataEventArgs<TClass>> BeginUpdateData;
        event EventHandler<BeginOperationDataEventArgs<TClass>> BeginDeleteData;
        event EventHandler<EndOperationDataEventArgs<TClass>> EndInsertData;
        event EventHandler<EndOperationDataEventArgs<TClass>> EndUpdateData;
        event EventHandler<EndOperationDataEventArgs<TClass>> EndDeleteData;
        
        #endregion

    }

}
