using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Dismoyo.Ciptoning.Data
{

    [Table("[dbo].[vNewOpenOutlet]")]
    public class ScalarFunctionResult
    {

        #region Properties

        [Key]
        public string Value { get; set; }

        #endregion

    }

    public class ScalarFunctionResultEntityTypeConfig : EntityTypeConfiguration<ScalarFunctionResult>
    {



    }

}
