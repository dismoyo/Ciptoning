﻿// ===================================================================================
// Author        : System
// Created date  : 12 Apr 2016 20:59:16
// Description   : ISalesman partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ISalesman.cs'
//       up to one level of this file location inside 'Salesman' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ISalesman
    {                
        
        #region Properties
        
        System.Guid ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        System.Guid WarehouseID { get; set; }
        int GroupID { get; set; }
        int CategoryID { get; set; }
        string Phone { get; set; }
        bool? SFAFlag { get; set; }
        string SFA { get; set; }
        int StatusID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}
