﻿// ===================================================================================
// Author        : System
// Created date  : 27 Jul 2016 00:19:09
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

        [QueryInterceptor("vRoles")]
        public Expression<Func<vRole, bool>> OnQueryvRoles()
        {
            return (p => !p.IsDeleted);
        }

        [ChangeInterceptor("vRoles")]
        public void OnChangevRoles(vRole data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvRoleDataProvider>();

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

        #endregion

    }

}
