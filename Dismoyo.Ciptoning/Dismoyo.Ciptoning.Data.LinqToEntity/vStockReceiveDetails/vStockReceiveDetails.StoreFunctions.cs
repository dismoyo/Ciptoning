using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fStockReceiveDetails

        [DbFunction("StoreFunctionsDataContext", "fStockReceiveDetails")]
        public IQueryable<vStockReceiveDetails> fStockReceiveDetails(
            Guid? p_DocumentID,
            int? p_ProductID,
            int? p_ProductLotID,
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
            int? p_ProductLotStatusID)
        {
            return OrderQuery<vStockReceiveDetails>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vStockReceiveDetails>(string.Format(@"
                [{0}].[fStockReceiveDetails]
                ( 
                    @DocumentID,
                    @ProductID,
                    @ProductLotID,
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
                    @ProductLotStatusID
                )", GetType().Name),

                DefaultDataContext.CreateParameter("DocumentID", typeof(Guid?), p_DocumentID),
                DefaultDataContext.CreateParameter("ProductID", typeof(int?), p_ProductID),
                DefaultDataContext.CreateParameter("ProductLotID", typeof(int?), p_ProductLotID),
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
                DefaultDataContext.CreateParameter("ProductLotStatusID", typeof(int?), p_ProductLotStatusID)));
        }

        #endregion

    }

};
