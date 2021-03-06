﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 23:05:13
// Description   : vSyncHistory partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vSyncHistory.cs'
//       up to one level of this file location inside 'vSyncHistory' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vSyncHistory")]
    public partial class vSyncHistory : IvSyncHistory
    {

        #region Implements IvSyncHistory

        public System.Guid SiteID { get; set; }

        [Key]
        public string SiteCode { get; set; }

        public string Site { get; set; }

        public System.DateTime LastSyncDataDate { get; set; }

        public System.DateTime LastSyncDate { get; set; }

        #endregion

    }

}
