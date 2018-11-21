using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Dismoyo.Ciptoning.Data
{

    public static class DataConfiguration
    {

        #region Default

        private static List<Assembly> defaultDataAccessAssemblies = new List<Assembly>();
        

        public static string DefaultConnectionStringName { get; set; }
        
        public static string[] DefaultDataAccessAssemblyFileNames { get; set; }
        
        public static Assembly[] DefaultDataAccessAssemblies
        {
            get { return defaultDataAccessAssemblies.ToArray(); }
        }

        public static string DefaultDataContextCommandTimeoutName { get; set; }


        public static void LoadDefaultDataAccessAssemblies()
        {
            Assembly execAssembly = Assembly.GetExecutingAssembly();
            defaultDataAccessAssemblies.Clear();
            foreach (var item in DefaultDataAccessAssemblyFileNames)
                defaultDataAccessAssemblies.Add(
                    Assembly.LoadFrom(execAssembly.CodeBase.ToLower().Replace(execAssembly.ManifestModule.Name.ToLower(),
                    item.ToLower())));
        }

        public static TIDataProvider GetDefaultDataProvider<TIDataProvider>()
        {
            Type type = typeof(TIDataProvider);
            if (!type.IsInterface)
                throw new NotSupportedException(string.Format("The type '{0}' is not an interface. " +
                    "Only interface generic parameter is supported.", type.Name));

            // The required pattern for naming convention is prefix with 'I' for interface,
            // and without prefix for implemented class.
            // Example: Interface of User is 'IUserDataProvider', and implemented class is 'UserDataProvider'.
            string typeName = type.Name;
            if (typeName.StartsWith("I", StringComparison.Ordinal))
                typeName = typeName.Substring(1);

            foreach (var assembly in defaultDataAccessAssemblies)
            {
                Type exportedType = assembly.ExportedTypes.Where(p => (p.Name == typeName)).SingleOrDefault();
                if (exportedType != null)
                    return (TIDataProvider)Activator.CreateInstance(exportedType);
            }

            throw new EntryPointNotFoundException(string.Format("The type '{0}' could not be found.", typeName));
        }

        #endregion

    }

}
