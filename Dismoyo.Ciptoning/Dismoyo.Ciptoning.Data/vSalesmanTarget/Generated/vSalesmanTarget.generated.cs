﻿// ===================================================================================
// Author        : System
// Created date  : 01 Nov 2016 10:47:30
// Description   : vSalesmanTarget partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vSalesmanTarget.cs'
//       up to one level of this file location inside 'vSalesmanTarget' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vSalesmanTarget")]
    public partial class vSalesmanTarget : IvSalesmanTarget
    {                
        
        #region Implements IvSalesmanTarget
        
        [Key]
        [Column(Order = 0)]
        public System.Guid SalesmanID { get; set; }

        [Key]
        [Column(Order = 1)]
        public System.DateTime PeriodID { get; set; }

        public string SalesmanCode { get; set; }

        public string SalesmanName { get; set; }

        public System.String Salesman { get; set; }

        public System.Guid? WarehouseID { get; set; }

        public string WarehouseCode { get; set; }

        public string WarehouseName { get; set; }

        public System.String Warehouse { get; set; }

        public System.Guid? SiteID { get; set; }

        public string SiteCode { get; set; }

        public string SiteName { get; set; }

        public System.String Site { get; set; }

        public int? CompanyID { get; set; }

        public string CompanyCode { get; set; }

        public string CompanyName { get; set; }

        public System.String Company { get; set; }

        public int? AreaID { get; set; }

        public string AreaCode { get; set; }

        public string AreaName { get; set; }

        public System.String Area { get; set; }

        public int? RegionID { get; set; }

        public string RegionCode { get; set; }

        public string RegionName { get; set; }

        public System.String Region { get; set; }

        public int? TerritoryID { get; set; }

        public string TerritoryCode { get; set; }

        public string TerritoryName { get; set; }

        public System.String Territory { get; set; }

        public int SiteDistributionTypeID { get; set; }

        public System.String SiteDistributionTypeName { get; set; }

        public int WarehouseTypeID { get; set; }

        public System.String WarehouseTypeName { get; set; }

        public int SalesmanGroupID { get; set; }

        public System.String SalesmanGroupName { get; set; }

        public int SalesmanCategoryID { get; set; }

        public System.String SalesmanCategoryName { get; set; }

        public System.String SalesmanPhoneID { get; set; }

        public System.String SalesmanSFA { get; set; }

        public int SalesmanStatusID { get; set; }

        public System.String SalesmanStatusName { get; set; }

        public bool IsSalesmanDeleted { get; set; }

        public double SalesOrderAmount { get; set; }

        public int NewCustomer { get; set; }

        public int Visibility { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public System.String CreatedByUserName { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        public int? ModifiedByUserID { get; set; }

        public System.String ModifiedByUserName { get; set; }

        #endregion

    }

}
