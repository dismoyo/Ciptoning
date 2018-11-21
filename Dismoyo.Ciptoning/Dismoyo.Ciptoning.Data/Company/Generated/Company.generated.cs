﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 00:38:55
// Description   : Company partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'Company.cs'
//       up to one level of this file location inside 'Company' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("Company")]
    public partial class Company : ICompany
    {                
        
        #region Implements ICompany

        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
            
        public string Code { get; set; }
            
        public string Name { get; set; }
            
        public string TaxNumber { get; set; }
            
        public int StatusID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }
            
        public bool IsDeleted { get; set; }
            
        #endregion

    }

}
