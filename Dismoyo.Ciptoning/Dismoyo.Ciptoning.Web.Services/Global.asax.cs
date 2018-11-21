using Dismoyo.Ciptoning.Data;
using System;
using System.Data.Services;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

namespace Dismoyo.Ciptoning.Web.Services
{

    public class Global : HttpApplication
    {

        #region Methods
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //This line is the addition.
            routes.IgnoreRoute("{resource}.svc/{*pathInfo}");

            routes.MapRoute(
                "Default",                                              // Route name
                "{controller}/{action}/{id}",                           // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }  // Parameter defaults
            );

        }

        #endregion

        #region Events

        protected void Application_OnStart()
        {
            //GlobalConfiguration.Configure(WebApiConfig.Register);
            //FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            //AreaRegistration.RegisterAllAreas();
            //WebApiConfig.Register(GlobalConfiguration.Configuration);
            RegisterRoutes(RouteTable.Routes);
            //AuthConfig.RegisterAuth();

            DataConfiguration.DefaultConnectionStringName = "DefaultDB";
            DataConfiguration.DefaultDataContextCommandTimeoutName = "DataContext:CommandTimeout";
            DataConfiguration.DefaultDataAccessAssemblyFileNames = new string[]
            {
                "Dismoyo.Ciptoning.Data.LinqToEntity.dll"
            };
            DataConfiguration.LoadDefaultDataAccessAssemblies();

            //ModelBinders.Binders.DefaultBinder = new DevExpressEditorsBinder();

            //ModelMetadataProviders.Current = new DefaultModelMetadataProvider();

            //DataConfiguration.LoadDefaultLocalString();
            //DataConfiguration.LoadDefaultLocalMenuGroup();
            //DataConfiguration.LoadDefaultLocalLookup();
            //DataConfiguration.LoadDefaultLocalCountry();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            CorsSupport.HandlePreflightRequest(HttpContext.Current);

            DataService.OverwriteMethods(HttpContext.Current);            
        }

        #endregion

    }

}
