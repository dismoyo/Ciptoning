﻿// ===================================================================================
// Author        : System
// Created date  : 12 Apr 2016 20:59:34
// Description   : IvSalesman partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvSalesman.cs'
//       up to one level of this file location inside 'vSalesman' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvSalesman
    {                
        
        #region Properties
        
        System.Guid ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        string Salesman { get; set; }
        System.Guid WarehouseID { get; set; }
        string WarehouseCode { get; set; }
        string WarehouseName { get; set; }
        string Warehouse { get; set; }
        System.Guid? SiteID { get; set; }
        string SiteCode { get; set; }
        string SiteName { get; set; }
        string Site { get; set; }
        int? CompanyID { get; set; }
        string CompanyCode { get; set; }
        string CompanyName { get; set; }
        string Company { get; set; }
        int? AreaID { get; set; }
        string AreaCode { get; set; }
        string AreaName { get; set; }
        string Area { get; set; }
        int? RegionID { get; set; }
        string RegionCode { get; set; }
        string RegionName { get; set; }
        string Region { get; set; }
        int? TerritoryID { get; set; }
        string TerritoryCode { get; set; }
        string TerritoryName { get; set; }
        string Territory { get; set; }
        int? SiteDistributionTypeID { get; set; }
        string SiteDistributionTypeName { get; set; }
        bool? IsSiteLotNumberEntryRequired { get; set; }
        int? WarehouseTypeID { get; set; }
        string WarehouseTypeName { get; set; }
        int GroupID { get; set; }
        string GroupName { get; set; }
        int CategoryID { get; set; }
        string CategoryName { get; set; }
        string Phone { get; set; }
        bool? SFAFlag { get; set; }
        string SFA { get; set; }
        int StatusID { get; set; }
        string StatusName { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        string CreatedByUserName { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        string ModifiedByUserName { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}