﻿// ===================================================================================
// Author        : System
// Created date  : 20 Mar 2016 01:38:45
// Description   : vCompanyViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vCompanyViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
        this.Company = ko.observable();
        this.Address1 = ko.observable();
        this.Address2 = ko.observable();
        this.Address3 = ko.observable();
        this.Address = ko.observable();
        this.City = ko.observable();
        this.StateProvince = ko.observable();
        this.CountryID = ko.observable();
        this.CountryName = ko.observable();
        this.ZipCode = ko.observable();
        this.Phone1 = ko.observable();
        this.Phone2 = ko.observable();
        this.Fax = ko.observable();
        this.Email = ko.observable();
        this.TaxNumber = ko.observable();
        this.StatusID = ko.observable();
        this.StatusName = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();
        this.IsDeleted = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vCompanyViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
                Company: this.Company(),
                Address1: this.Address1(),
                Address2: this.Address2(),
                Address3: this.Address3(),
                Address: this.Address(),
                City: this.City(),
                StateProvince: this.StateProvince(),
                CountryID: this.CountryID(),
                CountryName: this.CountryName(),
                ZipCode: this.ZipCode(),
                Phone1: this.Phone1(),
                Phone2: this.Phone2(),
                Fax: this.Fax(),
                Email: this.Email(),
                TaxNumber: this.TaxNumber(),
                StatusID: this.StatusID(),
                StatusName: this.StatusName(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),
                IsDeleted: this.IsDeleted()
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Code(data.Code);
                this.Name(data.Name);
                this.Company(data.Company);
                this.Address1(data.Address1);
                this.Address2(data.Address2);
                this.Address3(data.Address3);
                this.Address(data.Address);
                this.City(data.City);
                this.StateProvince(data.StateProvince);
                this.CountryID(data.CountryID);
                this.CountryName(data.CountryName);
                this.ZipCode(data.ZipCode);
                this.Phone1(data.Phone1);
                this.Phone2(data.Phone2);
                this.Fax(data.Fax);
                this.Email(data.Email);
                this.TaxNumber(data.TaxNumber);
                this.StatusID(data.StatusID);
                this.StatusName(data.StatusName);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);
                this.IsDeleted(data.IsDeleted);
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Code(undefined);
            this.Name(undefined);
            this.Company(undefined);
            this.Address1(undefined);
            this.Address2(undefined);
            this.Address3(undefined);
            this.Address(undefined);
            this.City(undefined);
            this.StateProvince(undefined);
            this.CountryID(undefined);
            this.CountryName(undefined);
            this.ZipCode(undefined);
            this.Phone1(undefined);
            this.Phone2(undefined);
            this.Fax(undefined);
            this.Email(undefined);
            this.TaxNumber(undefined);
            this.StatusID(undefined);
            this.StatusName(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);
            this.IsDeleted(undefined);
        }
    });
})();
