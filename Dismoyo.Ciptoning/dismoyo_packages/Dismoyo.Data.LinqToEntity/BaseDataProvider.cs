using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Data.LinqToEntity
{

    public abstract class BaseDataProvider<TEntity> : IDataProvider<TEntity>
        where TEntity : class, new()
    {

        #region Fields

        private DataContext dataContext;

        #endregion

        #region Constructors

        public BaseDataProvider(DataContext dataContext)
            : this(dataContext, "")
        {
        }

        public BaseDataProvider(DataContext dataContext, string lcidField)
        {
            UseUniqueDataSource = false;
            SuppressError = false;

            this.dataContext = dataContext;
        }

        #endregion

        #region Properties

        public DataContext DataContext
        {
            get
            {
                if (UseUniqueDataSource)
                    dataContext = GetUniqueDataSource();

                return dataContext;
            }
            protected set
            {
                dataContext = value;
            }
        }

        #endregion

        #region Methods

        public virtual DataContext GetUniqueDataSource()
        {
            throw new NotImplementedException();
        }



        protected virtual void OnBeginInsertData(BeginOperationDataEventArgs<TEntity> e)
        {
            if (BeginInsertData != null)
                BeginInsertData(this, e);
        }

        protected virtual void OnBeginUpdateData(BeginOperationDataEventArgs<TEntity> e)
        {
            if (BeginUpdateData != null)
                BeginUpdateData(this, e);
        }

        protected virtual void OnBeginDeleteData(BeginOperationDataEventArgs<TEntity> e)
        {
            if (BeginDeleteData != null)
                BeginDeleteData(this, e);
        }

        protected virtual void OnEndInsertData(EndOperationDataEventArgs<TEntity> e)
        {
            if (EndInsertData != null)
                EndInsertData(this, e);
        }

        protected virtual void OnEndUpdateData(EndOperationDataEventArgs<TEntity> e)
        {
            if (EndUpdateData != null)
                EndUpdateData(this, e);
        }

        protected virtual void OnEndDeleteData(EndOperationDataEventArgs<TEntity> e)
        {
            if (EndDeleteData != null)
                EndDeleteData(this, e);
        }


        protected virtual void RefreshEntity()
        {
            var context = ((IObjectContextAdapter)DataContext).ObjectContext;
            var refreshableObjects = DataContext.ChangeTracker.Entries<TEntity>().Select(c => c.Entity).ToList();
            context.Refresh(RefreshMode.StoreWins, refreshableObjects);
        }

        #endregion


        #region Implements IDataProvider

        public bool UseUniqueDataSource { get; set; }
        public bool SuppressError { get; set; }
        
        public abstract IQueryable<TEntity> GetData();
        public abstract TEntity GetData(params object[] primaryKeys);
        public abstract void InsertData(TEntity obj);
        public abstract void InsertData(TEntity obj, bool useTransaction);
        public abstract void UpdateData(TEntity obj);
        public abstract void UpdateData(TEntity obj, bool useTransaction);
        public abstract void DeleteData(TEntity obj);
        public abstract void DeleteData(TEntity obj, bool useTransaction);

        public event EventHandler<BeginOperationDataEventArgs<TEntity>> BeginInsertData;
        public event EventHandler<BeginOperationDataEventArgs<TEntity>> BeginUpdateData;
        public event EventHandler<BeginOperationDataEventArgs<TEntity>> BeginDeleteData;
        public event EventHandler<EndOperationDataEventArgs<TEntity>> EndInsertData;
        public event EventHandler<EndOperationDataEventArgs<TEntity>> EndUpdateData;
        public event EventHandler<EndOperationDataEventArgs<TEntity>> EndDeleteData;

        #endregion

    }

}
