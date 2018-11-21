using Dismoyo.Ciptoning.Data;
using DevExpress.Web;
using DevExpress.XtraReports.Web;
using DevExpress.XtraReports.Web.Native.ClientControls.Services;
using DevExpress.XtraReports.Web.ReportDesigner.Native;
using DevExpress.XtraReports.Web.WebDocumentViewer;
using Dismoyo.Utilities;
using System;
using System.Web;
using System.Web.SessionState;

namespace Dismoyo.Ciptoning.Web.Reports
{

    public class Global_asax : System.Web.HttpApplication
    {

        #region Events

        public void Application_Start(object sender, EventArgs e)
        {
            DefaultReportLoggingService.DefaultReportLoggingServiceDirectoryName = "DefaultReportLoggingDirectory";

            DataConfiguration.DefaultConnectionStringName = "DefaultDB";
            DataConfiguration.DefaultDataContextCommandTimeoutName = "DataContext:CommandTimeout";
            DataConfiguration.DefaultDataAccessAssemblyFileNames = new string[]
            {
                "Dismoyo.Ciptoning.Data.LinqToEntity.dll"
            };
            DataConfiguration.LoadDefaultDataAccessAssemblies();

            ReportDesignerBootstrapper.SessionState = SessionStateBehavior.Required;
            ASPxWebControl.CallbackError += new EventHandler(Application_Error);
            
            DefaultWebDocumentViewerContainer.UseFileDocumentStorage(Server.MapPath("~/App_Data/PreviewCache"));
            ASPxWebDocumentViewer.StaticInitialize();
                        
            DefaultLoggingService.SetInstance(new DefaultReportLoggingService());
            DefaultLoggingService.Instance.Info("'Application Start' event has ocurred.");
        }

        public void Application_End(object sender, EventArgs e)
        {
            DefaultLoggingService.Instance.Info("'Application End' event has ocurred.");
        }

        public void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();

            if (ex.GetType() == typeof(HttpException))
            {
                if (ex.Message.Contains("NoCatch") || ex.Message.Contains("maxUrlLength"))
                    return;                
            }

            var errorID = Guid.NewGuid().ToString();
            DefaultLoggingService.Instance.Error(string.Format("[{0}] {1}", errorID,
               ExceptionUtility.InnermostException(ex).Message));
            Server.ClearError();

            Server.Transfer("Error.aspx?ErrorID=" + HttpUtility.UrlEncode(errorID) +
                "&ErrorMessage=" + HttpUtility.UrlEncode(ex.Message));
        }

        public void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
        }

        public void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
        }

        #endregion

    }

}
