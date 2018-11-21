﻿// ===================================================================================
// Author        : System
// Created date  : 21 Mar 2016 07:43:13
// Description   : vWarehouseViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vWarehouseViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
        this.Warehouse = ko.observable();
        this.SiteID = ko.observable();
        this.SiteCode = ko.observable();
        this.SiteName = ko.observable();
        this.Site = ko.observable();
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
        this.CompanyID = ko.observable();
        this.CompanyCode = ko.observable();
        this.CompanyName = ko.observable();
        this.Company = ko.observable();
        this.SiteDistributionTypeID = ko.observable();
        this.SiteDistributionTypeName = ko.observable();
        this.IsSiteLotNumberEntryRequired = ko.observable();
        this.TypeID = ko.observable();
        this.TypeName = ko.observable();
        this.IsSOAllowed = ko.observable();
        this.StatusID = ko.observable();
        this.StatusName = ko.observable();
        this.SAPCode = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();
        this.IsDeleted = ko.observable();

        this.Parent = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vWarehouseViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
                Warehouse: this.Warehouse(),
                SiteID: this.SiteID(),
                SiteCode: this.SiteCode(),
                SiteName: this.SiteName(),
                Site: this.Site(),
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
                CompanyID: this.CompanyID(),
                CompanyCode: this.CompanyCode(),
                CompanyName: this.CompanyName(),
                Company: this.Company(),
                SiteDistributionTypeID: this.SiteDistributionTypeID(),
                SiteDistributionTypeName: this.SiteDistributionTypeName(),
                IsSiteLotNumberEntryRequired: this.IsSiteLotNumberEntryRequired(),
                TypeID: this.TypeID(),
                TypeName: this.TypeName(),
                IsSOAllowed: this.IsSOAllowed(),
                StatusID: this.StatusID(),
                StatusName: this.StatusName(),
                SAPCode: this.SAPCode(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),
                IsDeleted: this.IsDeleted(),

                Parent: this.Parent()
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Code(data.Code);
                this.Name(data.Name);
                this.Warehouse(data.Warehouse);
                this.SiteID(data.SiteID);
                this.SiteCode(data.SiteCode);
                this.SiteName(data.SiteName);
                this.Site(data.Site);
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
                this.CompanyID(data.CompanyID);
                this.CompanyCode(data.CompanyCode);
                this.CompanyName(data.CompanyName);
                this.Company(data.Company);
                this.SiteDistributionTypeID(data.SiteDistributionTypeID);
                this.SiteDistributionTypeName(data.SiteDistributionTypeName);
                this.IsSiteLotNumberEntryRequired(data.IsSiteLotNumberEntryRequired);
                this.TypeID(data.TypeID);
                this.TypeName(data.TypeName);
                this.IsSOAllowed(data.IsSOAllowed);
                this.StatusID(data.StatusID);
                this.StatusName(data.StatusName);
                this.SAPCode(data.SAPCode);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);
                this.IsDeleted(data.IsDeleted);

                if (data.Parent)
                    this.Parent(data.Parent);
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Code(undefined);
            this.Name(undefined);
            this.Warehouse(undefined);
            this.SiteID(undefined);
            this.SiteCode(undefined);
            this.SiteName(undefined);
            this.Site(undefined);
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
            this.CompanyID(undefined);
            this.CompanyCode(undefined);
            this.CompanyName(undefined);
            this.Company(undefined);
            this.SiteDistributionTypeID(undefined);
            this.SiteDistributionTypeName(undefined);
            this.IsSiteLotNumberEntryRequired(undefined);
            this.TypeID(undefined);
            this.TypeName(undefined);
            this.IsSOAllowed(undefined);
            this.StatusID(undefined);
            this.StatusName(undefined);
            this.SAPCode(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);
            this.IsDeleted(undefined);

            this.Parent(undefined);
        }
    });
})();