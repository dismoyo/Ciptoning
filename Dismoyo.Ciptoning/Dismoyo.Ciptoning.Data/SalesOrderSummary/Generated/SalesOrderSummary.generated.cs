﻿// ===================================================================================
// Author        : System
// Created date  : 15 May 2016 19:53:05
// Description   : SalesOrderSummary partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'SalesOrderSummary.cs'
//       up to one level of this file location inside 'SalesOrderSummary' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("SalesOrderSummary")]
    public partial class SalesOrderSummary : ISalesOrderSummary
    {                
        
        #region Implements ISalesOrderSummary

        [Key, Column(Order = 0)]
        public System.Guid DocumentID { get; set; }
            
        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }
            
        public System.DateTime? PriceDate { get; set; }
            
        public int QtyOnHand { get; set; }
            
        public int QtyConvL { get; set; }
            
        public int QtyConvM { get; set; }
            
        public int QtyConvS { get; set; }
            
        public int Qty { get; set; }
            
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
            
        public double RawSubtotalDiscountStrata2 { get; set; }
            
        public double RawSubtotalDiscountStrata3 { get; set; }
            
        public double RawSubtotalDiscountStrata4 { get; set; }
            
        public double RawSubtotalDiscountStrata5 { get; set; }
            
        public double RawSubtotalGross { get; set; }
            
        public double RawSubtotalTax { get; set; }
            
        public double RawSubtotal { get; set; }
            
        public double SubtotalGrossPrice { get; set; }
            
        public double SubtotalPrice { get; set; }
            
        public double SubtotalDiscountStrata1 { get; set; }
            
        public double SubtotalDiscountStrata2 { get; set; }
            
        public double SubtotalDiscountStrata3 { get; set; }
            
        public double SubtotalDiscountStrata4 { get; set; }
            
        public double SubtotalDiscountStrata5 { get; set; }
            
        public double SubtotalGross { get; set; }
            
        public double SubtotalTax { get; set; }
            
        public double Subtotal { get; set; }
            
        public double SubtotalWeight { get; set; }
            
        public int SubtotalDimension { get; set; }
            
        #endregion

    }

}
