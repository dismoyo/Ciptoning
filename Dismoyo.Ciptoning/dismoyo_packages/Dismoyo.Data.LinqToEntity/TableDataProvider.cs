using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Linq.Expressions;
using Dismoyo.Utilities;
using System.Data.Entity;

namespace Dismoyo.Data.LinqToEntity
{

    public class TableDataProvider<TEntity> : BaseDataProvider<TEntity>
        where TEntity : class, new()
    {

        #region Constructors

        public TableDataProvider(DataContext dataContext)
            : base(dataContext)
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

                    DataContext.Set<TEntity>().Add(obj);
                    DataContext.SaveChanges();
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

                    DataContext.SaveChanges();
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

                    DataContext.Set<TEntity>().Remove(obj);
                    DataContext.SaveChanges();
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

        #endregion

    }

}
