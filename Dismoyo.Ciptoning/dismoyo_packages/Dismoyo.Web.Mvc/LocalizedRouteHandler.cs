using System;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using ISID.Utilities;

namespace ISID.Web.Mvc
{

    public class LocalizedRouteHandler : MvcRouteHandler
    {

        #region Methods

        protected override IHttpHandler GetHttpHandler(RequestContext requestContext)
        {
            string cultureName = (string)requestContext.RouteData.Values["culture"];
            if (cultureName == null)
                cultureName = ((requestContext.HttpContext.Request.UserLanguages != null) &&
                    (requestContext.HttpContext.Request.UserLanguages.Length > 0)) ?
                    requestContext.HttpContext.Request.UserLanguages[0] : null;

            cultureName = CultureUtility.GetImplementedCultureName(cultureName);

            CultureUtility.SetCurrentCulture(cultureName);

            var cookie = requestContext.HttpContext.Request.Cookies["culture"];
            if ((cookie == null) || !cookie.Value.Equals(cultureName, StringComparison.OrdinalIgnoreCase))
                requestContext.HttpContext.Response.Cookies.Add(new HttpCookie("culture", cultureName));

            return base.GetHttpHandler(requestContext);
        }

        #endregion
        
    }

}
