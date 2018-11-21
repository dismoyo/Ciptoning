using Dismoyo.Ciptoning.Data;
using System;
using System.ServiceModel;
using System.ServiceModel.Activation;

namespace Dismoyo.Ciptoning.Web.Services
{

#if DEBUG
    [ServiceBehavior(IncludeExceptionDetailInFaults = true)]
#endif
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    [JSONPSupportBehavior]
    public class CommonService : ICommonService
    {

        #region Methods

        public DateTime GetDBServerDateTime()
        {
            return DefaultDataContext.GetDBServerDateTime();
        }

        public DateTime GetDBServerUtcDateTime()
        {
            return DefaultDataContext.GetDBServerUtcDateTime();
        }

        #endregion

    }

}
