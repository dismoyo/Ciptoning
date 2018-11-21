using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;

namespace Dismoyo.Utilities
{

    public static class ExpressionUtility
    {

        #region Methods

        public static Expression<Func<TClass, TProperty>> CreatePropertyExpression<TClass, TProperty>(string propertyName)
        {
            return InternalCreatePropertyExpression<TClass, TProperty>(propertyName);
        }

        public static Expression CreatePropertyExpression<TClass>(string propertyName)
        {
            return CreatePropertyExpression(typeof(TClass), propertyName);
        }

        public static Expression CreatePropertyExpression<TClass>(Type propertyType, string propertyName)
        {
            return CreatePropertyExpression(typeof(TClass), propertyType, propertyName);
        }

        public static Expression CreatePropertyExpression(Type classType, string propertyName)
        {
            Type propertyType = ObjectUtility.GetPropertyType(classType, propertyName);

            return CreatePropertyExpression(classType, propertyType, propertyName);
        }

        public static Expression CreatePropertyExpression(Type classType, Type propertyType, string propertyName)
        {
            return (Expression)ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCreatePropertyExpression", new Type[] { classType, propertyType }, new object[] { propertyName });
        }


        public static Expression<Func<TClass, TProperty>> CreateChildPropertyExpression<TClass, TParentProperty, TProperty>(
            Expression<Func<TClass, TParentProperty>> parentExpression, string propertyName)
        {
            return InternalCreateChildPropertyExpression<TClass, TParentProperty, TProperty>(parentExpression, propertyName);
        }

        public static Expression CreateChildPropertyExpression<TClass, TParentProperty>(
            Expression<Func<TClass, TParentProperty>> parentExpression, Type propertyType, string propertyName)
        {
            return CreateChildPropertyExpression(typeof(TClass), typeof(TParentProperty), parentExpression, propertyType, propertyName);
        }

        public static Expression CreateChildPropertyExpression<TClass>(Expression parentExpression,
            Type parentPropertyType, Type propertyType, string propertyName)
        {
            return CreateChildPropertyExpression(typeof(TClass), parentPropertyType, parentExpression, propertyType, propertyName);
        }
                
        public static Expression CreateChildPropertyExpression(Type classType, Type parentPropertyType,
            Expression parentExpression, Type propertyType, string propertyName)
        {
            return (Expression)ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCreateChildPropertyExpression", new Type[] { classType, parentPropertyType, propertyType },
                new object[] { parentExpression, propertyName });
        }



        public static Expression<Func<TClass, bool>> CreateExpression<TClass>(Expression expression,
            ParameterExpression param)
        {
            return InternalCreateExpression<TClass>(expression, param);
        }

        public static Expression CreateExpression(Type classType, Expression expression, ParameterExpression param)
        {
            return (Expression)ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCreateExpression", new Type[] { classType }, new object[] { expression, param });
        }


        public static Expression<Func<TClass, bool>> CreateBinaryExpression<TClass>(string propertyName,
            object propertyValue, Type propertyType, ExpressionType expressionType)
        {
            return InternalCreateBinaryExpression<TClass>(propertyName, propertyValue, propertyType, expressionType);
        }

        public static BinaryExpression CreateBinaryExpression(Type classType, string propertyName,
            object propertyValue, ExpressionType expressionType)
        {
            return CreateBinaryExpression(classType, propertyName, propertyValue, expressionType);
        }

        public static Expression CreateBinaryExpression(Type classType, string propertyName,
            object propertyValue, Type propertyType, ExpressionType expressionType)
        {
            return (Expression)ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCreateBinaryExpression", new Type[] { classType },
                new object[] { propertyName, propertyValue, propertyType, expressionType });
        }


        public static BinaryExpression CreateBinaryMemberExpression(ParameterExpression param, string propertyName,
            object propertyValue, ExpressionType expressionType)
        {
            return CreateBinaryMemberExpression(param, propertyName, propertyValue, propertyValue.GetType(), expressionType);
        }

        public static BinaryExpression CreateBinaryMemberExpression(ParameterExpression param, string propertyName,
            object propertyValue, Type propertyType, ExpressionType expressionType)
        {
            return (BinaryExpression)ObjectUtility.InvokePrivateStaticMethod(typeof(ExpressionUtility),
                "InternalCreateBinaryMemberExpression",
                new object[] { param, propertyName, propertyValue, propertyType, expressionType });
        }



        public static Expression<Func<TClass, bool>> CreateMethodCallExpression<TClass>(string propertyName,
            Type propertyType, string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            return InternalCreateMethodCallExpression<TClass>(propertyName, propertyType, methodName, methodParamTypes, methodParamValues);
        }

        public static MethodCallExpression CreateMethodCallExpression(Type classType, string propertyName,
            string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            return CreateMethodCallExpression(classType, propertyName, methodName, methodParamTypes, methodParamValues);
        }

        public static Expression CreateMethodCallExpression(Type classType, string propertyName,
            Type propertyType, string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            return (Expression)ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCreateMethodCallExpression", new Type[] { classType },
                new object[] { propertyName, propertyType, methodName, methodParamTypes, methodParamValues });
        }


        public static MethodCallExpression CreateMethodCallMemberExpression(ParameterExpression param, string propertyName,
            Type propertyType, string methodName, object[] methodParamValues)
        {
            var methodParamTypes = new Type[methodParamValues.Length];
            for (int i = 0; i < methodParamTypes.Length; i++)
                methodParamTypes[i] = methodParamValues.GetType();
                
            return CreateMethodCallMemberExpression(param, propertyName, propertyType, methodName, methodParamTypes, methodParamValues);
        }

        public static MethodCallExpression CreateMethodCallMemberExpression(ParameterExpression param, string propertyName,
            Type propertyType, string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            return (MethodCallExpression)ObjectUtility.InvokePrivateStaticMethod(typeof(ExpressionUtility),
                "InternalCreateMethodCallMemberExpression",
                new object[] { param, propertyName, propertyType, methodName, methodParamTypes, methodParamValues });
        }



        public static object Compile(Expression expression)
        {
            return ObjectUtility.InvokePrivateStaticGenericMethod(typeof(ExpressionUtility),
                "InternalCompile",
                new Type[] { expression.Type },
                new object[] { expression });
        }


        public static Expression CreateAttributePropertyExpression<TAttribute>(Type classType, params object[] propertyValues)
            where TAttribute : Attribute
        {
            Expression expression = null;
            var param = Expression.Parameter(classType);
            int i = 0;
            foreach (var propertyInfo in classType.GetProperties())
            {
                var keyAttr = AttributeUtility.GetCustomAttribute<TAttribute>(propertyInfo);
                if (keyAttr != null)
                {
                    var binaryMemberExpr = CreateBinaryMemberExpression(param, propertyInfo.Name,
                        propertyValues[i], propertyInfo.PropertyType, ExpressionType.Equal);
                    expression = (expression == null) ? (Expression)binaryMemberExpr : BinaryExpression.MakeBinary(
                        ExpressionType.And, expression, (Expression)binaryMemberExpr);

                    i++;
                    if (i >= propertyValues.Length)
                        break;
                }
            }

            return CreateExpression(classType, expression, param);
        }
        
        public static Expression[] GetAttributePropertyExpressions<TAttribute, TClass>()
            where TAttribute : Attribute
        {
            var list = new List<Expression>();

            Type classType = typeof(TClass);
            var param = Expression.Parameter(classType);
            foreach (var propertyInfo in classType.GetProperties())
            {
                var keyAttr = AttributeUtility.GetCustomAttribute<TAttribute>(propertyInfo);
                if (keyAttr != null)
                    list.Add(Expression.Lambda(Expression.PropertyOrField((Expression)param, propertyInfo.Name), param));
            }

            return list.ToArray();
        }


        public static MemberExpression GetMemberExpression(Expression param, string propertyName)
        {
            return GetMemberExpression(param, null, propertyName);
        }

        public static MemberExpression GetMemberExpression(Expression param, MemberExpression member, string propertyName)
        {
            foreach (var item in propertyName.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries))
                member = Expression.PropertyOrField((member) ?? (Expression)param, item);
            return member;
        }
                


        private static Expression<Func<TClass, TProperty>> InternalCreatePropertyExpression<TClass, TProperty>(
            string propertyName)
        {
            var param = Expression.Parameter(typeof(TClass));
            MemberExpression member = GetMemberExpression(param, propertyName);

            return Expression.Lambda<Func<TClass, TProperty>>((member) ?? (Expression)param, param);
        }

        private static Expression<Func<TClass, TProperty>>
            InternalCreateChildPropertyExpression<TClass, TParentProperty, TProperty>(
            Expression<Func<TClass, TParentProperty>> parentExpression, string propertyName)
        {
            var param = parentExpression.Parameters[0];
            MemberExpression member = GetMemberExpression(param, (MemberExpression)((param == parentExpression.Body) ? null :
                parentExpression.Body), propertyName);

            return Expression.Lambda<Func<TClass, TProperty>>((member) ?? (Expression)param, param);
        }


        private static Expression<Func<TClass, bool>> InternalCreateExpression<TClass>(Expression expression,
            ParameterExpression param)
        {
            return Expression.Lambda<Func<TClass, bool>>(expression, param);
        }

        private static Expression<Func<TClass, bool>> InternalCreateBinaryExpression<TClass>(string propertyName,
            object propertyValue, Type propertyType, ExpressionType expressionType)
        {
            var param = Expression.Parameter(typeof(TClass));
            return Expression.Lambda<Func<TClass, bool>>(InternalCreateBinaryMemberExpression(param, propertyName,
                propertyValue, propertyType, expressionType), param);
        }
                
        private static BinaryExpression InternalCreateBinaryMemberExpression(ParameterExpression param, string propertyName,
            object propertyValue, Type propertyType, ExpressionType expressionType)
        {
            MemberExpression member = GetMemberExpression(param, propertyName);

            ConstantExpression value = Expression.Constant(propertyValue, propertyType);

            return BinaryExpression.MakeBinary(expressionType, ((member) ?? (Expression)param), value);
        }


        private static Expression<Func<TClass, bool>> InternalCreateMethodCallExpression<TClass>(string propertyName,
            Type propertyType, string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            var param = Expression.Parameter(typeof(TClass));
            return Expression.Lambda<Func<TClass, bool>>(InternalCreateMethodCallMemberExpression(param, propertyName,
                propertyType, methodName, methodParamTypes, methodParamValues), param);
        }

        private static MethodCallExpression InternalCreateMethodCallMemberExpression(ParameterExpression param, string propertyName,
            Type propertyType, string methodName, Type[] methodParamTypes, object[] methodParamValues)
        {
            MemberExpression member = GetMemberExpression(param, propertyName);

            var values = new ConstantExpression[methodParamValues.Length];
            for (int i = 0; i < values.Length; i++)
                values[i] = Expression.Constant(methodParamValues[i], methodParamTypes[i]);

            MethodInfo method = propertyType.GetMethod(methodName, methodParamTypes);

            return Expression.Call(member, method, values);
        }


        private static TDelegate InternalCompile<TDelegate>(Expression<TDelegate> expression)
        {
            return expression.Compile();
        }

        #endregion

    }

}
