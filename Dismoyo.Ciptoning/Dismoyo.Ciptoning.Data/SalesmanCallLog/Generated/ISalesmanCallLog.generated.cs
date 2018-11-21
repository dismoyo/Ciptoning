﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 20:28:03
// Description   : ISalesmanCallLog partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesmanCallLog.cs'
//       up to one level of this file location inside 'SalesmanCallLog' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesmanCallLog
    {                
        
        #region Properties
        
        System.Guid ID { get; set; }
        System.Guid SalesmanCallID { get; set; }
        System.DateTime CheckedDate { get; set; }
        decimal? CheckedLongitude { get; set; }
        decimal? CheckedLatitude { get; set; }
        bool? IsCheckedIn { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }

        #endregion

    }

}
