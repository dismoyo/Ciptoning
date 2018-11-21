using System.Web.Http;

namespace Dismoyo.Ciptoning.Web.Mvc.Applications
{

    public static class WebApiConfig
    {

        #region Methods

        public static void Register(HttpConfiguration config)
        {
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }

        #endregion

    }

}
