// ===================================================================================
// Author        : System
// Created date  : 09 Mar 2016 11:47:54
// Description   : vCustomerCategoryViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vCustomerCategoryViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
        this.Category = ko.observable();
        this.ParentID = ko.observable();
        this.ParentCode = ko.observable();
        this.ParentName = ko.observable();
        this.Parent = ko.observable();
        this.Group = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vCustomerCategoryViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
                Category: this.Category(),
                ParentID: this.ParentID(),
                ParentCode: this.ParentCode(),
                ParentName: this.ParentName(),
                Parent: this.Parent(),
                Group: this.Group(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName()
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Code(data.Code);
                this.Name(data.Name);
                this.Category(data.Category);
                this.ParentID(data.ParentID);
                this.ParentCode(data.ParentCode);
                this.ParentName(data.ParentName);
                this.Parent(data.Parent);
                this.Group(data.Group);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Code(undefined);
            this.Name(undefined);
            this.Category(undefined);
            this.ParentID(undefined);
            this.ParentCode(undefined);
            this.ParentName(undefined);
            this.Parent(undefined);
            this.Group(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);
        }
    });
})();
