﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 02:02:37
// Description   : ISalesmanInitialCall partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesmanInitialCall.cs'
//       up to one level of this file location inside 'SalesmanInitialCall' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesmanInitialCall
    {                
        
        #region Properties
        
        System.Guid SalesmanID { get; set; }
        System.DateTime CallDate { get; set; }
        double StartOdometer { get; set; }
        double EndOdometer { get; set; }
        int EndOfDayPrintCount { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }

        #endregion

    }

}