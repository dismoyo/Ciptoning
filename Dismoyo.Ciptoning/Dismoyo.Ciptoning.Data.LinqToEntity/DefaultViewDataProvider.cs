using Dismoyo.Data.LinqToEntity;

namespace Dismoyo.Ciptoning.Data
{

    public partial class DefaultViewDataProvider<T> : ViewDataProvider<T>
        where T : class, new()
    {

        #region Constructors

        public DefaultViewDataProvider()
            : base(DefaultDataContext.DataContext)
        {
        }

        public DefaultViewDataProvider(string lcidField)
            : base(DefaultDataContext.DataContext, lcidField)
        {
        }

        #endregion

        #region Methods

        public override DataContext GetUniqueDataSource()
        {
            return DefaultDataContext.NewDataContext;
        }

        #endregion
              
    }

}
