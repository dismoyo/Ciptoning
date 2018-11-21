using System.Dynamic;
using System.Web.Mvc;

namespace ISID.Web.Mvc
{

    public class DynamicViewData<TModel> : DynamicObject
    {

        #region Fields

        private readonly ViewDataDictionary<TModel> viewData;

        #endregion

        #region Constructors

        public DynamicViewData(ViewDataDictionary<TModel> viewData)
        {
            this.viewData = viewData;
        }

        #endregion

        #region Methods

        public override bool TryGetMember(GetMemberBinder binder, out dynamic result)
        {
            result = viewData.ContainsKey(binder.Name) ? viewData[binder.Name] : null;

            return true;
        }

        public override bool TrySetMember(SetMemberBinder binder, dynamic value)
        {
            if (value == null)
            {
                if (viewData.ContainsKey(binder.Name))
                    viewData.Remove(binder.Name);
            }
            else
                viewData[binder.Name] = value;

            return true;
        }

        #endregion

    }

}
