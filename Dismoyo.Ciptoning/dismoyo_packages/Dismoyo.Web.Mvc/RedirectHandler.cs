using System.Diagnostics.CodeAnalysis;
using System.Web;

namespace ISID.Web.Mvc
{

    public class RedirectHandler : IHttpHandler
    {
        
        #region Fields

        private string newUrl;
        
        #endregion

        #region Properties

        public bool IsReusable
        {
            get { return true; }
        }

        #endregion

        #region Methods

        [SuppressMessage(category: "Microsoft.Design", checkId: "CA1054:UriParametersShouldNotBeStrings",
            Justification = "String is used since HttpResponse.Redirect only accept as string parameter.")]
        public RedirectHandler(string newUrl)
        {
            this.newUrl = newUrl;
        }
        
        public void ProcessRequest(HttpContext context)
        {
            context.Response.Redirect(this.newUrl);
        }

        #endregion

    }

}
