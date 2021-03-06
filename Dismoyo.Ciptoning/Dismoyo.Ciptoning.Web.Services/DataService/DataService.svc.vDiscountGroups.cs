﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 00:00:00
// Description   : DataService partial class.
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
using System.Data;
using System.Data.Services;
using System.Data.Services.Providers;
using System.Linq;
using System.Linq.Expressions;

namespace Dismoyo.Ciptoning.Web.Services
{

    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Methods

        [QueryInterceptor("vDiscountGroups")]
        public Expression<Func<vDiscountGroup, bool>> OnQueryvDiscountGroups()
        {
            return (p => !p.IsDeleted);
        }

        [ChangeInterceptor("vDiscountGroups")]
        public void OnChangevDiscountGroups(vDiscountGroup data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvDiscountGroupDataProvider>();

            switch (operations)
            {
                case UpdateOperations.Add:
                    using (var transaction = DefaultDataContext.DataContext.Database.BeginTransaction())
                    {
                        try
                        {
                            if (data.ID == 0)
                                dataProvider.InsertData(data, true);
                            else
                                dataProvider.UpdateData(data, true);

                            DefaultDataContext.DataContext.SaveChanges();
                            transaction.Commit();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            throw ex;
                        }
                    }

                    operations = UpdateOperations.None;
                    break;
                case UpdateOperations.Change:
                    using (var transaction = DefaultDataContext.DataContext.Database.BeginTransaction())
                    {
                        try
                        {
                            dataProvider.UpdateData(data, true);
                            DefaultDataContext.DataContext.SaveChanges();
                            transaction.Commit();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            throw ex;
                        }
                    }

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
