﻿// ===================================================================================
// Author        : System
// Created date  : 10 Apr 2016 02:31:26
// Description   : ProductPrice partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'ProductPrice.cs'
//       up to one level of this file location inside 'ProductPrice' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("ProductPrice")]
    public partial class ProductPrice : IProductPrice
    {                
        
        #region Implements IProductPrice

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
            
        public string Code { get; set; }
            
        public int ProductID { get; set; }
            
        public System.DateTime? ValidDateFrom { get; set; }
            
        public System.DateTime? ValidDateTo { get; set; }
            
        public int PriceGroupID { get; set; }
            
        public double GrossPrice { get; set; }
            
        public double TaxPercentage { get; set; }
            
        public double Price { get; set; }
            
        public int StatusID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        public bool IsDeleted { get; set; }
            
        #endregion

    }

}
