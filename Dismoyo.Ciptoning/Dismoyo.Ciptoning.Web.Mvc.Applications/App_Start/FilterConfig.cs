using System.Web.Mvc;

namespace Dismoyo.Ciptoning.Web.Mvc.Applications
{

    public class FilterConfig
    {

        #region Methods

        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        #endregion

    }

}
