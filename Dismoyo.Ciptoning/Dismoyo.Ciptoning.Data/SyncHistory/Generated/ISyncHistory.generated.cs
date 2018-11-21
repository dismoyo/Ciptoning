using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dismoyo.Ciptoning.Data
{
    public partial interface ISyncHistory
    {

        #region Properties
        
        string SiteCode { get; set; }
        System.DateTime LastSyncDataDate { get; set; }
        System.DateTime LastSyncDate { get; set; }

        #endregion
    }
}
