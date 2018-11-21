using Dismoyo.Data;
using Dismoyo.Web.Security;
using System;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{
    public partial class SyncHistoryDataProvider : DefaultTableDataProvider<SyncHistory>, ISyncHistoryDataProvider
    {

        #region Methods


        protected override void OnBeginInsertData(BeginOperationDataEventArgs<SyncHistory> e)
        {
            //e.Data.CreatedDate = DefaultDataContext.GetDatabaseServerUtcDateTime();
            //if (HttpContext.Current.User.Identity.IsAuthenticated)
            //    e.Data.CreatedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<SyncHistory> e)
        {
            //e.Data.ModifiedDate = DefaultDataContext.GetDatabaseServerUtcDateTime();
            //if (HttpContext.Current.User.Identity.IsAuthenticated)
            //    e.Data.ModifiedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginUpdateData(e);
        }

        #endregion
    }
}
