﻿// ===================================================================================
// Author        : System
// Created date  : 16 Dec 2016 13:50:21
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
using System.Linq;
using System.Linq.Expressions;
using System.ServiceModel.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Methods

        [QueryInterceptor("vSFADashboardDetails")]
        public Expression<Func<vSFADashboardDetails, bool>> OnQueryvSFADashboardDetails()
        {
            return (p => true);
        }

        [ChangeInterceptor("vSFADashboardDetails")]
        public void OnChangevSFADashboardDetails(vSFADashboardDetails data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvSFADashboardDetailsDataProvider>();

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
        
        #region Custom Methods

        [WebGet]
        public IQueryable<vSFADashboardDetails> fSFADashboardDetails()
        {
            return CurrentDataSource.fSFADashboardDetails(
                (Guid?)GetQueryFilterParameterValue("SalesmanID"),
                (DateTime?)GetQueryFilterParameterValue("TransactionDate"));
        }

        #endregion

    }

}