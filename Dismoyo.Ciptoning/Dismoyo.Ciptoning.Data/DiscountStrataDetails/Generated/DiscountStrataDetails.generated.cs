﻿// ===================================================================================
// Author        : System
// Created date  : 14 Apr 2016 07:35:39
// Description   : DiscountStrataDetails partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'DiscountStrataDetails.cs'
//       up to one level of this file location inside 'DiscountStrataDetails' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("DiscountStrataDetails")]
    public partial class DiscountStrataDetails : IDiscountStrataDetails
    {                
        
        #region Implements IDiscountStrataDetails

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
            
        public int StrataID { get; set; }
            
        public double? Minimum { get; set; }
            
        public double? Maximum { get; set; }
            
        public double? DiscountPercentage { get; set; }
            
        #endregion

    }

}
