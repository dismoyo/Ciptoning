﻿// ===================================================================================
// Author        : System
// Created date  : 10 Apr 2016 13:23:57
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

        [QueryInterceptor("vRoutePlanSalesmen")]
        public Expression<Func<vRoutePlanSalesman, bool>> OnQueryvRoutePlanSalesmen()
        {
            return (p => true);
        }

        [ChangeInterceptor("vRoutePlanSalesmen")]
        public void OnChangevRoutePlanSalesmen(vRoutePlanSalesman data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvRoutePlanSalesmanDataProvider>();

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
        public IQueryable<vRoutePlanSalesman> fRoutePlanSalesmen()
        {
            return CurrentDataSource.fRoutePlanSalesman(
                (Guid?)GetQueryFilterParameterValue("SalesmanID"),
                (Guid?)GetQueryFilterParameterValue("CustomerID"),                
                (int?)GetQueryFilterParameterValue("WeekID"),
                (int?)GetQueryFilterParameterValue("DayID"),
                (string)GetQueryFilterParameterValue("SalesmanCode"),
                (string)GetQueryFilterParameterValue("SalesmanName"),
                (Guid?)GetQueryFilterParameterValue("WarehouseID"),
                (string)GetQueryFilterParameterValue("WarehouseCode"),
                (string)GetQueryFilterParameterValue("WarehouseName"),
                (Guid?)GetQueryFilterParameterValue("SiteID"),
                (string)GetQueryFilterParameterValue("SiteCode"),
                (string)GetQueryFilterParameterValue("SiteName"),
                (int?)GetQueryFilterParameterValue("CompanyID"),
                (string)GetQueryFilterParameterValue("CompanyCode"),
                (string)GetQueryFilterParameterValue("CompanyName"),
                (int?)GetQueryFilterParameterValue("AreaID"),
                (string)GetQueryFilterParameterValue("AreaCode"),
                (string)GetQueryFilterParameterValue("AreaName"),
                (int?)GetQueryFilterParameterValue("RegionID"),
                (string)GetQueryFilterParameterValue("RegionCode"),
                (string)GetQueryFilterParameterValue("RegionName"),
                (int?)GetQueryFilterParameterValue("TerritoryID"),
                (string)GetQueryFilterParameterValue("TerritoryCode"),
                (string)GetQueryFilterParameterValue("TerritoryName"),
                (int?)GetQueryFilterParameterValue("SiteDistributionTypeID"),
                (int?)GetQueryFilterParameterValue("WarehouseTypeID"),
                (int?)GetQueryFilterParameterValue("SalesmanGroupID"),
                (int?)GetQueryFilterParameterValue("SalesmanCategoryID"),
                (int?)GetQueryFilterParameterValue("SalesmanStatusID"),
                (string)GetQueryFilterParameterValue("CustomerCode"),
                (string)GetQueryFilterParameterValue("CustomerName"));
        }

        #endregion

    }

}
