// ===================================================================================
// Author        : System
// Created date  : 25 Jul 2016 07:22:27
// Description   : vRoutePlanSalesmanViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vRoutePlanSalesmanViewModel = function (data) {
        this.SalesmanID = ko.observable();
        this.SalesmanCode = ko.observable();
        this.SalesmanName = ko.observable();
        this.Salesman = ko.observable();
        this.WarehouseID = ko.observable();
        this.WarehouseCode = ko.observable();
        this.WarehouseName = ko.observable();
        this.Warehouse = ko.observable();
        this.SiteID = ko.observable();
        this.SiteCode = ko.observable();
        this.SiteName = ko.observable();
        this.Site = ko.observable();
        this.CompanyID = ko.observable();
        this.CompanyCode = ko.observable();
        this.CompanyName = ko.observable();
        this.Company = ko.observable();
        this.AreaID = ko.observable();
        this.AreaCode = ko.observable();
        this.AreaName = ko.observable();
        this.Area = ko.observable();
        this.RegionID = ko.observable();
        this.RegionCode = ko.observable();
        this.RegionName = ko.observable();
        this.Region = ko.observable();
        this.TerritoryID = ko.observable();
        this.TerritoryCode = ko.observable();
        this.TerritoryName = ko.observable();
        this.Territory = ko.observable();
        this.OddWeek1 = ko.observable();
        this.OddWeek2 = ko.observable();
        this.OddWeek3 = ko.observable();
        this.OddWeek4 = ko.observable();
        this.OddWeek5 = ko.observable();
        this.OddWeek6 = ko.observable();
        this.OddWeek7 = ko.observable();
        this.EvenWeek1 = ko.observable();
        this.EvenWeek2 = ko.observable();
        this.EvenWeek3 = ko.observable();
        this.EvenWeek4 = ko.observable();
        this.EvenWeek5 = ko.observable();
        this.EvenWeek6 = ko.observable();
        this.EvenWeek7 = ko.observable();
        this.CustomerID = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vRoutePlanSalesmanViewModel.prototype, {
        toJS: function () {
            return {
                SalesmanID: this.SalesmanID(),
                SalesmanCode: this.SalesmanCode(),
                SalesmanName: this.SalesmanName(),
                Salesman: this.Salesman(),
                WarehouseID: this.WarehouseID(),
                WarehouseCode: this.WarehouseCode(),
                WarehouseName: this.WarehouseName(),
                Warehouse: this.Warehouse(),
                SiteID: this.SiteID(),
                SiteCode: this.SiteCode(),
                SiteName: this.SiteName(),
                Site: this.Site(),
                CompanyID: this.CompanyID(),
                CompanyCode: this.CompanyCode(),
                CompanyName: this.CompanyName(),
                Company: this.Company(),
                AreaID: this.AreaID(),
                AreaCode: this.AreaCode(),
                AreaName: this.AreaName(),
                Area: this.Area(),
                RegionID: this.RegionID(),
                RegionCode: this.RegionCode(),
                RegionName: this.RegionName(),
                Region: this.Region(),
                TerritoryID: this.TerritoryID(),
                TerritoryCode: this.TerritoryCode(),
                TerritoryName: this.TerritoryName(),
                Territory: this.Territory(),
                OddWeek1: this.OddWeek1(),
                OddWeek2: this.OddWeek2(),
                OddWeek3: this.OddWeek3(),
                OddWeek4: this.OddWeek4(),
                OddWeek5: this.OddWeek5(),
                OddWeek6: this.OddWeek6(),
                OddWeek7: this.OddWeek7(),
                EvenWeek1: this.EvenWeek1(),
                EvenWeek2: this.EvenWeek2(),
                EvenWeek3: this.EvenWeek3(),
                EvenWeek4: this.EvenWeek4(),
                EvenWeek5: this.EvenWeek5(),
                EvenWeek6: this.EvenWeek6(),
                EvenWeek7: this.EvenWeek7(),
                CustomerID: this.CustomerID(),
            };
        },

        fromJS: function (data) {
            if (data) {
                this.SalesmanID(data.SalesmanID);
                this.SalesmanCode(data.SalesmanCode);
                this.SalesmanName(data.SalesmanName);
                this.Salesman(data.Salesman);
                this.WarehouseID(data.WarehouseID);
                this.WarehouseCode(data.WarehouseCode);
                this.WarehouseName(data.WarehouseName);
                this.Warehouse(data.Warehouse);
                this.SiteID(data.SiteID);
                this.SiteCode(data.SiteCode);
                this.SiteName(data.SiteName);
                this.Site(data.Site);
                this.CompanyID(data.CompanyID);
                this.CompanyCode(data.CompanyCode);
                this.CompanyName(data.CompanyName);
                this.Company(data.Company);
                this.AreaID(data.AreaID);
                this.AreaCode(data.AreaCode);
                this.AreaName(data.AreaName);
                this.Area(data.Area);
                this.RegionID(data.RegionID);
                this.RegionCode(data.RegionCode);
                this.RegionName(data.RegionName);
                this.Region(data.Region);
                this.TerritoryID(data.TerritoryID);
                this.TerritoryCode(data.TerritoryCode);
                this.TerritoryName(data.TerritoryName);
                this.Territory(data.Territory);
                this.OddWeek1(data.OddWeek1);
                this.OddWeek2(data.OddWeek2);
                this.OddWeek3(data.OddWeek3);
                this.OddWeek4(data.OddWeek4);
                this.OddWeek5(data.OddWeek5);
                this.OddWeek6(data.OddWeek6);
                this.OddWeek7(data.OddWeek7);
                this.EvenWeek1(data.EvenWeek1);
                this.EvenWeek2(data.EvenWeek2);
                this.EvenWeek3(data.EvenWeek3);
                this.EvenWeek4(data.EvenWeek4);
                this.EvenWeek5(data.EvenWeek5);
                this.EvenWeek6(data.EvenWeek6);
                this.EvenWeek7(data.EvenWeek7);
                this.CustomerID(data.CustomerID);
            }
        },

        clear: function () {
            this.SalesmanID(undefined);
            this.SalesmanCode(undefined);
            this.SalesmanName(undefined);
            this.Salesman(undefined);
            this.WarehouseID(undefined);
            this.WarehouseCode(undefined);
            this.WarehouseName(undefined);
            this.Warehouse(undefined);
            this.SiteID(undefined);
            this.SiteCode(undefined);
            this.SiteName(undefined);
            this.Site(undefined);
            this.CompanyID(undefined);
            this.CompanyCode(undefined);
            this.CompanyName(undefined);
            this.Company(undefined);
            this.AreaID(undefined);
            this.AreaCode(undefined);
            this.AreaName(undefined);
            this.Area(undefined);
            this.RegionID(undefined);
            this.RegionCode(undefined);
            this.RegionName(undefined);
            this.Region(undefined);
            this.TerritoryID(undefined);
            this.TerritoryCode(undefined);
            this.TerritoryName(undefined);
            this.Territory(undefined);
            this.OddWeek1(undefined);
            this.OddWeek2(undefined);
            this.OddWeek3(undefined);
            this.OddWeek4(undefined);
            this.OddWeek5(undefined);
            this.OddWeek6(undefined);
            this.OddWeek7(undefined);
            this.EvenWeek1(undefined);
            this.EvenWeek2(undefined);
            this.EvenWeek3(undefined);
            this.EvenWeek4(undefined);
            this.EvenWeek5(undefined);
            this.EvenWeek6(undefined);
            this.EvenWeek7(undefined);
            this.CustomerID(undefined);
        }
    });
})();
