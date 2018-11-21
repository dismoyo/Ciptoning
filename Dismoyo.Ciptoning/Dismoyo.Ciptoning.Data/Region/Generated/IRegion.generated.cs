﻿// ===================================================================================
// Author        : System
// Created date  : 17 Mar 2016 11:54:24
// Description   : IRegion partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IRegion.cs'
//       up to one level of this file location inside 'Region' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IRegion
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        int? TerritoryID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}