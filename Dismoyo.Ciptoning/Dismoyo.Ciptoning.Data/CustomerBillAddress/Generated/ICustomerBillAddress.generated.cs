﻿// ===================================================================================
// Author        : System
// Created date  : 15 Apr 2016 08:21:55
// Description   : ICustomerBillAddress partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'ICustomerBillAddress.cs'
//       up to one level of this file location inside 'CustomerBillAddress' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface ICustomerBillAddress
    {                
        
        #region Properties
        
        System.Guid CustomerID { get; set; }
        bool IsSameAsAddress { get; set; }
        string Name { get; set; }
        string Address1 { get; set; }
        string Address2 { get; set; }
        string Address3 { get; set; }
        string City { get; set; }
        string StateProvince { get; set; }
        string CountryID { get; set; }
        string ZipCode { get; set; }
        string Phone1 { get; set; }
        string Phone2 { get; set; }
        string Phone3 { get; set; }
        string Fax { get; set; }
        string Email { get; set; }
       

        #endregion

    }

}
