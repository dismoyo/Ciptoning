﻿// ===================================================================================
// Author        : System
// Created date  : 19 May 2016 11:38:02
// Description   : IvSalesOrderSwap partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvSalesOrderSwap.cs'
//       up to one level of this file location inside 'vSalesOrderSwap' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvSalesOrderSwap
    {                
        
        #region Properties
        
        System.Guid DocumentID { get; set; }
        string DocumentCode { get; set; }
        System.DateTime TransactionDate { get; set; }
        System.Guid SalesmanID { get; set; }
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
        int? WarehouseTypeID { get; set; }
        string WarehouseTypeName { get; set; }
        bool? IsSiteLotNumberEntryRequired { get; set; }
        System.Guid CustomerID { get; set; }
        string CustomerCode { get; set; }
        string CustomerName { get; set; }
        string Customer { get; set; }
        string ReferenceNumber { get; set; }
        string AttachmentFile { get; set; }
        System.Guid DODocumentID { get; set; }
        string DODocumentCode { get; set; }
        System.DateTime? DOShipmentDate { get; set; }
        System.DateTime? DOReceivedDate { get; set; }
        int? DOPrintedCount { get; set; }
        System.DateTime? DOLastPrintedDate { get; set; }
        double TotalWeight { get; set; }
        int TotalDimension { get; set; }
        int DocumentStatusID { get; set; }
        string DocumentStatusName { get; set; }
        string DocumentStatusReason { get; set; }
        string SFAInvoiceDocumentCode { get; set; }
        int PrintCount { get; set; }
        System.DateTime? PostedDate { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        string CreatedByUserName { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        string ModifiedByUserName { get; set; }

        #endregion

    }

}
