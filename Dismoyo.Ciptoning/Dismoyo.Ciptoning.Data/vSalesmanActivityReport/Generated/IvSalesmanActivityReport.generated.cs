﻿// ===================================================================================
// Author        : System
// Created date  : 19 Jan 2017 17:22:17
// Description   : IvSalesmanActivityReport partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IvSalesmanActivityReport.cs'
//       up to one level of this file location inside 'vSalesmanActivityReport' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IvSalesmanActivityReport
    {                
        
        #region Properties
        
        System.Guid CustomerID { get; set; }
        System.DateTime CallDate { get; set; }
        System.DateTime? CheckInDate { get; set; }
        System.DateTime? CheckOutDate { get; set; }
        string CustomerType { get; set; }
        System.String Customer { get; set; }
        System.Guid SalesmanID { get; set; }
        System.String Salesman { get; set; }
        double? Latitude { get; set; }
        double? Longitude { get; set; }
        int RouteTypeID { get; set; }
        System.String RouteTypeName { get; set; }
        string Activity { get; set; }
        string DocumentCode { get; set; }

        #endregion

    }

}
