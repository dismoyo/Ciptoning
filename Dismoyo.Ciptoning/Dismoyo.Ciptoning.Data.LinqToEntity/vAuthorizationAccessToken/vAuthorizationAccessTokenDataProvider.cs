﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vAuthorizationAccessTokenDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vAuthorizationAccessTokenDataProvider : DefaultViewDataProvider<vAuthorizationAccessToken>, IvAuthorizationAccessTokenDataProvider
    {

        #region Methods

        protected override void OnInsertData(vAuthorizationAccessToken obj)
        {
            var authorizationAccessTokenDataProvider = DataConfiguration.GetDefaultDataProvider<IAuthorizationAccessTokenDataProvider>();

            var authorizationAccessToken = new AuthorizationAccessToken();

            authorizationAccessToken.ID = obj.ID;
            authorizationAccessToken.UserID = obj.UserID;
            authorizationAccessToken.DeviceID = obj.DeviceID;
            authorizationAccessToken.ExpiredDate = obj.ExpiredDate;
            
            authorizationAccessTokenDataProvider.InsertData(authorizationAccessToken);
        }

        protected override void OnUpdateData(vAuthorizationAccessToken obj)
        {
            var authorizationAccessTokenDataProvider = DataConfiguration.GetDefaultDataProvider<IAuthorizationAccessTokenDataProvider>();

            var authorizationAccessToken = authorizationAccessTokenDataProvider.GetData(obj.ID);

            authorizationAccessToken.ExpiredDate = obj.ExpiredDate;

            authorizationAccessTokenDataProvider.UpdateData(authorizationAccessToken);
        }
                
        #endregion

    }

}
