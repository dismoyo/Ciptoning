using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Dismoyo.Web.Security
{
    public abstract class BasicAuthProvider
    {

        #region Constructors

        public BasicAuthProvider()
        {
            RequestHeaderName = "Authorization";
            HeaderPrefix = "Basic ";
        }

        #endregion

        #region Properties

        protected string RequestHeaderName { get; set; }
        protected string HeaderPrefix { get; set; }

        #endregion

        #region Methods

        public abstract void Authenticate(HttpContext context);
        protected abstract IPrincipal GetPrincipalFromCredentials(string userName, string password);



        protected virtual void Authenticate(HttpContext context, bool isSslRequired)
        {
            if (isSslRequired && !context.Request.IsSecureConnection)
                return;

            context.User = AuthenticateRequest(context.Request.Headers);
        }

        protected virtual string[] ParseAuthHeader(string header)
        {
            if (String.IsNullOrEmpty(header) || !header.StartsWith(HeaderPrefix))
                return null;

            var cred = Encoding.ASCII.GetString(Convert.FromBase64String(
                header.Substring(HeaderPrefix.Length))).Split(':');
            if (cred.Length != 2)
                return null;

            return cred;
        }

        protected virtual IPrincipal AuthenticateRequest(NameValueCollection requestHeaders)
        {
            var credentials = ParseAuthHeader(requestHeaders[RequestHeaderName]);
            if (credentials == null)
                return null;

            return GetPrincipalFromCredentials(credentials[0], credentials[1]);
        }

        #endregion

    }

}
