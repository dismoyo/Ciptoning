using Dismoyo.Data.LinqToEntity;

namespace Dismoyo.Ciptoning.Data
{

    public partial class DefaultTableDataProvider<T> : TableDataProvider<T>
        where T : class, new()
    {

        #region Constructors

        public DefaultTableDataProvider()
            : base(DefaultDataContext.DataContext)
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
