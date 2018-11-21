using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fDailySalesReport

        [DbFunction("StoreFunctionsDataContext", "fDailySalesReport")]
        public IQueryable<vDailySalesReport> fDailySalesReport(
            DateTime? p_ReportDateFrom,
            DateTime? p_ReportDateTo,
            int? p_TerritoryID,
            int? p_RegionID,
            int? p_AreaID,
            int? p_CompanyID,
            Guid? p_SiteID,
            int? p_SiteDistributionTypeID,
            Guid? p_SalesmanID,
            Guid? p_WarehouseID,
            int? p_WarehouseTypeID,
            int? p_SalesmanGroupID,
            int? p_SalesmanCategoryID,
            int? p_ProductBrandID,
            int? p_ProductID)
        {
            return OrderQuery<vDailySalesReport>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vDailySalesReport>(string.Format(@"
                [{0}].[fDailySalesReport]
                ( 
                    @ReportDateFrom,
                    @ReportDateTo,
                    @TerritoryID,
                    @RegionID,
                    @AreaID,
                    @CompanyID,
                    @SiteID,
                    @SiteDistributionTypeID,
                    @SalesmanID,
                    @WarehouseID,
                    @WarehouseTypeID,
                    @SalesmanGroupID,
                    @SalesmanCategoryID,
                    @ProductBrandID,
                    @ProductID
                )", GetType().Name),

                DefaultDataContext.CreateParameter("ReportDateFrom", typeof(DateTime?), p_ReportDateFrom),
                DefaultDataContext.CreateParameter("ReportDateTo", typeof(DateTime?), p_ReportDateTo),
                DefaultDataContext.CreateParameter("TerritoryID", typeof(int?), p_TerritoryID),
                DefaultDataContext.CreateParameter("RegionID", typeof(int?), p_RegionID),
                DefaultDataContext.CreateParameter("AreaID", typeof(int?), p_AreaID),
                DefaultDataContext.CreateParameter("CompanyID", typeof(int?), p_CompanyID),
                DefaultDataContext.CreateParameter("SiteID", typeof(Guid?), p_SiteID),
                DefaultDataContext.CreateParameter("SiteDistributionTypeID", typeof(int?), p_SiteDistributionTypeID),
                DefaultDataContext.CreateParameter("SalesmanID", typeof(Guid?), p_SalesmanID),
                DefaultDataContext.CreateParameter("WarehouseID", typeof(Guid?), p_WarehouseID),
                DefaultDataContext.CreateParameter("WarehouseTypeID", typeof(int?), p_WarehouseTypeID),
                DefaultDataContext.CreateParameter("SalesmanGroupID", typeof(int?), p_SalesmanGroupID),
                DefaultDataContext.CreateParameter("SalesmanCategoryID", typeof(int?), p_SalesmanCategoryID),
                DefaultDataContext.CreateParameter("ProductBrandID", typeof(int?), p_ProductBrandID),
                DefaultDataContext.CreateParameter("ProductID", typeof(int?), p_ProductID)));
        }

        #endregion

    }

};
