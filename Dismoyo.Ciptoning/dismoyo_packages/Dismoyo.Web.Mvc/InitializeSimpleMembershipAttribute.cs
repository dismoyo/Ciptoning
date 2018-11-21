using System;
using System.Threading;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace ISID.Web.Mvc
{

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
    public sealed class InitializeSimpleMembershipAttribute : ActionFilterAttribute
    {

        #region Classes

        private class SimpleMembershipInitializer
        {

            public SimpleMembershipInitializer()
            {
                //Database.SetInitializer<BaseDataContext>(null);

                try
                {
                    //using (var context = new BaseDataContext())
                    //{
                    //    if (!context.DatabaseExists())
                    //    {
                    //        // Create the SimpleMembership database without Entity Framework migration schema
                    //        ((IObjectContextAdapter)context).ObjectContext.CreateDatabase();
                    //    }
                    //}

                    WebSecurity.InitializeDatabaseConnection("DefaultDB", "User", "ID", "Name", autoCreateTables: true);
                }
                catch (Exception ex)
                {
                    throw new InvalidOperationException("The ASP.NET Simple Membership database could not be initialized. For more information, please see http://go.microsoft.com/fwlink/?LinkId=256588", ex);
                }
            }

        }

        #endregion

        #region Fields

        private static SimpleMembershipInitializer _initializer;
        private static object _initializerLock = new object();
        private static bool _isInitialized;

        #endregion

        #region Methods

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // Ensure ASP.NET Simple Membership is initialized only once per app start.
            LazyInitializer.EnsureInitialized(ref _initializer, ref _isInitialized, ref _initializerLock);
        }

        #endregion

    }

}
