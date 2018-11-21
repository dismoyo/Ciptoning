Dismoyo_Ciptoning_Client.vAreas = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevAreasModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vAreas');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vAreas.off('modified', handlevAreasModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vAreas,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vAreaViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vAreas.on('modified', handlevAreasModification);





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
            onEnterKey: function () { collapsibleFilter.events.performSearch(); },
            onValueChanged: function (e) {
                CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Region',
                    ['Territory'],
                    []);
            }
        }
    }, {
        name: 'Area',
        dataField: '',
        label: { text: 'Area' },
        editorOptions: {
            placeholder: 'Code/Name',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
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

        // Area
        value = form.getEditor('Area').option('value');
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'Code', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'Name', 'contains', value, 'or');
        DXUtility.addGroupFilterExpression(filterExpr, groupFilterExpr, 'and');

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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Areas.AddNewArea');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Areas.EditArea');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Areas.DeleteArea');

    commonGridView.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow' && e.dataField == 'Code') {
            if (!e.row.inserted) {
                e.allowEditing = false;
                e.editorElement.append($('<td style="padding: 5px;">').text(e.row.data.Code()));
                e.cancel = true;
            }
        }
    };

    var regionDataSourceArray;
    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'TerritoryID', caption: 'Territory', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vTerritories.dataSource(null),
            displayExpr: 'Territory',
            valueExpr: 'ID',
            allowClearing: true,
            sortOrder: "asc"
        },
        setCellValue: function (rowData, value) {
            rowData.RegionID = null;
            this.defaultSetCellValue(rowData, value);
        },
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

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'Code', width: '70px',
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vAreas_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Area' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                if (commonGridView.dataGridOptions.editing.allowUpdating ||
                    commonGridView.dataGridOptions.editing.allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        editorOptions: {
            maxLength: 10
        }
    }, {
        dataField: 'Name', width: '180px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 50
        },
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

        icon: 'Images/area_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
