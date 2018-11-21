﻿// ===================================================================================
// Author        : System
// Created date  : 14 Apr 2016 16:09:36
// Description   : DiscountGroupProduct partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'DiscountGroupProduct.cs'
//       up to one level of this file location inside 'DiscountGroupProduct' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("DiscountGroupProduct")]
    public partial class DiscountGroupProduct : IDiscountGroupProduct
    {                
        
        #region Implements IDiscountGroupProduct

        [Key, Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int DiscountGroupID { get; set; }
            
        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }
            
        public int? DiscountStrata1ID { get; set; }
            
        public int? DiscountStrata2ID { get; set; }
            
        public int? DiscountStrata3ID { get; set; }
            
        public int? DiscountStrata4ID { get; set; }
            
        public int? DiscountStrata5ID { get; set; }
            
        #endregion

    }

}
