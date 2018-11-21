using System.IO;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

    [ServiceContract]
    public interface IFileService
    {

        #region Methods

        [OperationContract]
        [WebGet(UriTemplate = "/Download/{fileName}")]
        Stream Download(string fileName);

        [OperationContract]
        [WebInvoke(Method = "POST", UriTemplate = "/Upload?fileName={fileName}")]
        void Upload(string fileName, Stream stream);

        #endregion

    }

}
