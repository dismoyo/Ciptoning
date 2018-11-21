﻿// ===================================================================================
// Author        : System
// Created date  : 15 May 2016 19:56:49
// Description   : vSalesOrderFOC partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vSalesOrderFOC.cs'
//       up to one level of this file location inside 'vSalesOrderFOC' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vSalesOrderFOC")]
    public partial class vSalesOrderFOC : IvSalesOrderFOC
    {

        #region Implements IvSalesOrderFOC

        [Key]
        public System.Guid DocumentID { get; set; }

        public string DocumentCode { get; set; }

        public System.DateTime TransactionDate { get; set; }

        public System.Guid? PODocumentID { get; set; }

        public string PODocumentCode { get; set; }

        public System.DateTime? POTransactionDate { get; set; }

        public System.Guid SalesmanID { get; set; }

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

        public int? CompanyID { get; set; }

        public string CompanyCode { get; set; }

        public string CompanyName { get; set; }

        public string Company { get; set; }

        public int? AreaID { get; set; }

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

        public int? SiteDistributionTypeID { get; set; }

        public string SiteDistributionTypeName { get; set; }

        public int? WarehouseTypeID { get; set; }

        public string WarehouseTypeName { get; set; }

        public bool? IsSiteLotNumberEntryRequired { get; set; }

        public System.Guid CustomerID { get; set; }

        public string CustomerCode { get; set; }

        public string CustomerName { get; set; }

        public string Customer { get; set; }

        public int PriceGroupID { get; set; }

        public string PriceGroupName { get; set; }

        public int DiscountGroupID { get; set; }

        public string DiscountGroupCode { get; set; }

        public string DiscountGroupName { get; set; }

        public string DiscountGroup { get; set; }

        public string DiscountGroupDescription { get; set; }

        public int TermOfPaymentID { get; set; }

        public string TermOfPaymentName { get; set; }

        public string ReferenceNumber { get; set; }

        public System.Guid DODocumentID { get; set; }

        public string DODocumentCode { get; set; }

        public System.DateTime? DOShipmentDate { get; set; }

        public System.DateTime? DOReceivedDate { get; set; }

        public int? DOPrintedCount { get; set; }

        public System.DateTime? DOLastPrintedDate { get; set; }

        public System.Guid? InvoiceDocumentID { get; set; }

        public string InvoiceDocumentCode { get; set; }

        public double RawTotalGrossPrice { get; set; }

        public double RawTotalPrice { get; set; }

        public double RawTotalDiscountStrata1Amount { get; set; }

        public double RawTotalDiscountStrata2Amount { get; set; }

        public double RawTotalDiscountStrata3Amount { get; set; }

        public double RawTotalDiscountStrata4Amount { get; set; }

        public double RawTotalDiscountStrata5Amount { get; set; }

        public double RawTotalAddDiscountStrataAmount { get; set; }

        public double RawTotalGross { get; set; }

        public double RawTotalTax { get; set; }

        public double RawTotal { get; set; }

        public double TotalGrossPrice { get; set; }

        public double TotalPrice { get; set; }

        public double TotalDiscountStrata1Amount { get; set; }

        public double TotalDiscountStrata2Amount { get; set; }

        public double TotalDiscountStrata3Amount { get; set; }

        public double TotalDiscountStrata4Amount { get; set; }

        public double TotalDiscountStrata5Amount { get; set; }

        public double TotalAddDiscountStrataAmount { get; set; }

        public double TotalGross { get; set; }

        public double TotalTax { get; set; }

        public double Total { get; set; }

        public double TotalWeight { get; set; }

        public int TotalDimension { get; set; }

        public string AddDiscountStrataReason { get; set; }

        public int DocumentStatusID { get; set; }

        public string DocumentStatusName { get; set; }

        public string DocumentStatusReason { get; set; }

        public string SFAInvoiceDocumentCode { get; set; }

        public int PrintCount { get; set; }

        public System.DateTime? PostedDate { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public string CreatedByUserName { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        public int? ModifiedByUserID { get; set; }

        public string ModifiedByUserName { get; set; }

        #endregion

    }

}
