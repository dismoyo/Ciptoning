using System;
using System.Resources;

namespace Dismoyo.Utilities
{
    
    public static class ResourceUtility
    {

        #region Methods
        
        public static string GetRuntimeFormattedString(object resourceRuntimeType, string formatkey,
            params string[] paramKeys)
        {
            Type resourceType = ConvertToType(resourceRuntimeType);
            return GetFormattedString(resourceType, formatkey, resourceType, paramKeys);
        }

        public static string GetRuntimeFormattedString(object formatResourceRuntimeType, string formatkey,
            object paramResourceRuntimeType, params string[] paramKeys)
        {
            Type formatResourceType = ConvertToType(formatResourceRuntimeType);
            Type paramResourceType = ConvertToType(paramResourceRuntimeType);
            return GetFormattedString(formatResourceType, formatkey, paramResourceType, paramKeys);
        }

        public static string GetFormattedString(Type resourceType, string formatkey, params string[] paramKeys)
        {
            return GetFormattedString(resourceType, formatkey, resourceType, paramKeys);
        }

        public static string GetFormattedString(Type formatResourceType, string formatkey,
            Type paramResourceType, params string[] paramKeys)
        {
            var formatResourceManager = new ResourceManager(formatResourceType);
            var paramResourceManager = new ResourceManager(paramResourceType);
            
            string[] paramValues = new string[paramKeys.Length];
            for (int i = 0; i < paramValues.Length; i++)
                paramValues[i] = paramResourceManager.GetString(paramKeys[i]);

            return string.Format(formatResourceManager.GetString(formatkey), paramValues); 
        }


        private static Type ConvertToType(object runtimeType)
        {
            return (Type)runtimeType.GetType().GetProperty("UnderlyingSystemType").GetValue(runtimeType, null);
        }

        #endregion
        
    }

}
