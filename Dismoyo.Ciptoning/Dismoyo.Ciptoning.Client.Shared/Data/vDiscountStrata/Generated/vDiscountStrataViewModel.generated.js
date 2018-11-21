﻿// ===================================================================================
// Author        : System
// Created date  : 14 Apr 2016 10:06:07
// Description   : vDiscountStrataViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vDiscountStrataViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
        this.DiscountStrata = ko.observable();
        this.ValidDateFrom = ko.observable();
        this.ValidDateTo = ko.observable();
        this.StatusID = ko.observable();
        this.StatusName = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();
        this.IsDeleted = ko.observable();

        this.ChildDetails = ko.observableArray([]);

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vDiscountStrataViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
                DiscountStrata: this.DiscountStrata(),
                ValidDateFrom: this.ValidDateFrom(),
                ValidDateTo: this.ValidDateTo(),
                StatusID: this.StatusID(),
                StatusName: this.StatusName(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),
                IsDeleted: this.IsDeleted(),

                ChildDetails: ko.toJS(this.ChildDetails())
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Code(data.Code);
                this.Name(data.Name);
                this.DiscountStrata(data.DiscountStrata);
                this.ValidDateFrom(data.ValidDateFrom);
                this.ValidDateTo(data.ValidDateTo);
                this.StatusID(data.StatusID);
                this.StatusName(data.StatusName);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);
                this.IsDeleted(data.IsDeleted);

                if (data.ChildDetails) {
                    for (var i = 0; i < data.ChildDetails.length; i++)
                        this.ChildDetails.push(new Dismoyo_Ciptoning_Client.vDiscountStrataDetailsViewModel(
                            data.ChildDetails[i]));
                }
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Code(undefined);
            this.Name(undefined);
            this.DiscountStrata(undefined);
            this.ValidDateFrom(undefined);
            this.ValidDateTo(undefined);
            this.StatusID(undefined);
            this.StatusName(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);
            this.IsDeleted(undefined);

            this.ChildDetails(undefined);
        }
    });
})();