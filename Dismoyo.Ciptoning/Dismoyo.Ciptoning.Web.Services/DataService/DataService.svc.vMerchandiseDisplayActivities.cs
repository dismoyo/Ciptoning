﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 20:28:59
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

        [QueryInterceptor("vMerchandiseDisplayActivities")]
        public Expression<Func<vMerchandiseDisplayActivity, bool>> OnQueryvMerchandiseDisplayActivities()
        {
            return (p => true);
        }

        [ChangeInterceptor("vMerchandiseDisplayActivities")]
        public void OnChangevMerchandiseDisplayActivities(vMerchandiseDisplayActivity data, UpdateOperations operations)
        {
            if (ValidateSegment("vMerchandiseDisplayActivities"))
            {
                var dataProvider = DataConfiguration.GetDefaultDataProvider<IvMerchandiseDisplayActivityDataProvider>();

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
