﻿// ===================================================================================
// Author        : System
// Created date  : 06 Nov 2016 22:09:51
// Description   : vSalesmanProductTargetViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vSalesmanProductTargetViewModel = function (data) {
        this.SalesmanID = ko.observable();
        this.PeriodID = ko.observable();
        this.ProductID = ko.observable();
        this.ProductCode = ko.observable();
        this.ProductName = ko.observable();
        this.Product = ko.observable();
        this.ProductBrandID = ko.observable();
        this.ProductBrandCode = ko.observable();
        this.ProductBrandName = ko.observable();
        this.ProductBrand = ko.observable();
        this.ProductShortName = ko.observable();
        this.ProductUOMLID = ko.observable();
        this.ProductUOMMID = ko.observable();
        this.ProductUOMSID = ko.observable();
        this.ProductUOMLName = ko.observable();
        this.ProductUOMMName = ko.observable();
        this.ProductUOMSName = ko.observable();
        this.ProductWeight = ko.observable();
        this.ProductDimensionL = ko.observable();
        this.ProductDimensionW = ko.observable();
        this.ProductDimensionH = ko.observable();
        this.ProductConversionL = ko.observable();
        this.ProductConversionM = ko.observable();
        this.ProductConversionS = ko.observable();
        this.ProductStatusID = ko.observable();
        this.ProductStatusName = ko.observable();
        this.ProductAdditionalInfo1 = ko.observable();
        this.ProductAdditionalInfo2 = ko.observable();
        this.ProductAdditionalInfo3 = ko.observable();
        this.ProductAdditionalInfo4 = ko.observable();
        this.ProductAdditionalInfo5 = ko.observable();
        this.ProductAdditionalInfo6 = ko.observable();
        this.ProductAdditionalInfo7 = ko.observable();
        this.ProductAdditionalInfo8 = ko.observable();
        this.ProductAdditionalInfo9 = ko.observable();
        this.ProductAdditionalInfo10 = ko.observable();
        this.SalesOrderQty = ko.observable();
        this.EffectiveCall = ko.observable();
        this.CustomerTransaction = ko.observable();

        this.EffectiveCallValue = ko.observable();
        this.CustomerTransactionValue = ko.observable();

        this.Parent = ko.observable();

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vSalesmanProductTargetViewModel.prototype, {
        toJS: function () {
            return {
                SalesmanID: this.SalesmanID(),
                PeriodID: this.PeriodID(),
                ProductID: this.ProductID(),
                ProductCode: this.ProductCode(),
                ProductName: this.ProductName(),
                Product: this.Product(),
                ProductBrandID: this.ProductBrandID(),
                ProductBrandCode: this.ProductBrandCode(),
                ProductBrandName: this.ProductBrandName(),
                ProductBrand: this.ProductBrand(),
                ProductShortName: this.ProductShortName(),
                ProductUOMLID: this.ProductUOMLID(),
                ProductUOMMID: this.ProductUOMMID(),
                ProductUOMSID: this.ProductUOMSID(),
                ProductUOMLName: this.ProductUOMLName(),
                ProductUOMMName: this.ProductUOMMName(),
                ProductUOMSName: this.ProductUOMSName(),
                ProductWeight: this.ProductWeight(),
                ProductDimensionL: this.ProductDimensionL(),
                ProductDimensionW: this.ProductDimensionW(),
                ProductDimensionH: this.ProductDimensionH(),
                ProductConversionL: this.ProductConversionL(),
                ProductConversionM: this.ProductConversionM(),
                ProductConversionS: this.ProductConversionS(),
                ProductStatusID: this.ProductStatusID(),
                ProductStatusName: this.ProductStatusName(),
                ProductAdditionalInfo1: this.ProductAdditionalInfo1(),
                ProductAdditionalInfo2: this.ProductAdditionalInfo2(),
                ProductAdditionalInfo3: this.ProductAdditionalInfo3(),
                ProductAdditionalInfo4: this.ProductAdditionalInfo4(),
                ProductAdditionalInfo5: this.ProductAdditionalInfo5(),
                ProductAdditionalInfo6: this.ProductAdditionalInfo6(),
                ProductAdditionalInfo7: this.ProductAdditionalInfo7(),
                ProductAdditionalInfo8: this.ProductAdditionalInfo8(),
                ProductAdditionalInfo9: this.ProductAdditionalInfo9(),
                ProductAdditionalInfo10: this.ProductAdditionalInfo10(),
                SalesOrderQty: this.SalesOrderQty(),
                EffectiveCall: this.EffectiveCall(),
                CustomerTransaction: this.CustomerTransaction(),

                EffectiveCallValue: this.EffectiveCallValue(),
                CustomerTransactionValue: this.CustomerTransactionValue(),

                Parent: this.Parent()
            };
        },

        fromJS: function (data) {
            if (data) {
                this.SalesmanID(data.SalesmanID);
                this.PeriodID(data.PeriodID);
                this.ProductID(data.ProductID);
                this.ProductCode(data.ProductCode);
                this.ProductName(data.ProductName);
                this.Product(data.Product);
                this.ProductBrandID(data.ProductBrandID);
                this.ProductBrandCode(data.ProductBrandCode);
                this.ProductBrandName(data.ProductBrandName);
                this.ProductBrand(data.ProductBrand);
                this.ProductShortName(data.ProductShortName);
                this.ProductUOMLID(data.ProductUOMLID);
                this.ProductUOMMID(data.ProductUOMMID);
                this.ProductUOMSID(data.ProductUOMSID);
                this.ProductUOMLName(data.ProductUOMLName);
                this.ProductUOMMName(data.ProductUOMMName);
                this.ProductUOMSName(data.ProductUOMSName);
                this.ProductWeight(data.ProductWeight);
                this.ProductDimensionL(data.ProductDimensionL);
                this.ProductDimensionW(data.ProductDimensionW);
                this.ProductDimensionH(data.ProductDimensionH);
                this.ProductConversionL(data.ProductConversionL);
                this.ProductConversionM(data.ProductConversionM);
                this.ProductConversionS(data.ProductConversionS);
                this.ProductStatusID(data.ProductStatusID);
                this.ProductStatusName(data.ProductStatusName);
                this.ProductAdditionalInfo1(data.ProductAdditionalInfo1);
                this.ProductAdditionalInfo2(data.ProductAdditionalInfo2);
                this.ProductAdditionalInfo3(data.ProductAdditionalInfo3);
                this.ProductAdditionalInfo4(data.ProductAdditionalInfo4);
                this.ProductAdditionalInfo5(data.ProductAdditionalInfo5);
                this.ProductAdditionalInfo6(data.ProductAdditionalInfo6);
                this.ProductAdditionalInfo7(data.ProductAdditionalInfo7);
                this.ProductAdditionalInfo8(data.ProductAdditionalInfo8);
                this.ProductAdditionalInfo9(data.ProductAdditionalInfo9);
                this.ProductAdditionalInfo10(data.ProductAdditionalInfo10);
                this.SalesOrderQty(data.SalesOrderQty);
                this.EffectiveCall(data.EffectiveCall);
                this.CustomerTransaction(data.CustomerTransaction);

                this.EffectiveCallValue(data.EffectiveCallValue);
                this.CustomerTransactionValue(data.CustomerTransactionValue);

                if (data.Parent)
                    this.Parent(data.Parent);
            }
        },

        clear: function () {
            this.SalesmanID(undefined);
            this.PeriodID(undefined);
            this.ProductID(undefined);
            this.ProductCode(undefined);
            this.ProductName(undefined);
            this.Product(undefined);
            this.ProductBrandID(undefined);
            this.ProductBrandCode(undefined);
            this.ProductBrandName(undefined);
            this.ProductBrand(undefined);
            this.ProductShortName(undefined);
            this.ProductUOMLID(undefined);
            this.ProductUOMMID(undefined);
            this.ProductUOMSID(undefined);
            this.ProductUOMLName(undefined);
            this.ProductUOMMName(undefined);
            this.ProductUOMSName(undefined);
            this.ProductWeight(undefined);
            this.ProductDimensionL(undefined);
            this.ProductDimensionW(undefined);
            this.ProductDimensionH(undefined);
            this.ProductConversionL(undefined);
            this.ProductConversionM(undefined);
            this.ProductConversionS(undefined);
            this.ProductStatusID(undefined);
            this.ProductStatusName(undefined);
            this.ProductAdditionalInfo1(undefined);
            this.ProductAdditionalInfo2(undefined);
            this.ProductAdditionalInfo3(undefined);
            this.ProductAdditionalInfo4(undefined);
            this.ProductAdditionalInfo5(undefined);
            this.ProductAdditionalInfo6(undefined);
            this.ProductAdditionalInfo7(undefined);
            this.ProductAdditionalInfo8(undefined);
            this.ProductAdditionalInfo9(undefined);
            this.ProductAdditionalInfo10(undefined);
            this.SalesOrderQty(undefined);
            this.EffectiveCall(undefined);
            this.CustomerTransaction(undefined);

            this.EffectiveCallValue(undefined);
            this.CustomerTransactionValue(undefined);

            this.Parent(undefined);
        }
    });
})();
