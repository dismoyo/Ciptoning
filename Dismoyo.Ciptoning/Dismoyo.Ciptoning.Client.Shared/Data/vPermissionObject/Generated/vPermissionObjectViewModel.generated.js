﻿// ===================================================================================
// Author        : System
// Created date  : 27 Jul 2016 00:37:24
// Description   : vPermissionObjectViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vPermissionObjectViewModel = function (data) {
        this.ID = ko.observable();
        this.Description = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();

        this.ChildUserRolePermissions = ko.observableArray([]);

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vPermissionObjectViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Description: this.Description(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),

                ChildUserRolePermissions: ko.toJS(this.ChildUserRolePermissions())
            };
        },

        fromJS: function (data) {
            if (data) {
                this.ID(data.ID);
                this.Description(data.Description);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);

                if (data.ChildUserRolePermissions) {
                    for (var i = 0; i < data.ChildUserRolePermissions.length; i++)
                        this.ChildUserRolePermissions.push(new Dismoyo_Ciptoning_Client.vUserRolePermissionViewModel(
                            data.ChildUserRolePermissions[i]));
                }
            }
        },

        clear: function () {
            this.ID(undefined);
            this.Description(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);

            this.ChildUserRolePermissions(undefined);
        }
    });
})();
