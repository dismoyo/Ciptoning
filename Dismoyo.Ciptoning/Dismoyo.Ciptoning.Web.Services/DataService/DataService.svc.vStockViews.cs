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

        [QueryInterceptor("vStockViews")]
        public Expression<Func<vStockView, bool>> OnQueryvStockViews()
        {
            return (p => true);
        }

        [ChangeInterceptor("vStockViews")]
        public void OnChangevStockViews(vStockView data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvStockViewDataProvider>();

            switch (operations)
            {
                case UpdateOperations.Add:
                    operations = UpdateOperations.None;
                    break;
                case UpdateOperations.Change:
                    operations = UpdateOperations.None;
                    break;
                case UpdateOperations.Delete:
                    operations = UpdateOperations.None;
                    break;
            }

            if (operations == UpdateOperations.None)
                CancelChanges();
        }

        #endregion


        #region Custom Methods

        [WebGet]
        public IQueryable<vStockView> fStockViews()
        {
            return CurrentDataSource.fStockView(                
                (Guid?)GetQueryFilterParameterValue("WarehouseID"),
                (DateTime?)GetQueryFilterParameterValue("TransactionDate"),
                (int?)GetQueryFilterParameterValue("ProductID"),
                (int?)GetQueryFilterParameterValue("ProductLotID"),
                (string)GetQueryFilterParameterValue("WarehouseCode"),
                (string)GetQueryFilterParameterValue("WarehouseName"),
                (Guid?)GetQueryFilterParameterValue("SiteID"),
                (string)GetQueryFilterParameterValue("SiteCode"),
                (string)GetQueryFilterParameterValue("SiteName"),
                (int?)GetQueryFilterParameterValue("AreaID"),
                (string)GetQueryFilterParameterValue("AreaCode"),
                (string)GetQueryFilterParameterValue("AreaName"),
                (int?)GetQueryFilterParameterValue("RegionID"),
                (string)GetQueryFilterParameterValue("RegionCode"),
                (string)GetQueryFilterParameterValue("RegionName"),
                (int?)GetQueryFilterParameterValue("TerritoryID"),
                (string)GetQueryFilterParameterValue("TerritoryCode"),
                (string)GetQueryFilterParameterValue("TerritoryName"),
                (int?)GetQueryFilterParameterValue("CompanyID"),
                (string)GetQueryFilterParameterValue("CompanyCode"),
                (string)GetQueryFilterParameterValue("CompanyName"),
                (int?)GetQueryFilterParameterValue("SiteDistributionTypeID"),
                (bool?)GetQueryFilterParameterValue("IsSiteLotNumberEntryRequired"),
                (int?)GetQueryFilterParameterValue("WarehouseTypeID"),
                (bool?)GetQueryFilterParameterValue("IsWarehouseSOAllowed"),
                (int?)GetQueryFilterParameterValue("WarehouseStatusID"),
                (bool?)GetQueryFilterParameterValue("IsWarehouseDeleted"),
                (string)GetQueryFilterParameterValue("ProductCode"),
                (string)GetQueryFilterParameterValue("ProductName"),
                (int?)GetQueryFilterParameterValue("ProductBrandID"),
                (string)GetQueryFilterParameterValue("ProductBrandCode"),
                (string)GetQueryFilterParameterValue("ProductBrandName"),
                (string)GetQueryFilterParameterValue("ProductPack"),
                (string)GetQueryFilterParameterValue("ProductShortName"),
                (string)GetQueryFilterParameterValue("ProductUOM"),
                (int?)GetQueryFilterParameterValue("ProductStatusID"),
                (string)GetQueryFilterParameterValue("ProductAdditionalInfo"),
                (string)GetQueryFilterParameterValue("ProductLotCode"),
                (DateTime?)GetQueryFilterParameterValue("ProductLotExpiredDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("ProductLotExpiredDateTo"),
                (int?)GetQueryFilterParameterValue("ProductLotStatusID"),
                (bool?)GetQueryFilterParameterValue("IsProductLotDeleted"));
        }

        #endregion

    }

}
