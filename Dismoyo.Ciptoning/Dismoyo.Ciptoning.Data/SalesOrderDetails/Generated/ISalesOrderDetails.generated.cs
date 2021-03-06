﻿// ===================================================================================
// Author        : System
// Created date  : 30 Apr 2016 16:10:01
// Description   : ISalesOrderDetails partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesOrderDetails.cs'
//       up to one level of this file location inside 'SalesOrderDetails' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesOrderDetails
    {                
        
        #region Properties
        
        System.Guid DocumentID { get; set; }
        int ProductID { get; set; }
        int ProductLotID { get; set; }
        int QtyOnHand { get; set; }
        int QtyConvL { get; set; }
        int QtyConvM { get; set; }
        int QtyConvS { get; set; }
        int Qty { get; set; }

        #endregion

    }

}
