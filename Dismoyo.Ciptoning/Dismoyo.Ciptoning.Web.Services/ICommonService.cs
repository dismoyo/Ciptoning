using System;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

    [ServiceContract]
    public interface ICommonService
    {

        #region Methods

        [OperationContract]
        [WebGet(UriTemplate = "/GetDBServerDateTime")]
        DateTime GetDBServerDateTime();

        [OperationContract]
        [WebGet(UriTemplate = "/GetDBServerUtcDateTime")]
        DateTime GetDBServerUtcDateTime();
                
        #endregion

    }

}
