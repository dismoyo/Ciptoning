using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fStockOnHandAvailable

        [DbFunction("StoreFunctionsDataContext", "fStockOnHandAvailable")]
        public IQueryable<vStockOnHandAvailable> fStockOnHandAvailable(
            Guid? p_WarehouseID,
            DateTime? p_TransactionDate,
            int? p_ProductID,
            int? p_ProductLotID,
            string p_WarehouseCode,
            string p_WarehouseName,
            Guid? p_SiteID,
            string p_SiteCode,
            string p_SiteName,
            int? p_AreaID,
            string p_AreaCode,
            string p_AreaName,
            int? p_RegionID,
            string p_RegionCode,
            string p_RegionName,
            int? p_TerritoryID,
            string p_TerritoryCode,
            string p_TerritoryName,
            int? p_CompanyID,
            string p_CompanyCode,
            string p_CompanyName,
            int? p_SiteDistributionTypeID,
            bool? p_IsSiteLotNumberEntryRequired,
            int? p_WarehouseTypeID,
            bool? p_IsWarehouseSOAllowed,
            int? p_WarehouseStatusID,
            bool? p_IsWarehouseDeleted,
            string p_ProductCode,
            string p_ProductName,
            int? p_ProductBrandID,
            string p_ProductBrandCode,
            string p_ProductBrandName,
            string p_ProductShortName,
            int? p_ProductStatusID,
            string p_ProductAdditionalInfo,
            string p_ProductLotCode,
            DateTime? p_ProductLotExpiredDateFrom,
            DateTime? p_ProductLotExpiredDateTo,
            int? p_ProductLotStatusID,
            bool? p_IsProductLotDeleted)
        {
            return OrderQuery<vStockOnHandAvailable>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vStockOnHandAvailable>(string.Format(@"
                [{0}].[fStockOnHandAvailable]
                ( 
                    @WarehouseID,
                    @TransactionDate,
                    @ProductID,
                    @ProductLotID,
                    @WarehouseCode,
                    @WarehouseName,
                    @SiteID,
                    @SiteCode,
                    @SiteName,
                    @AreaID,
                    @AreaCode,
                    @AreaName,
                    @RegionID,
                    @RegionCode,
                    @RegionName,
                    @TerritoryID,
                    @TerritoryCode,
                    @TerritoryName,
                    @CompanyID,
                    @CompanyCode,
                    @CompanyName,
                    @SiteDistributionTypeID,
                    @IsSiteLotNumberEntryRequired,
                    @WarehouseTypeID,
                    @IsWarehouseSOAllowed,
                    @WarehouseStatusID,
                    @IsWarehouseDeleted,
                    @ProductCode,
                    @ProductName,
                    @ProductBrandID,
                    @ProductBrandCode,
                    @ProductBrandName,
                    @ProductShortName,
                    @ProductStatusID,
                    @ProductAdditionalInfo,
                    @ProductLotCode,
                    @ProductLotExpiredDateFrom,
                    @ProductLotExpiredDateTo,
                    @ProductLotStatusID,
                    @IsProductLotDeleted
                )", GetType().Name),

                DefaultDataContext.CreateParameter("WarehouseID", typeof(Guid?), p_WarehouseID),
                DefaultDataContext.CreateParameter("TransactionDate", typeof(DateTime?), p_TransactionDate),
                DefaultDataContext.CreateParameter("ProductID", typeof(int?), p_ProductID),
                DefaultDataContext.CreateParameter("ProductLotID", typeof(int?), p_ProductLotID),
                DefaultDataContext.CreateParameter("WarehouseCode", typeof(string), p_WarehouseCode),
                DefaultDataContext.CreateParameter("WarehouseName", typeof(string), p_WarehouseName),
                DefaultDataContext.CreateParameter("SiteID", typeof(Guid?), p_SiteID),
                DefaultDataContext.CreateParameter("SiteCode", typeof(string), p_SiteCode),
                DefaultDataContext.CreateParameter("SiteName", typeof(string), p_SiteName),
                DefaultDataContext.CreateParameter("AreaID", typeof(int?), p_AreaID),
                DefaultDataContext.CreateParameter("AreaCode", typeof(string), p_AreaCode),
                DefaultDataContext.CreateParameter("AreaName", typeof(string), p_AreaName),
                DefaultDataContext.CreateParameter("RegionID", typeof(int?), p_RegionID),
                DefaultDataContext.CreateParameter("RegionCode", typeof(string), p_RegionCode),
                DefaultDataContext.CreateParameter("RegionName", typeof(string), p_RegionName),
                DefaultDataContext.CreateParameter("TerritoryID", typeof(int?), p_TerritoryID),
                DefaultDataContext.CreateParameter("TerritoryCode", typeof(string), p_TerritoryCode),
                DefaultDataContext.CreateParameter("TerritoryName", typeof(string), p_TerritoryName),
                DefaultDataContext.CreateParameter("CompanyID", typeof(int?), p_CompanyID),
                DefaultDataContext.CreateParameter("CompanyCode", typeof(string), p_CompanyCode),
                DefaultDataContext.CreateParameter("CompanyName", typeof(string), p_CompanyName),
                DefaultDataContext.CreateParameter("SiteDistributionTypeID", typeof(int?), p_SiteDistributionTypeID),
                DefaultDataContext.CreateParameter("IsSiteLotNumberEntryRequired", typeof(bool?), p_IsSiteLotNumberEntryRequired),
                DefaultDataContext.CreateParameter("WarehouseTypeID", typeof(int?), p_WarehouseTypeID),
                DefaultDataContext.CreateParameter("IsWarehouseSOAllowed", typeof(bool?), p_IsWarehouseSOAllowed),
                DefaultDataContext.CreateParameter("WarehouseStatusID", typeof(int?), p_WarehouseStatusID),
                DefaultDataContext.CreateParameter("IsWarehouseDeleted", typeof(bool?), p_IsWarehouseDeleted),
                DefaultDataContext.CreateParameter("ProductCode", typeof(string), p_ProductCode),
                DefaultDataContext.CreateParameter("ProductName", typeof(string), p_ProductName),
                DefaultDataContext.CreateParameter("ProductBrandID", typeof(int?), p_ProductBrandID),
                DefaultDataContext.CreateParameter("ProductBrandCode", typeof(string), p_ProductBrandCode),
                DefaultDataContext.CreateParameter("ProductBrandName", typeof(string), p_ProductBrandName),
                DefaultDataContext.CreateParameter("ProductShortName", typeof(string), p_ProductShortName),
                DefaultDataContext.CreateParameter("ProductStatusID", typeof(int?), p_ProductStatusID),
                DefaultDataContext.CreateParameter("ProductAdditionalInfo", typeof(string), p_ProductAdditionalInfo),
                DefaultDataContext.CreateParameter("ProductLotCode", typeof(string), p_ProductLotCode),
                DefaultDataContext.CreateParameter("ProductLotExpiredDateFrom", typeof(DateTime?), p_ProductLotExpiredDateFrom),
                DefaultDataContext.CreateParameter("ProductLotExpiredDateTo", typeof(DateTime?), p_ProductLotExpiredDateTo),
                DefaultDataContext.CreateParameter("ProductLotStatusID", typeof(int?), p_ProductLotStatusID),
                DefaultDataContext.CreateParameter("IsProductLotDeleted", typeof(bool?), p_IsProductLotDeleted)));
        }

        #endregion

    }

};
