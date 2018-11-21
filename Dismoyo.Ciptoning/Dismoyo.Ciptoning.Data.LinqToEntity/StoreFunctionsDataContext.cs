using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Reflection;
using CodeFirstStoreFunctions;
using Dismoyo.Data.LinqToEntity;
using Dismoyo.Utilities;

namespace Dismoyo.Ciptoning.Data
{
    
    public partial class StoreFunctionsDataContext : DataContext
    {

        #region Constructors

        public StoreFunctionsDataContext()
            : base(DataConfiguration.DefaultConnectionStringName, DataConfiguration.DefaultDataAccessAssemblies,
                  DataConfiguration.DefaultDataContextCommandTimeoutName)
        {
        }

        public StoreFunctionsDataContext(string connectionStringName, Assembly[] assemblies)
            : base(connectionStringName, assemblies)
        {
        }

        public StoreFunctionsDataContext(string connectionStringName, Assembly[] assemblies,
            string appSettingsCommandTimeoutName)
            : base(connectionStringName, assemblies, appSettingsCommandTimeoutName)
        {
        }

        #endregion

        #region Methods

        protected override void OnModelCreating(System.Data.Entity.DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Add(new FunctionsConvention<StoreFunctionsDataContext>("dbo"));

            base.OnModelCreating(modelBuilder);
        }


        protected IQueryable<TEntity> OrderQuery<TEntity>(IQueryable<TEntity> query)
        {
            foreach (var item in ExpressionUtility.GetAttributePropertyExpressions<KeyAttribute, TEntity>())
                query = (IQueryable<TEntity>)LinqUtility.OrderBy(query, item);

            return query;
        }

        #endregion

    }

}
