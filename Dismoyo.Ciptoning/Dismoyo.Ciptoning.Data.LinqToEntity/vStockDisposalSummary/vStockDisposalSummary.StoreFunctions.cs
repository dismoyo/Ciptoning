using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fStockDisposalSummary

        [DbFunction("StoreFunctionsDataContext", "fStockDisposalSummary")]
        public IQueryable<vStockDisposalSummary> fStockDisposalSummary(
            Guid? p_DocumentID,
            int? p_ProductID,
            string p_ProductCode,
            string p_ProductName,
            int? p_ProductBrandID,
            string p_ProductBrandCode,
            string p_ProductBrandName,
            string p_ProductShortName,
            int? p_ProductStatusID,
            string p_ProductAdditionalInfo)
        {
            return OrderQuery<vStockDisposalSummary>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vStockDisposalSummary>(string.Format(@"
                [{0}].[fStockDisposalSummary]
                ( 
                    @DocumentID,
                    @ProductID,
                    @ProductCode,
                    @ProductName,
                    @ProductBrandID,
                    @ProductBrandCode,
                    @ProductBrandName,
                    @ProductShortName,
                    @ProductStatusID,
                    @ProductAdditionalInfo
                )", GetType().Name),

                DefaultDataContext.CreateParameter("DocumentID", typeof(Guid?), p_DocumentID),
                DefaultDataContext.CreateParameter("ProductID", typeof(int?), p_ProductID),
                DefaultDataContext.CreateParameter("ProductCode", typeof(string), p_ProductCode),
                DefaultDataContext.CreateParameter("ProductName", typeof(string), p_ProductName),
                DefaultDataContext.CreateParameter("ProductBrandID", typeof(int?), p_ProductBrandID),
                DefaultDataContext.CreateParameter("ProductBrandCode", typeof(string), p_ProductBrandCode),
                DefaultDataContext.CreateParameter("ProductBrandName", typeof(string), p_ProductBrandName),
                DefaultDataContext.CreateParameter("ProductShortName", typeof(string), p_ProductShortName),
                DefaultDataContext.CreateParameter("ProductStatusID", typeof(int?), p_ProductStatusID),
                DefaultDataContext.CreateParameter("ProductAdditionalInfo", typeof(string), p_ProductAdditionalInfo)));
        }

        #endregion

    }

};
