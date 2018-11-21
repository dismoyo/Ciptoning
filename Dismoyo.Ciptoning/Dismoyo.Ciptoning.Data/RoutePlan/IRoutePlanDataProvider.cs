﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:27:21
// Description   : IRoutePlanDataProvider partial interface.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Data;
using System;
using System.Collections.Generic;

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IRoutePlanDataProvider : IDataProvider<RoutePlan>
    {

        #region Methods

        List<RoutePlan> GetDataBySalesmanIDAndCustomerID(Guid salesmanID, Guid customerID);

        #endregion

    }

}
