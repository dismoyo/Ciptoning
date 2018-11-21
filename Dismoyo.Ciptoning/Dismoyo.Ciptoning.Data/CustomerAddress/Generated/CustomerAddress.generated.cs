﻿// ===================================================================================
// Author        : System
// Created date  : 15 Apr 2016 08:21:48
// Description   : CustomerAddress partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'CustomerAddress.cs'
//       up to one level of this file location inside 'CustomerAddress' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("CustomerAddress")]
    public partial class CustomerAddress : ICustomerAddress
    {                
        
        #region Implements ICustomerAddress

        [Key]
        public System.Guid CustomerID { get; set; }
            
        public string Address1 { get; set; }
            
        public string Address2 { get; set; }
            
        public string Address3 { get; set; }
            
        public string City { get; set; }
            
        public string StateProvince { get; set; }
            
        public string CountryID { get; set; }
            
        public string ZipCode { get; set; }
            
        public string Phone1 { get; set; }
            
        public string Phone2 { get; set; }
            
        public string Phone3 { get; set; }
            
        public string Fax { get; set; }
            
        public string Email { get; set; }
            
        public double? Longitude { get; set; }
            
        public double? Latitude { get; set; }
            
        #endregion

    }

}