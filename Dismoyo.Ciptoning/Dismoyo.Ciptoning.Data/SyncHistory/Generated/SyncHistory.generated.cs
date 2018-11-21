using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dismoyo.Ciptoning.Data
{
    [Table("[dbo].[SyncHistory]")]
    public partial class SyncHistory : ISyncHistory
    {

        #region Implements ISyncHistory
        [Key, Column(Order = 0)]
        public string SiteCode { get; set; }

        public System.DateTime LastSyncDataDate { get; set; }

        public System.DateTime LastSyncDate { get; set; }

        #endregion
    }
}
