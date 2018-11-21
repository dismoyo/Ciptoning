using Dismoyo.Ciptoning.Web.Security;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

    [ServiceContract]
    public interface IAuthService
    {

        #region Methods

        [OperationContract]
        [WebGet(UriTemplate = "/Authenticate")]
        BasicAuthentication.AuthResponse Authenticate();

        #endregion

    }

}
