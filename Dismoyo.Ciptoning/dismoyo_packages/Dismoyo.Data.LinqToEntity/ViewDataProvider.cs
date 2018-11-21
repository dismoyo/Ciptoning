using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using Dismoyo.Utilities;

namespace Dismoyo.Data.LinqToEntity
{

    public class ViewDataProvider<TEntity> : BaseDataProvider<TEntity>
        where TEntity : class, new()
    {

        #region Constructors

        public ViewDataProvider(DataContext dataContext)
            : base(dataContext)
        {
        }

        public ViewDataProvider(DataContext dataContext, string lcidField)
            : base(dataContext, lcidField)
        {
        }

        #endregion

        #region Methods

        public override IQueryable<TEntity> GetData()
        {
            IQueryable<TEntity> query = (from obj in DataContext.Set<TEntity>() select obj);
            //foreach (var item in ExpressionUtility.GetAttributePropertyExpressions<KeyAttribute, TEntity>())
            //    query = (IQueryable<TEntity>)LinqUtility.OrderBy(query, item);

            return query;
        }

        public override TEntity GetData(params object[] primaryKeys)
        {
            return GetData().SingleOrDefault((Expression<Func<TEntity, bool>>)(
                ExpressionUtility.CreateAttributePropertyExpression<KeyAttribute>(
                typeof(TEntity), primaryKeys)));
        }

        public override void InsertData(TEntity obj)
        {
            InsertData(obj, false);
        }

        public override void InsertData(TEntity obj, bool useTransaction)
        {
            var copyObj = (useTransaction) ? obj : ObjectUtility.CopyPropertyValues<TEntity>(obj);

            var beginOperationDataEventArgs = new BeginOperationDataEventArgs<TEntity>(copyObj);

            OnBeginInsertData(beginOperationDataEventArgs);
            if (!beginOperationDataEventArgs.Cancel)
            {
                Exception exception = null;

                try
                {
                    if (!useTransaction)
                        ObjectUtility.CopyPropertyValues(copyObj, obj);

                    var entry = DataContext.Entry<TEntity>(obj);
                    if (entry.State == EntityState.Added)
                        entry.State = EntityState.Detached;

                    if (!useTransaction)
                        OnInsertData(copyObj);
                    else
                        OnInsertData(copyObj, useTransaction);

                    RefreshEntity();
                }
                catch (Exception ex)
                {
                    exception = ex;
                    if (!SuppressError)
                        throw ex;
                }

                OnEndInsertData(new EndOperationDataEventArgs<TEntity>(copyObj, exception));
            }
        }

        public override void UpdateData(TEntity obj)
        {
            UpdateData(obj, false);
        }

        public override void UpdateData(TEntity obj, bool useTransaction)
        {
            var copyObj = (useTransaction) ? obj : ObjectUtility.CopyPropertyValues<TEntity>(obj);

            var beginOperationDataEventArgs = new BeginOperationDataEventArgs<TEntity>(copyObj);

            OnBeginUpdateData(beginOperationDataEventArgs);
            if (!beginOperationDataEventArgs.Cancel)
            {
                Exception exception = null;

                try
                {
                    if (!useTransaction)
                        ObjectUtility.CopyPropertyValues(copyObj, obj);

                    var entry = DataContext.Entry<TEntity>(obj);
                    if (entry.State == EntityState.Deleted)
                        entry.Reload();

                    if (!useTransaction)
                        OnUpdateData(copyObj);
                    else
                        OnUpdateData(copyObj, useTransaction);

                    RefreshEntity();
                }
                catch (Exception ex)
                {
                    exception = ex;
                    if (!SuppressError)
                        throw ex;
                }

                OnEndUpdateData(new EndOperationDataEventArgs<TEntity>(copyObj, exception));
            }
        }

        public override void DeleteData(TEntity obj)
        {
            DeleteData(obj, false);
        }

        public override void DeleteData(TEntity obj, bool useTransaction)
        {
            var copyObj = (useTransaction) ? obj : ObjectUtility.CopyPropertyValues<TEntity>(obj);

            var beginOperationDataEventArgs = new BeginOperationDataEventArgs<TEntity>(copyObj);

            OnBeginDeleteData(beginOperationDataEventArgs);
            if (!beginOperationDataEventArgs.Cancel)
            {
                Exception exception = null;

                try
                {
                    if (!useTransaction)
                        ObjectUtility.CopyPropertyValues(copyObj, obj);

                    var entry = DataContext.Entry<TEntity>(obj);
                    if (entry.State == EntityState.Modified)
                        entry.State = EntityState.Unchanged;

                    if (!useTransaction)
                        OnDeleteData(copyObj);
                    else
                        OnDeleteData(copyObj, useTransaction);

                    RefreshEntity();
                }
                catch (Exception ex)
                {
                    exception = ex;
                    if (!SuppressError)
                        throw ex;
                }

                OnEndDeleteData(new EndOperationDataEventArgs<TEntity>(copyObj, exception));
            }
        }


        protected virtual void OnInsertData(TEntity obj)
        {
            OnInsertData(obj, false);
        }

        protected virtual void OnInsertData(TEntity obj, bool useTransaction)
        {
            throw new NotImplementedException();
        }

        protected virtual void OnUpdateData(TEntity obj)
        {
            OnUpdateData(obj, false);
        }

        protected virtual void OnUpdateData(TEntity obj, bool useTransaction)
        {
            throw new NotImplementedException();
        }

        protected virtual void OnDeleteData(TEntity obj)
        {
            OnDeleteData(obj, false);
        }

        protected virtual void OnDeleteData(TEntity obj, bool useTransaction)
        {
            throw new NotImplementedException();
        }

        #endregion

    }

}
