﻿// ===================================================================================
// Author        : System
// Created date  : 07 Apr 2016 06:15:05
// Description   : IvStockView partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvStockView.cs'
//       up to one level of this file location inside 'vStockView' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvStockView
    {

        #region Properties

        System.Guid WarehouseID { get; set; }
        int ProductID { get; set; }
        int ProductLotID { get; set; }
        string WarehouseCode { get; set; }
        string WarehouseName { get; set; }
        string Warehouse { get; set; }
        System.Guid? SiteID { get; set; }
        string SiteCode { get; set; }
        string SiteName { get; set; }
        string Site { get; set; }
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
        int? CompanyID { get; set; }
        string CompanyCode { get; set; }
        string CompanyName { get; set; }
        string Company { get; set; }
        int? SiteDistributionTypeID { get; set; }
        string SiteDistributionTypeName { get; set; }
        bool? IsSiteLotNumberEntryRequired { get; set; }
        int WarehouseTypeID { get; set; }
        string WarehouseTypeName { get; set; }
        bool IsWarehouseSOAllowed { get; set; }
        int WarehouseStatusID { get; set; }
        string WarehouseStatusName { get; set; }
        int QtyPeriodOnHandGood { get; set; }
        int QtyPeriodOnHandHold { get; set; }
        int QtyPeriodOnHandBad { get; set; }
        int? QtyTransactionGood { get; set; }
        int? QtyTransactionHold { get; set; }
        int? QtyTransactionBad { get; set; }
        int? QtyOnHandGood { get; set; }
        int? QtyOnHandHold { get; set; }
        int? QtyOnHandBad { get; set; }
        string ProductCode { get; set; }
        string ProductName { get; set; }
        string Product { get; set; }
        int? ProductBrandID { get; set; }
        string ProductBrandCode { get; set; }
        string ProductBrandName { get; set; }
        string ProductBrand { get; set; }
        string ProductShortName { get; set; }
        int? ProductUOMLID { get; set; }
        string ProductUOMLName { get; set; }
        int? ProductUOMMID { get; set; }
        string ProductUOMMName { get; set; }
        int? ProductUOMSID { get; set; }
        string ProductUOMSName { get; set; }
        double? ProductWeight { get; set; }
        int? ProductDimensionL { get; set; }
        int? ProductDimensionW { get; set; }
        int? ProductDimensionH { get; set; }
        int? ProductConversionL { get; set; }
        int? ProductConversionM { get; set; }
        int? ProductConversionS { get; set; }
        int? ProductStatusID { get; set; }
        string ProductStatusName { get; set; }
        string ProductAdditionalInfo1 { get; set; }
        string ProductAdditionalInfo2 { get; set; }
        string ProductAdditionalInfo3 { get; set; }
        string ProductAdditionalInfo4 { get; set; }
        string ProductAdditionalInfo5 { get; set; }
        string ProductAdditionalInfo6 { get; set; }
        string ProductAdditionalInfo7 { get; set; }
        string ProductAdditionalInfo8 { get; set; }
        string ProductAdditionalInfo9 { get; set; }
        string ProductAdditionalInfo10 { get; set; }
        string ProductLotCode { get; set; }
        System.DateTime ProductLotExpiredDate { get; set; }
        string ProductLot { get; set; }
        int ProductLotStatusID { get; set; }
        string ProductLotStatusName { get; set; }
        bool IsProductLotCodeDeleted { get; set; }

        #endregion

    }

}