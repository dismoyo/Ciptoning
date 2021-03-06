﻿// ===================================================================================
// Author        : System
// Created date  : 14 Apr 2016 07:35:30
// Description   : DiscountStrata partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'DiscountStrata.cs'
//       up to one level of this file location inside 'DiscountStrata' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("DiscountStrata")]
    public partial class DiscountStrata : IDiscountStrata
    {                
        
        #region Implements IDiscountStrata

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
            
        public string Code { get; set; }
            
        public string Name { get; set; }
            
        public System.DateTime? ValidDateFrom { get; set; }
            
        public System.DateTime? ValidDateTo { get; set; }
            
        public int StatusID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        public bool IsDeleted { get; set; }
            
        #endregion

    }

}
