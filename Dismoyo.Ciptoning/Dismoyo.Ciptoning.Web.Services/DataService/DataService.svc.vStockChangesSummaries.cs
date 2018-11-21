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

        [QueryInterceptor("vStockChangesSummaries")]
        public Expression<Func<vStockChangesSummary, bool>> OnQueryvStockChangesSummaries()
        {
            return (p => true);
        }

        [ChangeInterceptor("vStockChangesSummaries")]
        public void OnChangevStockChangesSummaries(vStockChangesSummary data, UpdateOperations operations)
        {
            if (ValidateSegment("vStockChangesSummaries"))
            {
                var dataProvider = DataConfiguration.GetDefaultDataProvider<IvStockChangesSummaryDataProvider>();

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

        #region Custom Methods

        [WebGet]
        public IQueryable<vStockChangesSummary> fStockChangesSummaries()
        {
            return CurrentDataSource.fStockChangesSummary(
                (Guid?)GetQueryFilterParameterValue("DocumentID"),
                (int?)GetQueryFilterParameterValue("ProductID"),
                (string)GetQueryFilterParameterValue("ProductCode"),
                (string)GetQueryFilterParameterValue("ProductName"),
                (int?)GetQueryFilterParameterValue("ProductBrandID"),
                (string)GetQueryFilterParameterValue("ProductBrandCode"),
                (string)GetQueryFilterParameterValue("ProductBrandName"),
                (string)GetQueryFilterParameterValue("ProductShortName"),
                (int?)GetQueryFilterParameterValue("ProductStatusID"),
                (string)GetQueryFilterParameterValue("ProductAdditionalInfo"));
        }

        #endregion

    }

}
