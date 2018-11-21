﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 13:46:55
// Description   : IvSiteAddress partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvSiteAddress.cs'
//       up to one level of this file location inside 'vSiteAddress' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvSiteAddress
    {                
        
        #region Properties
        
        System.Guid SiteID { get; set; }
        string Address1 { get; set; }
        string Address2 { get; set; }
        string Address3 { get; set; }
        string Address { get; set; }
        string City { get; set; }
        string StateProvince { get; set; }
        string CountryID { get; set; }
        string CountryName { get; set; }
        string ZipCode { get; set; }
        string Phone1 { get; set; }
        string Phone2 { get; set; }
        string Fax { get; set; }
        string Email { get; set; }

        #endregion

    }

}