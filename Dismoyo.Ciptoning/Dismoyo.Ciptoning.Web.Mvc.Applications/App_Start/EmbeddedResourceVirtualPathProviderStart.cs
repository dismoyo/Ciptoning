using Dismoyo.Ciptoning.Web.Mvc.Applications;
using System.Linq;
using System.Reflection;
using System.Web.Compilation;
using System.Web.Hosting;

[assembly: WebActivatorEx.PostApplicationStartMethod(typeof(EmbeddedResourceVirtualPathProviderStart), "Start")]

namespace Dismoyo.Ciptoning.Web.Mvc.Applications
{

    public static class EmbeddedResourceVirtualPathProviderStart
    {

        #region Methods

        public static void Start()
        {
            //By default, we scan all non system assemblies for embedded resources
            var assemblies = BuildManager.GetReferencedAssemblies().Cast<Assembly>()
                .Where(p => p.GetName().Name.StartsWith("System") == false);
            HostingEnvironment.RegisterVirtualPathProvider(
                new EmbeddedResourceVirtualPathProvider.Vpp(assemblies.ToArray())
                {
                    //you can do a specific assembly registration too. If you provide the assembly source path, it can read
                    //from the source file so you can change the content while the app is running without needing to rebuild
                    //{typeof(SomeAssembly.SomeClass).Assembly, @"..\SomeAssembly"} 
                });
        }

        #endregion

    }

}