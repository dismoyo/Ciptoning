(function () {
    Dismoyo_Ciptoning_Client.LocalStore = {
        load: function (store, viewModel) {
            Dismoyo_Ciptoning_Client.LocalStore.loadWithSort(store, viewModel, null);
        },
        loadWithSort: function (store, viewModel, sort) {
            Dismoyo_Ciptoning_Client.LocalStore[store].isLoading(true);

            var dataSource = new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB[store],
                sort: sort,
                map: function (item) { return new Dismoyo_Ciptoning_Client[viewModel](item); },
                paginate: false
            });

            dataSource.load()
                .done(function (result) {
                    Dismoyo_Ciptoning_Client.LocalStore[store].data(result);
                    Dismoyo_Ciptoning_Client.LocalStore[store].isLoading(false);
                })
                .fail(function (error) {
                    Dismoyo_Ciptoning_Client.LocalStore[store].isLoading(false);
                });
        },
        dataSource: function (store) {
            return Dismoyo_Ciptoning_Client.LocalStore.dataSourceWithPaging(store, false);
        },
        dataSourceWithPaging: function (store, paginate) {
            return new DevExpress.data.DataSource({
                store: {
                    type: 'array',
                    data: Dismoyo_Ciptoning_Client.LocalStore[store].data(),
                },
                paginate: paginate
            });
        },
        dataSourceFromWS: function (store, viewModel) {
            return new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB[store],
                map: function (item) { return new Dismoyo_Ciptoning_Client[viewModel](item); },
                paginate: false
            });
        },
        dataByFilter: function (store, filter) {
            var dataSource = Dismoyo_Ciptoning_Client.LocalStore.dataSource(store);

            if (filter)
                dataSource.filter(filter);

            dataSource.load();
            return dataSource.items();
        },


        loadAllData: function () {
            Dismoyo_Ciptoning_Client.LocalStore.vCountries.loadWithSort('Name');
            Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.load();
            Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.load();
            Dismoyo_Ciptoning_Client.LocalStore.vTerritories.loadWithSort('Territory');
            Dismoyo_Ciptoning_Client.LocalStore.vRegions.loadWithSort('Region');
            Dismoyo_Ciptoning_Client.LocalStore.vAreas.loadWithSort('Area');
            Dismoyo_Ciptoning_Client.LocalStore.vCompanies.loadWithSort('Company');
            Dismoyo_Ciptoning_Client.LocalStore.vSites.loadWithSort('Site');
            Dismoyo_Ciptoning_Client.LocalStore.vWarehouses.loadWithSort('Warehouse');
            //Dismoyo_Ciptoning_Client.LocalStore.vSalesmen.loadWithSort('Salesman');
            //Dismoyo_Ciptoning_Client.LocalStore.vCustomers.loadWithSort('Customer');
            Dismoyo_Ciptoning_Client.LocalStore.vProducts.loadWithSort('Product');
            Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.loadWithSort('Brand');
            Dismoyo_Ciptoning_Client.LocalStore.vProductPrices.loadWithSort('Code');
            Dismoyo_Ciptoning_Client.LocalStore.vDiscountStrataDetails.loadWithSort('StrataID');
            Dismoyo_Ciptoning_Client.LocalStore.vDiscountStratas.loadWithSort('DiscountStrata');
            Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroupProducts.loadWithSort('DiscountGroupID');
            Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.loadWithSort('DiscountGroup');
            Dismoyo_Ciptoning_Client.LocalStore.vCustomerCategories.load();
            //Dismoyo_Ciptoning_Client.LocalStore.vProductLots.loadWithSort('ID');
        },
        isAllDataLoaded: function () {
            return !Dismoyo_Ciptoning_Client.LocalStore.vCountries.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vTerritories.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vRegions.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vAreas.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vCompanies.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vSites.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vWarehouses.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vSalesmen.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vCustomers.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vProducts.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vProductPrices.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vDiscountStrataDetails.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vDiscountStratas.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroupProducts.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vCustomerCategories.isLoading() &&
                !Dismoyo_Ciptoning_Client.LocalStore.vProductLots.isLoading();
        },
        vCountries: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vCountries', 'vCountryViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vCountries', 'vCountryViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vCountries', 'vCountryViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vCountries', filter); }
        },
        vSystemLookups: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vSystemLookups', 'vSystemLookupViewModel'); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vSystemLookups', 'vSystemLookupViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vSystemLookups', filter); }
        },
        vSystemParameters: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vSystemParameters', 'vSystemParameterViewModel'); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vSystemParameters', 'vSystemParameterViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vSystemParameters', filter); },

            galleryImages: function () {
                var images = [];
                var list = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', 'Login.Galleries']);
                if (list.length > 0) {
                    var value = list[0].Value().split('|');
                    for (var i = 0; i < value.length; i++)
                        images.push('Galleries/' + value[i]);
                }

                return images;
            }
        },
        vTerritories: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vTerritories', 'vTerritoryViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vTerritories', 'vTerritoryViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vTerritories', 'vTerritoryViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vTerritories', filter); }
        },
        vRegions: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vRegions', 'vRegionViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vRegions', 'vRegionViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vRegions', 'vRegionViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vRegions', filter); }
        },
        vAreas: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vAreas', 'vAreaViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vAreas', 'vAreaViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vAreas', 'vAreaViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vAreas', filter); }
        },
        vCompanies: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vCompanies', 'vCompanyViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vCompanies', 'vCompanyViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vCompanies', 'vCompanyViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vCompanies', filter); }
        },
        vCustomerCategories: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vCustomerCategories', 'vCustomerCategoryViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vCustomerCategories', 'vCustomerCategoryViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vCustomerCategories', 'vCustomerCategoryViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vCustomerCategories', filter); }
        },
        vSites: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vSites', 'vSiteViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vSites', 'vSiteViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vSites', 'vSiteViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vSites', filter); }
        },
        vWarehouses: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vWarehouses', 'vWarehouseViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vWarehouses', 'vWarehouseViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vWarehouses', 'vWarehouseViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vWarehouses', filter); }
        },
        vSalesmen: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vSalesmen', 'vSalesmanViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vSalesmen', 'vSalesmanViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vSalesmen', 'vSalesmanViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vSalesmen', filter); }
        },
        vCustomers: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vCustomers', 'vCustomerViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vCustomers', 'vCustomerViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vCustomers', 'vCustomerViewModel'); },
            dataSourceWithPaging: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceWithPaging('vCustomers', true); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vCustomers', filter); }
        },
        vProducts: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vProducts', 'vProductViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vProducts', 'vProductViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vProducts', 'vProductViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vProducts', filter); }
        },
        vProductBrands: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vProductBrands', 'vProductBrandViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vProductBrands', 'vProductBrandViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vProductBrands', 'vProductBrandViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vProductBrands', filter); },

            expandedData: function () {
                var expandedData = [];

                var data = Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.data();
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];

                    item.ChildProducts([]);
                    var childProducts = Dismoyo_Ciptoning_Client.LocalStore.vProducts.dataByFilter(['BrandID', '=', item.ID()]);
                    for (var j = 0; j < childProducts.length; j++)
                        item.ChildProducts().push(childProducts[j]);

                    expandedData.push(item);
                }

                return expandedData;
            }
        },
        vProductPrices: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vProductPrices', 'vProductPriceViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vProductPrices', 'vProductPriceViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vProductPrices', 'vProductPriceViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vProductPrices', filter); }
        },
        vDiscountStrataDetails: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vDiscountStrataDetails', 'vDiscountStrataDetailsViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vDiscountStrataDetails', 'vDiscountStrataDetailsViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vDiscountStrataDetails', 'vDiscountStrataDetailsViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vDiscountStrataDetails', filter); }
        },
        vDiscountStratas: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vDiscountStratas', 'vDiscountStrataViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vDiscountStratas', 'vDiscountStrataViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vDiscountStratas', 'vDiscountStrataViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vDiscountStratas', filter); },

            expandedData: function () {
                var expandedData = [];

                var data = Dismoyo_Ciptoning_Client.LocalStore.vDiscountStratas.data();
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];

                    item.ChildDetails([]);
                    var childDetails = Dismoyo_Ciptoning_Client.LocalStore.vDiscountStrataDetails.dataByFilter(['StrataID', '=', item.ID()]);
                    for (var j = 0; j < childDetails.length; j++)
                        item.ChildDetails().push(childDetails[j]);

                    expandedData.push(item);
                }

                return expandedData;
            }
        },
        vDiscountGroupProducts: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vDiscountGroupProducts', 'vDiscountGroupProductViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vDiscountGroupProducts', 'vDiscountGroupProductViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vDiscountGroupProducts', 'vDiscountGroupProductViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vDiscountGroupProducts', filter); }
        },
        vDiscountGroups: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vDiscountGroups', 'vDiscountGroupViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vDiscountGroups', 'vDiscountGroupViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vDiscountGroups', 'vDiscountGroupViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vDiscountGroups', filter); },

            expandedDataByKey: function (key) {
                var expandedData = [];

                var data = Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.data();
                if (key)
                    data = Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.dataByFilter(['ID', '=', key]);

                for (var i = 0; i < data.length; i++) {
                    var item = data[i];

                    item.ChildProducts([]);
                    var childProducts = Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroupProducts.dataByFilter(['DiscountGroupID', '=', item.ID()]);
                    for (var j = 0; j < childProducts.length; j++) {
                        item.ChildProducts().push(childProducts[j]);

                        var index = item.ChildProducts().length - 1;

                        for (var x = 1; x <= 5; x++) {
                            var strataField = 'ChildStrata' + x.toString();
                            var childStrata = Dismoyo_Ciptoning_Client.LocalStore.vDiscountStratas.dataByFilter(
                                ['ID', '=', item.ChildProducts()[index]['DiscountStrata' + x.toString() + 'ID']()]);
                            if (childStrata.length > 0) {
                                item.ChildProducts()[index][strataField](childStrata[0]);

                                item.ChildProducts()[index][strataField]().ChildDetails([]);
                                var childStrataDetails = Dismoyo_Ciptoning_Client.LocalStore.vDiscountStrataDetails.dataByFilter(
                                    ['StrataID', '=', item.ChildProducts()[index][strataField]().ID()]);
                                for (var k = 0; k < childStrataDetails.length; k++) {
                                    item.ChildProducts()[index][strataField]().ChildDetails().push(childStrataDetails[k]);
                                }
                            } else
                                item.ChildProducts()[index][strataField](undefined);
                        }
                    }

                    expandedData.push(item);
                }

                return expandedData;
            }
        },
        vProductLots: {
            isLoading: ko.observable(false),
            load: function () { Dismoyo_Ciptoning_Client.LocalStore.load('vProductLots', 'vProductLotViewModel'); },
            loadWithSort: function (sort) { Dismoyo_Ciptoning_Client.LocalStore.loadWithSort('vProductLots', 'vProductLotViewModel', sort); },
            dataSource: function () { return Dismoyo_Ciptoning_Client.LocalStore.dataSourceFromWS('vProductLots', 'vProductLotViewModel'); },
            data: ko.observableArray([]),
            dataByFilter: function (filter) { return Dismoyo_Ciptoning_Client.LocalStore.dataByFilter('vProductLots', filter); }
        }
    };
}());
