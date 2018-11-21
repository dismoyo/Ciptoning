﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 23:00:22
// Description   : UserRole partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'UserRole.cs'
//       up to one level of this file location inside 'UserRole' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("UserRole")]
    public partial class UserRole : IUserRole
    {                
        
        #region Implements IUserRole

        [Key, Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RoleID { get; set; }
            
        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int UserID { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        #endregion

    }

}
