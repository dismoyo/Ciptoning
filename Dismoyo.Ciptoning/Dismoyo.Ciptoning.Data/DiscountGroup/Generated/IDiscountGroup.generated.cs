﻿// ===================================================================================
// Author        : System
// Created date  : 13 Apr 2016 20:52:27
// Description   : IDiscountGroup partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IDiscountGroup.cs'
//       up to one level of this file location inside 'DiscountGroup' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IDiscountGroup
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        string Description { get; set; }
        int StatusID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}
