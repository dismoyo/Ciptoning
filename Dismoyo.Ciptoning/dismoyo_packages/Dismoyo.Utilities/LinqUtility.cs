using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace Dismoyo.Utilities
{
    
    public static class LinqUtility
    {

        #region Methods

        public static IQueryable Where(IQueryable source, Expression predicate)
        {
            return (IQueryable)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalWhere",
                new Type[] { predicate.Type.GenericTypeArguments[0] },
                new object[] { source, predicate });
        }

        public static IQueryable OrderBy(IQueryable source, Expression keySelector)
        {
            return (IQueryable)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalOrderBy",
                new Type[] { keySelector.Type.GenericTypeArguments[0], keySelector.Type.GenericTypeArguments[1] },
                new object[] { source, keySelector });
        }

        public static IQueryable Distinct(IQueryable source, Type entityType)
        {
            return (IQueryable)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalDistinct",
                new Type[] { entityType },
                new object[] { source });
        }

        public static object Sum(IQueryable source, Expression selector)
        {
            return ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalSum",
                new Type[] { selector.Type.GenericTypeArguments[0] },
                new object[] { source, selector });
        }

        public static object Max(IQueryable source, Expression selector)
        {
            return ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalMax",
                new Type[] { selector.Type.GenericTypeArguments[0], selector.Type.GenericTypeArguments[1] },
                new object[] { source, selector });
        }

        public static object Min(IQueryable source, Expression selector)
        {
            return ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalMin",
                new Type[] { selector.Type.GenericTypeArguments[0], selector.Type.GenericTypeArguments[1] },
                new object[] { source, selector });
        }

        public static object Average(IQueryable source, Expression selector)
        {
            return ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalAverage",
                new Type[] { selector.Type.GenericTypeArguments[0] },
                new object[] { source, selector });
        }

        public static IQueryable Select(IQueryable source, Expression selector)
        {
            return (IQueryable)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalSelect",
                new Type[] { selector.Type.GenericTypeArguments[0], selector.Type.GenericTypeArguments[1] },
                new object[] { source, selector });
        }


        public static IEnumerable Where(IEnumerable source, Expression predicate)
        {
            return (IEnumerable)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalEnumerableWhere",
                new Type[] { source.GetType().GenericTypeArguments[0] },
                new object[] { source, predicate });
        }

        public static object SingleOrDefault(IEnumerable source, Expression predicate)
        {
            var compile = ExpressionUtility.Compile(predicate);
            return ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalEnumerableSingleOrDefault",
                new Type[] { source.GetType().GenericTypeArguments[0] },
                new object[] { source, compile });
        }

        public static int FindIndex(IEnumerable source, Expression predicate)
        {
            var compile = ExpressionUtility.Compile(predicate);
            return (int)ObjectUtility.InvokePrivateStaticGenericMethod(
                typeof(LinqUtility), "InternalEnumerableFindIndex",
                new Type[] { source.GetType().GenericTypeArguments[0] },
                new object[] { source, compile });
        }



        private static IQueryable<TSource> InternalWhere<TSource>(IQueryable<TSource> source,
            Expression<Func<TSource, bool>> predicate)
        {
            return source.Where(predicate);
        }

        private static IQueryable<TSource> InternalOrderBy<TSource, TKey>(IQueryable<TSource> source,
            Expression<Func<TSource, TKey>> keySelector)
        {
            return source.OrderBy(keySelector);
        }

        private static IQueryable<TSource> InternalDistinct<TSource>(IQueryable<TSource> source)
        {
            return source.Distinct();
        }

        private static object InternalSum<TSource>(IQueryable<TSource> source, Expression selector)
        {
            Type type = selector.Type.GenericTypeArguments[1];
            if (type.Equals(typeof(int)))
                return source.Sum((Expression<Func<TSource, int>>)selector);
            else if (type.Equals(typeof(int?)))
                return source.Sum((Expression<Func<TSource, int?>>)selector);
            if (type.Equals(typeof(long)))
                return source.Sum((Expression<Func<TSource, long>>)selector);
            else if (type.Equals(typeof(long?)))
                return source.Sum((Expression<Func<TSource, long?>>)selector);
            if (type.Equals(typeof(float)))
                return source.Sum((Expression<Func<TSource, float>>)selector);
            else if (type.Equals(typeof(float?)))
                return source.Sum((Expression<Func<TSource, float?>>)selector);
            if (type.Equals(typeof(double)))
                return source.Sum((Expression<Func<TSource, double>>)selector);
            else if (type.Equals(typeof(double?)))
                return source.Sum((Expression<Func<TSource, double?>>)selector);
            if (type.Equals(typeof(decimal)))
                return source.Sum((Expression<Func<TSource, decimal>>)selector);
            else if (type.Equals(typeof(decimal?)))
                return source.Sum((Expression<Func<TSource, decimal?>>)selector);

            return null;
        }

        private static TKey InternalMax<TSource, TKey>(IQueryable<TSource> source,
            Expression<Func<TSource, TKey>> selector)
        {
            return source.Max(selector);
        }

        private static TKey InternalMin<TSource, TKey>(IQueryable<TSource> source,
            Expression<Func<TSource, TKey>> selector)
        {
            return source.Min(selector);
        }

        private static object InternalAverage<TSource>(IQueryable<TSource> source, Expression selector)
        {
            Type type = selector.Type.GenericTypeArguments[1];
            if (type.Equals(typeof(int)))
                return source.Average((Expression<Func<TSource, int>>)selector);
            else if (type.Equals(typeof(int?)))
                return source.Average((Expression<Func<TSource, int?>>)selector);
            if (type.Equals(typeof(long)))
                return source.Average((Expression<Func<TSource, long>>)selector);
            else if (type.Equals(typeof(long?)))
                return source.Average((Expression<Func<TSource, long?>>)selector);
            if (type.Equals(typeof(float)))
                return source.Average((Expression<Func<TSource, float>>)selector);
            else if (type.Equals(typeof(float?)))
                return source.Average((Expression<Func<TSource, float?>>)selector);
            if (type.Equals(typeof(double)))
                return source.Average((Expression<Func<TSource, double>>)selector);
            else if (type.Equals(typeof(double?)))
                return source.Average((Expression<Func<TSource, double?>>)selector);
            if (type.Equals(typeof(decimal)))
                return source.Average((Expression<Func<TSource, decimal>>)selector);
            else if (type.Equals(typeof(decimal?)))
                return source.Average((Expression<Func<TSource, decimal?>>)selector);

            return null;
        }

        private static IQueryable<TResult> InternalSelect<TSource, TResult>(IQueryable<TSource> source, Expression selector)
        {
            return source.Select((Expression<Func<TSource, TResult>>)selector);
        }


        private static IEnumerable<TSource> InternalEnumerableWhere<TSource>(IEnumerable<TSource> source,
            Func<TSource, bool> predicate)
        {            
            return source.Where(predicate);
        }

        private static TSource InternalEnumerableSingleOrDefault<TSource>(IEnumerable<TSource> source,
            Func<TSource, bool> predicate)
        {
            return source.SingleOrDefault(predicate);
        }

        private static int InternalEnumerableFindIndex<TSource>(IEnumerable<TSource> source,
            Func<TSource, bool> predicate)
        {
            return source.ToList().FindIndex(new Predicate<TSource>(predicate));
        }
                                
        #endregion
        
    }

}
