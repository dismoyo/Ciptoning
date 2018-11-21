using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fStockReceive

        [DbFunction("StoreFunctionsDataContext", "fStockReceive")]
        public IQueryable<vStockReceive> fStockReceive(
            Guid? p_DocumentID,
            string p_DocumentCode,
            DateTime? p_TransactionDateFrom,
            DateTime? p_TransactionDateTo,
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
            bool? p_IsSiteLotNumberEntryRequired,
            int? p_WarehouseTypeID,
            string p_PIC,
            string p_ReferenceNumber,
            int? p_DocumentStatusID,
            DateTime? p_PostedDateFrom,
            DateTime? p_PostedDateTo)
        {
            return OrderQuery<vStockReceive>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vStockReceive>(string.Format(@"
                [{0}].[fStockReceive]
                ( 
                    @DocumentID,
                    @DocumentCode,
                    @TransactionDateFrom,
                    @TransactionDateTo,
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
                    @IsSiteLotNumberEntryRequired,
                    @WarehouseTypeID,
                    @PIC,
                    @ReferenceNumber,
                    @DocumentStatusID,
                    @PostedDateFrom,
                    @PostedDateTo
                )", GetType().Name),

                DefaultDataContext.CreateParameter("DocumentID", typeof(Guid?), p_DocumentID),
                DefaultDataContext.CreateParameter("DocumentCode", typeof(string), p_DocumentCode),
                DefaultDataContext.CreateParameter("TransactionDateFrom", typeof(DateTime?), p_TransactionDateFrom),
                DefaultDataContext.CreateParameter("TransactionDateTo", typeof(DateTime?), p_TransactionDateTo),
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
                DefaultDataContext.CreateParameter("IsSiteLotNumberEntryRequired", typeof(bool?), p_IsSiteLotNumberEntryRequired),
                DefaultDataContext.CreateParameter("WarehouseTypeID", typeof(int?), p_WarehouseTypeID),
                DefaultDataContext.CreateParameter("PIC", typeof(string), p_PIC),
                DefaultDataContext.CreateParameter("ReferenceNumber", typeof(string), p_ReferenceNumber),
                DefaultDataContext.CreateParameter("DocumentStatusID", typeof(int?), p_DocumentStatusID),
                DefaultDataContext.CreateParameter("PostedDateFrom", typeof(DateTime?), p_PostedDateFrom),
                DefaultDataContext.CreateParameter("PostedDateTo", typeof(DateTime?), p_PostedDateTo)));
        }

        #endregion

    }

};
