using System;
using System.IO;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web;
using System.Web.Hosting;

namespace Dismoyo.Ciptoning.Web.Services
{

#if DEBUG
    [ServiceBehavior(IncludeExceptionDetailInFaults = true)]
#endif
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class FileService : IFileService
    {

        #region Methods

        public Stream Download(string fileName)
        {
            var pathName = HttpContext.Current.Request.QueryString["pathName"];

            fileName = fileName.Replace('|', '/');
            string filePath = HostingEnvironment.MapPath("~/Files/" +
                (string.IsNullOrEmpty(pathName) ? "" : "/" + pathName) +
                (string.IsNullOrEmpty(fileName) ? "" : "/" + fileName));

            var fileInfo = new FileInfo(filePath);
            if (!fileInfo.Exists)
                throw new FileNotFoundException();

            String headerInfo = "attachment; filename=" + fileName;
            WebOperationContext.Current.OutgoingResponse.Headers["Content-Disposition"] = headerInfo;
            WebOperationContext.Current.OutgoingResponse.ContentType = "application/octet-stream";
            
            return fileInfo.OpenRead();
        }

        public void Upload(string fileName, Stream stream)
        {
            string filePath = HostingEnvironment.MapPath("~/Files/" + fileName);
            var parser = new MultipartParser(stream);

            var fileInfo = new FileInfo(filePath);
            if (!Directory.Exists(fileInfo.DirectoryName))
                Directory.CreateDirectory(fileInfo.DirectoryName);

            using (FileStream writer = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None))
            {
                var buffer = parser.FileContents;
                writer.Write(buffer, 0, buffer.Length);

                writer.Flush();
                writer.Close();
            }

            stream.Close();
        }

        #endregion

    }

}
