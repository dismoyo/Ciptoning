﻿// ===================================================================================
// Author        : System
// Created date  : 10 Apr 2016 02:31:26
// Description   : IProductPrice partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IProductPrice.cs'
//       up to one level of this file location inside 'ProductPrice' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IProductPrice
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        int ProductID { get; set; }
        System.DateTime? ValidDateFrom { get; set; }
        System.DateTime? ValidDateTo { get; set; }
        int PriceGroupID { get; set; }
        double GrossPrice { get; set; }
        double TaxPercentage { get; set; }
        double Price { get; set; }
        int StatusID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}
