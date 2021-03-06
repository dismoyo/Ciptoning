﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 23:00:22
// Description   : IAuthorizationAccessToken partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IAuthorizationAccessToken.cs'
//       up to one level of this file location inside 'AuthorizationAccessToken' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IAuthorizationAccessToken
    {                
        
        #region Properties
        
        System.Guid ID { get; set; }
        int UserID { get; set; }
        string DeviceID { get; set; }
        System.DateTime ExpiredDate { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }

        #endregion

    }

}
