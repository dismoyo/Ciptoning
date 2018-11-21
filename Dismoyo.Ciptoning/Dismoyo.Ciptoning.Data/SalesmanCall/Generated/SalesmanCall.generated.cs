﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 20:28:10
// Description   : SalesmanCall partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'SalesmanCall.cs'
//       up to one level of this file location inside 'SalesmanCall' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("SalesmanCall")]
    public partial class SalesmanCall : ISalesmanCall
    {                
        
        #region Implements ISalesmanCall

        [Key]
        public System.Guid ID { get; set; }
            
        public System.Guid SalesmanID { get; set; }
            
        public System.DateTime CallDate { get; set; }
            
        public System.Guid CustomerID { get; set; }
            
        public bool IsInRoute { get; set; }
            
        public string MerchandiseDisplayActivityNote { get; set; }
            
        public string PromoMaterialActivityNote { get; set; }
            
        public int StatusID { get; set; }
            
        public bool IsTransactionPaid { get; set; }
            
        public int NoTransactionReasonID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        #endregion

    }

}