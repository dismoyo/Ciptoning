﻿// ===================================================================================
// Author        : System
// Created date  : 01 Nov 2016 10:41:07
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

        [QueryInterceptor("vSalesmanProductTargets")]
        public Expression<Func<vSalesmanProductTarget, bool>> OnQueryvSalesmanProductTargets()
        {
            return (p => true);
        }

        [ChangeInterceptor("vSalesmanProductTargets")]
        public void OnChangevSalesmanProductTargets(vSalesmanProductTarget data, UpdateOperations operations)
        {
            if (ValidateSegment("vSalesmanProductTargets"))
            {
                var dataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesmanProductTargetDataProvider>();

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
