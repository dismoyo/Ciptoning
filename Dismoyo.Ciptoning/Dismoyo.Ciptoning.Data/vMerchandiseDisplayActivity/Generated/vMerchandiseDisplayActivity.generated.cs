﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 02:02:57
// Description   : vMerchandiseDisplayActivity partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vMerchandiseDisplayActivity.cs'
//       up to one level of this file location inside 'vMerchandiseDisplayActivity' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vMerchandiseDisplayActivity")]
    public partial class vMerchandiseDisplayActivity : IvMerchandiseDisplayActivity
    {                
        
        #region Implements IvMerchandiseDisplayActivity
        
        [Key]
        public System.Guid ID { get; set; }

        public System.DateTime ActivityDate { get; set; }

        public System.Guid SalesmanCallID { get; set; }

        public System.Guid SalesmanID { get; set; }

        public System.DateTime? CallDate { get; set; }

        public System.Guid CustomerID { get; set; }

        public System.String AttachmentFile { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public System.String CreatedByUserName { get; set; }

        #endregion

    }

}
