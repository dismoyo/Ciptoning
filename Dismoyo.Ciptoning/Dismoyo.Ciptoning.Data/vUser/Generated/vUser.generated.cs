﻿// ===================================================================================
// Author        : System
// Created date  : 10 Mar 2016 11::36:48
// Description   : User partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vUser.cs'
//       up to one level of this file location inside 'vUser' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vUser")]
    public partial class vUser : IvUser
    {                
        
        #region Implements IvUser

        [Key]
        public int ID { get; set; }
            
        public string Name { get; set; }

        public string Password { get; set; }

        public bool IsHeadOffice { get; set; }

        public System.Guid? SiteID { get; set; }

        public string SiteCode { get; set; }

        public string SiteName { get; set; }

        public string Site { get; set; }

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

        public int? CompanyID { get; set; }

        public string CompanyCode { get; set; }

        public string CompanyName { get; set; }

        public string Company { get; set; }

        public int? SiteDistributionTypeID { get; set; }

        public bool? IsSiteLotNumberEntryRequired { get; set; }

        public int StatusID { get; set; }

        public string StatusName { get; set; }

        public System.DateTime CreatedDate { get; set; }
            
        public int? CreatedByUserID { get; set; }
            
        public System.DateTime? ModifiedDate { get; set; }
            
        public int? ModifiedByUserID { get; set; }

        public bool IsDeleted { get; set; }

        #endregion

    }

}
