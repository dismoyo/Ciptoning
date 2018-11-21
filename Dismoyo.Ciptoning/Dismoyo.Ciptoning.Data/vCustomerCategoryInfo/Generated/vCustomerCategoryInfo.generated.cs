﻿// ===================================================================================
// Author        : System
// Created date  : 10 May 2016 17:39:01
// Description   : vCustomerCategoryInfo partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vCustomerCategoryInfo.cs'
//       up to one level of this file location inside 'vCustomerCategoryInfo' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vCustomerCategoryInfo")]
    public partial class vCustomerCategoryInfo : IvCustomerCategoryInfo
    {                
        
        #region Implements IvCustomerCategoryInfo
        
        [Key]
        public System.Guid CustomerID { get; set; }

        public int? Category1ID { get; set; }

        public string Category1Code { get; set; }

        public string Category1Name { get; set; }

        public string Category1 { get; set; }

        public int? Category2ID { get; set; }

        public string Category2Code { get; set; }

        public string Category2Name { get; set; }

        public string Category2 { get; set; }

        public int? Category3ID { get; set; }

        public string Category3Code { get; set; }

        public string Category3Name { get; set; }

        public string Category3 { get; set; }

        public int? Category4ID { get; set; }

        public string Category4Code { get; set; }

        public string Category4Name { get; set; }

        public string Category4 { get; set; }

        public int? Category5ID { get; set; }

        public string Category5Code { get; set; }

        public string Category5Name { get; set; }

        public string Category5 { get; set; }

        public int? Category6ID { get; set; }

        public string Category6Code { get; set; }

        public string Category6Name { get; set; }

        public string Category6 { get; set; }

        public int? Category7ID { get; set; }

        public string Category7Code { get; set; }

        public string Category7Name { get; set; }

        public string Category7 { get; set; }

        public int? Category8ID { get; set; }

        public string Category8Code { get; set; }

        public string Category8Name { get; set; }

        public string Category8 { get; set; }

        public int? Category9ID { get; set; }

        public string Category9Code { get; set; }

        public string Category9Name { get; set; }

        public string Category9 { get; set; }

        public int? Category10ID { get; set; }

        public string Category10Code { get; set; }

        public string Category10Name { get; set; }

        public string Category10 { get; set; }

        #endregion

    }

}
