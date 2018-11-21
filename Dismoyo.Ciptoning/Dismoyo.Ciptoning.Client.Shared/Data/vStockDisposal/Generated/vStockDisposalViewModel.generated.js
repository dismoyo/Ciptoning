﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 12:44:40
// Description   : vStockDisposalViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vStockDisposalViewModel = function (data) {
        this.DocumentID = ko.observable();
        this.DocumentCode = ko.observable();
        this.TransactionDate = ko.observable();
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
        this.WarehouseTypeID = ko.observable();
        this.WarehouseTypeName = ko.observable();
        this.IsSiteLotNumberEntryRequired = ko.observable();
        this.PIC = ko.observable();
        this.ReferenceNumber = ko.observable();
        this.AttachmentFile = ko.observable();
        this.DocumentStatusID = ko.observable();
        this.DocumentStatusName = ko.observable();
        this.PostedDate = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();

        this.ChildSummaries = ko.observableArray([]);

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vStockDisposalViewModel.prototype, {
        toJS: function () {
            return {
                DocumentID: this.DocumentID(),
                DocumentCode: this.DocumentCode(),
                TransactionDate: this.TransactionDate(),
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
                WarehouseTypeID: this.WarehouseTypeID(),
                WarehouseTypeName: this.WarehouseTypeName(),
                IsSiteLotNumberEntryRequired: this.IsSiteLotNumberEntryRequired(),
                PIC: this.PIC(),
                ReferenceNumber: this.ReferenceNumber(),
                AttachmentFile: this.AttachmentFile(),
                DocumentStatusID: this.DocumentStatusID(),
                DocumentStatusName: this.DocumentStatusName(),
                PostedDate: this.PostedDate(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),

                ChildSummaries: ko.toJS(this.ChildSummaries())
            }
        },

        fromJS: function (data) {
            if (data) {
                this.DocumentID(data.DocumentID);
                this.DocumentCode(data.DocumentCode);
                this.TransactionDate(data.TransactionDate);
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
                this.WarehouseTypeID(data.WarehouseTypeID);
                this.WarehouseTypeName(data.WarehouseTypeName);
                this.IsSiteLotNumberEntryRequired(data.IsSiteLotNumberEntryRequired);
                this.PIC(data.PIC);
                this.ReferenceNumber(data.ReferenceNumber);
                this.AttachmentFile(data.AttachmentFile);
                this.DocumentStatusID(data.DocumentStatusID);
                this.DocumentStatusName(data.DocumentStatusName);
                this.PostedDate(data.PostedDate);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);

                if (data.ChildSummaries) {
                    for (var i = 0; i < data.ChildSummaries.length; i++)
                        this.ChildSummaries.push(new Dismoyo_Ciptoning_Client.vStockDisposalSummaryViewModel(
                            data.ChildSummaries[i]));
                }
            }
        },

        clear: function () {
            this.DocumentID(undefined);
            this.DocumentCode(undefined);
            this.TransactionDate(undefined);
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
            this.WarehouseTypeID(undefined);
            this.WarehouseTypeName(undefined);
            this.IsSiteLotNumberEntryRequired(undefined);
            this.PIC(undefined);
            this.ReferenceNumber(undefined);
            this.AttachmentFile(undefined);
            this.DocumentStatusID(undefined);
            this.DocumentStatusName(undefined);
            this.PostedDate(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);

            this.ChildSummaries(undefined);
        }
    });
})();
