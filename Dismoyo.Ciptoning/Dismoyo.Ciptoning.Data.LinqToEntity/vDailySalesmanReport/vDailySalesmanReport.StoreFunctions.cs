using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fDailySalesmanReport

        [DbFunction("StoreFunctionsDataContext", "fDailySalesmanReport")]
        public IQueryable<vDailySalesmanReport> fDailySalesmanReport(
            DateTime? p_ReportDateFrom,
            DateTime? p_ReportDateTo,
            Guid? p_SalesmanID)
        {
            return OrderQuery<vDailySalesmanReport>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vDailySalesmanReport>(string.Format(@"
                [{0}].[fDailySalesmanReport]
                ( 
                    @ReportDateFrom,
                    @ReportDateTo,
                    @SalesmanID
                )", GetType().Name),

                DefaultDataContext.CreateParameter("ReportDateFrom", typeof(DateTime?), p_ReportDateFrom),
                DefaultDataContext.CreateParameter("ReportDateTo", typeof(DateTime?), p_ReportDateTo),
                DefaultDataContext.CreateParameter("SalesmanID", typeof(Guid?), p_SalesmanID)));
        }

        #endregion

    }

};
