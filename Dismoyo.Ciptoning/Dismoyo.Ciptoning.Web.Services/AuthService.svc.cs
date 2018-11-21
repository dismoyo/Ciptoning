using Dismoyo.Ciptoning.Data;
using Dismoyo.Ciptoning.Web.Security;
using Dismoyo.Web.Security;
using System;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

#if DEBUG
    [ServiceBehavior(IncludeExceptionDetailInFaults = true)]
#endif
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    [JSONPSupportBehavior]
    public class AuthService : IAuthService
    {

        #region Implements IAuthService

        public BasicAuthentication.AuthResponse Authenticate()
        {
            bool authenticated = false;
            IvUser user = null;
            string deviceID = HttpContext.Current.Request.Headers["Authorization.DeviceID"];

            //if (DataService.ValidateSegment("vSystemParameters"))
            //    return true;

            //if (!bool.Parse(ConfigurationManager.AppSettings["EnableAuthentication"]))
            //    authenticated = true;

            if (!authenticated)
            {
                var basicAuth = new BasicAuthentication();
                basicAuth.Authenticate(HttpContext.Current);

                authenticated = (HttpContext.Current.User != null);
            }

            if (authenticated)
            {
                user = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData;
                var authorizationAccessTokenDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IAuthorizationAccessTokenDataProvider>();
                var c = authorizationAccessTokenDataProvider.GetData().ToList();
                var authorizationAccessTokenData = authorizationAccessTokenDataProvider.CreateToken(user.ID,
                    deviceID, 1); ///////////
                
                return new BasicAuthentication.AuthResponse(authorizationAccessTokenData.ID, authorizationAccessTokenData.UserID,
                    authorizationAccessTokenData.DeviceID);
            }

            throw new UnauthorizedAccessException("Authentication Failed. Invalid user name or password.");
        }
        
        public static bool Authorize()
        {
            try
            {
                Guid accessToken;
                int userID = int.Parse(HttpContext.Current.Request.Headers["Authorization.UserID"]);
                string deviceID = HttpContext.Current.Request.Headers["Authorization.DeviceID"];

                var authorizationAccessTokenDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IAuthorizationAccessTokenDataProvider>();
                if (Guid.TryParse(HttpContext.Current.Request.Headers["Authorization.AccessToken"], out accessToken) &&
                    !accessToken.Equals(Guid.Empty) && authorizationAccessTokenDataProvider.IsActiveToken(accessToken,
                    userID, deviceID))
                {
                    authorizationAccessTokenDataProvider.CreateToken(userID, deviceID, 1); ///////////

                    return true;
                }
            }
            catch (Exception)
            {
                
            }

            throw new UnauthorizedAccessException("Authorization Failed. Invalid token or expired.");
        }

        #endregion

    }

}
