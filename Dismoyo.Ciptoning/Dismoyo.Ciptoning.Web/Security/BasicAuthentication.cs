using Dismoyo.Ciptoning.Data;
using Dismoyo.Utilities;
using Dismoyo.Web.Security;
using System;
using System.Collections.Specialized;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Web;

namespace Dismoyo.Ciptoning.Web.Security
{
    public class BasicAuthentication : BasicAuthProvider
    {

        #region Classes

        [Serializable]
        public class AuthResponse
        {

            #region Constructors

            public AuthResponse(Guid accessToken, int userID, string deviceID)
            {
                AccessToken = accessToken;
                UserID = userID;
                DeviceID = deviceID;
            }

            #endregion

            #region Properties

            public Guid AccessToken { get; private set; }
            public int UserID { get; private set; }
            public string DeviceID { get; private set; }

            #endregion

        }

        #endregion

        #region Methods

        public override void Authenticate(HttpContext context)
        {
            // NOTE: Production environment must be required to use SSL secured protocol
            Authenticate(context, false);
        }

        protected override IPrincipal GetPrincipalFromCredentials(string userName, string password)
        {
            var userProvider = DataConfiguration.GetDefaultDataProvider<IvUserDataProvider>();

            var passwordHash = CryptographyUtility.GetSaltedHash(password);
            var user = userProvider.GetDataByName(userName);
            if ((user == null) || (user.Password != passwordHash))
                return null;

            var userPermissionAllDataProvider = DataConfiguration.GetDefaultDataProvider<IvUserPermissionAllDataProvider>();

            user.ChildPermissions = userPermissionAllDataProvider.GetDataByUserID(user.ID);
            return new GenericPrincipal(new BasicGenericIdentity<IvUser>(user.Name, user), new string[] { });
        }

        #endregion

    }

}
