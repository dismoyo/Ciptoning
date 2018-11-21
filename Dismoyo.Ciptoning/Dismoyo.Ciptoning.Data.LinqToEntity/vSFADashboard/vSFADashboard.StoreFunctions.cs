using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fSFADashboard

        [DbFunction("StoreFunctionsDataContext", "fSFADashboard")]
        public IQueryable<vSFADashboard> fSFADashboard(
            Guid? p_SalesmanID,
            DateTime? p_TransactionDate)
        {
            return OrderQuery<vSFADashboard>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vSFADashboard>(string.Format(@"
                [{0}].[fSFADashboard]
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
