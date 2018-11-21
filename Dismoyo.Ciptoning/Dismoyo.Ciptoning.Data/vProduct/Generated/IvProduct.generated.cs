﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 10:23:20
// Description   : IvProduct partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvProduct.cs'
//       up to one level of this file location inside 'vProduct' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvProduct
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        string Product { get; set; }
        int? BrandID { get; set; }
        string BrandCode { get; set; }
        string BrandName { get; set; }
        string Brand { get; set; }
        string ShortName { get; set; }
        int? UOMLID { get; set; }
        string UOMLName { get; set; }
        int? UOMMID { get; set; }
        string UOMMName { get; set; }
        int? UOMSID { get; set; }
        string UOMSName { get; set; }
        double Weight { get; set; }
        int? DimensionL { get; set; }
        int? DimensionW { get; set; }
        int? DimensionH { get; set; }
        int? ConversionL { get; set; }
        int? ConversionM { get; set; }
        int? ConversionS { get; set; }
        int StatusID { get; set; }
        string AdditionalInfo1 { get; set; }
        string AdditionalInfo2 { get; set; }
        string AdditionalInfo3 { get; set; }
        string AdditionalInfo4 { get; set; }
        string AdditionalInfo5 { get; set; }
        string AdditionalInfo6 { get; set; }
        string AdditionalInfo7 { get; set; }
        string AdditionalInfo8 { get; set; }
        string AdditionalInfo9 { get; set; }
        string AdditionalInfo10 { get; set; }
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