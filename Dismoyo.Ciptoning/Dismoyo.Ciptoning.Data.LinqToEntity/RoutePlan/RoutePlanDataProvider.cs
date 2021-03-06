﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : RoutePlanDataProvider partial class.
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
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{

    public partial class RoutePlanDataProvider : DefaultTableDataProvider<RoutePlan>, IRoutePlanDataProvider
    {

        #region Methods

        public List<RoutePlan> GetDataBySalesmanIDAndCustomerID(Guid salesmanID, Guid customerID)
        {
            var routePlans = GetData().Where(p => p.SalesmanID.Equals(salesmanID) &&
                p.CustomerID.Equals(customerID)).ToList();

            return routePlans;
        }



        protected override void OnBeginInsertData(BeginOperationDataEventArgs<RoutePlan> e)
        {
            e.Data.CreatedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.CreatedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        #endregion

    }

}
