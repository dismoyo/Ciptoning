using System.Diagnostics.CodeAnalysis;
using System.Web.Routing;

namespace ISID.Web.Mvc
{

    public static class RouteCollectionExtensions
    {

        #region Methods
        
        [SuppressMessage("Microsoft.Design", "CA1054:UriParametersShouldNotBeStrings",
            Justification = "This is a URL template with special characters, more than a regular valid URL.")]
        public static Route MapRouteToLocalizeRedirect(this RouteCollection routes, string name, string url, object defaults)
        {
            var redirectRoute = new Route(url, new RouteValueDictionary(defaults), new LocalizationRedirectRouteHandler());
            routes.Add(name, redirectRoute);

            return redirectRoute;
        }

        public static Route MapLocalizeRoute(this RouteCollection routes, string name, string url, object defaults)
        {
            return routes.MapLocalizeRoute(name, url, defaults, new { });
        }

        public static Route MapLocalizeRoute(this RouteCollection routes, string name, string url, object defaults, object constraints)
        {
            var route = new Route(
                url,
                new RouteValueDictionary(defaults),
                new RouteValueDictionary(constraints),
                new LocalizedRouteHandler());

            routes.Add(name, route);

            return route;
        }

        #endregion

    }

}
