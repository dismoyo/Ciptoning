Dismoyo_Ciptoning_Client.vRoutePlans = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isCustomerCallsDataGridRefreshRequired;

    function handlevRoutePlansModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vRoutePlans');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vRoutePlans.off('modified', handlevRoutePlansModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vRoutePlanSalesmen,
        select: [
            'SalesmanID',
            'Salesman',
            'Territory',
            'Region',
            'Area',
            'Company',
            'SiteID',
            'Site',
            'OddWeek1',
            'OddWeek2',
            'OddWeek3',
            'OddWeek4',
            'OddWeek5',
            'OddWeek6',
            'OddWeek7',
            'EvenWeek1',
            'EvenWeek2',
            'EvenWeek3',
            'EvenWeek4',
            'EvenWeek5',
            'EvenWeek6',
            'EvenWeek7'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vRoutePlanSalesmanViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vRoutePlans.on('modified', handlevRoutePlansModification);

    var dataSource_vRoutePlan = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vRoutePlans,
        select: [
            'SalesmanID',
            'CustomerID',
            'WeekID',
            'DayID',
            'Salesman',
            'Customer',
            'CustomerAddress',
            'SortIndex'
        ],
        sort: 'SortIndex',
        map: function (item) { return new Dismoyo_Ciptoning_Client.vRoutePlanViewModel(item); }
    });

    var dataSource_vRoutePlanCustomer = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vRoutePlanCustomers,
        select: [
            'CustomerID',
            'SalesmanID',
            'Customer',
            'CustomerAddress',
            'Salesman',
            'Territory',
            'Region',
            'Area',
            'Company',
            'Site',
            'OddWeek1',
            'OddWeek2',
            'OddWeek3',
            'OddWeek4',
            'OddWeek5',
            'OddWeek6',
            'OddWeek7',
            'EvenWeek1',
            'EvenWeek2',
            'EvenWeek3',
            'EvenWeek4',
            'EvenWeek5',
            'EvenWeek6',
            'EvenWeek7',
            'SortIndex'
        ],
        sort: 'SortIndex',
        map: function (item) { return new Dismoyo_Ciptoning_Client.vRoutePlanCustomerViewModel(item); }
    });
        
    var weekDay = [];
    weekDay[1] = 'Su';
    weekDay[2] = 'Mo';
    weekDay[3] = 'Tu';
    weekDay[4] = 'We';
    weekDay[5] = 'Th';
    weekDay[6] = 'Fr';
    weekDay[7] = 'Sa';

    var selectedDate = DateTimeUtility.getFirstTimeOfDay(new Date());
    var selectedSalesmanID;
    var selectedWeekID;
    var selectedDayID;
    var selectedSiteID;



    function updateMoveCustomersSiteChildEditor(form, siteID, companyID) {
        if (!siteID)
            siteID = null;

        var oldSalesmanDataSource = DataUtility.GetLookupSalesmanDataSource(['SiteID', '=', siteID]);

        form.getEditor('OldSalesmanID').option('value', null);
        form.getEditor('OldSalesmanID').option('dataSource', []);
        oldSalesmanDataSource.load()
            .done(function (result) {
                form.getEditor('OldSalesmanID').option('dataSource', oldSalesmanDataSource);
            });

        var newSiteDataSource = DataUtility.GetLookupSiteDataSource(['CompanyID', '=', companyID]);

        form.getEditor('NewSiteID').option('value', null);
        form.getEditor('NewSiteID').option('dataSource', []);
        newSiteDataSource.load()
            .done(function (result) {
                form.getEditor('NewSiteID').option('dataSource', newSiteDataSource);
            });
    }

    function updateMoveCustomersSalesmanEditor(form, salesmanID, newSiteID) {
        if (!salesmanID)
            salesmanID = null;

        if (!newSiteID)
            newSiteID = null;

        var newSalesmanDataSource = DataUtility.GetLookupSalesmanDataSource([
            ['ID', '<>', salesmanID], 'and',
            ['SiteID', '=', newSiteID]
        ]);

        form.getEditor('NewSalesmanID').option('value', null);
        form.getEditor('NewSalesmanID').option('dataSource', []);
        newSalesmanDataSource.load()
            .done(function (result) {
                form.getEditor('NewSalesmanID').option('dataSource', newSalesmanDataSource);
            });
    }





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
                        ['Salesman']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Route Plan',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'CustomerID',
            label: { text: 'Customer' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: new DevExpress.data.DataSource({
                    store: Dismoyo_Ciptoning_Client.DB.vCustomers,
                    select: ['ID', 'Customer', 'SiteID'],
                    map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); },
                    filter: (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                }),
                displayExpr: 'Customer',
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

        // SalesmanID
        value = form.getEditor('SalesmanID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SalesmanID', '=', value, 'and');

        // CustomerID
        value = form.getEditor('CustomerID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'CustomerID', '=', value, 'and');

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

    commonGridView.dataGridOptions.editing.editEnabled = false;
    commonGridView.dataGridOptions.editing.removeEnabled = false;

    commonGridView.dataGridOptions.onSelectionChanged = function (e) {
        commonGridView.deleteRows().option('disabled', (e.selectedRowsData.length <= 0));
    }

    commonGridView.newRowOptions.text = 'Move Customers'; // New button is used as Move Customers.
    commonGridView.newRowOptions.icon = null;

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'SalesmanID', visible: false
    }, {
        dataField: 'Salesman', caption: 'Salesman',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vRoutePlans_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" colspan="7">' + 'Odd Week' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="7">' + 'Even Week' + '</td>';
                tr += '</tr>'

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }];

    for (var index = 1; index <= 14; index++) {
        var weekID = (index <= 7) ? 1 : 2;
        var dayID = ((index - 1) % 7) + 1;

        commonGridView.dataGridOptions.columns.push({
            dataField: ((weekID == 1) ? 'Odd' : 'Even') + 'Week' + dayID.toString(),
            caption: weekDay[dayID],
            weekID: weekID,
            dayID: dayID,
            width: '36px',
            alignment: 'center',
            cellTemplate: function (container, options) {
                new DevExpress.data.DataSource({
                    store: Dismoyo_Ciptoning_Client.DB.vSystemParameters,
                    filter: ['ID', '=', 'RoutePlan.CurrentWeek'],
                    map: function (item) { return new Dismoyo_Ciptoning_Client.vSystemParameterViewModel(item); }
                }).load()
                    .done(function (result) {
                        if (result.length > 0) {
                            var curWeek = parseInt(result[0].Value());

                            var value = (!options.value) ? '0' : options.value;

                            var date = DateTimeUtility.getFirstTimeOfDay(new Date());
                            if (curWeek == options.column.weekID) {
                                var curDay = date.getDay() + 1;
                                if (curDay == options.column.dayID)
                                    container.css('background', '#92D08C');
                            }

                            container.append($('<a>').addClass('dx-link').text(value)
                                .on('dxclick', function () {
                                    dataGridEvents.performShowCustomerCalls(options);
                                })
                            );
                        }
                    })
                    .fail(function (error) {
                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load current week data.'), 'Load Failed');                        
                    });                
            }
        });
    }



    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    var customerCallsPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_customerCallsPopupEdit_dataGrid', 'dxDataGrid'); };
    var customerCallsPopupEditNew = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_customerCallsPopupEdit_new', 'dxButton'); };
    var customerCallsPopupEditDelete = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_customerCallsPopupEdit_delete', 'dxButton'); };

    commonPopupEdit.popupEditOptions.title = 'Customer Calls';

    commonPopupEdit.okOptions.visible = false;
    commonPopupEdit.cancelOptions.text = 'Close';
    commonPopupEdit.cancelOptions.onClick = function () { customerCallsPopupEditEvents.performCancel(); };

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append($('<div id="vRoutePlans_customerCallsPopupEdit_new" style="margin: 7px 4px 7px 0;">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () { customerCallsPopupEditEvents.performNewRow(); }
        }));

        content.append($('<div id="vRoutePlans_customerCallsPopupEdit_delete" style="margin: 7px 0 7px 0;">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                customerCallsPopupEditEvents.performDeleteRows();
            }
        }));

        content.append($('<div id="vRoutePlans_customerCallsPopupEdit_dataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            paging: {
            },
            pager: {
                showPageSizeSelector: true,
                allowedPageSizes: [5, 10, 20],
                showInfo: true,
                showNavigationButtons: true
            },
            selection: {
                mode: 'multiple'
            },
            editing: {
                editMode: 'row',
                allowUpdating: false,
                allowDeleting: true,

                editEnabled: false,
                removeEnabled: true
            },
            onSelectionChanged: function (info) {
                customerCallsPopupEditDelete().option('disabled', (info.selectedRowsData.length <= 0));
            },
            onRowPrepared: function (info) {
                if ((info.rowType == 'data') && (info.data.SortIndex() == 1)) {
                    info.rowElement.css('background', '#FFD966');
                }
            },
            onRowRemoved: function (info) {
                isDataGridRefreshRequired = true;
            },
            columns: [{
                dataField: 'CustomerID', visible: false
            }, {
                dataField: 'Customer', caption: 'Customer', width: '300px'
            }, {
                dataField: 'CustomerAddress', caption: 'Address'
            }, {
                dataField: 'SortIndex', visible: false,
                sortIndex: 0
            }]
        }));

        extContent.append(content);
    };

    // ------------------------------------------------------------------------------------------------
    // Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    commonPopupEdit.formOptions.items = [{
        itemType: 'group',
        colCount: 5,
        colSpan: 3,
        items: [{
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                readOnly: true
            }
        }, {
            dataField: 'WeekID',
            label: { text: 'Week' },
            colSpan: 1,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'Week']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                readOnly: true
            }
        }, {
            dataField: 'DayID',
            label: { text: 'Day' },
            colSpan: 1,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'Day']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                readOnly: true
            }
        }]
    }];





    // ------------------------------------------------------------------------------------------------
    // New Customer Call Popup Edit
    // ------------------------------------------------------------------------------------------------
    var newCustomerCallPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    newCustomerCallPopupEdit.popupEdit = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit', 'dxPopup'); }
    newCustomerCallPopupEdit.popupContent = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit_popupContent', 'dxScrollView'); }
    newCustomerCallPopupEdit.form = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit_form', 'dxForm'); }
    newCustomerCallPopupEdit.extContent = function () { return $('#vRoutePlans_newCustomerCallPopupEdit_extContent'); }
    newCustomerCallPopupEdit.ok = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit_ok', 'dxButton'); }
    newCustomerCallPopupEdit.cancel = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit_cancel', 'dxButton'); }

    var newCustomerCallPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_newCustomerCallPopupEdit_dataGrid', 'dxDataGrid'); };

    newCustomerCallPopupEdit.popupEditOptions.title = 'New Customer Calls';

    newCustomerCallPopupEdit.popupEditOptions.fullScreen = false;
    newCustomerCallPopupEdit.popupEditOptions.width = 1200;
    newCustomerCallPopupEdit.popupEditOptions.height = 600;

    newCustomerCallPopupEdit.okOptions.disabled = true;
    newCustomerCallPopupEdit.okOptions.text = 'Save';
    newCustomerCallPopupEdit.okOptions.onClick = function () { newCustomerCallPopupEditEvents.performSave(); };
    newCustomerCallPopupEdit.cancelOptions.onClick = function () { newCustomerCallPopupEditEvents.performCancel(); };

    newCustomerCallPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#vRoutePlans_newCustomerCallPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop(''));

        var columns = [{
            dataField: 'CustomerID', visible: false
        }, {
            dataField: 'Customer', caption: 'Customer', width: '300px',
            headerCellTemplate: function (columnHeader, headerInfo) {
                var dataGrid = $(newCustomerCallPopupEditDataGrid().element());
                if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                    var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                    tr += '       <td class="dx-datagrid-action" colspan="7">' + 'Odd Week' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="7">' + 'Even Week' + '</td>';
                    tr += '</tr>'

                    var table = dataGrid.find('.dx-header-row:first-child');
                    $(tr).insertBefore(table[0].parentElement);
                    $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
                }
            }
        }, {
            dataField: 'CustomerAddress', caption: 'Address'
        }, {
            dataField: 'SortIndex', visible: false,
            sortIndex: 0
        }];

        for (var index = 1; index <= 14; index++) {
            var weekID = (index <= 7) ? 1 : 2;
            var dayID = ((index - 1) % 7) + 1;

            columns.push({
                dataField: ((weekID == 1) ? 'Odd' : 'Even') + 'Week' + dayID.toString(),
                caption: weekDay[dayID],
                width: '36px',
                alignment: 'center',
                customizeText: function (options) {
                    return (options.value) ? 'X' : '';
                }
            });
        }

        content.append($('<div id="vRoutePlans_newCustomerCallPopupEdit_dataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            paging: {
            },
            pager: {
                showPageSizeSelector: true,
                allowedPageSizes: [5, 10, 20],
                showInfo: true,
                showNavigationButtons: true
            },
            selection: {
                mode: 'multiple'
            },
            editing: {
                editMode: 'row',
                allowUpdating: false,
                allowDeleting: false,

                editEnabled: false,
                removeEnabled: false
            },
            onSelectionChanged: function (info) {
                newCustomerCallPopupEdit.ok().option('disabled', (info.selectedRowsData.length <= 0));
            },
            onRowPrepared: function (info) {
                if ((info.rowType == 'data') && (info.data.SortIndex() == 1)) {
                    info.rowElement.css('background', '#FFD966');
                }
            },
            columns: columns
        }));

        extContent.append(content);
    };

    // ------------------------------------------------------------------------------------------------
    // New Customer Call Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    newCustomerCallPopupEdit.formOptions.items = [{
        name: 'Search',
        dataField: '',
        label: { visible: false },
        colSpan: 2,
        editorOptions: {
            placeholder: 'Customer/Address',
            mode: 'search',
            onEnterKey: function () { newCustomerCallPopupEditEvents.performSearch(); }
        }
    }, {
        name: 'CustomerRouteStatus',
        dataField: '',        
        label: { text: 'Route Status' },
        editorType: 'dxSelectBox',
        colSpan: 1,
        editorOptions: {
            dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'CustomerRouteStatus']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            placeholder: '(All)',
            searchEnabled: true,
            showClearButton: true,
            onEnterKey: function () { newCustomerCallPopupEditEvents.performSearch(); }
        }
    }];





    // ------------------------------------------------------------------------------------------------
    // Move Customer Popup Edit
    // ------------------------------------------------------------------------------------------------
    var moveCustomersPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    moveCustomersPopupEdit.popupEdit = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit', 'dxPopup'); }
    moveCustomersPopupEdit.popupContent = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit_popupContent', 'dxScrollView'); }
    moveCustomersPopupEdit.form = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit_form', 'dxForm'); }
    moveCustomersPopupEdit.extContent = function () { return $('#vRoutePlans_moveCustomersPopupEdit_extContent'); };
    moveCustomersPopupEdit.ok = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit_ok', 'dxButton'); }
    moveCustomersPopupEdit.cancel = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit_cancel', 'dxButton'); }

    var moveCustomersPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vRoutePlans_moveCustomersPopupEdit_dataGrid', 'dxDataGrid'); };

    moveCustomersPopupEdit.popupEditOptions.title = 'Move Customers';

    moveCustomersPopupEdit.okOptions.text = 'Move';
    moveCustomersPopupEdit.okOptions.onClick = function () { moveCustomersPopupEditEvents.performMove(); };
    moveCustomersPopupEdit.cancelOptions.onClick = function () { moveCustomersPopupEditEvents.performCancel(); };

    moveCustomersPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#vRoutePlans_moveCustomersPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop(''));

        content.append($('<div id="vRoutePlans_moveCustomersPopupEdit_dataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            paging: {
            },
            pager: {
                showPageSizeSelector: true,
                allowedPageSizes: [5, 10, 20],
                showInfo: true,
                showNavigationButtons: true
            },
            selection: {
                mode: 'multiple'
            },
            onSelectionChanged: function (e) {
                moveCustomersPopupEdit.ok().option('disabled', (e.currentSelectedRowKeys.length <= 0));
            },
            columns: [{
                dataField: 'ID', visible: false,
            }, {
                dataField: 'Customer', caption: 'Customer', width: '300px'
            }, {
                dataField: 'Address', caption: 'Address'
            }]
        }));

        extContent.append(content);
    };

    // ------------------------------------------------------------------------------------------------
    // Move Customers Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    moveCustomersPopupEdit.formOptions.items = [{
        itemType: 'group',
        caption: 'Organization',
        colCount: 3,
        colSpan: 3,
        visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
        items: [{
            dataField: 'TerritoryID',
            label: { text: 'Territory' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupTerritoryDataSource(null),
                displayExpr: 'Territory',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(moveCustomersPopupEdit.form(), e.selectedItem, e.value, 'Territory',
                        [],
                        ['Region']);
                }
            }
        }, {
            dataField: 'RegionID',
            label: { text: 'Region' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupRegionDataSource(null),
                displayExpr: 'Region',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(moveCustomersPopupEdit.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area']);
                }
            }
        }, {
            dataField: 'AreaID',
            label: { text: 'Area' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupAreaDataSource(null),
                displayExpr: 'Area',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(moveCustomersPopupEdit.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Site']);
                }
            }
        }, {
            dataField: 'Company',
            label: { text: 'Company' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    var form = moveCustomersPopupEdit.form();

                    CommonUtility.cascadeValueChanged(form, e.selectedItem, e.value, 'Site',
                       ['Area', 'Region', 'Territory'],
                       []);

                    var company = null;
                    var companyID = null;

                    if (e.selectedItem) {
                        company = e.selectedItem.Company();
                        companyID = e.selectedItem.CompanyID();
                    }

                    form.getEditor('Company').option('value', company);

                    updateMoveCustomersSiteChildEditor(form, e.value, companyID);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Move Customer',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'OldSalesmanID',
            label: { text: 'Old Salesman' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    var form = moveCustomersPopupEdit.form();

                    var customerDataSource = new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vCustomers,
                        select: [
                            'ID',
                            'Customer',
                            'Address'
                        ],
                        filter: ['SalesmanID', '=', (e.value) ? e.value : null],
                        map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); }
                    });

                    var customersDataGrid = moveCustomersPopupEditDataGrid();

                    customersDataGrid.beginCustomLoading();

                    customersDataGrid.option('dataSource', []);
                    customerDataSource.load()
                        .done(function (result) {
                            customersDataGrid.endCustomLoading();

                            customersDataGrid.option('dataSource', customerDataSource);
                        })
                        .fail(function (error) {
                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download customers data.'), 'Download Customers Failed');

                            customersDataGrid.endCustomLoading();
                        });

                    updateMoveCustomersSalesmanEditor(form, e.value, form.getEditor('NewSiteID').option('value'));
                }
            }
        }, {
            itemType: 'empty',
            colSpan: 3
        }, {
            dataField: 'NewSiteID',
            label: { text: 'New Site' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); },
                onValueChanged: function (e) {
                    var form = moveCustomersPopupEdit.form();

                    updateMoveCustomersSalesmanEditor(form, form.getEditor('OldSalesmanID').option('value'), e.value);
                }
            }
        }, {
            dataField: 'NewSalesmanID',
            label: { text: 'New Salesman' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { moveCustomersPopupEditEvents.performMove(); }
            }
        }]
    }];





    // New button is used as Move Customers.
    commonGridView.events.performNewRow = function () {
        moveCustomersPopupEdit.popupEditOptions.visible(true);
        moveCustomersPopupEdit.popupContent().scrollTo(0);

        var moveDataGrid = moveCustomersPopupEditDataGrid();

        moveDataGrid.option('dataSource', []);
        moveDataGrid.clearSorting();
                
        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = moveCustomersPopupEdit.form();
        DXUtility.resetFormValidation(form);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var territoryID = user.TerritoryID();
        var regionID = user.RegionID();
        var areaID = user.AreaID();
        var companyID = user.CompanyID();
        var siteID = user.SiteID();

        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', territoryID);
            form.getEditor('RegionID').option('value', regionID);
            form.getEditor('AreaID').option('value', areaID);
            if (form.getEditor('CompanyID'))
                form.getEditor('CompanyID').option('value', companyID);

            form.getEditor('SiteID').option('value', siteID);
        }

        moveCustomersPopupEdit.ok().option('disabled', true);

        updateMoveCustomersSiteChildEditor(form, siteID, companyID);
    };

    commonGridView.events.performDeleteRows = function (dataGrid, selectedRows) {
        showLoadingPanel();

        var selectedKeys = dataGrid.getSelectedRowKeys();
        var salesmanFilter = [];
        for (var i = 0; i < selectedKeys.length; i++) {
            if (i > 0)
                salesmanFilter.push('or');

            salesmanFilter.push(['SalesmanID', '=', selectedKeys[i]]);
        }

        if (salesmanFilter.length > 0) {
            dataSource_vRoutePlan.filter(salesmanFilter);
            dataSource_vRoutePlan.load().then(function (e) {
                if (e.length == 0)
                    hideLoadingPanel();

                for (var i = 0; i < e.length; i++) {
                    dataSource_vRoutePlan.store().remove(e[i].ID())
                        .done(function (result) {
                            if (i >= (e.length - 1)) {
                                hideLoadingPanel();
                                dataSource_vRoutePlan.load().done(function (result) { commonGridView.dataGrid().refresh(); });
                            }
                        })
                        .fail(function (error) {
                            if (i >= (e.length - 1)) {
                                hideLoadingPanel();
                                dataSource_vRoutePlan.load().done(function (result) { commonGridView.dataGrid().refresh(); });
                            }
                        });
                }
            });
        } else {
            moveCustomersPopupEdit.popupEditOptions.visible(false);
            hideLoadingPanel();
        }
    };

    var dataGridEvents = {
        performShowCustomerCalls: function (options) {
            commonPopupEdit.popupEditData(options.data);
            commonPopupEdit.popupEditOptions.visible(true);
            commonPopupEdit.popupContent().scrollTo(0);

            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            selectedSalesmanID = data.SalesmanID();
            selectedWeekID = options.column.weekID;
            selectedDayID = options.column.dayID;
            selectedSiteID = data.SiteID();

            form.getEditor('SalesmanID').option('value', selectedSalesmanID);
            form.getEditor('WeekID').option('value', selectedWeekID);
            form.getEditor('DayID').option('value', selectedDayID);

            var filter = [
                ['SalesmanID', '=', selectedSalesmanID], 'and',
                ['WeekID', '=', selectedWeekID], 'and',
                ['DayID', '=', selectedDayID], 'and',
                ['OrderBySalesmanID', '=', selectedSalesmanID]
            ];

            var callsDataGrid = customerCallsPopupEditDataGrid();

            callsDataGrid.option('dataSource', []);
            callsDataGrid.clearSorting();
            dataSource_vRoutePlan.sort('SortIndex');

            callsDataGrid.pageIndex(0);
            callsDataGrid.refresh().done(function (result) {
                callsDataGrid.option('dataSource', dataSource_vRoutePlan);
                callsDataGrid.filter(filter);
            });
        }
    }

    var customerCallsPopupEditEvents = {
        performNewRow: function () {
            newCustomerCallPopupEdit.popupEditOptions.visible(true);
            newCustomerCallPopupEdit.popupContent().scrollTo(0);

            var callDataGrid = newCustomerCallPopupEditDataGrid();

            callDataGrid.option('dataSource', []);
            callDataGrid.clearSorting();
            dataSource_vRoutePlanCustomer.sort('SortIndex');

            newCustomerCallPopupEdit.form().getEditor('Search').option('value', null);
            newCustomerCallPopupEditEvents.performSearch();
        },
        performDeleteRows: function () {
            DevExpress.ui.dialog.confirm(
                'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                    if (dialogResult) {
                        DXUtility.deleteSelectedRows(customerCallsPopupEditDataGrid(), commonGridView);
                        isDataGridRefreshRequired = true;
                    }
                });
        },
        performCancel: function () {
            commonPopupEdit.popupEditOptions.visible(false);

            if (isDataGridRefreshRequired) {
                commonGridView.dataGrid().refresh();
                isDataGridRefreshRequired = false;
            }
        }
    };

    var newCustomerCallPopupEditEvents = {
        performSave: function () {
            var selectedData = newCustomerCallPopupEditDataGrid().getSelectedRowsData();
            for (var i = 0; i < selectedData.length; i++) {
                var data = new Dismoyo_Ciptoning_Client.vRoutePlanViewModel();

                data.SalesmanID(selectedSalesmanID);
                data.CustomerID(selectedData[i].CustomerID());
                data.WeekID(selectedWeekID);
                data.DayID(selectedDayID);

                dataSource_vRoutePlan.store().insert(data.toJS()).done(function (result) {
                    isDataGridRefreshRequired = true;
                    isCustomerCallsDataGridRefreshRequired = true;

                    newCustomerCallPopupEditEvents.performCancel();
                });
            }
        },
        performCancel: function () {
            newCustomerCallPopupEdit.popupEditOptions.visible(false);

            if (isCustomerCallsDataGridRefreshRequired) {
                customerCallsPopupEditDataGrid().refresh();
                isCustomerCallsDataGridRefreshRequired = false;
            }
        },
        performSearch: function () {
            var newCallForm = newCustomerCallPopupEdit.form();
            
            var searchValue = newCallForm.getEditor('Search').option('value');
            if (searchValue == undefined)
                searchValue = null;
                        
            var filter = [
                ['SiteID', '=', selectedSiteID], 'and',
                ['OrderBySalesmanID', '=', selectedSalesmanID], 'and',
                ['FilterByKeywords', '=', searchValue]
            ];

            var customerRouteStatusValue = newCallForm.getEditor('CustomerRouteStatus').option('value');
            if ((customerRouteStatusValue != undefined) && (customerRouteStatusValue != null)) {
                filter.push('and');
                switch (customerRouteStatusValue) {
                    case 1:                        
                        filter.push([
                            ['OddWeek1', '=', 1], 'or',
                            ['OddWeek2', '=', 1], 'or',
                            ['OddWeek3', '=', 1], 'or',
                            ['OddWeek4', '=', 1], 'or',
                            ['OddWeek5', '=', 1], 'or',
                            ['OddWeek6', '=', 1], 'or',
                            ['OddWeek7', '=', 1], 'or',
                            ['EvenWeek1', '=', 1], 'or',
                            ['EvenWeek2', '=', 1], 'or',
                            ['EvenWeek3', '=', 1], 'or',
                            ['EvenWeek4', '=', 1], 'or',
                            ['EvenWeek5', '=', 1], 'or',
                            ['EvenWeek6', '=', 1], 'or',
                            ['EvenWeek7', '=', 1], 'or'
                        ]);
                        break;
                    case 2:
                        filter.push([
                            ['OddWeek1', '<>', 1], 'and',
                            ['OddWeek2', '<>', 1], 'and',
                            ['OddWeek3', '<>', 1], 'and',
                            ['OddWeek4', '<>', 1], 'and',
                            ['OddWeek5', '<>', 1], 'and',
                            ['OddWeek6', '<>', 1], 'and',
                            ['OddWeek7', '<>', 1], 'and',
                            ['EvenWeek1', '<>', 1], 'and',
                            ['EvenWeek2', '<>', 1], 'and',
                            ['EvenWeek3', '<>', 1], 'and',
                            ['EvenWeek4', '<>', 1], 'and',
                            ['EvenWeek5', '<>', 1], 'and',
                            ['EvenWeek6', '<>', 1], 'and',
                            ['EvenWeek7', '<>', 1], 'and'
                        ]);
                        break;
                }
                
            }

            var newCallDataGrid = newCustomerCallPopupEditDataGrid();

            newCallDataGrid.option('dataSource', []);
            newCallDataGrid.pageIndex(0);
            newCallDataGrid.refresh().done(function (result) {
                newCallDataGrid.option('dataSource', dataSource_vRoutePlanCustomer);
                newCallDataGrid.filter(filter);
            });
        }
    };

    var moveCustomersPopupEditEvents = {
        performMove: function () {
            var isValid = moveCustomersPopupEdit.form().validate().isValid;
            var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

            if (isValid) {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to Move the selected customers?', 'Move Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            showLoadingPanel();

                            var form = moveCustomersPopupEdit.form();
                            var dataGrid = moveCustomersPopupEditDataGrid();

                            var newSalesmanID = form.getEditor('NewSalesmanID').option('value');
                            var _dataSource = dataGrid.option('dataSource');
                            var selectedKeys = dataGrid.getSelectedRowKeys();

                            for (var i = 0; i < selectedKeys.length; i++) {
                                var customer = _dataSource.store().byKey(selectedKeys[i])
                                    .done(function (result) {
                                        result.SalesmanID = newSalesmanID;

                                        var dataJS = ko.toJS(result);

                                        _dataSource.store().insert(dataJS)
                                            .done(function (result) {
                                                if (i >= (selectedKeys.length - 1)) {
                                                    hideLoadingPanel();
                                                    _dataSource.load().done(function (result) { dataGrid.clearSelection(); dataGrid.refresh(); });
                                                    dataSource.load().done(function (result) { commonGridView.dataGrid().refresh(); });
                                                }
                                            })
                                            .fail(function (error) {
                                                DevExpress.ui.dialog.alert(error.message, 'Move Failed');

                                                if (i >= (selectedKeys.length - 1)) {
                                                    hideLoadingPanel();
                                                    _dataSource.load().done(function (result) { dataGrid.clearSelection(); dataGrid.refresh(); });
                                                    dataSource.load().done(function (result) { commonGridView.dataGrid().refresh(); });
                                                }
                                            });
                                    })
                                    .fail(function (error) {
                                        DevExpress.ui.dialog.alert(error.message, 'Move Failed');
                                        hideLoadingPanel();
                                    });
                            }
                        }
                    }
                );
            }

            if (errorMsg != '') {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(errorMsg), 'Move Failed');
            }
        },
        performCancel: function () {
            moveCustomersPopupEdit.popupEditOptions.visible(false);
        }
    };


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

        icon: "/Images/route_plan_32px.png",

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        newCustomerCallPopupEdit: newCustomerCallPopupEdit,
        moveCustomersPopupEdit: moveCustomersPopupEdit        
    };
};
