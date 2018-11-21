// NOTE object below must be a valid JSON
const LOCAL_ROOT_URI = 'http://localhost:6300';
const PRODUCTION_ROOT_URI = 'http://192.168.4.12:8188';

const LOCAL_REPORTS_ROOT_URI = 'http://localhost:6302';
const PRODUCTION_REPORTS_ROOT_URI = 'http://192.168.4.12:8188';

window.Dismoyo_Ciptoning_Client = $.extend(true, window.Dismoyo_Ciptoning_Client, {
    config: {
        endpoints: {
            CommonService: {
                local: LOCAL_ROOT_URI + '/CommonService.svc',
                production: PRODUCTION_ROOT_URI + '/CommonService.svc'
            },
            FileService: {
                local: LOCAL_ROOT_URI + '/FileService.svc',
                production: PRODUCTION_ROOT_URI + '/FileService.svc'
            },
            DataService: {
                local: LOCAL_ROOT_URI + '/DataService.svc',
                production: PRODUCTION_ROOT_URI + '/DataService.svc'
            },
            ReportWebsite: {
                local: LOCAL_REPORTS_ROOT_URI,
                production: PRODUCTION_REPORTS_ROOT_URI
            }
        },
        services: {
            CommonService: {
                methods: {
                    'GetDatabaseUtcDateTime': function () {
                    }
                }
            },
            FileService: {
                'UploadFile': {
                    url: function (fileName) {
                        if (!fileName)
                            fileName = '';

                        return encodeURI(Dismoyo_Ciptoning_Client.FileService.url + '/UploadFile?fileName=' + fileName);
                    }
                },
                'DownloadFile': {
                    url: function (pathName, fileName) {
                        if (!pathName)
                            pathName = '';

                        if (!fileName)
                            fileName = '';

                        var i = fileName.lastIndexOf('.');
                        
                        return encodeURI(Dismoyo_Ciptoning_Client.FileService.url + '/File' +
                            ((fileName.length == 0) ? '' :
                            '/' + ((i == 0) ? fileName : fileName.substring(0, i) + '/' + fileName.substring(i + 1))) +
                            '?pathName=' + pathName);
                    }
                }
            },
            DataService: {
                entities: {

                    // --------------------------------------------------------------------------------------
                    // System Parameter, Lookup, and Country
                    // --------------------------------------------------------------------------------------
                    'vSystemParameters': {
                        'key': 'ID',
                        'keyType': 'String'
                    },
                    'vSystemLookups': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vCountries': {
                        'key': 'ID',
                        'keyType': 'String'
                    },

                    // --------------------------------------------------------------------------------------
                    // User, Role, and Permission
                    // --------------------------------------------------------------------------------------
                    'vUsers': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vRoles': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vUserRoles': {
                        'key': ['RoleID', 'UserID'],
                        'keyType': {
                            RoleID: 'Int32',
                            UserID: 'Int32'
                        }
                    },
                    'vUserRoleAlls': {
                        'key': ['UserRoleID', 'IsUser'],
                        'keyType': {
                            UserRoleID: 'Int32',
                            IsUser: 'Boolean'
                        }
                    },
                    'vPermissionObjects': {
                        'key': 'ID',
                        'keyType': 'String'
                    },
                    'vUserRolePermissions': {
                        'key': ['PermissionObjectID', 'UserRoleID', 'IsUser'],
                        'keyType': {
                            PermissionObjectID: 'String',
                            UserRoleID: 'Int32',
                            IsUser: 'Boolean'
                        }
                    },
                    'vUserPermissionAlls': {
                        'key': ['UserID', 'PermissionObjectID'],
                        'keyType': {
                            UserID: 'Int32',
                            PermissionObjectID: 'String'
                        }
                    },
                    'vUserNotifications': {
                        'key': 'ID',
                        'keyType': 'Guid'
                    },
                    'ChangePasswords': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },

                    // --------------------------------------------------------------------------------------
                    // Territory, Region, and Area
                    // --------------------------------------------------------------------------------------
                    'vTerritories': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vRegions': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vAreas': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },

                    // --------------------------------------------------------------------------------------
                    // Company
                    // --------------------------------------------------------------------------------------
                    'vCompanies': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },

                    // --------------------------------------------------------------------------------------
                    // Site
                    // --------------------------------------------------------------------------------------
                    'vSites': {
                        'key': 'ID',
                        'keyType': 'Guid'
                    },
                    'vSiteProducts': {
                        'key': ['SiteID', 'ProductID'],
                        'keyType': {
                            SiteID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Warehouse
                    // --------------------------------------------------------------------------------------
                    'vWarehouses': {
                        'key': 'ID',
                        'keyType': 'Guid'
                    },

                    // --------------------------------------------------------------------------------------
                    // Salesman
                    // --------------------------------------------------------------------------------------
                    'vSalesmen': {
                        'key': 'ID',
                        'keyType': 'Guid'
                    },
                    'vSalesmanProducts': {
                        'key': ['SalesmanID', 'ProductID'],
                        'keyType': {
                            SalesmanID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },                    
                    'vSalesmanTargets': {
                        'key': ['SalesmanID', 'PeriodID'],
                        'keyType': {
                            SalesmanID: 'Guid',
                            PeriodID: 'DateTime'
                        }
                    },
                    'vSalesmanProductTargets': {
                        'key': ['SalesmanID', 'PeriodID', 'ProductID'],
                        'keyType': {
                            SalesmanID: 'Guid',
                            PeriodID: 'DateTime',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Customer
                    // --------------------------------------------------------------------------------------
                    'vCustomers': {
                        'key': 'ID',
                        'keyType': 'Guid'
                    },
                    'vCustomerCategories': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },

                    // --------------------------------------------------------------------------------------
                    // Product
                    // --------------------------------------------------------------------------------------
                    'vProductBrands': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vProducts': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vProductPrices': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vProductLots': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },

                    // --------------------------------------------------------------------------------------
                    // Discount
                    // --------------------------------------------------------------------------------------
                    'vDiscountGroups': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vDiscountStratas': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vDiscountStrataDetails': {
                        'key': 'ID',
                        'keyType': 'Int32'
                    },
                    'vDiscountGroupProducts': {
                        'key': ['DiscountGroupID', 'ProductID'],
                        'keyType': {
                            DiscountGroupID: 'Int32',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock On Hand
                    // --------------------------------------------------------------------------------------
                    'vStockOnHandAlls': {
                        'key': ['WarehouseID', 'ProductID', 'ProductLotID'],
                        'keyType': {
                            WarehouseID: 'Guid',
                            ProductID: 'Int32',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockOnHandAvailables': {
                        'key': ['WarehouseID', 'ProductID', 'ProductLotID'],
                        'keyType': {
                            WarehouseID: 'Guid',
                            ProductID: 'Int32',
                            ProductLotID: 'Int32'
                        }
                    },



                    // --------------------------------------------------------------------------------------
                    // Closing Period
                    // --------------------------------------------------------------------------------------
                    'vClosingPeriods': {
                        'key': ['SiteID', 'YearID'],
                        'keyType': {
                            SiteID: 'Guid',
                            YearID: 'Int32'
                        }
                    },


                    
                    // --------------------------------------------------------------------------------------
                    // Route Plan
                    // --------------------------------------------------------------------------------------
                    'vRoutePlans': {
                        'key': ['SalesmanID', 'CustomerID', 'WeekID', 'DayID'],
                        'keyType': {
                            SalesmanID: 'Guid',
                            CustomerID: 'Guid',
                            WeekID: 'Int32',
                            DayID: 'Int32'
                        }
                    },
                    'vRoutePlanSalesmen': {
                        'key': 'SalesmanID',
                        'keyType': 'Guid',
                    },
                    'vRoutePlanCustomers': {
                        'key': ['CustomerID', 'SalesmanID'],
                        'keyType': {
                            CustomerID: 'Guid',
                            SalesmanID: 'Guid'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock View
                    // --------------------------------------------------------------------------------------
                    'vStockViews': {
                        'key': ['WarehouseID', 'ProductID', 'ProductLotID'],
                        'keyType': {
                            WarehouseID: 'Guid',
                            ProductID: 'Int32',
                            ProductLotID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock Receival
                    // --------------------------------------------------------------------------------------
                    'vStockReceives': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vStockReceiveDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockReceiveSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock Opname
                    // --------------------------------------------------------------------------------------
                    'vStockOpnames': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vStockOpnameDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockOpnameSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock Changes
                    // --------------------------------------------------------------------------------------
                    'vStockChanges': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vStockChangesDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockChangesSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock Disposal
                    // --------------------------------------------------------------------------------------
                    'vStockDisposals': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vStockDisposalDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockDisposalSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Stock Transfer
                    // --------------------------------------------------------------------------------------
                    'vStockTransfers': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vStockTransferDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vStockTransferSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Sales Order
                    // --------------------------------------------------------------------------------------
                    'vSalesOrders': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vSalesOrderDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vSalesOrderSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Sales Order Return
                    // --------------------------------------------------------------------------------------
                    'vSalesOrderReturns': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vSalesOrderReturnDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vSalesOrderReturnSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Sales Order Swap
                    // --------------------------------------------------------------------------------------
                    'vSalesOrderSwaps': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vSalesOrderSwapDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vSalesOrderSwapSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Sales Order Sample
                    // --------------------------------------------------------------------------------------
                    'vSalesOrderSamples': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vSalesOrderSampleDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vSalesOrderSampleSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Sales Order FOC
                    // --------------------------------------------------------------------------------------
                    'vSalesOrderFOCs': {
                        'key': 'DocumentID',
                        'keyType': 'Guid'
                    },
                    'vSalesOrderFOCDetails': {
                        'key': ['DocumentID', 'ProductLotID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductLotID: 'Int32'
                        }
                    },
                    'vSalesOrderFOCSummaries': {
                        'key': ['DocumentID', 'ProductID'],
                        'keyType': {
                            DocumentID: 'Guid',
                            ProductID: 'Int32'
                        }
                    },

                    // --------------------------------------------------------------------------------------
                    // Reports
                    // --------------------------------------------------------------------------------------
                    
                    'vSalesmanActivityReports': {
                        'key': ['CustomerID', 'CallDate'],
                        'keyType': {
                            CustomerID: 'Guid',
                            CallDate: 'DateTime'
                        }
                    },
                }
            },
            ReportWebsite: {
                'DailySalesReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/DailySalesReport.aspx' + query);
                    }
                },
                'SalesByChannelReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/SalesByChannelReport.aspx' + query);
                    }
                },
                'SalesBySiteReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/SalesBySiteReport.aspx' + query);
                    }
                },
                'DailySalesmanReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/DailySalesmanReport.aspx' + query);
                    }
                },
                'SalesByOrderReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/SalesByOrderReport.aspx' + query);
                    }
                },
                'CustomerMasterReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/CustomerMasterReport.aspx' + query);
                    }
                },
                'StockOpnameReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/StockOpnameReport.aspx' + query);
                    }
                },
                'DeliveryOrderReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/DeliveryOrderReport.aspx' + query);
                    }                    
                },
                'ExtDeliveryOrderReport': {
                    url: function (filter) {
                        var query = '';
                        if (filter && (Object.prototype.toString.call(filter) === '[object Array]')) {
                            for (var i = 0; i < filter.length; i++) {
                                if ((Object.prototype.toString.call(filter[i]) === '[object Array]')) {
                                    var str = '';

                                    switch (Object.prototype.toString.call(filter[i][2])) {
                                        case '[object Date]': str = DateTimeUtility.getISODateString(filter[i][2]); break;
                                        default: str = filter[i][2].toString(); break;
                                    }

                                    query += ((query.length == 0) ? '?' : '&') + filter[i][0].toString() + '=' + HtmlUtility.htmlEncode(str);
                                }
                            }
                        }

                        return encodeURI(Dismoyo_Ciptoning_Client.ReportWebsite.url + '/ExtDeliveryOrderReport.aspx' + query);
                    }
                }
            }
        }
    }
});
