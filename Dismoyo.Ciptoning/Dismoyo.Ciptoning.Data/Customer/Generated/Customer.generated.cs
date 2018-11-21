﻿// ===================================================================================
// Author        : System
// Created date  : 15 Apr 2016 08:22:37
// Description   : Customer partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'Customer.cs'
//       up to one level of this file location inside 'Customer' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("Customer")]
    public partial class Customer : ICustomer
    {                
        
        #region Implements ICustomer

        [Key]
        public System.Guid ID { get; set; }
            
        public string Code { get; set; }
            
        public string Name { get; set; }
            
        public System.Guid SalesmanID { get; set; }
            
        public System.DateTime RegisteredDate { get; set; }
            
        public int TermOfPaymentID { get; set; }
            
        public double? CreditLimit { get; set; }

        public int PriceGroupID { get; set; }

        public int DiscountGroupID { get; set; }
            
        public bool IsTaxNumberAvailable { get; set; }

        public string TaxSAPCode { get; set; }

        public string TaxNumber { get; set; }

        public string Photo { get; set; }

        public int StatusID { get; set; }

        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        public bool IsDeleted { get; set; }
            
        #endregion

    }

}