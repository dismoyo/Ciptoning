﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 10:23:25
// Description   : vProductAdditionalInfo partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vProductAdditionalInfo.cs'
//       up to one level of this file location inside 'vProductAdditionalInfo' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vProductAdditionalInfo")]
    public partial class vProductAdditionalInfo : IvProductAdditionalInfo
    {                
        
        #region Implements IvProductAdditionalInfo
        
        [Key]
        public int ProductID { get; set; }

        public string AdditionalInfo1 { get; set; }

        public string AdditionalInfo2 { get; set; }

        public string AdditionalInfo3 { get; set; }

        public string AdditionalInfo4 { get; set; }

        public string AdditionalInfo5 { get; set; }

        public string AdditionalInfo6 { get; set; }

        public string AdditionalInfo7 { get; set; }

        public string AdditionalInfo8 { get; set; }

        public string AdditionalInfo9 { get; set; }

        public string AdditionalInfo10 { get; set; }

        #endregion

    }

}