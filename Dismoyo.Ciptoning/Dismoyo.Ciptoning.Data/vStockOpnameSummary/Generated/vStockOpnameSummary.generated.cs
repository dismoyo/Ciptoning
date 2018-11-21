﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:53:58
// Description   : vStockOpnameSummary partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vStockOpnameSummary.cs'
//       up to one level of this file location inside 'vStockOpnameSummary' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vStockOpnameSummary")]
    public partial class vStockOpnameSummary : IvStockOpnameSummary
    {

        #region Implements IvStockOpnameSummary

        [Key]
        [Column(Order = 0)]
        public System.Guid DocumentID { get; set; }

        [Key]
        [Column(Order = 1)]
        public int ProductID { get; set; }

        public string ProductCode { get; set; }

        public string ProductName { get; set; }

        public string Product { get; set; }

        public int? ProductBrandID { get; set; }

        public string ProductBrandCode { get; set; }

        public string ProductBrandName { get; set; }

        public string ProductBrand { get; set; }

        public string ProductShortName { get; set; }

        public int? ProductUOMLID { get; set; }

        public string ProductUOMLName { get; set; }

        public int? ProductUOMMID { get; set; }

        public string ProductUOMMName { get; set; }

        public int? ProductUOMSID { get; set; }

        public string ProductUOMSName { get; set; }

        public double? ProductWeight { get; set; }

        public int? ProductDimensionL { get; set; }

        public int? ProductDimensionW { get; set; }

        public int? ProductDimensionH { get; set; }

        public int? ProductConversionL { get; set; }

        public int? ProductConversionM { get; set; }

        public int? ProductConversionS { get; set; }

        public int? ProductStatusID { get; set; }

        public string ProductStatusName { get; set; }

        public string ProductAdditionalInfo1 { get; set; }

        public string ProductAdditionalInfo2 { get; set; }

        public string ProductAdditionalInfo3 { get; set; }

        public string ProductAdditionalInfo4 { get; set; }

        public string ProductAdditionalInfo5 { get; set; }

        public string ProductAdditionalInfo6 { get; set; }

        public string ProductAdditionalInfo7 { get; set; }

        public string ProductAdditionalInfo8 { get; set; }

        public string ProductAdditionalInfo9 { get; set; }

        public string ProductAdditionalInfo10 { get; set; }

        public int QtyOnHandGood { get; set; }

        public int QtyOnHandHold { get; set; }

        public int QtyOnHandBad { get; set; }

        public int QtyConvLGood { get; set; }

        public int QtyConvMGood { get; set; }

        public int QtyConvSGood { get; set; }

        public int QtyConvLHold { get; set; }

        public int QtyConvMHold { get; set; }

        public int QtyConvSHold { get; set; }

        public int QtyConvLBad { get; set; }

        public int QtyConvMBad { get; set; }

        public int QtyConvSBad { get; set; }

        public int QtyGood { get; set; }

        public int QtyHold { get; set; }

        public int QtyBad { get; set; }

        public string QtyOpnameConvGood { get; set; }

        public string QtyOpnameConvHold { get; set; }

        public string QtyOpnameConvBad { get; set; }

        public int QtyOpnameGood { get; set; }

        public int QtyOpnameHold { get; set; }

        public int QtyOpnameBad { get; set; }

        #endregion

    }

}
