﻿using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fRoutePlanCustomer

        [DbFunction("StoreFunctionsDataContext", "fRoutePlanCustomer")]
        public IQueryable<vRoutePlanCustomer> fRoutePlanCustomer(
            Guid? p_CustomerID,
            Guid? p_SalesmanID,
            int? p_WeekID,
            int? p_DayID,
            string p_CustomerCode,
            string p_CustomerName,
            string p_SalesmanCode,
            string p_SalesmanName,
            Guid? p_WarehouseID,
            string p_WarehouseCode,
            string p_WarehouseName,
            Guid? p_SiteID,
            string p_SiteCode,
            string p_SiteName,
            int? p_CompanyID,
            string p_CompanyCode,
            string p_CompanyName,
            int? p_AreaID,
            string p_AreaCode,
            string p_AreaName,
            int? p_RegionID,
            string p_RegionCode,
            string p_RegionName,
            int? p_TerritoryID,
            string p_TerritoryCode,
            string p_TerritoryName,
            int? p_SiteDistributionTypeID,
            int? p_WarehouseTypeID,
            int? p_SalesmanGroupID,
            int? p_SalesmanCategoryID,
            int? p_SalesmanStatusID,
            Guid? p_OrderBySalesmanID,
            string p_FilterByKeywords)
        {
            return OrderQuery<vRoutePlanCustomer>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vRoutePlanCustomer>(string.Format(@"
                [{0}].[fRoutePlanCustomer]
                ( 
                    @CustomerID,
                    @SalesmanID,
                    @WeekID,
                    @DayID,
                    @CustomerCode,
                    @CustomerName,
                    @SalesmanCode,
                    @SalesmanName,
                    @WarehouseID,
                    @WarehouseCode,
                    @WarehouseName,
                    @SiteID,
                    @SiteCode,
                    @SiteName,
                    @CompanyID,
                    @CompanyCode,
                    @CompanyName,
                    @AreaID,
                    @AreaCode,
                    @AreaName,
                    @RegionID,
                    @RegionCode,
                    @RegionName,
                    @TerritoryID,
                    @TerritoryCode,
                    @TerritoryName,
                    @SiteDistributionTypeID,
                    @WarehouseTypeID,
                    @SalesmanGroupID,
                    @SalesmanCategoryID,
                    @SalesmanStatusID,
                    @OrderBySalesmanID,
                    @FilterByKeywords
                )", GetType().Name),

                DefaultDataContext.CreateParameter("CustomerID", typeof(Guid?), p_CustomerID),
                DefaultDataContext.CreateParameter("SalesmanID", typeof(Guid?), p_SalesmanID),
                DefaultDataContext.CreateParameter("WeekID", typeof(int?), p_WeekID),
                DefaultDataContext.CreateParameter("DayID", typeof(int?), p_DayID),
                DefaultDataContext.CreateParameter("CustomerCode", typeof(string), p_CustomerCode),
                DefaultDataContext.CreateParameter("CustomerName", typeof(string), p_CustomerName),
                DefaultDataContext.CreateParameter("SalesmanCode", typeof(string), p_SalesmanCode),
                DefaultDataContext.CreateParameter("SalesmanName", typeof(string), p_SalesmanName),
                DefaultDataContext.CreateParameter("WarehouseID", typeof(Guid?), p_WarehouseID),
                DefaultDataContext.CreateParameter("WarehouseCode", typeof(string), p_WarehouseCode),
                DefaultDataContext.CreateParameter("WarehouseName", typeof(string), p_WarehouseName),
                DefaultDataContext.CreateParameter("SiteID", typeof(Guid?), p_SiteID),
                DefaultDataContext.CreateParameter("SiteCode", typeof(string), p_SiteCode),
                DefaultDataContext.CreateParameter("SiteName", typeof(string), p_SiteName),
                DefaultDataContext.CreateParameter("CompanyID", typeof(int?), p_CompanyID),
                DefaultDataContext.CreateParameter("CompanyCode", typeof(string), p_CompanyCode),
                DefaultDataContext.CreateParameter("CompanyName", typeof(string), p_CompanyName),
                DefaultDataContext.CreateParameter("AreaID", typeof(int?), p_AreaID),
                DefaultDataContext.CreateParameter("AreaCode", typeof(string), p_AreaCode),
                DefaultDataContext.CreateParameter("AreaName", typeof(string), p_AreaName),
                DefaultDataContext.CreateParameter("RegionID", typeof(int?), p_RegionID),
                DefaultDataContext.CreateParameter("RegionCode", typeof(string), p_RegionCode),
                DefaultDataContext.CreateParameter("RegionName", typeof(string), p_RegionName),
                DefaultDataContext.CreateParameter("TerritoryID", typeof(int?), p_TerritoryID),
                DefaultDataContext.CreateParameter("TerritoryCode", typeof(string), p_TerritoryCode),
                DefaultDataContext.CreateParameter("TerritoryName", typeof(string), p_TerritoryName),
                DefaultDataContext.CreateParameter("SiteDistributionTypeID", typeof(int?), p_SiteDistributionTypeID),
                DefaultDataContext.CreateParameter("WarehouseTypeID", typeof(int?), p_WarehouseTypeID),
                DefaultDataContext.CreateParameter("SalesmanGroupID", typeof(int?), p_SalesmanGroupID),
                DefaultDataContext.CreateParameter("SalesmanCategoryID", typeof(int?), p_SalesmanCategoryID),
                DefaultDataContext.CreateParameter("SalesmanStatusID", typeof(int?), p_SalesmanStatusID),
                DefaultDataContext.CreateParameter("OrderBySalesmanID", typeof(Guid?), p_OrderBySalesmanID),
                DefaultDataContext.CreateParameter("FilterByKeywords", typeof(string), p_FilterByKeywords)));
        }

        #endregion

    }

};
