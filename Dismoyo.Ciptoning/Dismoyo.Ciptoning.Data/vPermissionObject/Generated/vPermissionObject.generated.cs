﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 23:02:19
// Description   : vPermissionObject partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vPermissionObject.cs'
//       up to one level of this file location inside 'vPermissionObject' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vPermissionObject")]
    public partial class vPermissionObject : IvPermissionObject
    {                
        
        #region Implements IvPermissionObject
        
        public string ID { get; set; }

        public string Description { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public string CreatedByUserName { get; set; }

        #endregion

    }

}
