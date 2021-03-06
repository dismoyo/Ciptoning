﻿// ===================================================================================
// Author        : System
// Created date  : 12 Apr 2016 21:28:41
// Description   : vSalesmanViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vSalesmanViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
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
        this.SiteDistributionTypeID = ko.observable();
        this.SiteDistributionTypeName = ko.observable();
        this.IsSiteLotNumberEntryRequired = ko.observable();
        this.WarehouseTypeID = ko.observable();
        this.WarehouseTypeName = ko.observable();
        this.GroupID = ko.observable();
        this.GroupName = ko.observable();
        this.CategoryID = ko.observable();
        this.CategoryName = ko.observable();
        this.Phone = ko.observable();
        this.SFAFlag = ko.observable();
        this.SFA = ko.observable();
        this.StatusID = ko.observable();
        this.StatusName = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();
        this.IsDeleted = ko.observable();

        this.ChildProducts = ko.observableArray([]);

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vSalesmanViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
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
                SiteDistributionTypeID: this.SiteDistributionTypeID(),
                SiteDistributionTypeName: this.SiteDistributionTypeName(),
                IsSiteLotNumberEntryRequired: this.IsSiteLotNumberEntryRequired(),
                WarehouseTypeID: this.WarehouseTypeID(),
                WarehouseTypeName: this.WarehouseTypeName(),
                GroupID: this.GroupID(),
                GroupName: this.GroupName(),
                CategoryID: this.CategoryID(),
                CategoryName: this.CategoryName(),
                Phone: this.Phone(),
                SFAFlag: this.SFAFlag(),
                SFA: this.SFA(),
                StatusID: this.StatusID(),
                StatusName: this.StatusName(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),
                IsDeleted: this.IsDeleted(),

                ChildProducts: ko.toJS(this.ChildProducts())
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Code(data.Code);
                this.Name(data.Name);
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
                this.SiteDistributionTypeID(data.SiteDistributionTypeID);
                this.SiteDistributionTypeName(data.SiteDistributionTypeName);
                this.IsSiteLotNumberEntryRequired(data.IsSiteLotNumberEntryRequired);
                this.WarehouseTypeID(data.WarehouseTypeID);
                this.WarehouseTypeName(data.WarehouseTypeName);
                this.GroupID(data.GroupID);
                this.GroupName(data.GroupName);
                this.CategoryID(data.CategoryID);
                this.CategoryName(data.CategoryName);
                this.Phone(data.Phone);
                this.SFAFlag(data.SFAFlag);
                this.SFA(data.SFA);
                this.StatusID(data.StatusID);
                this.StatusName(data.StatusName);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);
                this.IsDeleted(data.IsDeleted);

                if (data.ChildProducts) {
                    for (var i = 0; i < data.ChildProducts.length; i++)
                        this.ChildProducts.push(new Dismoyo_Ciptoning_Client.vSalesmanProductViewModel(
                            data.ChildProducts[i]));
                }
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Code(undefined);
            this.Name(undefined);
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
            this.SiteDistributionTypeID(undefined);
            this.SiteDistributionTypeName(undefined);
            this.IsSiteLotNumberEntryRequired(undefined);
            this.WarehouseTypeID(undefined);
            this.WarehouseTypeName(undefined);
            this.GroupID(undefined);
            this.GroupName(undefined);
            this.CategoryID(undefined);
            this.CategoryName(undefined);
            this.Phone(undefined);
            this.SFAFlag(undefined);
            this.SFA(undefined);
            this.StatusID(undefined);
            this.StatusName(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);
            this.IsDeleted(undefined);

            this.ChildProducts(undefined);
        }
    });
})();
