﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 23:00:30
// Description   : IUserRolePermission partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IUserRolePermission.cs'
//       up to one level of this file location inside 'UserRolePermission' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IUserRolePermission
    {                
        
        #region Properties
        
        string PermissionObjectID { get; set; }
        int UserRoleID { get; set; }
        bool IsUser { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }

        #endregion

    }

}
