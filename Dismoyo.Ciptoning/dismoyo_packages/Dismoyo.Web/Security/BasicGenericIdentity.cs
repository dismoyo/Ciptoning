using System.Security.Principal;

namespace Dismoyo.Web.Security
{
    public class BasicGenericIdentity<T> : GenericIdentity
    {

        #region Constructors

        public BasicGenericIdentity(string name, T userData) :
            base(name) 
        {
            UserData = userData;
        }

        #endregion

        #region Properties

        public T UserData { get; private set; }

        #endregion

    }

}
