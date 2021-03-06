﻿// ===================================================================================
// Author        : System
// Created date  : 14 Apr 2016 07:36:03
// Description   : IvDiscountStrataDetails partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvDiscountStrataDetails.cs'
//       up to one level of this file location inside 'vDiscountStrataDetails' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvDiscountStrataDetails
    {                
        
        #region Properties
        
        int ID { get; set; }
        int StrataID { get; set; }
        double? Minimum { get; set; }
        double? Maximum { get; set; }
        double? DiscountPercentage { get; set; }

        #endregion

    }

}
