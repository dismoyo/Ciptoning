﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:54:04
// Description   : vStockTransfer partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vStockTransfer.cs'
//       up to one level of this file location inside 'vStockTransfer' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vStockTransfer")]
    public partial class vStockTransfer : IvStockTransfer
    {

        #region Implements IvStockTransfer

        [Key]
        public System.Guid DocumentID { get; set; }

        public string DocumentCode { get; set; }

        public System.DateTime TransactionDate { get; set; }

        public System.Guid SourceWarehouseID { get; set; }

        public string SourceWarehouseCode { get; set; }

        public string SourceWarehouseName { get; set; }

        public string SourceWarehouse { get; set; }

        public System.Guid? SourceSiteID { get; set; }

        public string SourceSiteCode { get; set; }

        public string SourceSiteName { get; set; }

        public string SourceSite { get; set; }

        public int? SourceCompanyID { get; set; }

        public string SourceCompanyCode { get; set; }

        public string SourceCompanyName { get; set; }

        public string SourceCompany { get; set; }

        public int? SourceAreaID { get; set; }

        public string SourceAreaCode { get; set; }

        public string SourceAreaName { get; set; }

        public string SourceArea { get; set; }

        public int? SourceRegionID { get; set; }

        public string SourceRegionCode { get; set; }

        public string SourceRegionName { get; set; }

        public string SourceRegion { get; set; }

        public int? SourceTerritoryID { get; set; }

        public string SourceTerritoryCode { get; set; }

        public string SourceTerritoryName { get; set; }

        public string SourceTerritory { get; set; }

        public int? SourceSiteDistributionTypeID { get; set; }

        public string SourceSiteDistributionTypeName { get; set; }

        public int? SourceWarehouseTypeID { get; set; }

        public string SourceWarehouseTypeName { get; set; }

        public bool? IsSourceSiteLotNumberEntryRequired { get; set; }

        public string SourcePIC { get; set; }

        public System.Guid DestinationWarehouseID { get; set; }

        public string DestinationWarehouseCode { get; set; }

        public string DestinationWarehouseName { get; set; }

        public string DestinationWarehouse { get; set; }

        public System.Guid? DestinationSiteID { get; set; }

        public string DestinationSiteCode { get; set; }

        public string DestinationSiteName { get; set; }

        public string DestinationSite { get; set; }

        public int? DestinationCompanyID { get; set; }

        public string DestinationCompanyCode { get; set; }

        public string DestinationCompanyName { get; set; }

        public string DestinationCompany { get; set; }

        public int? DestinationAreaID { get; set; }

        public string DestinationAreaCode { get; set; }

        public string DestinationAreaName { get; set; }

        public string DestinationArea { get; set; }

        public int? DestinationRegionID { get; set; }

        public string DestinationRegionCode { get; set; }

        public string DestinationRegionName { get; set; }

        public string DestinationRegion { get; set; }

        public int? DestinationTerritoryID { get; set; }

        public string DestinationTerritoryCode { get; set; }

        public string DestinationTerritoryName { get; set; }

        public string DestinationTerritory { get; set; }

        public int? DestinationSiteDistributionTypeID { get; set; }

        public string DestinationSiteDistributionTypeName { get; set; }

        public int? DestinationWarehouseTypeID { get; set; }

        public string DestinationWarehouseTypeName { get; set; }

        public bool? IsDestinationSiteLotNumberEntryRequired { get; set; }

        public string DestinationPIC { get; set; }

        public string ReferenceNumber { get; set; }

        public string AttachmentFile { get; set; }

        public System.Guid DODocumentID { get; set; }

        public string DODocumentCode { get; set; }

        public System.DateTime? DOShipmentDate { get; set; }

        public System.DateTime? DOReceivedDate { get; set; }

        public int? DOPrintedCount { get; set; }

        public System.DateTime? DOLastPrintedDate { get; set; }

        public int DocumentStatusID { get; set; }

        public string DocumentStatusName { get; set; }

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
