﻿// ===================================================================================
// Author        : System
// Created date  : 13 Apr 2016 20:52:40
// Description   : vDiscountGroup partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vDiscountGroup.cs'
//       up to one level of this file location inside 'vDiscountGroup' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vDiscountGroup")]
    public partial class vDiscountGroup : IvDiscountGroup
    {                
        
        #region Implements IvDiscountGroup
        
        public int ID { get; set; }

        public string Code { get; set; }

        public string Name { get; set; }

        public string DiscountGroup { get; set; }

        public string Description { get; set; }

        public int StatusID { get; set; }

        public string StatusName { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public string CreatedByUserName { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        public int? ModifiedByUserID { get; set; }

        public string ModifiedByUserName { get; set; }

        public bool IsDeleted { get; set; }

        #endregion

    }

}