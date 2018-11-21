Dismoyo_Ciptoning_Client.vWarehouses = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevWarehousesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vWarehouses');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vWarehouses.off('modified', handlevWarehousesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    function createCodeMask(siteID) {
        return "\\" + siteID.split("").join("\\") + "-AAAAA";
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vWarehouses,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vWarehouseViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vWarehouses.on('modified', handlevWarehousesModification);





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
                        ['Company', 'Site']);
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
        }]
    }, {
        itemType: 'group',
        caption: 'Warehouse',
        colCount: 3,
        colSpan: 3,
        items: [{
            name: 'Warehouse',
            dataField: '',
            label: { text: 'Warehouse' },
            editorType: 'dxTextBox',
            editorOptions: {
                placeholder: 'Code/Name',
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }, {
            dataField: '',
            label: { text: '', visible: false },
            editorOptions: { visible: false }
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

        // Warehouse
        value = form.getEditor('Warehouse').option('value');
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
    
    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Warehouses.AddNewWarehouse');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Warehouses.EditWarehouse');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Warehouses.DeleteWarehouse');

    commonGridView.events.initRow = function (info) {
        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        if (!user.IsHeadOffice()) {
            info.data.TerritoryID = user.TerritoryID();
            info.data.RegionID = user.RegionID();
            info.data.AreaID = user.AreaID();
            info.data.SiteID = user.SiteID();
            info.data.CompanyID = user.CompanyID();
        }
    };

    //commonGridView.dataGridOptions.onInitNewRow = function (info) {
    //    info.data.StatusID = 1; // Active
    //};

    //// For masking purpose (not use yet)
    //commonGridView.dataGridOptions.onEditorPrepared = function (e) {
    //    if (!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) {
    //        if (e.dataField == 'Code') {
    //            e.editorElement.dxTextBox('instance')
    //                .option('mask', createCodeMask(Dismoyo_Ciptoning_Client.app.CurrentUser.SiteCode()));
    //        }
    //    }
    //};

    commonGridView.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow') {
            if (e.row) {
                e.component.editRowIndex = e.row.rowIndex;

                //// For masking purpose (not use yet)
                //if (e.dataField == 'Site') {
                //    e.editorElement.dxSelectBox({
                //        dataSource: Dismoyo_Ciptoning_Client.LocalStore.vAreas.dataSource(),
                //        displayExpr: 'Site',
                //        valueExpr: 'ID',
                //        allowClearing: true,
                //        value: e.value,
                //        validationRules: [{ type: 'required' }],
                //        onValueChanged: function (ea) {
                //            if (ea.value) {
                //                var item = this.option('selectedItem');
                //                if (item) {
                //                    e.component.cellValue(e.row.rowIndex, 'TerritoryID', item.TerritoryID());
                //                    e.component.cellValue(e.row.rowIndex, 'RegionID', item.RegionID());
                //                    e.component.cellValue(e.row.rowIndex, 'AreaID', item.AreaID());
                //                    e.component.cellValue(e.row.rowIndex, 'Company', item.Company());

                //                    e.component.cellValue(e.row.rowIndex, 'Code', ea.selectedItem.Code() + "-");
                //                    var codeTextBox = e.component.getCellElement(e.row.rowIndex, 'Code').find('.dx-textbox').dxTextBox('instance');
                //                    codeTextBox.option('mask', createCodeMask(ea.selectedItem.Code()));
                //                }
                //            }

                //            e.component.cellValue(e.row.rowIndex, 'Site', ea.value);
                //            e.setValue(ea.value);
                //        },
                //        itemTemplate: function (data, index, element) {
                //            if (typeof data.Site == "function")
                //                data = data.toJS();

                //            var div = "<p title='" + data.Site + "'>" + data.Site + "</p>";
                //            return div;
                //        }
                //    });

                //    e.cancel = true;
                //}

                //if (e.dataField == 'Code') {
                //    if (!e.row.inserted) {
                //        e.allowEditing = false;
                //        e.editorElement.append($('<td style="padding: 5px;">').text(e.row.data.Code()));
                //        e.cancel = true;
                //    }
                //}
            }
        }
    };

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------

    // Added by Andhika 2016.05.16 UAT Issue No.157 -------
    var codeValidationFormat = {
        type: 'pattern',
        pattern: /^\w+\-\w+$/,
        message: 'Format must be [Site Code]-[Warehouse Code].'
    };

    var codeValidationCustom = {
        type: 'custom',
        validationCallback: function (options) {
            var valid = true;
            var siteCode = "";
            if (!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) {
                siteCode = Dismoyo_Ciptoning_Client.app.CurrentUser.SiteCode()
            } else {
                var data = options.validator._validationGroup.data;
                if (data.SiteID) {
                    var row = Dismoyo_Ciptoning_Client.LocalStore.vSites.dataByFilter(['ID', '=', data.SiteID._value])[0];
                    if (row) {
                        siteCode = row.Code();
                    }
                }
            }

            if (siteCode != "" && siteCode != undefined) {
                if (siteCode != options.value.split("-")[0]) {
                    valid = false;
                }
            }

            return valid;
        },
        message: 'Site Code must be ' + ((!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ?
            Dismoyo_Ciptoning_Client.app.CurrentUser.SiteCode() + "." : 'same as selected Site.')
    }
    //------------------------------------------------------

    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'TerritoryID', caption: 'Territory', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
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
        dataField: 'RegionID', caption: 'Region', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
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

            rowData.AreaID = null;
            rowData.SiteID = null;
            rowData.Company = null;

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'AreaID', caption: 'Area', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
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

            rowData.SiteID = null;
            rowData.Company = null;

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'Company', caption: 'Company', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(), allowEditing: false
    }, {
        dataField: 'SiteID', caption: 'Site', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
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

            rowData.Code = $.grep(this.lookup.items, function (e) { return e.ID()._value == value._value; })[0].Code() + "-";
            
            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'Code', width: '120px',
        defaultValue: (!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ?
            Dismoyo_Ciptoning_Client.app.CurrentUser.SiteCode() + "-" : undefined,
        validationRules: [{ type: 'required' }, codeValidationFormat, codeValidationCustom],
        editorOptions: {
            maxLength: 12
        },
        onlyAllowAdd: true,
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vWarehouses_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                if (user.IsHeadOffice()) {
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                }

                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Warehouse' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
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
        }
    }, {
        dataField: 'Name', width: '180px',
        editorOptions: {
            maxLength: 50
        },
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'TypeID', caption: 'Type', width: '120px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vSystemLookups.dataSource(['Group', '=', 'WarehouseType']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        }
    }, {
        dataField: 'StatusID', caption: 'Status', width: '100px',
        defaultValue: 1,
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vSystemLookups.dataSource(['Group', '=', 'WarehouseStatus']),
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

        icon: 'Images/warehouse_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
