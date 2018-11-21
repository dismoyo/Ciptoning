// ------------------------------------------------------------------------------------------------
// DataUtility: A class for supporting the Data Source control programming.
// ------------------------------------------------------------------------------------------------


// DataUtility class definition.
var DataUtility = {
    // Attributes

    vCountries: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vCountries,
                select: [
                    'ID',
                    'Name'
                ],
                filter: filter,
                sort: 'Name',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vCountryViewModel(item); }
            };
        }
    },
    vSystemLookups: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vSystemLookups,
                select: [
                    'ID',
                    'Name',
                    'Value_Int32',
                    'Value_String',
                    'Group',
                    'SortIndex'
                ],
                filter: filter,
                sort: 'SortIndex',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSystemLookupViewModel(item); }
            };
        }
    },
    vCustomerCategories: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vCustomerCategories,
                select: [
                    'ID',
                    'Category'
                ],
                filter: filter,
                sort: 'Name',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerCategoryViewModel(item); }
            };
        }
    },
    vDiscountGroups: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vDiscountGroups,
                select: [
                    'ID',
                    'DiscountGroup'
                ],
                filter: filter,
                sort: 'Name',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel(item); }
            };
        }
    },
    vDiscountStratas: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vDiscountStratas,
                select: [
                    'ID',
                    'DiscountStrata',
                    'ValidDateFrom',
                    'ValidDateTo'
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel(item); }
            };
        }
    },
    vTerritories: {
        dataSource: function(filter){
            return {
                store: Dismoyo_Ciptoning_Client.DB.vTerritories,
                select: [
                    'ID',
                    'Territory'                    
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vTerritoryViewModel(item); }
            };
        },
    },
    vRegions: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vRegions,
                select: [
                    'ID',
                    'Region',
                    'TerritoryID'                    
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vRegionViewModel(item); }
            };
        }
    },
    vAreas: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vAreas,
                select: [
                    'ID',
                    'Area',
                    'TerritoryID',
                    'RegionID'
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vAreaViewModel(item); }
            };
        }
    },
    vCompanies: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vCompanies,
                select: [
                    'ID',
                    'Company'
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vCompanyViewModel(item); }
            };
        }
    },
    vSites: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vSites,
                select: [
                    'ID',
                    'Code',
                    'Site',
                    'TerritoryID',
                    'RegionID',
                    'AreaID',
                    'CompanyID',
                    'Company'
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSiteViewModel(item); }
            };
        }
    },
    vWarehouses: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vWarehouses,
                select: [
                    'ID',
                    'Warehouse',
                    'TerritoryID',
                    'RegionID',
                    'AreaID',
                    'CompanyID',
                    'SiteID'                    
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vWarehouseViewModel(item); }
            };
        }
    },
    vSalesmen: {
        dataSource: function (filter) {
            return {
                store: Dismoyo_Ciptoning_Client.DB.vSalesmen,
                select: [
                    'ID',
                    'Salesman',
                    'WarehouseID',
                    'SiteID',
                    'AreaID',
                    'RegionID',
                    'TerritoryID',
                    'CompanyID'
                ],
                filter: filter,
                sort: 'Code',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanViewModel(item); }
            };
        }
    },

    // Public Methods

    GetLookupCountryDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vCountries.dataSource(filter));
    },
    GetLookupSalesmanDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vSalesmen.dataSource(filter));
    },
    GetLookupSystemLookupDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vSystemLookups.dataSource(filter));
    },
    GetLookupCustomerCategoryDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vCustomerCategories.dataSource(filter));
    },
    GetLookupTerritoryDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vTerritories.dataSource(filter));
    },
    GetLookupRegionDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vRegions.dataSource(filter));
    },
    GetLookupAreaDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vAreas.dataSource(filter));
    },
    GetLookupCompanyDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vCompanies.dataSource(filter));
    },
    GetLookupSiteDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vSites.dataSource(filter));
    },
    GetLookupWarehouseDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vWarehouses.dataSource(filter));
    },
    GetLookupSalesmanDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vSalesmen.dataSource(filter));
    },
    GetLookupDiscountGroupDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vDiscountGroups.dataSource(filter));
    },    
    GetLookupDiscountStrataDataSource: function (filter) {
        return new DevExpress.data.DataSource(DataUtility.vDiscountStratas.dataSource(filter));
    }

}
