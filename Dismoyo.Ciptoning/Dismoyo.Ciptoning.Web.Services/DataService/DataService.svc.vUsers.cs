﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 00:00:00
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
using Dismoyo.Utilities;
using System;
using System.Data.Services;
using System.Data.Services.Providers;
using System.Linq;
using System.Linq.Expressions;

namespace Dismoyo.Ciptoning.Web.Services
{

    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Methods

        [QueryInterceptor("vUsers")]
        public Expression<Func<vUser, bool>> OnQueryvUsers()
        {
            return (p => !p.IsDeleted);
        }

        [ChangeInterceptor("vUsers")]
        public void OnChangevUsers(vUser data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvUserDataProvider>();
            
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
