﻿// ===================================================================================
// Author        : System
// Created date  : 28 Mar 2016 16:48:48
// Description   : IRoutePlan partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IRoutePlan.cs'
//       up to one level of this file location inside 'RoutePlan' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IRoutePlan
    {

        #region Properties

        System.Guid SalesmanID { get; set; }
        System.Guid CustomerID { get; set; }
        int WeekID { get; set; }
        int DayID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        
        #endregion

    }

}
