﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 23:05:13
// Description   : vTerritory partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vTerritory.cs'
//       up to one level of this file location inside 'vTerritory' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vTerritory")]
    public partial class vTerritory : IvTerritory
    {                
        
        #region Implements IvTerritory
        
        [Key]
        public int ID { get; set; }

        public string Code { get; set; }

        public string Name { get; set; }

        public string Territory { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public string CreatedByUserName { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        public int? ModifiedByUserID { get; set; }

        public string ModifiedByUserName { get; set; }

        public bool IsDeleted { get; set; }

        #endregion

    }

}
