﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : SalesOrderFOCDataProvider partial class.
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

    public partial class SalesOrderFOCDataProvider : DefaultTableDataProvider<SalesOrderFOC>, ISalesOrderFOCDataProvider
    {

        #region Methods

        protected override void OnBeginInsertData(BeginOperationDataEventArgs<SalesOrderFOC> e)
        {
            e.Data.CreatedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.CreatedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<SalesOrderFOC> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.ModifiedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginUpdateData(e);
        }

        #endregion

    }

}
