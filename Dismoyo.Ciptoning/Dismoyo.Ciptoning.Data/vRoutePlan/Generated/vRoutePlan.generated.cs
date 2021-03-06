﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 07:18:39
// Description   : vRoutePlan partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vRoutePlan.cs'
//       up to one level of this file location inside 'vRoutePlan' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vRoutePlan")]
    public partial class vRoutePlan : IvRoutePlan
    {                
        
        #region Implements IvRoutePlan
        
        [Key, Column(Order = 0)]
        public System.Guid CustomerID { get; set; }

        [Key, Column(Order = 1)]
        public System.Guid SalesmanID { get; set; }

        [Key, Column(Order = 2)]
        public int WeekID { get; set; }

        [Key, Column(Order = 3)]
        public int DayID { get; set; }

        public string SalesmanCode { get; set; }

        public string SalesmanName { get; set; }

        public string Salesman { get; set; }

        public System.Guid WarehouseID { get; set; }

        public string WarehouseCode { get; set; }

        public string WarehouseName { get; set; }

        public string Warehouse { get; set; }

        public System.Guid? SiteID { get; set; }

        public string SiteCode { get; set; }

        public string SiteName { get; set; }

        public string Site { get; set; }

        public int CompanyID { get; set; }

        public string CompanyCode { get; set; }

        public string CompanyName { get; set; }

        public string Company { get; set; }

        public int AreaID { get; set; }

        public string AreaCode { get; set; }

        public string AreaName { get; set; }

        public string Area { get; set; }

        public int? RegionID { get; set; }

        public string RegionCode { get; set; }

        public string RegionName { get; set; }

        public string Region { get; set; }

        public int? TerritoryID { get; set; }

        public string TerritoryCode { get; set; }

        public string TerritoryName { get; set; }

        public string Territory { get; set; }

        public string CustomerCode { get; set; }

        public string CustomerName { get; set; }

        public string Customer { get; set; }

        public string CustomerAddress1 { get; set; }

        public string CustomerAddress2 { get; set; }

        public string CustomerAddress3 { get; set; }

        public string CustomerAddress { get; set; }

        public string WeekName { get; set; }

        public string DayName { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public string CreatedByUserName { get; set; }

        public System.Guid? OrderBySalesmanID { get; set; }

        public int SortIndex { get; set; }

        public int? WeekIDNotEqual { get; set; }

        public int? DayIDNotEqual { get; set; }

        #endregion

    }

}
