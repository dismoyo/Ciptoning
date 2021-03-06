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

        [QueryInterceptor("ChangePasswords")]
        public Expression<Func<ChangePassword, bool>> OnQueryChangePasswords()
        {
            return (p => true);
        }

        [ChangeInterceptor("ChangePasswords")]
        public void OnChangeChangePasswords(ChangePassword data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IUserDataProvider>();
            
            switch (operations)
            {
                case UpdateOperations.Change:
                    var user = dataProvider.GetData(data.ID);

                    if (user != null)
                        user.Password = CryptographyUtility.GetSaltedHash(data.Password);
                    else
                        throw new Exception("This user does not exist or inactive. Please contact the administrator.");

                    dataProvider.UpdateData(user);
                    operations = UpdateOperations.None;
                    break;
            }

            if (operations == UpdateOperations.None)
                CancelChanges();
        }

        #endregion

    }

}
