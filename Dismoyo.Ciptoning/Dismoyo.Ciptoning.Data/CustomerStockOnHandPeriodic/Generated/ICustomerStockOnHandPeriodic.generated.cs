﻿// ===================================================================================
// Author        : System
// Created date  : 22 Oct 2016 19:33:07
// Description   : ICustomerStockOnHandPeriodic partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ICustomerStockOnHandPeriodic.cs'
//       up to one level of this file location inside 'CustomerStockOnHandPeriodic' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ICustomerStockOnHandPeriodic
    {                
        
        #region Properties
        
        System.Guid ID { get; set; }
        System.DateTime PeriodDate { get; set; }
        System.Guid SalesmanCallID { get; set; }
        int ProductID { get; set; }
        int Qty { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }

        #endregion

    }

}