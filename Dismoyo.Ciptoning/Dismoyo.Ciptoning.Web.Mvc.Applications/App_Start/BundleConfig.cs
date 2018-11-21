using System.Web.Optimization;

namespace Dismoyo.Ciptoning.Web.Mvc.Applications
{

    public class BundleConfig
    {

        #region Methods

        public static void RegisterBundles(BundleCollection bundles)
        {
            var scriptBundle = new ScriptBundle("~/Scripts/bundle");
            var styleBundle = new StyleBundle("~/Content/bundle");

            // jQuery
            scriptBundle
                .Include("~/Scripts/jquery-3.3.1.js");

            // Bootstrap
            scriptBundle
                .Include("~/Scripts/bootstrap.js");

            // Bootstrap
            styleBundle
                .Include("~/Content/bootstrap.css");

            // Custom site styles
            styleBundle
                .Include("~/Content/Site.css");

            bundles.Add(scriptBundle);
            bundles.Add(styleBundle);

#if !DEBUG
            BundleTable.EnableOptimizations = true;
#endif
        }

        #endregion

    }

}
