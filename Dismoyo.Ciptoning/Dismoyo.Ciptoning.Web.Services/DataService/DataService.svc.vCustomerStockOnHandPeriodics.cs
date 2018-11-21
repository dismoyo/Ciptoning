﻿// ===================================================================================
// Author        : System
// Created date  : 22 Oct 2016 19:33:19
// Description   : DataService partial class.
//
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Ciptoning.Data;
using System;
using System.Data.Services;
using System.Data.Services.Providers;
using System.Linq.Expressions;

namespace Dismoyo.Ciptoning.Web.Services
{

    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Methods

        [QueryInterceptor("vCustomerStockOnHandPeriodics")]
        public Expression<Func<vCustomerStockOnHandPeriodic, bool>> OnQueryvCustomerStockOnHandPeriodics()
        {
            return (p => true);
        }

        [ChangeInterceptor("vCustomerStockOnHandPeriodics")]
        public void OnChangevCustomerStockOnHandPeriodics(vCustomerStockOnHandPeriodic data, UpdateOperations operations)
        {
            if (ValidateSegment("vCustomerStockOnHandPeriodics"))
            {
                var dataProvider = DataConfiguration.GetDefaultDataProvider<IvCustomerStockOnHandPeriodicDataProvider>();

                switch (operations)
                {
                    case UpdateOperations.Add:
                        dataProvider.InsertData(data);
                        operations = UpdateOperations.None;
                        break;
                    case UpdateOperations.Change:
                        dataProvider.UpdateData(data);
                        operations = UpdateOperations.None;
                        break;
                    case UpdateOperations.Delete:
                        dataProvider.DeleteData(data);
                        operations = UpdateOperations.None;
                        break;
                }

                if (operations == UpdateOperations.None)
                    CancelChanges();
            }
        }

        #endregion

    }

}