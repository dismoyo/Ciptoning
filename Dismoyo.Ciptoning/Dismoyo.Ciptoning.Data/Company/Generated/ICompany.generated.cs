﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 00:38:55
// Description   : ICompany partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ICompany.cs'
//       up to one level of this file location inside 'Company' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ICompany
    {                
        
        #region Properties
        
        int ID { get; set; }
        string Code { get; set; }
        string Name { get; set; }
        string TaxNumber { get; set; }
        int StatusID { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}
