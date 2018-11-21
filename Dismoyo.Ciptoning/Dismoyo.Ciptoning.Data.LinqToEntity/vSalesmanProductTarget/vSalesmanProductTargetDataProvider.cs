﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesmanProductTargetDataProvider partial class.
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

    public partial class vSalesmanProductTargetDataProvider : DefaultViewDataProvider<vSalesmanProductTarget>, IvSalesmanProductTargetDataProvider
    {

        #region Methods

        protected override void OnInsertData(vSalesmanProductTarget obj, bool useTransaction)
        {
            var salesmanProductTargetDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanProductTargetDataProvider>();

            var salesmanProductTarget = new SalesmanProductTarget();

            salesmanProductTarget.SalesmanID = obj.SalesmanID;
            salesmanProductTarget.PeriodID = obj.PeriodID;
            salesmanProductTarget.ProductID = obj.ProductID;
            salesmanProductTarget.SalesOrderQty = obj.SalesOrderQty;
            salesmanProductTarget.EffectiveCall = obj.EffectiveCall;
            salesmanProductTarget.CustomerTransaction = obj.CustomerTransaction;

            salesmanProductTargetDataProvider.InsertData(salesmanProductTarget, useTransaction);
        }

        protected override void OnUpdateData(vSalesmanProductTarget obj, bool useTransaction)
        {
            var salesmanProductTargetDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanProductTargetDataProvider>();

            var salesmanProductTarget = salesmanProductTargetDataProvider.GetData(obj.SalesmanID, obj.PeriodID, obj.ProductID);

            salesmanProductTarget.SalesOrderQty = obj.SalesOrderQty;
            salesmanProductTarget.EffectiveCall = obj.EffectiveCall;
            salesmanProductTarget.CustomerTransaction = obj.CustomerTransaction;

            salesmanProductTargetDataProvider.UpdateData(salesmanProductTarget, useTransaction);
        }

        protected override void OnDeleteData(vSalesmanProductTarget obj, bool useTransaction)
        {
            var salesmanProductTargetDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanProductTargetDataProvider>();

            var salesmanProductTarget = salesmanProductTargetDataProvider.GetData(obj.SalesmanID, obj.PeriodID, obj.ProductID);

            salesmanProductTargetDataProvider.DeleteData(salesmanProductTarget, useTransaction);
        }

        #endregion

    }

}
