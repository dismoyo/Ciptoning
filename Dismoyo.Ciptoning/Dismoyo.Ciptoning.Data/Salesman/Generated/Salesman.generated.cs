﻿// ===================================================================================
// Author        : System
// Created date  : 12 Apr 2016 20:59:16
// Description   : Salesman partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'Salesman.cs'
//       up to one level of this file location inside 'Salesman' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("Salesman")]
    public partial class Salesman : ISalesman
    {                
        
        #region Implements ISalesman

        [Key]
        public System.Guid ID { get; set; }
            
        public string Code { get; set; }
            
        public string Name { get; set; }
            
        public System.Guid WarehouseID { get; set; }
            
        public int GroupID { get; set; }
            
        public int CategoryID { get; set; }
            
        public string Phone { get; set; }

        public bool? SFAFlag { get; set; }

        public string SFA { get; set; }
            
        public int StatusID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        public bool IsDeleted { get; set; }
            
        #endregion

    }

}
