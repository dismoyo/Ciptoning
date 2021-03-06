﻿// ===================================================================================
// Author        : System
// Created date  : 25 Mar 2016 19:30:50
// Description   : IClosingPeriod partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IClosingPeriod.cs'
//       up to one level of this file location inside 'ClosingPeriod' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IClosingPeriod
    {                
        
        #region Properties
        
        System.Guid SiteID { get; set; }
        int YearID { get; set; }
        bool Jan { get; set; }
        bool Feb { get; set; }
        bool Mar { get; set; }
        bool Apr { get; set; }
        bool May { get; set; }
        bool Jun { get; set; }
        bool Jul { get; set; }
        bool Aug { get; set; }
        bool Sep { get; set; }
        bool Oct { get; set; }
        bool Nov { get; set; }
        bool Dec { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }

        #endregion

    }

}
