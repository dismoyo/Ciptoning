﻿// ===================================================================================
// Author        : System
// Created date  : 13 Sep 2016 03:20:39
// Description   : IvDailySalesmanInventoryReport partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvDailySalesmanInventoryReport.cs'
//       up to one level of this file location inside 'vDailySalesmanInventoryReport' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvDailySalesmanInventoryReport
    {                
        
        #region Properties
        
        System.Guid WarehouseID { get; set; }
        int ProductID { get; set; }
        string Product { get; set; }
        int QtyOnHandGood { get; set; }
        int QtyOnHandHold { get; set; }
        int QtyOnHandBad { get; set; }

        #endregion

    }

}
