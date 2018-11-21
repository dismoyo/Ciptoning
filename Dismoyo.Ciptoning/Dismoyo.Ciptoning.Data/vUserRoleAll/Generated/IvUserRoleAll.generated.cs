﻿// ===================================================================================
// Author        : System
// Created date  : 01 Aug 2016 08:41:08
// Description   : IvUserRoleAll partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvUserRoleAll.cs'
//       up to one level of this file location inside 'vUserRoleAll' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvUserRoleAll
    {                
        
        #region Properties
        
        int UserRoleID { get; set; }
        bool IsUser { get; set; }
        string UserRoleName { get; set; }
        bool IsUserHeadOffice { get; set; }
        System.Guid? UserSiteID { get; set; }
        string UserSiteCode { get; set; }
        string UserSiteName { get; set; }
        string UserSite { get; set; }
        int? UserAreaID { get; set; }
        string UserAreaCode { get; set; }
        string UserAreaName { get; set; }
        string UserArea { get; set; }
        int? UserRegionID { get; set; }
        string UserRegionCode { get; set; }
        string UserRegionName { get; set; }
        string UserRegion { get; set; }
        int? UserTerritoryID { get; set; }
        string UserTerritoryCode { get; set; }
        string UserTerritoryName { get; set; }
        string UserTerritory { get; set; }
        int? UserCompanyID { get; set; }
        string UserCompanyCode { get; set; }
        string UserCompanyName { get; set; }
        string UserCompany { get; set; }
        int? UserSiteDistributionTypeID { get; set; }
        string UserSiteDistributionTypeName { get; set; }
        bool? IsUserSiteLotNumberEntryRequired { get; set; }
        int? UserStatusID { get; set; }
        string UserStatusName { get; set; }
        bool IsDeleted { get; set; }

        #endregion

    }

}