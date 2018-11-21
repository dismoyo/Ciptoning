﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 23:44:52
// Description   : MerchandiseDisplayActivity partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'MerchandiseDisplayActivity.cs'
//       up to one level of this file location inside 'MerchandiseDisplayActivity' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("MerchandiseDisplayActivity")]
    public partial class MerchandiseDisplayActivity : IMerchandiseDisplayActivity
    {                
        
        #region Implements IMerchandiseDisplayActivity

        [Key]
        public System.Guid ID { get; set; }
            
        public System.DateTime ActivityDate { get; set; }
            
        public System.Guid SalesmanCallID { get; set; }
            
        public System.String AttachmentFile { get; set; }
            
        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        #endregion

    }

}
