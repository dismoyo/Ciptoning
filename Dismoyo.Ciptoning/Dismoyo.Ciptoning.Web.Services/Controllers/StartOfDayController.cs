using Dismoyo.Ciptoning.Data;
using System;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Hosting;
using System.Web.Http;
using System.Web.Mvc;

namespace Dismoyo.Ciptoning.Web.Services.Controllers
{
    public class StartOfDayController : Controller
    {
        public String GetById(string id)
        {
            return "HelloWorld";
        }

        [System.Web.Mvc.HttpPost]
        public String UploadFile()
        {
            int statusUpload = -1;

            try
            {
                // DEFINE THE PATH WHERE WE WANT TO SAVE THE FILES.
                string sPath = "";
                sPath = System.Web.Hosting.HostingEnvironment.MapPath("~/Files/Temp/");

                //System.Web.HttpFileCollection hfc = System.Web.HttpContext.Current.Request.Files["UploadedFiles"];
                var myFile = System.Web.HttpContext.Current.Request.Files["UploadedFiles"];
                var dirFile = System.Web.HttpContext.Current.Request.Params["DirFile"];

                if (myFile != null)
                {
                    // CHECK IF THE SELECTED FILE(S) ALREADY EXISTS IN FOLDER. (AVOID DUPLICATE
                    if (!System.IO.File.Exists(sPath + dirFile))
                    {
                        using (FileStream writer = new FileStream(sPath + dirFile, FileMode.Create, FileAccess.Write, FileShare.None))
                        {
                            //var buffer = parser.FileContents;
                            int filelength = myFile.ContentLength;
                            byte[] imagebytes = new byte[filelength];
                            myFile.InputStream.Read(imagebytes, 0, filelength);

                            writer.Write(imagebytes, 0, filelength);

                            writer.Flush();
                            writer.Close();
                            
                        }
                        statusUpload = 1;
                    }else
                    {
                        statusUpload = 0;
                    }
                }
            }
            catch (Exception e)
            {
                throw new Exception("Upload Failed");
            }
            
            if (statusUpload > -1)
            {
                return statusUpload+"";
            }
            else
            {
                throw new Exception("Upload Failed");
            }
        }
    }
}