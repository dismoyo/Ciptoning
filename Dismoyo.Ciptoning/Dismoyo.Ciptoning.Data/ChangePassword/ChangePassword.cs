using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vChangePassword")]
    public partial class ChangePassword : IChangePassword
    {

        #region Implements IChangePassword

        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string Password { get; set; }
                        
        #endregion

    }

}
