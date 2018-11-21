using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace ISID.Web.Mvc
{

    public class BaseModelMetadataProvider : DataAnnotationsModelMetadataProvider
    {

        #region Methods

        protected override ModelMetadata CreateMetadata(IEnumerable<Attribute> attributes, Type containerType,
            Func<object> modelAccessor, Type modelType, string propertyName)
        {
            var modelMetadata = base.CreateMetadata(attributes, containerType, modelAccessor, modelType, propertyName);
            
            foreach (var item in attributes)
            {
                var key = item.GetType().FullName;
                if (modelMetadata.AdditionalValues.ContainsKey(key))
                {
                    if (modelMetadata.AdditionalValues.ContainsValue(item))
                        continue;

                    key = string.Format("{0}.{1}", key, modelMetadata.AdditionalValues
                        .Count(p => (p.Key == key) || (p.Key.StartsWith(key + "."))));
                }

                modelMetadata.AdditionalValues.Add(key, item);
            }

            return modelMetadata;
        }

        #endregion
        
    }

}
