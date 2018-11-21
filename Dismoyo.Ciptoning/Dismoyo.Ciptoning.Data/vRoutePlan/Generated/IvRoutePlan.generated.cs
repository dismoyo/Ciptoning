﻿// ===================================================================================
// Author        : System
// Created date  : 26 Jul 2016 07:18:39
// Description   : IvRoutePlan partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvRoutePlan.cs'
//       up to one level of this file location inside 'vRoutePlan' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvRoutePlan
    {                
        
        #region Properties
        
        System.Guid CustomerID { get; set; }
        System.Guid SalesmanID { get; set; }
        int WeekID { get; set; }
        int DayID { get; set; }
        string SalesmanCode { get; set; }
        string SalesmanName { get; set; }
        string Salesman { get; set; }
        System.Guid WarehouseID { get; set; }
        string WarehouseCode { get; set; }
        string WarehouseName { get; set; }
        string Warehouse { get; set; }
        System.Guid? SiteID { get; set; }
        string SiteCode { get; set; }
        string SiteName { get; set; }
        string Site { get; set; }
        int CompanyID { get; set; }
        string CompanyCode { get; set; }
        string CompanyName { get; set; }
        string Company { get; set; }
        int AreaID { get; set; }
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
        string CustomerCode { get; set; }
        string CustomerName { get; set; }
        string Customer { get; set; }
        string CustomerAddress1 { get; set; }
        string CustomerAddress2 { get; set; }
        string CustomerAddress3 { get; set; }
        string CustomerAddress { get; set; }
        string WeekName { get; set; }
        string DayName { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        string CreatedByUserName { get; set; }
        System.Guid? OrderBySalesmanID { get; set; }
        int SortIndex { get; set; }
        int? WeekIDNotEqual { get; set; }
        int? DayIDNotEqual { get; set; }

        #endregion

    }

}
