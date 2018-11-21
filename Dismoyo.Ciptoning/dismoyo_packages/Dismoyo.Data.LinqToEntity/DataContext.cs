using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Reflection;

namespace Dismoyo.Data.LinqToEntity
{

    public class DataContext : DbContext
    {

        #region Constructors

        public DataContext(string connectionStringName, Assembly[] assemblies)
            : this(connectionStringName, assemblies, (int?)null)
        {
        }

        public DataContext(string connectionStringName, Assembly[] assemblies, string appSettingsCommandTimeoutName)
            : this(connectionStringName, assemblies,
                  int.Parse(ConfigurationManager.AppSettings[appSettingsCommandTimeoutName]))
        {            
        }

        public DataContext(string connectionStringName, Assembly[] assemblies, int? commandTimeout)
            : base(connectionStringName)
        {
            Assemblies = assemblies;
            if (commandTimeout != null)
                Database.CommandTimeout = commandTimeout;
        }

        #endregion

        #region Properties

        public Assembly[] Assemblies { get; private set; }

        #endregion

        #region Methods

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            foreach (var assembly in Assemblies)
                modelBuilder.Configurations.AddFromAssembly(assembly);

            base.OnModelCreating(modelBuilder);
        }

        public override DbSet<TEntity> Set<TEntity>()
        {
            return base.Set<TEntity>();
        }

        #endregion

    }

}
