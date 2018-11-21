Dismoyo_Ciptoning_Client.vUsers = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevUsersModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vUsers');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vUsers.off('modified', handlevUsersModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vUsers,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vUserViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vUsers.on('modified', handlevUsersModification);





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
        name: 'User',
        dataField: '',        
        label: { text: 'User' },
        editorOptions: {
            placeholder: 'Name',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
        }
    }, {
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
            onEnterKey: function () { collapsibleFilter.events.performSearch(); },
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
                    ['Site']);
            }
        }
    }, {
        dataField: 'CompanyID',
        label: { text: 'Company' },
        editorType: 'dxSelectBox',
        editorOptions: {
            dataSource: DataUtility.GetLookupCompanyDataSource(null),
            displayExpr: 'Company',
            valueExpr: 'ID',
            placeholder: '(All)',
            searchEnabled: true,
            showClearButton: true,
            onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
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
            onEnterKey: function () { collapsibleFilter.events.performSearch(); },
            onValueChanged: function (e) {
                CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                    ['Company', 'Area', 'Region', 'Territory'],
                    []);
            }
        }
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

        // TerritoryID
        value = form.getEditor('TerritoryID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'TerritoryID', '=', value, 'and');

        // RegionID
        value = form.getEditor('RegionID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'RegionID', '=', value, 'and');

        // AreaID
        value = form.getEditor('AreaID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'AreaID', '=', value, 'and');

        // CompanyID
        value = form.getEditor('CompanyID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'CompanyID', '=', value, 'and');

        // SiteID
        value = form.getEditor('SiteID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SiteID', '=', value, 'and');

        // User
        value = form.getEditor('User').option('value');
        DXUtility.addFilterExpression(filterExpr, 'Name', 'contains', value, 'and');

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
    
    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Users.AddNewUser');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Users.EditUser');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Users.DeleteUser');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Name', caption: 'User Name', width: '180px',
        validationRules: [{ type: 'required' }],
        onlyAllowAdd: true,
        editorOptions: {
            maxLength: 256
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vUsers_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '</tr>'

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }, {
        dataField: 'IsHeadOffice', caption: 'Head Office', width: '100px', dataType: 'boolean',
        defaultValue: false,
        setCellValue: function (rowData, value) {
            var disabled = (value) ? true : false;
            if (disabled) {
                rowData.TerritoryID = null;
                rowData.RegionID = null;
                rowData.AreaID = null;
                rowData.SiteID = null;
                rowData.Company = null;                
            }
            
            var dataGrid = commonGridView.dataGrid();
            var cols = [
                'TerritoryID',
                'RegionID',
                'AreaID',
                'SiteID'
            ];

            for (var i = 0; i < cols.length; i++) {
                var col = dataGrid.columnOption(cols[i]);

                var index = -1;
                if (col.validationRules) {
                    for (var j = 0; j < col.validationRules.length; j++) {
                        if (col.validationRules[j].type == 'required') {
                            index = j;
                            break;
                        }
                    }
                }

                if (index >= 0)
                    col.validationRules.splice(0, 1);

                if (!disabled)
                    col.validationRules.splice(0, 0, { type: 'required' });

                col.allowEditing = !disabled;
                dataGrid.columnOption(cols[i], col);
            }

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'TerritoryID', caption: 'Territory', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vTerritories.dataSource(null),
            displayExpr: 'Territory',
            valueExpr: 'ID',
            allowClearing: true
        },
        setCellValue: function (rowData, value) {
            rowData.RegionID = null;
            rowData.AreaID = null;
            rowData.SiteID = null;
            rowData.Company = null;
            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'RegionID', caption: 'Region', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: function (options) {
                return CommonUtility.cascadeLoadLookupDataSource(options.data, 'TerritoryID',
                    DataUtility.vRegions.dataSource);
            },
            displayExpr: 'Region',
            valueExpr: 'ID',
            allowClearing: true
        },
        setCellValue: function (rowData, value) {
            CommonUtility.cascadeLookupValueChanged(this.lookup.items, rowData, 'ID', value,
                ['TerritoryID']);

            if (!value)
                rowData.TerritoryID = null;

            rowData.AreaID = null;
            rowData.SiteID = null;
            rowData.Company = null;

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'AreaID', caption: 'Area', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: function (options) {
                return CommonUtility.cascadeLoadLookupDataSource(options.data, 'RegionID',
                    DataUtility.vAreas.dataSource);
            },
            displayExpr: 'Area',
            valueExpr: 'ID',
            allowClearing: true
        },
        setCellValue: function (rowData, value) {
            CommonUtility.cascadeLookupValueChanged(this.lookup.items, rowData, 'ID', value,
                ['TerritoryID', 'RegionID']);

            if (!value) {
                rowData.TerritoryID = null;
                rowData.RegionID = null;
            }

            rowData.SiteID = null;
            rowData.Company = null;

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'Company', caption: 'Company', width: '200px', allowEditing: false
    }, {
        dataField: 'SiteID', caption: 'Site', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: function (options) {
                return CommonUtility.cascadeLoadLookupDataSource(options.data, 'AreaID',
                    DataUtility.vSites.dataSource);
            },
            displayExpr: 'Site',
            valueExpr: 'ID',
            allowClearing: true
        },
        setCellValue: function (rowData, value) {
            CommonUtility.cascadeLookupGuidValueChanged(this.lookup.items, rowData, 'ID', value,
                ['TerritoryID', 'RegionID', 'AreaID', 'Company']);

            if (!value) {
                rowData.TerritoryID = null;
                rowData.RegionID = null;
                rowData.AreaID = null;
                rowData.Company = null;
            }

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'StatusID', caption: 'Status', width: '100px',
        defaultValue: 1,
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vSystemLookups.dataSource(['Group', '=', 'UserStatus']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        }
    }, {
        dataField: 'CreatedDate', caption: 'Date', width: '140px', allowEditing: false,
        customizeText: function (cellInfo) {
            if (cellInfo.value)
                return DateTimeUtility.convertToLocal(cellInfo.value).toLocaleString();

            return null;
        }
    }, {
        dataField: 'CreatedByUserName', caption: 'By', width: '140px', allowEditing: false
    }, {
        dataField: 'ModifiedDate', caption: 'Date', width: '140px', allowEditing: false,
        customizeText: function (cellInfo) {
            if (cellInfo.value)
                return DateTimeUtility.convertToLocal(cellInfo.value).toLocaleString();

            return null;
        }
    }, {
        dataField: 'ModifiedByUserName', caption: 'By', width: '140px', allowEditing: false
    }];





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

        icon: 'Images/user_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
