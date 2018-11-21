﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 23:05:13
// Description   : IvTerritory partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvTerritory.cs'
//       up to one level of this file location inside 'vTerritory' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvTerritory
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        string Territory { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        string CreatedByUserName { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        string ModifiedByUserName { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}
