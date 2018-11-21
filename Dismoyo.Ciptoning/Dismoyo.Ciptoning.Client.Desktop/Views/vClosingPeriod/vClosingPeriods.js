Dismoyo_Ciptoning_Client.vClosingPeriods = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevClosingPeriodsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vClosingPeriods');
        if (!pane)
            setTimeout(checkContainer, 50);
        else {
            commonGridView.commands().append($('<div class="desktop-commonGridView-commands-item" style="margin-left: 16px; margin-top: 4px; margin-bottom: 4px;">').text('Period:'));

            commonGridView.commands().append($('<div id="vClosingPeriods_periodInput" class="desktop-commonGridView-commands-item">').dxDateBox({
                width: '150px',
                showClearButton: true,
                min: new Date(2016, 6, 1),
                placeholder: 'mmm-yyyy',
                formatString: 'MMM-yyyy',
                maxZoomLevel: 'year',
            }));

            commonGridView.commands().append($('<div id="vClosingPeriods_newAll" class="desktop-commonGridView-commands-item">').dxButton({
                text: 'New All',
                onClick: function () {
                    performNewAll();
                }
            }));

            commonGridView.commands().append($('<div id="vClosingPeriods_openAll" class="desktop-commonGridView-commands-item">').dxButton({
                text: 'Open All',
                onClick: function () {
                    performOpenCloseAll(false);
                }
            }));

            commonGridView.commands().append($('<div id="vClosingPeriods_closeAll" class="desktop-commonGridView-commands-item">').dxButton({
                text: 'Close All',
                onClick: function () {
                    performOpenCloseAll(true);
                }
            }));
        }
    }

    function performNewAll() {
        var dataGrid = commonGridView.dataGrid();
        var date = $('#vClosingPeriods_periodInput').dxDateBox('instance').option('value');
        var year = date.getFullYear();

        DevExpress.ui.dialog.confirm(
            'Are you sure want to create new all sites data for year ' + year + '?',
            'New All Confirmation').done(function (dialogResult) {
                if (dialogResult) {
                    new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vSites,
                        select: ['ID'],
                        paginate: false,
                        map: function (item) { return new Dismoyo_Ciptoning_Client.vSiteViewModel(item); }
                    }).load()
                        .done(function (result) {
                            var sites = result;

                            new DevExpress.data.DataSource({
                                store: Dismoyo_Ciptoning_Client.DB.vClosingPeriods,
                                select: ['SiteID'],
                                filter: ['YearID', '=', year],
                                paginate: false,
                                map: function (item) { return new Dismoyo_Ciptoning_Client.vClosingPeriodViewModel(item); }
                            }).load()
                            .done(function (result2) {
                                var existingSites = result2;
                                var i = 0;

                                if (existingSites.length > 0) {
                                    while (i < sites.length) {
                                        var ids = $.grep(existingSites, function (e) {
                                            return (e.SiteID()._value == sites[i].ID()._value);
                                        });

                                        if (ids.length > 0)
                                            sites.splice(i, 1);
                                        else
                                            i++;
                                    }
                                }

                                if (sites.length > 0)
                                    dataGrid.beginCustomLoading();

                                var x = 0;
                                for (i = 0; i < sites.length; i++) {
                                    var data = new Dismoyo_Ciptoning_Client.vClosingPeriodViewModel();

                                    data.SiteID(sites[i].ID());
                                    data.YearID(year);
                                    data.Jan(false);
                                    data.Feb(false);
                                    data.Mar(false);
                                    data.Apr(false);
                                    data.May(false);
                                    data.Jun(false);
                                    data.Jul(false);
                                    data.Aug(false);
                                    data.Sep(false);
                                    data.Oct(false);
                                    data.Nov(false);
                                    data.Dec(false);
                                    
                                    dataSource.store().insert(data.toJS())
                                        .done(function (result3) {
                                            x++;
                                            if (x >= (sites.length - 1)) {
                                                dataSource.load()
                                                    .done(function (result4) {
                                                        dataGrid.endCustomLoading();
                                                        dataGrid.refresh();
                                                    })
                                                    .fail(function (error4) {
                                                        dataGrid.endCustomLoading();
                                                    });
                                            }
                                        })
                                        .fail(function (error3) {
                                            var dc = $('.dx-popup-normal>.dx-dialog-content');
                                            if (dc.length == 0)
                                                DevExpress.ui.dialog.alert(error3.message, 'Save Failed');

                                            x++;
                                            if (x >= (sites.length - 1)) {
                                                dataSource.load()
                                                    .done(function (result4) {                                                        
                                                        dataGrid.endCustomLoading();
                                                        dataGrid.refresh();
                                                    })
                                                    .fail(function (error4) {
                                                        dataGrid.endCustomLoading();
                                                    });
                                            }
                                        });
                                }
                            })
                            .fail(function (error2) {
                                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(
                                    'Failed to load existing closing period data.'), 'Load Failed');
                            });
                        })
                        .fail(function (error) {
                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load all sites data.'),
                                'Load Failed');
                        });
                }
            });
    }

    function performOpenCloseAll(isClosed) {
        var date = $('#vClosingPeriods_periodInput').dxDateBox('instance').option('value');
        var year = date.getFullYear();
        var monthName = null;
        switch (date.getMonth() + 1) {
            case 1: monthName = 'Jan'; break;
            case 2: monthName = 'Feb'; break;
            case 3: monthName = 'Mar'; break;
            case 4: monthName = 'Apr'; break;
            case 5: monthName = 'May'; break;
            case 6: monthName = 'Jun'; break;
            case 7: monthName = 'Jul'; break;
            case 8: monthName = 'Aug'; break;
            case 9: monthName = 'Sep'; break;
            case 10: monthName = 'Oct'; break;
            case 11: monthName = 'Nov'; break;
            case 12: monthName = 'Dec'; break;
        }

        var text = ((isClosed) ? 'Close' : 'Open');
        DevExpress.ui.dialog.confirm(
            'Are you sure want to ' + text + ' all sites for ' + monthName + ' ' + year + ' period?',
            text + ' All Confirmation').done(function (dialogResult) {
                if (dialogResult) {
                    new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vClosingPeriods,
                        select: [
                            'SiteID',
                            'YearID',
                            monthName
                        ],
                        filter: ['YearID', '=', year],
                        paginate: false,
                        map: function (item) { return new Dismoyo_Ciptoning_Client.vClosingPeriodViewModel(item); }
                    }).load()
                        .done(function (result) {
                            for (var i = 0; i < result.length; i++) {
                                result[i][monthName](isClosed);

                                var dataJS = result[i].toJS();
                                var store = dataSource.store();
                                store.update(store.keyOf(dataJS), dataJS)
                                    .done(function (result2) {
                                        if (i >= (result.length - 1))
                                            collapsibleFilter.events.performSearch(this);
                                    })
                                    .fail(function (error) {
                                        if (i >= (result.length - 1))
                                            collapsibleFilter.events.performSearch(this);
                                    });
                            }
                        });
                }
            });
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vClosingPeriods.off('modified', handlevClosingPeriodsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vClosingPeriods,
        select: [
            'SiteID',
            'YearID',
            'TerritoryID',
            'RegionID',
            'AreaID',
            'Company',
            'Site',
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
            'CreatedDate',
            'CreatedByUserName',
            'ModifiedDate',
            'ModifiedByUserName'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vClosingPeriodViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vClosingPeriods.on('modified', handlevClosingPeriodsModification);





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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area', 'Site']);
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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                        ['Company', 'Area', 'Region', 'Territory'],
                        []);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Closing Period',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'YearID',
            label: { text: 'Year' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                min: new Date(2016, 6, 1),
                placeholder: 'yyyy',
                formatString: 'yyyy',
                maxZoomLevel: 'decade',
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
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

        // YearID
        value = collapsibleFilter.form().getEditor('YearID').option('value');
        if (value instanceof Date)
            DXUtility.addFilterExpression(filterExpr, 'YearID', '=', value.getFullYear(), 'and');

        if (filterExpr.length > 0)
            dataGrid.filter(filterExpr);
        else
            dataGrid.refresh();
    };



    function convertMonthNameToNumber(monthName) {
        var myDate = new Date(monthName + " 1, 2000");
        var monthDigit = myDate.getMonth();
        return isNaN(monthDigit) ? 0 : (monthDigit + 1);
    }





    // ------------------------------------------------------------------------------------------------
    // commonGridView
    // ------------------------------------------------------------------------------------------------
    var commonGridView = new Dismoyo_Ciptoning_Client.CommonGridView();
    commonGridView.dataGridOptions.dataSource = dataSource;

    //commonGridView.dataGridOptions.onRowInserting = function (info) {
    //    if (info.data.YearID != undefined) {            
    //        info.data.Year = new Date(new Date(info.data.Year).getFullYear(), 0, 1);
    //    }
    //};

    //commonGridView.dataGridOptions.onRowUpdating = function (info) {
    //    if (info.newData.Year != undefined) {
    //        info.newData.Year = new Date(new Date(info.newData.Year).getFullYear(), 0, 1);
    //    }
    //};

    //commonGridView.dataGridOptions.onEditingStart = function (rowInfo) {
    //    var curMonth = Globalize.format(new Date(), "MMMM");
    //    var curYear = Globalize.format(new Date(), "yyyy");
    //    var columns = rowInfo.component.option("columns");

    //    for (var i = 3; i < 15; i++) {
    //        if (convertToDate(columns[i].dataField, rowInfo.data.Year().getFullYear()) > convertToDate(curMonth, curYear)) {
    //            commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', false);

    //        } else {
    //            commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', true);

    //        }
    //    }
    //}
    //var rowIndex = commonGridView.dataGrid()._controllers.data._editingController._editRowIndex;
    //if (!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) {
    //    var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
    //    info.data.SiteID = user.SiteID();

    //}

    //commonGridView.dataGridOptions.onInitNewRow = function (rowInfo) {
    //    var curMonth = Globalize.format(new Date(), "MMMM");
    //    var curYear = Globalize.format(new Date(), "yyyy");
    //    var columns = rowInfo.component.option("columns");

    //    if (!Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) {
    //        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
    //        rowInfo.data.SiteID = user.SiteID();
    //    }


    //    for (var i = 3; i < 15; i++) {
    //        if (convertMonthNameToNumber(columns[i].dataField) > convertMonthNameToNumber(curMonth)) {
    //            commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', false);
    //        } else {
    //            commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', true);
    //        }
    //    }
    //}



    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
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

            this.defaultSetCellValue(rowData, value);
        }
    }, {
        dataField: 'YearID', caption: 'Year', alignment: 'center', width: '70px',
        validationRules: [{ type: 'required' }],
        //format: 'yyyy', editorType: 'dxDateBox',
        //    editorOptions: {
        //onValueChanged: function (e) {
        //    if (e.value) {
        //        var curYear = Globalize.format(new Date(), 'yyyy');
        //        var curMonth = Globalize.format(new Date(), 'MMMM');
        //        var year = DateTimeUtility.convertToLocal(e.value).toLocaleString();
        //        var tahun = new Date(year);
        //        var columns = commonGridView.dataGridOptions.columns;
        //        var rowIndex = commonGridView.dataGrid()._controllers.data._editingController._editRowIndex;
        //        for (var i = 3; i < 15; i++) {
        //            if (convertToDate(columns[i].dataField, tahun.getFullYear()) > convertToDate(curMonth, curYear)) {

        //                commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', false);
        //                commonGridView.dataGrid().cellValue(rowIndex, 'Year', e.value);

        //            } else {

        //                commonGridView.dataGrid().columnOption(columns[i].dataField, 'allowEditing', true);
        //                commonGridView.dataGrid().cellValue(rowIndex, 'Year', e.value);

        //            }

        //        }
        //    }
        //},
        //    maxZoomLevel: 'decade',
        //    minZoomLevel: 'century',
        //},
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vClosingPeriods_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines data-grid-banded-header-border-top">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                if (user.IsHeadOffice()) {
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                }

                tr += '       <td class="dx-datagrid-action" colspan="13">' + 'Period' + '</td>';
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
        dataField: 'Jan', caption: 'Jan', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Feb', caption: 'Feb', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Mar', caption: 'Mar', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Apr', caption: 'Apr', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'May', caption: 'May', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Jun', caption: 'Jun', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Jul', caption: 'Jul', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Aug', caption: 'Aug', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Sep', caption: 'Sep', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Oct', caption: 'Oct', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Nov', caption: 'Nov', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
        }
    }, {
        dataField: 'Dec', caption: 'Dec', dataType: 'boolean', width: '75px',
        cellTemplate: function (container, cellInfo) {
            formatMonthValue(container, cellInfo);
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

    function formatMonthValue(container, cellInfo) {
        container.text((cellInfo.value) ? 'CLOSED' : 'OPEN');

        var date = DateTimeUtility.getFirstTimeOfDay(new Date());
        var year = DXUtility.getValue(cellInfo.data, 'YearID');
        var month = null;
        switch (cellInfo.column.dataField) {
            case 'Jan': month = 1; break;
            case 'Feb': month = 2; break;
            case 'Mar': month = 3; break;
            case 'Apr': month = 4; break;
            case 'May': month = 5; break;
            case 'Jun': month = 6; break;
            case 'Jul': month = 7; break;
            case 'Aug': month = 8; break;
            case 'Sep': month = 9; break;
            case 'Oct': month = 10; break;
            case 'Nov': month = 11; break;
            case 'Dec': month = 12; break;
        }

        if (((date.getMonth() + 1) == month) && (date.getFullYear() == year))
            container.css("background-color", "#CF7E72");
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

        icon: "Images/region_32px.png",

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
