﻿// ===================================================================================
// Author        : System
// Created date  : 29 Mar 2016 10:29:37
// Description   : IStockTransaction partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IStockTransaction.cs'
//       up to one level of this file location inside 'StockTransaction' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IStockTransaction
    {                
        
        #region Properties
        
        System.Guid DocumentID { get; set; }
        int ProductID { get; set; }
        int ProductLotID { get; set; }
        System.Guid? RefVoidedDocumentID { get; set; }
        System.DateTime TransactionDate { get; set; }
        int TransactionTypeID { get; set; }
        string DocumentCode { get; set; }
        System.Guid SourceID { get; set; }
        System.Guid? DestinationID { get; set; }
        int QtyGood { get; set; }
        int QtyHold { get; set; }
        int QtyBad { get; set; }
        System.DateTime CreatedDate { get; set; }

        #endregion

    }

}