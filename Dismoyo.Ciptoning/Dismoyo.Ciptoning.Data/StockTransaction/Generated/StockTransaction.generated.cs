﻿// ===================================================================================
// Author        : System
// Created date  : 29 Mar 2016 10:29:37
// Description   : StockTransaction partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'StockTransaction.cs'
//       up to one level of this file location inside 'StockTransaction' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("StockTransaction")]
    public partial class StockTransaction : IStockTransaction
    {                
        
        #region Implements IStockTransaction

        [Key, Column(Order = 0)]
        public System.Guid DocumentID { get; set; }
            
        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }
            
        [Key, Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductLotID { get; set; }

        public System.Guid? RefVoidedDocumentID { get; set; }

        public System.DateTime TransactionDate { get; set; }
            
        public int TransactionTypeID { get; set; }
            
        public string DocumentCode { get; set; }
            
        public System.Guid SourceID { get; set; }
            
        public System.Guid? DestinationID { get; set; }
            
        public int QtyGood { get; set; }
            
        public int QtyHold { get; set; }
            
        public int QtyBad { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        #endregion

    }

}
