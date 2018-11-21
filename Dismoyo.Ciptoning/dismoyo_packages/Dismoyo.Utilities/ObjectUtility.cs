using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Dismoyo.Utilities
{

    public static class ObjectUtility
    {

        #region Methods

        public static void SetPropertyValue(object classObject, string propertyName, object value)
        {
            SetPropertyValue(classObject, propertyName, value, false);
        }

        public static void SetPropertyValue(object classObject, string propertyName, object value, bool convertEmptyStringToNull)
        {
            object propertyValue = classObject;
            string[] properties = propertyName.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < properties.Length; i++)
            {
                var item = properties[i];
                if (i >= (properties.Length - 1))
                {
                    PropertyInfo propertyInfo = propertyValue.GetType().GetProperty(item);

                    if ((value != null) && (value.GetType() == typeof(string)))
                    {
                        if (value.GetType() != propertyInfo.PropertyType)
                            value = ConversionUtility.FromString(propertyInfo.PropertyType, (string)value);
                        else if (string.IsNullOrEmpty((string)value) && convertEmptyStringToNull)
                            value = null;
                    }

                    propertyValue.GetType().GetProperty(item).SetValue(propertyValue, value);
                }
                else
                {
                    try
                    {
                        propertyValue = propertyValue.GetType().GetProperty(item).GetValue(propertyValue);
                    }
                    catch (AmbiguousMatchException)
                    {
                        propertyValue = propertyValue.GetType().GetProperties().Where(p => (p.Name == item) &&
                            (p.PropertyType.Namespace.StartsWith("DevExpress.Web.Mvc"))).First().GetValue(propertyValue);
                    }
                }
            }
        }


        public static object GetPropertyValue(object classObject, string propertyName)
        {
            object propertyValue = classObject;
            string[] properties = propertyName.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < properties.Length; i++)
            {
                var item = properties[i];
                if (i >= (properties.Length - 1))
                {
                    PropertyInfo propertyInfo = propertyValue.GetType().GetProperty(item);
                    return propertyValue.GetType().GetProperty(item).GetValue(propertyValue);
                }
                else
                {
                    try
                    {
                        propertyValue = propertyValue.GetType().GetProperty(item).GetValue(propertyValue);
                    }
                    catch (AmbiguousMatchException)
                    {
                        propertyValue = propertyValue.GetType().GetProperties().Where(p => (p.Name == item) &&
                            (p.PropertyType.Namespace.StartsWith("DevExpress.Web.Mvc"))).First().GetValue(propertyValue);
                    }
                }
            }

            return null;
        }
        

        public static object[] GetAttributePropertyValues<TAttribute>(object obj) where TAttribute : Attribute
        {
            var primaryKeys = new List<object>();
            foreach (var propertyInfo in obj.GetType().GetProperties())
            {
                var keyAttr = AttributeUtility.GetCustomAttribute<TAttribute>(propertyInfo);
                if (keyAttr != null)
                    primaryKeys.Add(propertyInfo.GetValue(obj));
            }

            return primaryKeys.ToArray();
        }

        public static void SetAttributePropertyValues<TAttribute>(object obj, params object[] primaryKeys)
            where TAttribute : Attribute
        {
            if (primaryKeys.Length > 0)
            {
                int i = 0;
                foreach (var propertyInfo in obj.GetType().GetProperties())
                {
                    var keyAttr = AttributeUtility.GetCustomAttribute<TAttribute>(propertyInfo);
                    if (keyAttr != null)
                    {
                        propertyInfo.SetValue(obj, primaryKeys[i]);
                        i++;
                    }

                    if (i >= primaryKeys.Length)
                        break;
                }
            }
        }


        public static TTarget CopyPropertyValues<TTarget>(object source) where TTarget : new()
        {
            TTarget target = new TTarget();

            CopyPropertyValues(source, target);
            return target;
        }

        public static void CopyPropertyValues(object source, object target)
        {
            CopyPropertyValues(source, target, null, null);
        }

        public static TTarget CopyPropertyValues<TTarget>(object source, bool? useLocalDateTimeConversion,
            double? timeZoneOffset) where TTarget : new()
        {
            TTarget target = new TTarget();

            CopyPropertyValues(source, target, useLocalDateTimeConversion, timeZoneOffset);
            return target;
        }

        public static void CopyPropertyValues(object source, object target, bool? useLocalDateTimeConversion,
            double? timeZoneOffset)
        {
            if ((source != null) && (target != null))
            {
                foreach (var sourcePropertyInfo in source.GetType().GetProperties())
                {
                    var targetPropertyInfo = target.GetType().GetProperty(sourcePropertyInfo.Name);
                    if (targetPropertyInfo != null)
                    {
                        object sourcePropertyValue = sourcePropertyInfo.GetValue(source);
                        if (sourcePropertyInfo.PropertyType == typeof(DateTime?))
                        {
                            if (useLocalDateTimeConversion.HasValue)                            
                                sourcePropertyValue = (useLocalDateTimeConversion.Value) ?
                                    ConversionUtility.ToLocalNullableDateTime((DateTime?)sourcePropertyValue, timeZoneOffset) :
                                    ConversionUtility.ToUtcNullableDateTime((DateTime?)sourcePropertyValue, timeZoneOffset);
                        }
                        else if (sourcePropertyInfo.PropertyType == typeof(DateTime))
                        {
                            if (useLocalDateTimeConversion.HasValue)
                                sourcePropertyValue = (useLocalDateTimeConversion.Value) ?
                                    ConversionUtility.ToLocalDateTime((DateTime)sourcePropertyValue, timeZoneOffset) :
                                    ConversionUtility.ToUtcDateTime((DateTime)sourcePropertyValue, timeZoneOffset);
                        }

                        targetPropertyInfo.SetValue(target, sourcePropertyValue);
                    }
                }
            }
        }


        public static Type GetPropertyType<TEntity>(string propertyName)
        {
            return GetPropertyType(typeof(TEntity), propertyName);
        }

        public static Type GetPropertyType(Type classType, string propertyName)
        {
            Type propertyType = classType;
            foreach (var item in propertyName.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries))
            {
                PropertyInfo propertyInfo = propertyType.GetProperty(item);                
                propertyType = propertyInfo.PropertyType;
            }

            return propertyType;
        }

        
        public static object InvokePublicMethod(object obj, string methodName, object[] parameters)
        {
            return obj.GetType().GetMethod(methodName, BindingFlags.Public | BindingFlags.Instance).Invoke(obj, parameters);
        }

        public static object InvokePrivateMethod(object obj, string methodName, object[] parameters)
        {
            return obj.GetType().GetMethod(methodName, BindingFlags.NonPublic | BindingFlags.Instance).Invoke(obj, parameters);
        }

        public static object InvokePublicGenericMethod(object obj, string methodName, Type[] genericTypes,
            params object[] parameters)
        {
            return obj.GetType().GetMethod(methodName, BindingFlags.Public).MakeGenericMethod(genericTypes)
                .Invoke(obj, parameters);
        }

        public static object InvokePrivateGenericMethod(object obj, string methodName, Type[] genericTypes,
            params object[] parameters)
        {
            return obj.GetType().GetMethod(methodName, BindingFlags.NonPublic).MakeGenericMethod(genericTypes)
                .Invoke(obj, parameters);
        }

        public static object InvokePublicStaticMethod(Type classType, string methodName, object[] parameters)
        {
            return classType.GetMethod(methodName, BindingFlags.Public | BindingFlags.Static).Invoke(null, parameters);
        }

        public static object InvokePublicStaticGenericMethod(Type classType, string methodName, Type[] genericTypes,
            params object[] parameters)
        {
            return classType.GetMethod(methodName, BindingFlags.Public | BindingFlags.Static)
                .MakeGenericMethod(genericTypes).Invoke(null, parameters);
        }

        public static object InvokePrivateStaticMethod(Type classType, string methodName, object[] parameters)
        {
            return classType.GetMethod(methodName, BindingFlags.NonPublic | BindingFlags.Static).Invoke(null, parameters);
        }

        public static object InvokePrivateStaticGenericMethod(Type classType, string methodName, Type[] genericTypes,
            params object[] parameters)
        {
            return classType.GetMethod(methodName, BindingFlags.NonPublic | BindingFlags.Static)
                .MakeGenericMethod(genericTypes).Invoke(null, parameters);
        }

        public static object InvokeMethod(object obj, string methodName, Type[] types, object[] parameters)
        {
            return obj.GetType().GetMethod(methodName, types).Invoke(obj, parameters);
        }

        public static object InvokeStaticMethod(Type classType, string methodName, Type[] types, object[] parameters)
        {
            return classType.GetMethod(methodName, types).Invoke(null, parameters);
        }

        #endregion
        
    }

}
