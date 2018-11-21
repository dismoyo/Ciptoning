$(document).ready(function () {
    checkContainer();

    checkNotification();
});

function checkContainer() {
    if ($('#mainContent').is(':visible')) {
        $('.desktop-layout').tabs({
            activate: $.layout.callbacks.resizeTabLayout
        });

        $('.dx-viewport').layout({
            name: 'viewport',
            initPanes: false,
            resizeWithWindow: false,

            center: {
                paneSelector: '.desktop-layout',
                children: {
                    name: 'desktopLayout',
                    north: {
                        paneSelector: '#topPane',
                        resizable: false,
                        spacing_open: 0,
                        spacing_closed: 0
                    },
                    center: {
                        paneSelector: '#mainContent',
                        onresize: $.layout.callbacks.resizeTabLayout
                    },
                    west: {
                        paneSelector: '#leftPane',
                        initHidden: true,
                        initClosed: true,
                    },
                    south: {
                        paneSelector: '#bottomPane',
                        resizable: false,
                        spacing_open: 0,
                        spacing_closed: 0
                    }
                }
            }
        });
    } else
        setTimeout(checkContainer, 50);
}


var loadingPanel = function () { return DXUtility.getDXInstance(null, '#loadingPanel', 'dxLoadPanel'); }

var setLoadingPanelByVisibility = function (name, visible) {
    var panel = DXUtility.getDXInstance(null, name, 'dxLoadPanel');
    if (panel)
        panel.option('visible', visible);
};

var showLoadingPanel = function () {
    var panel = loadingPanel();
    if (panel)
        panel.option('visible', true);
};

var hideLoadingPanel = function () {
    var panel = loadingPanel();
    if (panel)
        panel.option('visible', false);
};

var desktopPane = function () { return $('.desktop-layout').layout(); };


//var mainMenuOptions = {
//    items: mainMenuItems,
//    dataStructure: 'plain',
//    parentIdExpr: 'categoryId',
//    keyExpr: 'ID',
//    displayExpr: 'name'
//}

var mainMenuItems = [{
    ID: '1',
    name: 'Home',
    iconSrc: 'Images/home_32px.png',
    uri: 'Home',
    viewScript: 'Views/Home/Home.js',
    view: 'Views/Home/Home.dxview'
}, {
    ID: '2',
    name: 'Settings',
    iconSrc: 'Images/settings_32px.png',
    isHeadOffice: true
}, {
    ID: '2_1',
    categoryId: '2',
    name: 'Users',
    iconSrc: 'Images/user_32px.png',
    uri: 'vUsers',
    viewScript: 'Views/vUser/vUsers.js',
    view: 'Views/vUser/vUsers.dxview',
    isHeadOffice: true,
    //permissionObjectID: 'Users.View'
}, {
    ID: '2_2',
    categoryId: '2',
    name: 'User Groups',
    iconSrc: 'Images/role_32px.png',
    uri: 'vRoles',
    viewScript: 'Views/vRole/vRoles.js',
    view: 'Views/vRole/vRoles.dxview',
    isHeadOffice: true
}, {
    ID: '2_3',
    categoryId: '2',
    name: 'Permissions',
    iconSrc: 'Images/permission_32px.png',
    uri: 'vPermissionObjects',
    viewScript: 'Views/vPermissionObject/vPermissionObjects.js',
    view: 'Views/vPermissionObject/vPermissionObjects.dxview',
    isHeadOffice: true
}, {
    ID: '2_5',
    categoryId: '2',
    name: 'System Parameters',
    iconSrc: 'Images/system_parameter_32px.png',
    uri: 'vSystemParameters',
    viewScript: 'Views/vSystemParameter/vSystemParameters.js',
    view: 'Views/vSystemParameter/vSystemParameters.dxview',
    isHeadOffice: true
}, {
    ID: '3',
    name: 'Master Data',
    iconSrc: 'Images/master_data_32px.png'
}, {
    ID: '3_1',
    categoryId: '3',
    name: 'Sales Organization',
    iconSrc: 'Images/sales_organization_32px.png',
    isHeadOffice: true
}, {
    ID: '3_1_1',
    categoryId: '3_1',
    name: 'Territories',
    iconSrc: 'Images/territory_32px.png',
    uri: 'vTerritories',
    viewScript: 'Views/vTerritory/vTerritories.js',
    view: 'Views/vTerritory/vTerritories.dxview',
    isHeadOffice: true,
    permissionObjectID: 'Territories.View'
}, {
    ID: '3_1_2',
    categoryId: '3_1',
    name: 'Regions',
    iconSrc: 'Images/region_32px.png',
    uri: 'vRegions',
    viewScript: 'Views/vRegion/vRegions.js',
    view: 'Views/vRegion/vRegions.dxview',
    isHeadOffice: true,
    permissionObjectID: 'Regions.View'
}, {
    ID: '3_1_3',
    categoryId: '3_1',
    name: 'Areas',
    iconSrc: 'Images/area_32px.png',
    uri: 'vAreas',
    viewScript: 'Views/vArea/vAreas.js',
    view: 'Views/vArea/vAreas.dxview',
    isHeadOffice: true,
    permissionObjectID: 'Areas.View'
}, {
    ID: '3_1_4',
    categoryId: '3_1',
    name: 'Companies',
    iconSrc: 'Images/company_32px.png',
    uri: 'vCompanies',
    viewScript: 'Views/vCompany/vCompanies.js',
    view: 'Views/vCompany/vCompanies.dxview',
    isHeadOffice: true,
    permissionObjectID: 'Companies.View'
}, {
    ID: '3_1_5',
    categoryId: '3_1',
    name: 'Sites',
    iconSrc: 'Images/site_32px.png',
    uri: 'vSites',
    viewScript: 'Views/vSite/vSites.js',
    view: 'Views/vSite/vSites.dxview',
    isHeadOffice: true,
    permissionObjectID: 'Sites.View'
}, {
    ID: '3_2',
    categoryId: '3',
    name: 'Inventories',
    iconSrc: 'Images/inventory_32px.png'
}, {
    ID: '3_2_1',
    categoryId: '3_2',
    name: 'Product Brands',
    iconSrc: 'Images/product_brand_32px.png',
    uri: 'vProductBrands',
    viewScript: 'Views/vProductBrand/vProductBrands.js',
    view: 'Views/vProductBrand/vProductBrands.dxview',
    isHeadOffice: true,
    //permissionObjectID: 'ProductBrands.View'
}, {
    ID: '3_2_2',
    categoryId: '3_2',
    name: 'Products',
    iconSrc: 'Images/product_32px.png',
    uri: 'vProducts',
    viewScript: 'Views/vProduct/vProducts.js',
    view: 'Views/vProduct/vProducts.dxview',
    isHeadOffice: true,
    //permissionObjectID: 'Products.View'
}, {
    ID: '3_2_3',
    categoryId: '3_2',
    name: 'Product Prices',
    iconSrc: 'Images/product_price_32px.png',
    uri: 'vProductPrices',
    viewScript: 'Views/vProductPrice/vProductPrices.js',
    view: 'Views/vProductPrice/vProductPrices.dxview',
    isHeadOffice: true,
    //permissionObjectID: 'ProductPrices.View'
}, {
    ID: '3_2_4',
    categoryId: '3_2',
    name: 'Warehouses',
    iconSrc: 'Images/warehouse_32px.png',
    uri: 'vWarehouses',
    viewScript: 'Views/vWarehouse/vWarehouses.js',
    view: 'Views/vWarehouse/vWarehouses.dxview',
    //permissionObjectID: 'Warehouses.View'
}, {
    ID: '3_3',
    categoryId: '3',
    name: 'Sales Orders',
    iconSrc: 'Images/sales_32px.png'
}, {
    ID: '3_3_1',
    categoryId: '3_3',
    name: 'Customer Categories',
    iconSrc: 'Images/sales_organization_32px.png',
    uri: 'vCustomerCategories',
    viewScript: 'Views/vCustomerCategory/vCustomerCategories.js',
    view: 'Views/vCustomerCategory/vCustomerCategories.dxview',
    isHeadOffice: true,
    //permissionObjectID: 'CustomerCategories.View'
},
    {
        ID: '3_3_2',
        categoryId: '3_3',
        name: 'Salesman',
        iconSrc: 'Images/salesman_32px.png',
        uri: 'vSalesmen',
        viewScript: 'Views/vSalesman/vSalesmen.js',
        view: 'Views/vSalesman/vSalesmen.dxview',
        //permissionObjectID: 'Salesmen.View'
    }, {
        ID: '3_3_3',
        categoryId: '3_3',
        name: 'Customers',
        iconSrc: 'Images/customer_32px.png',
        uri: 'vCustomers',
        viewScript: 'Views/vCustomer/vCustomers.js',
        view: 'Views/vCustomer/vCustomers.dxview',
        //permissionObjectID: 'Customers.View'
    },
    {
        ID: '3_3_4',
        categoryId: '3_3',
        name: 'Salesman Target',
        iconSrc: 'Images/salesman_target_32px.png',
        uri: 'vSalesmanTargets',
        viewScript: 'Views/vSalesmanTarget/vSalesmanTargets.js',
        view: 'Views/vSalesmanTarget/vSalesmanTargets.dxview',
        //permissionObjectID: 'SalesmanTargets.View'
    },
    {
        ID: '3_3_6',
        categoryId: '3_3',
        name: 'Closing Period ',
        iconSrc: 'Images/close_period_32px.png',
        uri: 'vClosingPeriods',
        viewScript: 'Views/vClosingPeriod/vClosingPeriods.js',
        view: 'Views/vClosingPeriod/vClosingPeriods.dxview',
        isHeadOffice: true,
        //permissionObjectID: 'ClosingPeriods.View'
    }, {
        ID: '3_4',
        categoryId: '3',
        name: 'Discount & Promo',
        iconSrc: 'Images/discount_promo_32px.png',
        isHeadOffice: true
    }, {
        ID: '3_4_1',
        categoryId: '3_4',
        name: 'Discount Strata',
        iconSrc: 'Images/discount_strata_32px.png',
        uri: 'vDiscountStratas',
        viewScript: 'Views/vDiscountStrata/vDiscountStratas.js',
        view: 'Views/vDiscountStrata/vDiscountStratas.dxview',
        isHeadOffice: true,
        //permissionObjectID: 'DiscountStratas.View'
    }, {
        ID: '3_4_2',
        categoryId: '3_4',
        name: 'Discount Groups',
        iconSrc: 'Images/discount_group_32px.png',
        uri: 'vDiscountGroups',
        viewScript: 'Views/vDiscountGroup/vDiscountGroups.js',
        view: 'Views/vDiscountGroup/vDiscountGroups.dxview',
        isHeadOffice: true,
        //permissionObjectID: 'DiscountGroups.View'
    }, {
        ID: '3_5',
        categoryId: '3',
        name: 'Routes',
        iconSrc: 'Images/route_32px.png'
    }, {
        ID: '3_5_2',
        categoryId: '3_5',
        name: 'Route Plans',
        iconSrc: 'Images/route_plan_32px.png',
        uri: 'vRoutePlans',
        viewScript: 'Views/vRoutePlan/vRoutePlans.js',
        view: 'Views/vRoutePlan/vRoutePlans.dxview'
    }, {
        ID: '4',
        name: 'Inventory Transaction',
        iconSrc: 'Images/inventory_32px.png'
    }, {
        ID: '4_1',
        categoryId: '4',
        name: 'Stock Views',
        iconSrc: 'Images/stock_view_32px.png',
        uri: 'vStockViews',
        viewScript: 'Views/vStockView/vStockViews.js',
        view: 'Views/vStockView/vStockViews.dxview'
    }, {
        ID: '4_2',
        categoryId: '4',
        name: 'Stock Receivals',
        iconSrc: 'Images/stock_receive_32px.png',
        uri: 'vStockReceives',
        viewScript: 'Views/vStockReceive/vStockReceives.js',
        view: 'Views/vStockReceive/vStockReceives.dxview'
    }, {
        ID: '4_3',
        categoryId: '4',
        name: 'Stock Opnames',
        iconSrc: 'Images/stock_opname_32px.png',
        uri: 'vStockOpnames',
        viewScript: 'Views/vStockOpname/vStockOpnames.js',
        view: 'Views/vStockOpname/vStockOpnames.dxview'
    }, {
        ID: '4_4',
        categoryId: '4',
        name: 'Stock Changes',
        onClick: "#vStockChanges",
        iconSrc: 'Images/stock_changes_32px.png',
        uri: 'vStockChanges',
        viewScript: 'Views/vStockChanges/vStockChanges.js',
        view: 'Views/vStockChanges/vStockChanges.dxview'
    }, {
        ID: '4_5',
        categoryId: '4',
        name: 'Stock Disposals',
        onClick: "#vStockDisposals",
        iconSrc: 'Images/stock_disposal_32px.png',
        uri: 'vStockDisposals',
        viewScript: 'Views/vStockDisposal/vStockDisposals.js',
        view: 'Views/vStockDisposal/vStockDisposals.dxview'
    }, {
        ID: '4_6',
        categoryId: '4',
        name: 'Stock Transfers',
        iconSrc: 'Images/stock_transfer_32px.png',
        uri: 'vStockTransfers',
        viewScript: 'Views/vStockTransfer/vStockTransfers.js',
        view: 'Views/vStockTransfer/vStockTransfers.dxview'
    }, {
        ID: '5',
        name: 'Sales Order Transaction',
        iconSrc: 'Images/sales_32px.png'
    }, {
        ID: '5_1',
        categoryId: '5',
        name: 'Sales Orders',
        iconSrc: 'Images/sales_order_32px.png',
        uri: 'vSalesOrders',
        viewScript: 'Views/vSalesOrder/vSalesOrders.js',
        view: 'Views/vSalesOrder/vSalesOrders.dxview'
    }, {
        ID: '5_2',
        categoryId: '5',
        name: 'Sales Order Returns',
        iconSrc: 'Images/sales_order_return_32px.png',
        uri: 'vSalesOrderReturns',
        viewScript: 'Views/vSalesOrderReturn/vSalesOrderReturns.js',
        view: 'Views/vSalesOrderReturn/vSalesOrderReturns.dxview'
    }, {
        ID: '5_3',
        categoryId: '5',
        name: 'Sales Order Swaps',
        iconSrc: 'Images/sales_order_swap_32px.png',
        uri: 'vSalesOrderSwaps',
        viewScript: 'Views/vSalesOrderSwap/vSalesOrderSwaps.js',
        view: 'Views/vSalesOrderSwap/vSalesOrderSwaps.dxview'
    }, {
        ID: '5_4',
        categoryId: '5',
        name: 'Sales Order FOC',
        iconSrc: 'Images/sales_order_foc_32px.png',
        uri: 'vSalesOrderFOCs',
        viewScript: 'Views/vSalesOrderFOC/vSalesOrderFOCs.js',
        view: 'Views/vSalesOrderFOC/vSalesOrderFOCs.dxview'
    }, {
        ID: '5_5',
        categoryId: '5',
        name: 'Sales Order Samples',
        iconSrc: 'Images/sales_order_sample_32px.png',
        uri: 'vSalesOrderSamples',
        viewScript: 'Views/vSalesOrderSample/vSalesOrderSamples.js',
        view: 'Views/vSalesOrderSample/vSalesOrderSamples.dxview'
    }, {
        ID: '6',
        name: 'Reports',
        iconSrc: 'Images/reports_32px.png'
    }, {
        ID: '6_1', categoryId: '6',
        name: 'Daily Sales Reports',
        iconSrc: 'Images/daily_sales_report_32px.png',
        uri: 'vDailySalesReports',
        viewScript: 'Views/vDailySalesReport/vDailySalesReports.js',
        view: 'Views/vDailySalesReport/vDailySalesReports.dxview'
    }, {
        ID: '6_2', categoryId: '6',
        name: 'Sales by Channel Reports',
        iconSrc: 'Images/sales_by_channel_report_32px.png',
        uri: 'vSalesByChannelReports',
        viewScript: 'Views/vSalesByChannelReport/vSalesByChannelReports.js',
        view: 'Views/vSalesByChannelReport/vSalesByChannelReports.dxview'
    }, {
        ID: '6_3', categoryId: '6',
        name: 'Sales by Site Reports',
        iconSrc: 'Images/sales_by_site_report_32px.png',
        uri: 'vSalesBySiteReports',
        viewScript: 'Views/vSalesBySiteReport/vSalesBySiteReports.js',
        view: 'Views/vSalesBySiteReport/vSalesBySiteReports.dxview'
    }, {
        ID: '6_4', categoryId: '6',
        name: 'Daily Salesman Reports',
        iconSrc: 'Images/daily_salesman_report_32px.png',
        uri: 'vDailySalesmanReports',
        viewScript: 'Views/vDailySalesmanReport/vDailySalesmanReports.js',
        view: 'Views/vDailySalesmanReport/vDailySalesmanReports.dxview'
    }, {
        ID: '6_5', categoryId: '6',
        name: 'Sales by Order Reports',
        iconSrc: 'Images/sales_by_order_report_32px.png',
        uri: 'vSalesByOrderReports',
        viewScript: 'Views/vSalesByOrderReport/vSalesByOrderReports.js',
        view: 'Views/vSalesByOrderReport/vSalesByOrderReports.dxview'
    }, {
        ID: '6_6', categoryId: '6',
        name: 'Customer Master Reports',
        iconSrc: 'Images/customer_master_report_32px.png',
        uri: 'vCustomerMasterReports',
        viewScript: 'Views/vCustomerMasterReport/vCustomerMasterReports.js',
        view: 'Views/vCustomerMasterReport/vCustomerMasterReports.dxview'
    }, {
        ID: '6_7', categoryId: '6',
        name: 'Salesman Activity Reports',
        iconSrc: 'Images/stock_view_32px.png',
        uri: 'vSalesmanActivityReports',
        viewScript: 'Views/vSalesmanActivityReport/vSalesmanActivityReports.js',
        view: 'Views/vSalesmanActivityReport/vSalesmanActivityReports.dxview'
    }
];

var headerMenu = function () { return DXUtility.getDXInstance(null, '#headerMenu', 'dxMenu'); };
var notificationPopover = function () { return DXUtility.getDXInstance(null, '#notificationPopover', 'dxPopover'); };
var notificationList = function () { return DXUtility.getDXInstance(null, '#notificationList', 'dxList'); };

var changePassword = new Dismoyo_Ciptoning_Client.ChangePassword();

function checkNotification() {
    var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
    var menu = headerMenu();
    if (user && menu && menu.option('visible')) {
        new DevExpress.data.DataSource({
            store: Dismoyo_Ciptoning_Client.DB.vUserNotifications,
            select: ['_'],
            filter: [
                ['UserID', '=', user.ID()],
                ['IsRead', '=', false]
            ],
            paginate: false,
            map: function (item) { return new Dismoyo_Ciptoning_Client.vUserNotificationViewModel(item); }
        }).load()
            .done(function (result) {
                if (user.NotificationCount() == undefined)
                    user.NotificationCount(0);

                var menuItems = menu.option('items');
                var iconSrc = 'Images/user_notification_empty_32px.png';
                if (user.NotificationCount() != result.length)
                    user.NotificationCount(result.length);

                CommonUtility.setJsonCookie('CurrentUser', user.toJS(), 7);

                if (user.NotificationCount() > 0)
                    iconSrc = 'Images/user_notification_32px.png';

                if (menuItems[0].iconSrc != iconSrc) {
                    menuItems[0].iconSrc = iconSrc;
                    menu.option('items', menuItems);
                }

                //setTimeout(checkNotification, 30000);
                setTimeout(checkNotification, 10000);
            })
            .fail(function (error) {
                //setTimeout(checkNotification, 30000);
                setTimeout(checkNotification, 10000);
            });
    } else
        setTimeout(checkNotification, 500);
}

function showNotification() {
    var list = notificationList();
    var user = Dismoyo_Ciptoning_Client.app.CurrentUser;

    if ((user.NotificationCount() != undefined) && (user.NotificationCount() > 0)) {
        var userNotificationDataSource = new DevExpress.data.DataSource({
            store: Dismoyo_Ciptoning_Client.DB.vUserNotifications,
            select: [
                'ID',
                'HtmlMessage',
                'IsRead'
            ],
            filter: [
                ['UserID', '=', user.ID()],
                ['IsRead', '=', false]
            ],
            paginate: false,
            map: function (item) { return new Dismoyo_Ciptoning_Client.vUserNotificationViewModel(item); }
        });

        list.option('dataSource', userNotificationDataSource);
        userNotificationDataSource.load()
            .done(function (result) {
                notificationPopover().show();

                for (var i = 0; i < result.length; i++) {
                    var dataJS = result[i].toJS();
                    if (dataJS.IsRead == false) {
                        dataJS.HtmlMessage = '';
                        dataJS.IsRead = true;
                        userNotificationDataSource.store().update(dataJS.ID, dataJS)
                            .done(function (result2) {
                                if (i >= (result.length - 1))
                                    checkNotification();
                            })
                            .fail(function (error2) {
                                if (i >= (result.length - 1))
                                    checkNotification();
                            });
                    }
                }
            });
    } else
        notificationPopover().show();
}

(function ($, DX, undefined) {
    var layoutSets = DX.framework.html.layoutSets;
    layoutSets['desktop'] = layoutSets['desktop'] || [];
    layoutSets['desktop'].push({
        platform: 'generic',
        controller: new DX.framework.html.DefaultLayoutController({ name: 'desktop' })
    })
})(jQuery, DevExpress);
