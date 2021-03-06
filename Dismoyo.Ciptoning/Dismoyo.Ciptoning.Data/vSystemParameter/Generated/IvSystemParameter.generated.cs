﻿// ===================================================================================
// Author        : System
// Created date  : 02 Mei 2016 21:23:35
// Description   : IvSystemParameter partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvSystemParameter.cs'
//       up to one level of this file location inside 'vSystemParameter' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvSystemParameter
    {                
        
        #region Properties
        
        string ID { get; set; }
        string Description { get; set; }
        string Value { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        string ModifiedByUserName { get; set; }

        #endregion

    }

}
