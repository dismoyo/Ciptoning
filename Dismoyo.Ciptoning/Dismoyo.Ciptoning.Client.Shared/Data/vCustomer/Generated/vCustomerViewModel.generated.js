// ===================================================================================
// Author        : System
// Created date  : 10 May 2016 17:47:45
// Description   : vCustomerViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vCustomerViewModel = function (data) {
        this.ID = ko.observable();
        this.Code = ko.observable();
        this.Name = ko.observable();
        this.Customer = ko.observable();
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
        this.SiteDistributionTypeID = ko.observable();
        this.SiteDistributionTypeName = ko.observable();
        this.WarehouseTypeID = ko.observable();
        this.WarehouseTypeName = ko.observable();
        this.SalesmanGroupID = ko.observable();
        this.SalesmanGroupName = ko.observable();
        this.SalesmanCategoryID = ko.observable();
        this.SalesmanCategoryName = ko.observable();
        this.SalesmanPhoneID = ko.observable();
        this.SalesmanSFA = ko.observable();
        this.SalesmanStatusID = ko.observable();
        this.SalesmanStatusName = ko.observable();
        this.IsSalesmanDeleted = ko.observable();
        this.RegisteredDate = ko.observable();
        this.TermOfPaymentID = ko.observable();
        this.TermOfPaymentName = ko.observable();
        this.CreditLimit = ko.observable();
        this.PriceGroupID = ko.observable();
        this.PriceGroupName = ko.observable();
        this.DiscountGroupID = ko.observable();
        this.DiscountGroupCode = ko.observable();
        this.DiscountGroupName = ko.observable();
        this.DiscountGroup = ko.observable();
        this.DiscountGroupDescription = ko.observable();
        this.DiscountGroupStatusID = ko.observable();
        this.DiscountGroupStatusName = ko.observable();
        this.IsTaxNumberAvailable = ko.observable();
        this.TaxSAPCode = ko.observable();
        this.TaxNumber = ko.observable();
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
        this.Phone3 = ko.observable();
        this.Fax = ko.observable();
        this.Email = ko.observable();
        this.Longitude = ko.observable();
        this.Latitude = ko.observable();
        this.IsBillSameAsAddress = ko.observable();
        this.BillName = ko.observable();
        this.BillAddress1 = ko.observable();
        this.BillAddress2 = ko.observable();
        this.BillAddress3 = ko.observable();
        this.BillAddress = ko.observable();
        this.BillCity = ko.observable();
        this.BillStateProvince = ko.observable();
        this.BillCountryID = ko.observable();
        this.BillCountryName = ko.observable();
        this.BillZipCode = ko.observable();
        this.BillPhone1 = ko.observable();
        this.BillPhone2 = ko.observable();
        this.BillPhone3 = ko.observable();
        this.BillFax = ko.observable();
        this.BillEmail = ko.observable();
        this.IsTaxSameAsAddress = ko.observable();
        this.IsTaxSameAsBillAddress = ko.observable();
        this.TaxName = ko.observable();
        this.TaxAddress1 = ko.observable();
        this.TaxAddress2 = ko.observable();
        this.TaxAddress3 = ko.observable();
        this.TaxAddress = ko.observable();
        this.TaxCity = ko.observable();
        this.TaxStateProvince = ko.observable();
        this.TaxCountryID = ko.observable();
        this.TaxCountryName = ko.observable();
        this.TaxZipCode = ko.observable();
        this.TaxPhone1 = ko.observable();
        this.TaxPhone2 = ko.observable();
        this.TaxPhone3 = ko.observable();
        this.TaxFax = ko.observable();
        this.TaxEmail = ko.observable();
        this.AdditionalInfo1 = ko.observable();
        this.AdditionalInfo2 = ko.observable();
        this.AdditionalInfo3 = ko.observable();
        this.AdditionalInfo4 = ko.observable();
        this.AdditionalInfo5 = ko.observable();
        this.AdditionalInfo6 = ko.observable();
        this.AdditionalInfo7 = ko.observable();
        this.AdditionalInfo8 = ko.observable();
        this.AdditionalInfo9 = ko.observable();
        this.AdditionalInfo10 = ko.observable();
        this.Category1ID = ko.observable();
        this.Category1Code = ko.observable();
        this.Category1Name = ko.observable();
        this.Category1 = ko.observable();
        this.Category2ID = ko.observable();
        this.Category2Code = ko.observable();
        this.Category2Name = ko.observable();
        this.Category2 = ko.observable();
        this.Category3ID = ko.observable();
        this.Category3Code = ko.observable();
        this.Category3Name = ko.observable();
        this.Category3 = ko.observable();
        this.Category4ID = ko.observable();
        this.Category4Code = ko.observable();
        this.Category4Name = ko.observable();
        this.Category4 = ko.observable();
        this.Category5ID = ko.observable();
        this.Category5Code = ko.observable();
        this.Category5Name = ko.observable();
        this.Category5 = ko.observable();
        this.Category6ID = ko.observable();
        this.Category6Code = ko.observable();
        this.Category6Name = ko.observable();
        this.Category6 = ko.observable();
        this.Category7ID = ko.observable();
        this.Category7Code = ko.observable();
        this.Category7Name = ko.observable();
        this.Category7 = ko.observable();
        this.Category8ID = ko.observable();
        this.Category8Code = ko.observable();
        this.Category8Name = ko.observable();
        this.Category8 = ko.observable();
        this.Category9ID = ko.observable();
        this.Category9Code = ko.observable();
        this.Category9Name = ko.observable();
        this.Category9 = ko.observable();
        this.Category10ID = ko.observable();
        this.Category10Code = ko.observable();
        this.Category10Name = ko.observable();
        this.Category10 = ko.observable();
        this.Photo = ko.observable();
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

    $.extend(Dismoyo_Ciptoning_Client.vCustomerViewModel.prototype, {
        toJS: function () {
            return {
                ID: this.ID(),
                Code: this.Code(),
                Name: this.Name(),
                Customer: this.Customer(),
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
                SiteDistributionTypeID: this.SiteDistributionTypeID(),
                SiteDistributionTypeName: this.SiteDistributionTypeName(),
                WarehouseTypeID: this.WarehouseTypeID(),
                WarehouseTypeName: this.WarehouseTypeName(),
                SalesmanGroupID: this.SalesmanGroupID(),
                SalesmanGroupName: this.SalesmanGroupName(),
                SalesmanCategoryID: this.SalesmanCategoryID(),
                SalesmanCategoryName: this.SalesmanCategoryName(),
                SalesmanPhoneID: this.SalesmanPhoneID(),
                SalesmanSFA: this.SalesmanSFA(),
                SalesmanStatusID: this.SalesmanStatusID(),
                SalesmanStatusName: this.SalesmanStatusName(),
                IsSalesmanDeleted: this.IsSalesmanDeleted(),
                RegisteredDate: this.RegisteredDate(),
                TermOfPaymentID: this.TermOfPaymentID(),
                TermOfPaymentName: this.TermOfPaymentName(),
                CreditLimit: this.CreditLimit(),
                PriceGroupID: this.PriceGroupID(),
                PriceGroupName: this.PriceGroupName(),
                DiscountGroupID: this.DiscountGroupID(),
                DiscountGroupCode: this.DiscountGroupCode(),
                DiscountGroupName: this.DiscountGroupName(),
                DiscountGroup: this.DiscountGroup(),
                DiscountGroupDescription: this.DiscountGroupDescription(),
                DiscountGroupStatusID: this.DiscountGroupStatusID(),
                DiscountGroupStatusName: this.DiscountGroupStatusName(),
                IsTaxNumberAvailable: this.IsTaxNumberAvailable(),
                TaxSAPCode: this.TaxSAPCode(),
                TaxNumber: this.TaxNumber(),
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
                Phone3: this.Phone3(),
                Fax: this.Fax(),
                Email: this.Email(),
                Longitude: this.Longitude(),
                Latitude: this.Latitude(),
                IsBillSameAsAddress: this.IsBillSameAsAddress(),
                BillName: this.BillName(),
                BillAddress1: this.BillAddress1(),
                BillAddress2: this.BillAddress2(),
                BillAddress3: this.BillAddress3(),
                BillAddress: this.BillAddress(),
                BillCity: this.BillCity(),
                BillStateProvince: this.BillStateProvince(),
                BillCountryID: this.BillCountryID(),
                BillCountryName: this.BillCountryName(),
                BillZipCode: this.BillZipCode(),
                BillPhone1: this.BillPhone1(),
                BillPhone2: this.BillPhone2(),
                BillPhone3: this.BillPhone3(),
                BillFax: this.BillFax(),
                BillEmail: this.BillEmail(),
                IsTaxSameAsAddress: this.IsTaxSameAsAddress(),
                IsTaxSameAsBillAddress: this.IsTaxSameAsBillAddress(),
                TaxName: this.TaxName(),
                TaxAddress1: this.TaxAddress1(),
                TaxAddress2: this.TaxAddress2(),
                TaxAddress3: this.TaxAddress3(),
                TaxAddress: this.TaxAddress(),
                TaxCity: this.TaxCity(),
                TaxStateProvince: this.TaxStateProvince(),
                TaxCountryID: this.TaxCountryID(),
                TaxCountryName: this.TaxCountryName(),
                TaxZipCode: this.TaxZipCode(),
                TaxPhone1: this.TaxPhone1(),
                TaxPhone2: this.TaxPhone2(),
                TaxPhone3: this.TaxPhone3(),
                TaxFax: this.TaxFax(),
                TaxEmail: this.TaxEmail(),
                AdditionalInfo1: this.AdditionalInfo1(),
                AdditionalInfo2: this.AdditionalInfo2(),
                AdditionalInfo3: this.AdditionalInfo3(),
                AdditionalInfo4: this.AdditionalInfo4(),
                AdditionalInfo5: this.AdditionalInfo5(),
                AdditionalInfo6: this.AdditionalInfo6(),
                AdditionalInfo7: this.AdditionalInfo7(),
                AdditionalInfo8: this.AdditionalInfo8(),
                AdditionalInfo9: this.AdditionalInfo9(),
                AdditionalInfo10: this.AdditionalInfo10(),
                Category1ID: this.Category1ID(),
                Category1Code: this.Category1Code(),
                Category1Name: this.Category1Name(),
                Category1: this.Category1(),
                Category2ID: this.Category2ID(),
                Category2Code: this.Category2Code(),
                Category2Name: this.Category2Name(),
                Category2: this.Category2(),
                Category3ID: this.Category3ID(),
                Category3Code: this.Category3Code(),
                Category3Name: this.Category3Name(),
                Category3: this.Category3(),
                Category4ID: this.Category4ID(),
                Category4Code: this.Category4Code(),
                Category4Name: this.Category4Name(),
                Category4: this.Category4(),
                Category5ID: this.Category5ID(),
                Category5Code: this.Category5Code(),
                Category5Name: this.Category5Name(),
                Category5: this.Category5(),
                Category6ID: this.Category6ID(),
                Category6Code: this.Category6Code(),
                Category6Name: this.Category6Name(),
                Category6: this.Category6(),
                Category7ID: this.Category7ID(),
                Category7Code: this.Category7Code(),
                Category7Name: this.Category7Name(),
                Category7: this.Category7(),
                Category8ID: this.Category8ID(),
                Category8Code: this.Category8Code(),
                Category8Name: this.Category8Name(),
                Category8: this.Category8(),
                Category9ID: this.Category9ID(),
                Category9Code: this.Category9Code(),
                Category9Name: this.Category9Name(),
                Category9: this.Category9(),
                Category10ID: this.Category10ID(),
                Category10Code: this.Category10Code(),
                Category10Name: this.Category10Name(),
                Category10: this.Category10(),
                Photo: this.Photo(),
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
                this.Customer(data.Customer);
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
                this.SiteDistributionTypeID(data.SiteDistributionTypeID);
                this.SiteDistributionTypeName(data.SiteDistributionTypeName);
                this.WarehouseTypeID(data.WarehouseTypeID);
                this.WarehouseTypeName(data.WarehouseTypeName);
                this.SalesmanGroupID(data.SalesmanGroupID);
                this.SalesmanGroupName(data.SalesmanGroupName);
                this.SalesmanCategoryID(data.SalesmanCategoryID);
                this.SalesmanCategoryName(data.SalesmanCategoryName);
                this.SalesmanPhoneID(data.SalesmanPhoneID);
                this.SalesmanSFA(data.SalesmanSFA);
                this.SalesmanStatusID(data.SalesmanStatusID);
                this.SalesmanStatusName(data.SalesmanStatusName);
                this.IsSalesmanDeleted(data.IsSalesmanDeleted);
                this.RegisteredDate(data.RegisteredDate);
                this.TermOfPaymentID(data.TermOfPaymentID);
                this.TermOfPaymentName(data.TermOfPaymentName);
                this.CreditLimit(data.CreditLimit);
                this.PriceGroupID(data.PriceGroupID);
                this.PriceGroupName(data.PriceGroupName);
                this.DiscountGroupID(data.DiscountGroupID);
                this.DiscountGroupCode(data.DiscountGroupCode);
                this.DiscountGroupName(data.DiscountGroupName);
                this.DiscountGroup(data.DiscountGroup);
                this.DiscountGroupDescription(data.DiscountGroupDescription);
                this.DiscountGroupStatusID(data.DiscountGroupStatusID);
                this.DiscountGroupStatusName(data.DiscountGroupStatusName);
                this.IsTaxNumberAvailable(data.IsTaxNumberAvailable);
                this.TaxSAPCode(data.TaxSAPCode);
                this.TaxNumber(data.TaxNumber);
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
                this.Phone3(data.Phone3);
                this.Fax(data.Fax);
                this.Email(data.Email);
                this.Longitude(data.Longitude);
                this.Latitude(data.Latitude);
                this.IsBillSameAsAddress(data.IsBillSameAsAddress);
                this.BillName(data.BillName);
                this.BillAddress1(data.BillAddress1);
                this.BillAddress2(data.BillAddress2);
                this.BillAddress3(data.BillAddress3);
                this.BillAddress(data.BillAddress);
                this.BillCity(data.BillCity);
                this.BillStateProvince(data.BillStateProvince);
                this.BillCountryID(data.BillCountryID);
                this.BillCountryName(data.BillCountryName);
                this.BillZipCode(data.BillZipCode);
                this.BillPhone1(data.BillPhone1);
                this.BillPhone2(data.BillPhone2);
                this.BillPhone3(data.BillPhone3);
                this.BillFax(data.BillFax);
                this.BillEmail(data.BillEmail);
                this.IsTaxSameAsAddress(data.IsTaxSameAsAddress);
                this.IsTaxSameAsBillAddress(data.IsTaxSameAsBillAddress);
                this.TaxName(data.TaxName);
                this.TaxAddress1(data.TaxAddress1);
                this.TaxAddress2(data.TaxAddress2);
                this.TaxAddress3(data.TaxAddress3);
                this.TaxAddress(data.TaxAddress);
                this.TaxCity(data.TaxCity);
                this.TaxStateProvince(data.TaxStateProvince);
                this.TaxCountryID(data.TaxCountryID);
                this.TaxCountryName(data.TaxCountryName);
                this.TaxZipCode(data.TaxZipCode);
                this.TaxPhone1(data.TaxPhone1);
                this.TaxPhone2(data.TaxPhone2);
                this.TaxPhone3(data.TaxPhone3);
                this.TaxFax(data.TaxFax);
                this.TaxEmail(data.TaxEmail);
                this.AdditionalInfo1(data.AdditionalInfo1);
                this.AdditionalInfo2(data.AdditionalInfo2);
                this.AdditionalInfo3(data.AdditionalInfo3);
                this.AdditionalInfo4(data.AdditionalInfo4);
                this.AdditionalInfo5(data.AdditionalInfo5);
                this.AdditionalInfo6(data.AdditionalInfo6);
                this.AdditionalInfo7(data.AdditionalInfo7);
                this.AdditionalInfo8(data.AdditionalInfo8);
                this.AdditionalInfo9(data.AdditionalInfo9);
                this.AdditionalInfo10(data.AdditionalInfo10);
                this.Category1ID(data.Category1ID);
                this.Category1Code(data.Category1Code);
                this.Category1Name(data.Category1Name);
                this.Category1(data.Category1);
                this.Category2ID(data.Category2ID);
                this.Category2Code(data.Category2Code);
                this.Category2Name(data.Category2Name);
                this.Category2(data.Category2);
                this.Category3ID(data.Category3ID);
                this.Category3Code(data.Category3Code);
                this.Category3Name(data.Category3Name);
                this.Category3(data.Category3);
                this.Category4ID(data.Category4ID);
                this.Category4Code(data.Category4Code);
                this.Category4Name(data.Category4Name);
                this.Category4(data.Category4);
                this.Category5ID(data.Category5ID);
                this.Category5Code(data.Category5Code);
                this.Category5Name(data.Category5Name);
                this.Category5(data.Category5);
                this.Category6ID(data.Category6ID);
                this.Category6Code(data.Category6Code);
                this.Category6Name(data.Category6Name);
                this.Category6(data.Category6);
                this.Category7ID(data.Category7ID);
                this.Category7Code(data.Category7Code);
                this.Category7Name(data.Category7Name);
                this.Category7(data.Category7);
                this.Category8ID(data.Category8ID);
                this.Category8Code(data.Category8Code);
                this.Category8Name(data.Category8Name);
                this.Category8(data.Category8);
                this.Category9ID(data.Category9ID);
                this.Category9Code(data.Category9Code);
                this.Category9Name(data.Category9Name);
                this.Category9(data.Category9);
                this.Category10ID(data.Category10ID);
                this.Category10Code(data.Category10Code);
                this.Category10Name(data.Category10Name);
                this.Category10(data.Category10);
                this.Photo(data.Photo);
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
            this.Customer(undefined);
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
            this.SiteDistributionTypeID(undefined);
            this.SiteDistributionTypeName(undefined);
            this.WarehouseTypeID(undefined);
            this.WarehouseTypeName(undefined);
            this.SalesmanGroupID(undefined);
            this.SalesmanGroupName(undefined);
            this.SalesmanCategoryID(undefined);
            this.SalesmanCategoryName(undefined);
            this.SalesmanPhoneID(undefined);
            this.SalesmanSFA(undefined);
            this.SalesmanStatusID(undefined);
            this.SalesmanStatusName(undefined);
            this.IsSalesmanDeleted(undefined);
            this.RegisteredDate(undefined);
            this.TermOfPaymentID(undefined);
            this.TermOfPaymentName(undefined);
            this.CreditLimit(undefined);
            this.PriceGroupID(undefined);
            this.PriceGroupName(undefined);
            this.DiscountGroupID(undefined);
            this.DiscountGroupCode(undefined);
            this.DiscountGroupName(undefined);
            this.DiscountGroup(undefined);
            this.DiscountGroupDescription(undefined);
            this.DiscountGroupStatusID(undefined);
            this.DiscountGroupStatusName(undefined);
            this.IsTaxNumberAvailable(undefined);
            this.TaxSAPCode(undefined);
            this.TaxNumber(undefined);
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
            this.Phone3(undefined);
            this.Fax(undefined);
            this.Email(undefined);
            this.Longitude(undefined);
            this.Latitude(undefined);
            this.IsBillSameAsAddress(undefined);
            this.BillName(undefined);
            this.BillAddress1(undefined);
            this.BillAddress2(undefined);
            this.BillAddress3(undefined);
            this.BillAddress(undefined);
            this.BillCity(undefined);
            this.BillStateProvince(undefined);
            this.BillCountryID(undefined);
            this.BillCountryName(undefined);
            this.BillZipCode(undefined);
            this.BillPhone1(undefined);
            this.BillPhone2(undefined);
            this.BillPhone3(undefined);
            this.BillFax(undefined);
            this.BillEmail(undefined);
            this.IsTaxSameAsAddress(undefined);
            this.IsTaxSameAsBillAddress(undefined);
            this.TaxName(undefined);
            this.TaxAddress1(undefined);
            this.TaxAddress2(undefined);
            this.TaxAddress3(undefined);
            this.TaxAddress(undefined);
            this.TaxCity(undefined);
            this.TaxStateProvince(undefined);
            this.TaxCountryID(undefined);
            this.TaxCountryName(undefined);
            this.TaxZipCode(undefined);
            this.TaxPhone1(undefined);
            this.TaxPhone2(undefined);
            this.TaxPhone3(undefined);
            this.TaxFax(undefined);
            this.TaxEmail(undefined);
            this.AdditionalInfo1(undefined);
            this.AdditionalInfo2(undefined);
            this.AdditionalInfo3(undefined);
            this.AdditionalInfo4(undefined);
            this.AdditionalInfo5(undefined);
            this.AdditionalInfo6(undefined);
            this.AdditionalInfo7(undefined);
            this.AdditionalInfo8(undefined);
            this.AdditionalInfo9(undefined);
            this.AdditionalInfo10(undefined);
            this.Category1ID(undefined);
            this.Category1Code(undefined);
            this.Category1Name(undefined);
            this.Category1(undefined);
            this.Category2ID(undefined);
            this.Category2Code(undefined);
            this.Category2Name(undefined);
            this.Category2(undefined);
            this.Category3ID(undefined);
            this.Category3Code(undefined);
            this.Category3Name(undefined);
            this.Category3(undefined);
            this.Category4ID(undefined);
            this.Category4Code(undefined);
            this.Category4Name(undefined);
            this.Category4(undefined);
            this.Category5ID(undefined);
            this.Category5Code(undefined);
            this.Category5Name(undefined);
            this.Category5(undefined);
            this.Category6ID(undefined);
            this.Category6Code(undefined);
            this.Category6Name(undefined);
            this.Category6(undefined);
            this.Category7ID(undefined);
            this.Category7Code(undefined);
            this.Category7Name(undefined);
            this.Category7(undefined);
            this.Category8ID(undefined);
            this.Category8Code(undefined);
            this.Category8Name(undefined);
            this.Category8(undefined);
            this.Category9ID(undefined);
            this.Category9Code(undefined);
            this.Category9Name(undefined);
            this.Category9(undefined);
            this.Category10ID(undefined);
            this.Category10Code(undefined);
            this.Category10Name(undefined);
            this.Category10(undefined);
            this.Photo(undefined);
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
