﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:52:56
// Description   : StockChangesDetails partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'StockChangesDetails.cs'
//       up to one level of this file location inside 'StockChangesDetails' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("StockChangesDetails")]
    public partial class StockChangesDetails : IStockChangesDetails
    {

        #region Implements IStockChangesDetails

        [Key, Column(Order = 0)]
        public System.Guid DocumentID { get; set; }

        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }

        [Key, Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductLotID { get; set; }

        public int QtyOnHand { get; set; }

        public int QtyConvL { get; set; }

        public int QtyConvM { get; set; }

        public int QtyConvS { get; set; }

        public int Qty { get; set; }
                
        #endregion

    }

}
