using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ISID.Web.Mvc
{

    public class LocalizationRedirectRouteHandler : IRouteHandler
    {

        #region Methods

        public IHttpHandler GetHttpHandler(RequestContext requestContext)
        {
            var cookie = requestContext.HttpContext.Request.Cookies["culture"];
            requestContext.RouteData.Values["culture"] = (cookie != null) ? cookie.Value :
                Thread.CurrentThread.CurrentCulture.Name;

            return new RedirectHandler(new UrlHelper(requestContext).RouteUrl(requestContext.RouteData.Values) +
                requestContext.HttpContext.Request.Url.Query);
        }

        #endregion
        
    }

}
