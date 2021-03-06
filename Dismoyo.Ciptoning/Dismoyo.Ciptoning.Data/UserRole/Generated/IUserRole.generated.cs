﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 23:00:22
// Description   : IUserRole partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IUserRole.cs'
//       up to one level of this file location inside 'UserRole' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IUserRole
    {                
        
        #region Properties
        
        int RoleID { get; set; }
        int UserID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }

        #endregion

    }

}
