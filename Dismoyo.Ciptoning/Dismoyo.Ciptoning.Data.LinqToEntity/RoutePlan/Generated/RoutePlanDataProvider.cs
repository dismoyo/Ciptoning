﻿// ===================================================================================
// Author        : System
// Created date  : 28 Mar 2016 16:48:48
// Description   : RoutePlanDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using ISID.Data;
using ISID.Web.Security;
using System;
using System.Linq;
using System.Web;

namespace AIO.IDOS2.Data
{

    public partial class RoutePlanDataProvider : DefaultTableDataProvider<RoutePlan>, IRoutePlanDataProvider
    {
        
        #region Methods

        public RoutePlan GetDataByCode(string code)
        {
            return null;
        }


        protected override void OnBeginInsertData(BeginOperationDataEventArgs<RoutePlan> e)
        {
            e.Data.ID = Guid.NewGuid();
            e.Data.CreatedDate = DefaultDataContext.GetDatabaseServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.CreatedByUserID = ((BasicGenericIdentity<vUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<RoutePlan> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDatabaseServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.ModifiedByUserID = ((BasicGenericIdentity<vUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginUpdateData(e);
        }

        #endregion

    }

}
