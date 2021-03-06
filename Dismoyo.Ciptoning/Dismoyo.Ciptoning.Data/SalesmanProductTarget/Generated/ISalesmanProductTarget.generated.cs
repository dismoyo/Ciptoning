﻿// ===================================================================================
// Author        : System
// Created date  : 01 Nov 2016 10:47:09
// Description   : ISalesmanProductTarget partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesmanProductTarget.cs'
//       up to one level of this file location inside 'SalesmanProductTarget' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesmanProductTarget
    {                
        
        #region Properties
        
        System.Guid SalesmanID { get; set; }
        System.DateTime PeriodID { get; set; }
        int ProductID { get; set; }
        int SalesOrderQty { get; set; }
        double EffectiveCall { get; set; }
        double CustomerTransaction { get; set; }

        #endregion

    }

}
