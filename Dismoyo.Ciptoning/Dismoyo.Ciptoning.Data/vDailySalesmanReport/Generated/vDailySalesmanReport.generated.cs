﻿// ===================================================================================
// Author        : System
// Created date  : 13 Sep 2016 03:20:39
// Description   : vDailySalesmanReport partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vDailySalesmanReport.cs'
//       up to one level of this file location inside 'vDailySalesmanReport' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vDailySalesmanReport")]
    public partial class vDailySalesmanReport : IvDailySalesmanReport
    {

        #region Implements IvDailySalesmanReport

        [Key, Column(Order = 0)]
        public int RowNumber { get; set; }

        [Key, Column(Order = 1)]
        public string RowArea1 { get; set; }

        [Key, Column(Order = 2)]
        public string RowArea2 { get; set; }

        [Key, Column(Order = 3)]
        public string ColumnArea1 { get; set; }

        [Key, Column(Order = 4)]
        public string ColumnArea2 { get; set; }

        public string DataArea1 { get; set; }

        public string DataArea2 { get; set; }

        public string DataArea3 { get; set; }

        public string DataArea4 { get; set; }

        public string DataArea5 { get; set; }

        #endregion

    }

}