using System;
using System.Configuration;
using System.IO;
using System.Web;

public class DefaultReportLoggingService : DevExpress.XtraReports.Web.Native.ClientControls.Services.ILoggingService
{

    #region Properties

    public static string DefaultReportLoggingServiceDirectoryName { get; set; }

    #endregion

    #region Methods

    public void Info(string message)
    {
        WriteLog(false, message);
    }

    public void Error(string message)
    {
        WriteLog(true, message);
    }
    


    private void WriteLog(bool isIerror, string message)
    {
        try
        {
            string fullReportDirectory = HttpContext.Current.Server.MapPath(
            ConfigurationManager.AppSettings[DefaultReportLoggingServiceDirectoryName]);
            if (!Directory.Exists(fullReportDirectory))
                Directory.CreateDirectory(fullReportDirectory);

            using (var sw = new StreamWriter(string.Format(@"{0}\{1}_log.txt", fullReportDirectory,
                DateTime.Today.ToString("yyyyMMdd")), true))
            {
                sw.WriteLine(string.Format("[{0}] {1}{2}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    (isIerror) ? "ERROR: " : "", message));
                sw.Close();
            }
        }
        catch (Exception)
        {
        }        
    }

    #endregion

}
