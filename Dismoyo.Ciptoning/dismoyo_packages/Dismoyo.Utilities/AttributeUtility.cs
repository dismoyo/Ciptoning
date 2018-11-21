using System;
using System.Reflection;

namespace Dismoyo.Utilities
{
    
    public class AttributeUtility
    {

        #region Methods

        public static TAttribute GetCustomAttribute<TAttribute>(Type type) where TAttribute : Attribute
        {
            return (TAttribute)type.GetCustomAttribute(typeof(TAttribute));
        }

        public static TAttribute GetCustomAttribute<TAttribute>(PropertyInfo propertyInfo) where TAttribute : Attribute
        {
            return (TAttribute)propertyInfo.GetCustomAttribute(typeof(TAttribute));
        }

        #endregion
        
    }

}
