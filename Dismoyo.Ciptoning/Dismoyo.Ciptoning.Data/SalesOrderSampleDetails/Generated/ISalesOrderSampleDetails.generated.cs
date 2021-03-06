﻿// ===================================================================================
// Author        : System
// Created date  : 05 May 2016 12:09:20
// Description   : ISalesOrderSampleDetails partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesOrderSampleDetails.cs'
//       up to one level of this file location inside 'SalesOrderSampleDetails' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesOrderSampleDetails
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
