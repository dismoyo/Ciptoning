using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fSalesByChannelByBrandReport

        [DbFunction("StoreFunctionsDataContext", "fSalesByChannelByBrandReport")]
        public IQueryable<vSalesByChannelByBrandReport> fSalesByChannelByBrandReport(
            DateTime? p_ReportDateFrom,
            DateTime? p_ReportDateTo,
            string p_CategoryChannelCode,
            int? p_TerritoryID,
            int? p_RegionID,
            int? p_AreaID,
            int? p_CompanyID,
            Guid? p_SiteID,
            int? p_SiteDistributionTypeID,
            int? p_ProductBrandID,
            int? p_ProductID)
        {
            return OrderQuery<vSalesByChannelByBrandReport>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vSalesByChannelByBrandReport>(string.Format(@"
                [{0}].[fSalesByChannelByBrandReport]
                ( 
                    @ReportDateFrom,
                    @ReportDateTo,
                    @CategoryChannelCode,
                    @TerritoryID,
                    @RegionID,
                    @AreaID,
                    @CompanyID,
                    @SiteID,
                    @SiteDistributionTypeID,
                    @ProductBrandID,
                    @ProductID
                )", GetType().Name),

                DefaultDataContext.CreateParameter("ReportDateFrom", typeof(DateTime?), p_ReportDateFrom),
                DefaultDataContext.CreateParameter("ReportDateTo", typeof(DateTime?), p_ReportDateTo),
                DefaultDataContext.CreateParameter("CategoryChannelCode", typeof(string), p_CategoryChannelCode),
                DefaultDataContext.CreateParameter("TerritoryID", typeof(int?), p_TerritoryID),
                DefaultDataContext.CreateParameter("RegionID", typeof(int?), p_RegionID),
                DefaultDataContext.CreateParameter("AreaID", typeof(int?), p_AreaID),
                DefaultDataContext.CreateParameter("CompanyID", typeof(int?), p_CompanyID),
                DefaultDataContext.CreateParameter("SiteID", typeof(Guid?), p_SiteID),
                DefaultDataContext.CreateParameter("SiteDistributionTypeID", typeof(int?), p_SiteDistributionTypeID),
                DefaultDataContext.CreateParameter("ProductBrandID", typeof(int?), p_ProductBrandID),
                DefaultDataContext.CreateParameter("ProductID", typeof(int?), p_ProductID)));
        }

        #endregion

    }

};
