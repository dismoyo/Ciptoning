Dismoyo_Ciptoning_Client.vStockViews = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevStockViewsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vStockViews');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        if (!user.IsHeadOffice()) {
            var filters = [
                ['TerritoryID', '=', user.TerritoryID()], 'and',
                ['RegionID', '=', user.RegionID()], 'and',
                ['AreaID', '=', user.AreaID()], 'and',
                ['CompanyID', '=', user.CompanyID()], 'and',
                ['SiteID', '=', user.SiteID()]
            ];

            dataSource.filter(filters);
        }

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vStockViews.off('modified', handlevStockViewsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockViews,
        select: [
            'ProductID',
            'Product',
            'ProductLotID',
            'ProductLotCode',
            'WarehouseID',
            'Warehouse',
            'QtyOnHandGood',
            'QtyOnHandHold',
            'QtyOnHandBad'
        ],
        sort: ['ProductID', 'ProductLotID']
    });

    Dismoyo_Ciptoning_Client.DB.vStockViews.on('modified', handlevStockViewsModification);





    // ------------------------------------------------------------------------------------------------
    // collapsibleFilter
    // ------------------------------------------------------------------------------------------------
    var collapsibleFilter = new Dismoyo_Ciptoning_Client.CollapsibleFilter();

    collapsibleFilter.filterOptions.onInitialized = function () {
        collapsibleFilter.filter().element().resize(function () {
            if (pane)
                pane.resizeAll();
        });
    };

    // ------------------------------------------------------------------------------------------------
    // Filter Items: Specify items of the filter here.
    // ------------------------------------------------------------------------------------------------    
    collapsibleFilter.formOptions.items = [{
        itemType: 'group',
        caption: 'Organization',
        colCount: 3,
        colSpan: 3,
        visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
        items: [{
            dataField: 'TerritoryID',
            label: { text: 'Territory' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupTerritoryDataSource(null),
                displayExpr: 'Territory',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Territory',
                        [],
                        ['Region']);
                }
            }
        }, {
            dataField: 'RegionID',
            label: { text: 'Region' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupRegionDataSource(null),
                displayExpr: 'Region',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area']);
                }
            }
        }, {
            dataField: 'AreaID',
            label: { text: 'Area' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupAreaDataSource(null),
                displayExpr: 'Area',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Company', 'Site']);
                }
            }
        }, {
            dataField: 'CompanyID',
            label: { text: 'Company' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCompanyDataSource(null),
                displayExpr: 'Company',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                        ['Company', 'Area', 'Region', 'Territory'],
                        ['Warehouse']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock View',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'TransactionDate',
            label: { text: 'Transaction Date' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                placeholder: 'mm/dd/yyyy',
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'WarehouseID',
            label: { text: 'Warehouse' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupWarehouseDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Warehouse',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'ProductID',
            label: { text: 'Product' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: Dismoyo_Ciptoning_Client.LocalStore.vProducts.dataSource(),
                displayExpr: 'Product',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }]
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        var dataGrid = commonGridView.dataGrid();
        var form = collapsibleFilter.form();

        var filterExpr = [];
        var value;

        dataGrid.clearFilter();

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var territoryID = user.TerritoryID();
        var regionID = user.RegionID();
        var areaID = user.AreaID();
        var companyID = user.CompanyID();
        var siteID = user.SiteID();

        if (form.itemOption('Organization').visible) {
            territoryID = form.getEditor('TerritoryID').option('value');
            regionID = form.getEditor('RegionID').option('value');
            areaID = form.getEditor('AreaID').option('value');
            companyID = form.getEditor('CompanyID').option('value');
            siteID = form.getEditor('SiteID').option('value');
        }

        // TerritoryID
        DXUtility.addFilterExpression(filterExpr, 'TerritoryID', '=', territoryID, 'and');

        // RegionID
        DXUtility.addFilterExpression(filterExpr, 'RegionID', '=', regionID, 'and');

        // AreaID
        DXUtility.addFilterExpression(filterExpr, 'AreaID', '=', areaID, 'and');

        // CompanyID
        DXUtility.addFilterExpression(filterExpr, 'CompanyID', '=', companyID, 'and');

        // SiteID
        DXUtility.addFilterExpression(filterExpr, 'SiteID', '=', siteID, 'and');

        // TransactionDateFrom
        value = form.getEditor('TransactionDate').option('value');
        if (value instanceof Date) {
            value = DateTimeUtility.getFirstTimeOfDay(value);
            DXUtility.addFilterExpression(filterExpr, 'TransactionDate', '=', value, 'and');
        }

        // WarehouseID
        value = form.getEditor('WarehouseID').option('value');        
        DXUtility.addFilterExpression(filterExpr, 'WarehouseID', '=', value, 'and');

        // ProductID
        value = form.getEditor('ProductID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'ProductID', '=', value, 'and');

        if (filterExpr.length > 0)
            dataGrid.filter(filterExpr);
        else
            dataGrid.refresh();
    };





    // ------------------------------------------------------------------------------------------------
    // commonGridView
    // ------------------------------------------------------------------------------------------------
    var commonGridView = new Dismoyo_Ciptoning_Client.CommonGridView();
    commonGridView.dataGridOptions.dataSource = dataSource;

    commonGridView.dataGridOptions.selection.mode = 'single';

    commonGridView.dataGridOptions.editing.editEnabled = false;
    commonGridView.dataGridOptions.editing.removeEnabled = false;

    commonGridView.newRowOptions.visible = false;
    commonGridView.deleteRowsOptions.visible = false;

    commonGridView.dataGridOptions.grouping = {
        autoExpandAll: false,
    };

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'Warehouse', caption: 'Product -> Lot Number -> Warehouse',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vStockViews_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none; border-left-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none; border-left-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Item Status' + '</td>';
                tr += '</tr>'

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }, {
        dataField: 'Product', caption: 'Product', groupIndex: 0
    }, {
        dataField: 'ProductLotCode', caption: 'Lot Number', groupIndex: 1        
    }, {
        dataField: 'QtyOnHandGood', caption: 'Good', width: '100px'
    }, {
        dataField: 'QtyOnHandHold', caption: 'Hold', width: '100px'
    }, {
        dataField: 'QtyOnHandBad', caption: 'Bad', width: '100px'
    }];

    commonGridView.dataGridOptions.customizeColumns = function (columns) {
        $.each(columns, function (e, element) {
            element.groupCellTemplate = function (groupCell, info) {
                groupCell.append($('<div>').html(info.text).css('font-weight', 'normal').css('font-style', 'normal'));
            };
        });
    };

    commonGridView.dataGridOptions.summary = {
        groupItems: [{
            column: 'QtyOnHandGood',
            summaryType: 'sum',
            displayFormat: '{0}',
            showInGroupFooter: false,
            alignByColumn: true
        }, {
            column: 'QtyOnHandHold',
            summaryType: 'sum',
            displayFormat: '{0}',
            showInGroupFooter: false,
            alignByColumn: true
        }, {
            column: 'QtyOnHandBad',
            summaryType: 'sum',
            displayFormat: '{0}',
            showInGroupFooter: false,
            alignByColumn: true
        }]
    }





    return {
        isReady: isReady.promise(),
        dataSource: dataSource,
        refreshList: refreshList,
        viewShowing: handleViewShowing,
        viewDisposing: handleViewDisposing,
        openCreateViewAsRoot: openCreateViewAsRoot,


        // ------------------------------------------------------------------------------------------------
        // Register Public Properties/Methods
        // ------------------------------------------------------------------------------------------------

        icon: 'Images/stock_view_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
