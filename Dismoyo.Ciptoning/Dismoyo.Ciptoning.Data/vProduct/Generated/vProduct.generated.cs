﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 10:23:20
// Description   : vProduct partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vProduct.cs'
//       up to one level of this file location inside 'vProduct' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vProduct")]
    public partial class vProduct : IvProduct
    {                
        
        #region Implements IvProduct
        
        [Key]        
        public int ID { get; set; }

        public string Code { get; set; }

        public string Name { get; set; }

        public string Product { get; set; }

        public int? BrandID { get; set; }

        public string BrandCode { get; set; }

        public string BrandName { get; set; }

        public string Brand { get; set; }

        public string ShortName { get; set; }

        public int? UOMLID { get; set; }

        public string UOMLName { get; set; }

        public int? UOMMID { get; set; }

        public string UOMMName { get; set; }

        public int? UOMSID { get; set; }

        public string UOMSName { get; set; }

        public double Weight { get; set; }

        public int? DimensionL { get; set; }

        public int? DimensionW { get; set; }

        public int? DimensionH { get; set; }

        public int? ConversionL { get; set; }

        public int? ConversionM { get; set; }

        public int? ConversionS { get; set; }

        public int StatusID { get; set; }

        public string AdditionalInfo1 { get; set; }

        public string AdditionalInfo2 { get; set; }

        public string AdditionalInfo3 { get; set; }

        public string AdditionalInfo4 { get; set; }

        public string AdditionalInfo5 { get; set; }

        public string AdditionalInfo6 { get; set; }

        public string AdditionalInfo7 { get; set; }

        public string AdditionalInfo8 { get; set; }

        public string AdditionalInfo9 { get; set; }

        public string AdditionalInfo10 { get; set; }

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
