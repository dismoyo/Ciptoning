﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:53:01
// Description   : StockTransferSummary partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'StockTransferSummary.cs'
//       up to one level of this file location inside 'StockTransferSummary' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("StockTransferSummary")]
    public partial class StockTransferSummary : IStockTransferSummary
    {

        #region Implements IStockTransferSummary

        [Key, Column(Order = 0)]
        public System.Guid DocumentID { get; set; }

        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }

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

        #endregion

    }

}
