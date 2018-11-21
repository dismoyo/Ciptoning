﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:53:01
// Description   : IStockChangesSummary partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IStockChangesSummary.cs'
//       up to one level of this file location inside 'StockChangesSummary' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IStockChangesSummary
    {

        #region Properties

        System.Guid DocumentID { get; set; }
        int ProductID { get; set; }
        int QtyOnHand { get; set; }
        int QtyConvL { get; set; }
        int QtyConvM { get; set; }
        int QtyConvS { get; set; }        
        int Qty { get; set; }
        
        #endregion

    }

}
