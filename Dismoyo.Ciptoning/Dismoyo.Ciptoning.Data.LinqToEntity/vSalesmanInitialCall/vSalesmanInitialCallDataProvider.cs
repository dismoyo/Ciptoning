﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesmanInitialCallDataProvider partial class.
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

    public partial class vSalesmanInitialCallDataProvider : DefaultViewDataProvider<vSalesmanInitialCall>, IvSalesmanInitialCallDataProvider
    {

        #region Methods

        protected override void OnInsertData(vSalesmanInitialCall obj)
        {
            var salesmanInitialCallDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanInitialCallDataProvider>();

            var salesmanInitialCall = new SalesmanInitialCall();

            salesmanInitialCall.SalesmanID = obj.SalesmanID;
            salesmanInitialCall.CallDate = obj.CallDate;
            salesmanInitialCall.StartOdometer = obj.StartOdometer;
            salesmanInitialCall.EndOdometer = obj.EndOdometer;
            salesmanInitialCall.EndOfDayPrintCount = obj.EndOfDayPrintCount;

            salesmanInitialCallDataProvider.InsertData(salesmanInitialCall);
        }

        protected override void OnUpdateData(vSalesmanInitialCall obj)
        {
            var salesmanInitialCallDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanInitialCallDataProvider>();

            var salesmanInitialCall = salesmanInitialCallDataProvider.GetData(obj.SalesmanID, obj.CallDate);

            salesmanInitialCall.StartOdometer = obj.StartOdometer;
            salesmanInitialCall.EndOdometer = obj.EndOdometer;
            salesmanInitialCall.EndOfDayPrintCount = obj.EndOfDayPrintCount;

            salesmanInitialCallDataProvider.UpdateData(salesmanInitialCall);
        }
                
        #endregion

    }

}