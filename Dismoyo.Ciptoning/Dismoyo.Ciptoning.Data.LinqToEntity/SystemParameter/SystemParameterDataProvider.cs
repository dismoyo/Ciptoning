﻿// ===================================================================================
// Author        : System
// Created date  : 02 Mei 2016 21:22:34
// Description   : SystemParameterDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Data;
using Dismoyo.Web.Security;
using System;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{

    public partial class SystemParameterDataProvider : DefaultTableDataProvider<SystemParameter>, ISystemParameterDataProvider
    {
        
        #region Methods

        protected override void OnBeginInsertData(BeginOperationDataEventArgs<SystemParameter> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.ModifiedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<SystemParameter> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.ModifiedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginUpdateData(e);
        }

        #endregion

    }

}
