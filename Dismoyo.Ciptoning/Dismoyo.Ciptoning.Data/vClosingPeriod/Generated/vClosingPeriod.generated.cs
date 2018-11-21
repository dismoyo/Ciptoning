﻿// ===================================================================================
// Author        : System
// Created date  : 14 Nov 2016 01:07:03
// Description   : vClosingPeriod partial class.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial class. If required,
//       a partial class should be created as 'vClosingPeriod.cs'
//       up to one level of this file location inside 'vClosingPeriod' folder.
// ===================================================================================

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dismoyo.Ciptoning.Data
{

    [Table("vClosingPeriod")]
    public partial class vClosingPeriod : IvClosingPeriod
    {                
        
        #region Implements IvClosingPeriod
        
        [Key, Column(Order = 0)]
        public System.Guid SiteID { get; set; }

        [Key, Column(Order = 1)]
        public int YearID { get; set; }

        public bool Jan { get; set; }

        public bool Feb { get; set; }

        public bool Mar { get; set; }

        public bool Apr { get; set; }

        public bool May { get; set; }

        public bool Jun { get; set; }

        public bool Jul { get; set; }

        public bool Aug { get; set; }

        public bool Sep { get; set; }

        public bool Oct { get; set; }

        public bool Nov { get; set; }

        public bool Dec { get; set; }

        public string SiteCode { get; set; }

        public string SiteName { get; set; }

        public System.String Site { get; set; }

        public int AreaID { get; set; }

        public string AreaCode { get; set; }

        public string AreaName { get; set; }

        public System.String Area { get; set; }

        public int? RegionID { get; set; }

        public string RegionCode { get; set; }

        public string RegionName { get; set; }

        public System.String Region { get; set; }

        public int? TerritoryID { get; set; }

        public string TerritoryCode { get; set; }

        public string TerritoryName { get; set; }

        public System.String Territory { get; set; }

        public int CompanyID { get; set; }

        public string CompanyCode { get; set; }

        public string CompanyName { get; set; }

        public System.String Company { get; set; }

        public int SiteDistributionTypeID { get; set; }

        public System.String SiteDistributionTypeName { get; set; }

        public System.DateTime CreatedDate { get; set; }

        public int? CreatedByUserID { get; set; }

        public System.String CreatedByUserName { get; set; }

        public System.DateTime? ModifiedDate { get; set; }

        public int? ModifiedByUserID { get; set; }

        public System.String ModifiedByUserName { get; set; }

        #endregion

    }

}
