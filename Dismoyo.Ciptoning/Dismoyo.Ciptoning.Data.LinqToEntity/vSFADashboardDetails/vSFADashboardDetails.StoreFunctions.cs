using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fSFADashboardDetails

        [DbFunction("StoreFunctionsDataContext", "fSFADashboardDetails")]
        public IQueryable<vSFADashboardDetails> fSFADashboardDetails(
            Guid? p_SalesmanID,
            DateTime? p_TransactionDate)
        {
            return OrderQuery<vSFADashboardDetails>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vSFADashboardDetails>(string.Format(@"
                [{0}].[fSFADashboardDetails]
                ( 
                    @SalesmanID,
                    @TransactionDate
                )", GetType().Name),

                DefaultDataContext.CreateParameter("SalesmanID", typeof(Guid?), p_SalesmanID),
                DefaultDataContext.CreateParameter("TransactionDate", typeof(DateTime?), p_TransactionDate)));
        }

        #endregion

    }

};
