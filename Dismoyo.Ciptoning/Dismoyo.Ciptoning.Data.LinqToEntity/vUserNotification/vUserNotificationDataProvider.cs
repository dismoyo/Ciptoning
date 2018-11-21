﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vUserNotificationDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using System;
using System.Collections.Generic;
using System.Linq;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vUserNotificationDataProvider : DefaultViewDataProvider<vUserNotification>, IvUserNotificationDataProvider
    {

        #region Methods

        protected override void OnInsertData(vUserNotification obj)
        {
            var userNotificationDataProvider = DataConfiguration.GetDefaultDataProvider<IUserNotificationDataProvider>();

            var userNotification = new UserNotification();

            userNotification.ID = (obj.ID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.ID);
            userNotification.RaisedDate = obj.RaisedDate;
            userNotification.UserID = obj.UserID;
            userNotification.CategoryID = obj.CategoryID;
            userNotification.HtmlMessage = obj.HtmlMessage;
            userNotification.IsRead = false;

            userNotificationDataProvider.InsertData(userNotification);
        }

        protected override void OnUpdateData(vUserNotification obj)
        {
            var userNotificationDataProvider = DataConfiguration.GetDefaultDataProvider<IUserNotificationDataProvider>();
            
            var userNotification = userNotificationDataProvider.GetData(obj.ID);
            
            userNotification.IsRead = obj.IsRead;

            userNotificationDataProvider.UpdateData(userNotification);
        }

        #endregion

    }

}