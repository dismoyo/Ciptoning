﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:53:58
// Description   : IvStockChangesSummary partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvStockChangesSummary.cs'
//       up to one level of this file location inside 'vStockChangesSummary' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvStockChangesSummary
    {

        #region Properties

        System.Guid DocumentID { get; set; }
        int ProductID { get; set; }
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
        int QtyOnHand { get; set; }
        int QtyConvL { get; set; }
        int QtyConvM { get; set; }
        int QtyConvS { get; set; }
        int Qty { get; set; }
        string QtyChangesConv { get; set; }
        int QtyChanges { get; set; }

        #endregion

    }

}
