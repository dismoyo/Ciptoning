﻿// ===================================================================================
// Author        : System
// Created date  : 16 Mar 2016 11:42:05
// Description   : vSystemLookup partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vSystemLookup.cs'
//       up to one level of this file location inside 'vSystemLookup' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vSystemLookup")]
    public partial class vSystemLookup : IvSystemLookup
    {                
        
        #region Implements IvSystemLookup
        
        public int ID { get; set; }

        public string Name { get; set; }

        public bool? Value_Boolean { get; set; }

        public int? Value_Int32 { get; set; }

        public double? Value_Double { get; set; }

        public string Value_String { get; set; }

        public System.Guid? Value_Guid { get; set; }

        public System.DateTime? Value_DateTime { get; set; }

        public int? ParentID { get; set; }

        public string Group { get; set; }

        public int SortIndex { get; set; }

        public bool IsActive { get; set; }

        public bool? IsAuthorization { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        #endregion

    }

}