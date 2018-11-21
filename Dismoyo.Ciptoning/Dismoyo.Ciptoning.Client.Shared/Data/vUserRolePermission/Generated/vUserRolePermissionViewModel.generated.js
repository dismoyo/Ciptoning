﻿// ===================================================================================
// Author        : System
// Created date  : 01 Aug 2016 05:24:47
// Description   : vUserRolePermissionViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vUserRolePermissionViewModel = function (data) {
        this.PermissionObjectID = ko.observable();
        this.UserRoleID = ko.observable();
        this.IsUser = ko.observable();
        this.UserRoleName = ko.observable();
        this.IsUserHeadOffice = ko.observable();
        this.UserSiteID = ko.observable();
        this.UserSiteCode = ko.observable();
        this.UserSiteName = ko.observable();
        this.UserSite = ko.observable();
        this.UserAreaID = ko.observable();
        this.UserAreaCode = ko.observable();
        this.UserAreaName = ko.observable();
        this.UserArea = ko.observable();
        this.UserRegionID = ko.observable();
        this.UserRegionCode = ko.observable();
        this.UserRegionName = ko.observable();
        this.UserRegion = ko.observable();
        this.UserTerritoryID = ko.observable();
        this.UserTerritoryCode = ko.observable();
        this.UserTerritoryName = ko.observable();
        this.UserTerritory = ko.observable();
        this.UserCompanyID = ko.observable();
        this.UserCompanyCode = ko.observable();
        this.UserCompanyName = ko.observable();
        this.UserCompany = ko.observable();
        this.UserSiteDistributionTypeID = ko.observable();
        this.UserSiteDistributionTypeName = ko.observable();
        this.IsUserSiteLotNumberEntryRequired = ko.observable();
        this.UserStatusID = ko.observable();
        this.UserStatusName = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();

        this.ParentPermissionObject = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vUserRolePermissionViewModel.prototype, {
        toJS: function () {
            return {
                PermissionObjectID: this.PermissionObjectID(),
                UserRoleID: this.UserRoleID(),
                IsUser: this.IsUser(),
                UserRoleName: this.UserRoleName(),
                IsUserHeadOffice: this.IsUserHeadOffice(),
                UserSiteID: this.UserSiteID(),
                UserSiteCode: this.UserSiteCode(),
                UserSiteName: this.UserSiteName(),
                UserSite: this.UserSite(),
                UserAreaID: this.UserAreaID(),
                UserAreaCode: this.UserAreaCode(),
                UserAreaName: this.UserAreaName(),
                UserArea: this.UserArea(),
                UserRegionID: this.UserRegionID(),
                UserRegionCode: this.UserRegionCode(),
                UserRegionName: this.UserRegionName(),
                UserRegion: this.UserRegion(),
                UserTerritoryID: this.UserTerritoryID(),
                UserTerritoryCode: this.UserTerritoryCode(),
                UserTerritoryName: this.UserTerritoryName(),
                UserTerritory: this.UserTerritory(),
                UserCompanyID: this.UserCompanyID(),
                UserCompanyCode: this.UserCompanyCode(),
                UserCompanyName: this.UserCompanyName(),
                UserCompany: this.UserCompany(),
                UserSiteDistributionTypeID: this.UserSiteDistributionTypeID(),
                UserSiteDistributionTypeName: this.UserSiteDistributionTypeName(),
                IsUserSiteLotNumberEntryRequired: this.IsUserSiteLotNumberEntryRequired(),
                UserStatusID: this.UserStatusID(),
                UserStatusName: this.UserStatusName(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),

                ParentPermissionObject: this.ParentPermissionObject()
            };
        },

        fromJS: function (data) {
            if (data) {
                this.PermissionObjectID(data.PermissionObjectID);
                this.UserRoleID(data.UserRoleID);
                this.IsUser(data.IsUser);
                this.UserRoleName(data.UserRoleName);
                this.IsUserHeadOffice(data.IsUserHeadOffice);
                this.UserSiteID(data.UserSiteID);
                this.UserSiteCode(data.UserSiteCode);
                this.UserSiteName(data.UserSiteName);
                this.UserSite(data.UserSite);
                this.UserAreaID(data.UserAreaID);
                this.UserAreaCode(data.UserAreaCode);
                this.UserAreaName(data.UserAreaName);
                this.UserArea(data.UserArea);
                this.UserRegionID(data.UserRegionID);
                this.UserRegionCode(data.UserRegionCode);
                this.UserRegionName(data.UserRegionName);
                this.UserRegion(data.UserRegion);
                this.UserTerritoryID(data.UserTerritoryID);
                this.UserTerritoryCode(data.UserTerritoryCode);
                this.UserTerritoryName(data.UserTerritoryName);
                this.UserTerritory(data.UserTerritory);
                this.UserCompanyID(data.UserCompanyID);
                this.UserCompanyCode(data.UserCompanyCode);
                this.UserCompanyName(data.UserCompanyName);
                this.UserCompany(data.UserCompany);
                this.UserSiteDistributionTypeID(data.UserSiteDistributionTypeID);
                this.UserSiteDistributionTypeName(data.UserSiteDistributionTypeName);
                this.IsUserSiteLotNumberEntryRequired(data.IsUserSiteLotNumberEntryRequired);
                this.UserStatusID(data.UserStatusID);
                this.UserStatusName(data.UserStatusName);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);

                if (data.ParentPermissionObject)
                    this.ParentPermissionObject(data.ParentPermissionObject);
            }
        },

        clear: function () {
            this.PermissionObjectID(undefined);
            this.UserRoleID(undefined);
            this.IsUser(undefined);
            this.UserRoleName(undefined);
            this.IsUserHeadOffice(undefined);
            this.UserSiteID(undefined);
            this.UserSiteCode(undefined);
            this.UserSiteName(undefined);
            this.UserSite(undefined);
            this.UserAreaID(undefined);
            this.UserAreaCode(undefined);
            this.UserAreaName(undefined);
            this.UserArea(undefined);
            this.UserRegionID(undefined);
            this.UserRegionCode(undefined);
            this.UserRegionName(undefined);
            this.UserRegion(undefined);
            this.UserTerritoryID(undefined);
            this.UserTerritoryCode(undefined);
            this.UserTerritoryName(undefined);
            this.UserTerritory(undefined);
            this.UserCompanyID(undefined);
            this.UserCompanyCode(undefined);
            this.UserCompanyName(undefined);
            this.UserCompany(undefined);
            this.UserSiteDistributionTypeID(undefined);
            this.UserSiteDistributionTypeName(undefined);
            this.IsUserSiteLotNumberEntryRequired(undefined);
            this.UserStatusID(undefined);
            this.UserStatusName(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);

            this.ParentPermissionObject(undefined);
        }
    });
})();