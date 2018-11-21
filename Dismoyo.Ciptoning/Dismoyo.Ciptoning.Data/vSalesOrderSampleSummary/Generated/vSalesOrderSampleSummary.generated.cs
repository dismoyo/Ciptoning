﻿// ===================================================================================
// Author        : System
// Created date  : 15 May 2016 19:57:42
// Description   : vSalesOrderSampleSummary partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vSalesOrderSampleSummary.cs'
//       up to one level of this file location inside 'vSalesOrderSampleSummary' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vSalesOrderSampleSummary")]
    public partial class vSalesOrderSampleSummary : IvSalesOrderSampleSummary
    {

        #region Implements IvSalesOrderSampleSummary

        [Key, Column(Order = 0)]
        public System.Guid DocumentID { get; set; }

        [Key, Column(Order = 1)]
        public int ProductID { get; set; }

        public System.DateTime? PriceDate { get; set; }

        public string ProductCode { get; set; }

        public string ProductName { get; set; }

        public string Product { get; set; }

        public int? ProductBrandID { get; set; }

        public string ProductBrandCode { get; set; }

        public string ProductBrandName { get; set; }

        public string ProductBrand { get; set; }

        public string ProductShortName { get; set; }

        public int? ProductUOMLID { get; set; }

        public int? ProductUOMMID { get; set; }

        public int? ProductUOMSID { get; set; }

        public string ProductUOMLName { get; set; }

        public string ProductUOMMName { get; set; }

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

        public int QtyOnHand { get; set; }

        public int QtyConvL { get; set; }

        public int QtyConvM { get; set; }

        public int QtyConvS { get; set; }

        public int Qty { get; set; }

        public string QtyOrderConv { get; set; }

        public int? QtyOrder { get; set; }

        public double UnitGrossPrice { get; set; }

        public double UnitPrice { get; set; }

        public double? DiscountStrata1Percentage { get; set; }

        public double? DiscountStrata2Percentage { get; set; }

        public double? DiscountStrata3Percentage { get; set; }

        public double? DiscountStrata4Percentage { get; set; }

        public double? DiscountStrata5Percentage { get; set; }

        public double? AddDiscountStrataPercentage { get; set; }

        public double TaxPercentage { get; set; }

        public double RawSubtotalGrossPrice { get; set; }

        public double RawSubtotalPrice { get; set; }

        public double RawSubtotalDiscountStrata1 { get; set; }

        public double RawDiscountStrata1Amount { get; set; }

        public double RawSubtotalDiscountStrata2 { get; set; }

        public double RawDiscountStrata2Amount { get; set; }

        public double RawSubtotalDiscountStrata3 { get; set; }

        public double RawDiscountStrata3Amount { get; set; }

        public double RawSubtotalDiscountStrata4 { get; set; }

        public double RawDiscountStrata4Amount { get; set; }

        public double RawSubtotalDiscountStrata5 { get; set; }

        public double RawDiscountStrata5Amount { get; set; }

        public double RawAddDiscountStrataAmount { get; set; }

        public double RawSubtotalGross { get; set; }

        public double RawSubtotalTax { get; set; }

        public double RawSubtotal { get; set; }

        public double SubtotalGrossPrice { get; set; }

        public double SubtotalPrice { get; set; }

        public double SubtotalDiscountStrata1 { get; set; }

        public double DiscountStrata1Amount { get; set; }

        public double SubtotalDiscountStrata2 { get; set; }

        public double DiscountStrata2Amount { get; set; }

        public double SubtotalDiscountStrata3 { get; set; }

        public double DiscountStrata3Amount { get; set; }

        public double SubtotalDiscountStrata4 { get; set; }

        public double DiscountStrata4Amount { get; set; }

        public double SubtotalDiscountStrata5 { get; set; }

        public double DiscountStrata5Amount { get; set; }

        public double AddDiscountStrataAmount { get; set; }

        public double SubtotalGross { get; set; }

        public double SubtotalTax { get; set; }

        public double Subtotal { get; set; }

        public double SubtotalWeight { get; set; }

        public int SubtotalDimension { get; set; }

        #endregion

    }

}
