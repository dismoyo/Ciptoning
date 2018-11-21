Dismoyo_Ciptoning_Client.vSalesmanTargets = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    
    function handlevSalesmanTargetsModification() { shouldReload = true; }

    var preventChangeSalesmanID = false;
    var preventChangePeriodID = false;
    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vSalesmanTargets');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vSalesmanTargets.off('modified', handlevSalesmanTargetsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesmanTargets,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanTargetViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vSalesmanTargets.on('modified', handlevSalesmanTargetsModification);



    var dataSource_vProducts = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vProducts,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vProductViewModel(item); }
    });
    
    function updateSalesmanAndPeriodChildEditor(salesmanID, periodID, isEditing) {
        var data = commonPopupEdit.popupEditData();
        var form = commonPopupEdit.form();

        showLoadingPanel();
        
        var targetsDataGrid = productTargetsDataGrid();
        targetsDataGrid.cancelEditData();
        
        form.getEditor('TotalRegisteredCustomer').option('value', 0);
        if (((salesmanID != undefined) || (salesmanID != null)) && (periodID instanceof Date)) {            
            new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vSalesmanProducts,
                select: [
                    'ProductID',
                    'Product'
                ],
                filter: ['SalesmanID', '=', salesmanID],
                sort: ['Product'],
                paginate: false,
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanProductViewModel(item); }
            }).load()
                .done(function (result) {
                    new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vCustomers,
                        select: ['StatusID'],
                        filter: [
                            ['SalesmanID', '=', salesmanID], 'and',
                            ['StatusID', '>=', 1], 'and',
                            ['RegisteredDate', '<', DateTimeUtility.getFirstDayOfMonth(periodID)]
                        ],
                        paginate: false,
                        map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); }
                    }).load()
                        .done(function (result2) {
                            var registeredCustomerCount = result2.length;
                            form.getEditor('TotalRegisteredCustomer').option('value', registeredCustomerCount);

                            var productTargets = [];
                            for (var i = 0; i < result.length; i++) {
                                productTargets.push(new Dismoyo_Ciptoning_Client.vSalesmanProductTargetViewModel());

                                productTargets[i].ProductID(result[i].ProductID());
                                productTargets[i].Product(result[i].Product());
                                productTargets[i].SalesOrderQty(0);
                                productTargets[i].EffectiveCall(0);
                                productTargets[i].CustomerTransaction(0);

                                productTargets[i].EffectiveCallValue(0);
                                productTargets[i].CustomerTransactionValue(0);
                            }

                            if (!isEditing || (productTargets.length != data.ChildProductTargets().length))
                                data.ChildProductTargets(productTargets);

                            updateSalesmanProductTarget(data.ChildProductTargets(), registeredCustomerCount);
                            targetsDataGrid.option('dataSource',
                                createProductTargetArrayDataSource(data.ChildProductTargets()));

                            hideLoadingPanel();
                        })
                        .fail(function (error) {
                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download RO.'), 'Download RO Failed');

                            data.ChildProductTargets([]);
                            targetsDataGrid.option('dataSource',
                                createProductTargetArrayDataSource(data.ChildProductTargets()));

                            hideLoadingPanel();
                        });
                })
                .fail(function (error) {
                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download salesman product data.'), 'Download Salesman Product Failed');

                    data.ChildProductTargets([]);
                    targetsDataGrid.option('dataSource',
                        createProductTargetArrayDataSource(data.ChildProductTargets()));

                    hideLoadingPanel();
                });
        } else {
            data.ChildProductTargets([]);
            targetsDataGrid.option('dataSource',
                createProductTargetArrayDataSource(data.ChildProductTargets()));

            hideLoadingPanel();
        }
    }
    
    function calcSalesmanTarget(e) {
        return calcSalesmanTargetBase(
            e.component,
            e.row.rowIndex,
            e.row.data,
            commonPopupEdit.form().getEditor('TotalRegisteredCustomer').option('value')
        );
    }

    function calcSalesmanTargetBase(dataGrid, rowIndex, rowData, registeredCustomerCount) {
        var customerTransaction = DXUtility.getValue(rowData, 'CustomerTransaction');
        var effectiveCall = DXUtility.getValue(rowData, 'EffectiveCall');

        var customerTransactionValue = (customerTransaction / 100) * registeredCustomerCount;
        var effectiveCallValue = effectiveCall * customerTransactionValue;

        DXUtility.setValue(rowData, 'CustomerTransactionValue', customerTransactionValue);
        DXUtility.setValue(rowData, 'EffectiveCallValue', effectiveCallValue);

        dataGrid.cellValue(rowIndex, 'CustomerTransactionValue', customerTransactionValue);
        dataGrid.cellValue(rowIndex, 'EffectiveCallValue', effectiveCallValue);
    }

    function updateSalesmanProductTarget(productTargets, registeredCustomerCount) {
        for (var i = 0; i < productTargets.length; i++) {
            var productTarget = productTargets[i];

            var customerTransactionValue = (productTarget.CustomerTransaction() / 100) * registeredCustomerCount;
            var effectiveCallValue = productTarget.EffectiveCall() * customerTransactionValue;

            productTarget.CustomerTransactionValue(customerTransactionValue);
            productTarget.EffectiveCallValue(effectiveCallValue);
        }
    }


    function updateSiteChildEditor(form, siteID) {
        if (!siteID)
            siteID = null;

        var salesmanDataSource = DataUtility.GetLookupSalesmanDataSource(['SiteID', '=', siteID]);

        var form = commonPopupEdit.form();

        form.getEditor('SalesmanID').option('value', null);
        form.getEditor('SalesmanID').option('dataSource', []);
        salesmanDataSource.load()
            .done(function (result) {
                form.getEditor('SalesmanID').option('dataSource', salesmanDataSource);
            });
    }


    function createProductTargetArrayDataSource(productTargets) {
        return CommonUtility.createArrayDataSource(
            'vSalesmanProductTargetViewModel',
            ['SalesmanID', 'PeriodID', 'ProductID'],
            productTargets
        );
    }

    function openSelectedEditing(salesmanID, periodID, refreshRequired) {
        showLoadingPanel();

        new DevExpress.data.DataSource({
            store: Dismoyo_Ciptoning_Client.DB.vSalesmanTargets,
            expand: ['ChildProductTargets'],
            filter: [
                ['SalesmanID', '=', salesmanID], 'and',
                ['PeriodID', '=', periodID]
            ],
            paginate: false,
            map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanTargetViewModel(item); }
        }).load()
            .done(function (result) {
                if (result.length > 0) {
                    hideLoadingPanel();

                    isDataGridRefreshRequired = refreshRequired;
                    openEditing(result[0]);
                } else {
                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The selected data is not found.'), 'Load Failed');
                    hideLoadingPanel();
                }
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vSalesmanTargetViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Salesman Target');
        commonPopupEdit.popupEditOptions.editingKey = [data.SalesmanID(), data.PeriodID()];
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);

        if (newData) {
            data.SalesmanID(null);
            data.PeriodID(null);

            data.TerritoryID(user.TerritoryID());
            data.RegionID(user.RegionID());
            data.AreaID(user.AreaID());
            data.SiteID(user.SiteID());
            data.SiteCode(user.SiteCode());
            data.CompanyID(user.CompanyID());
            data.Company(user.Company());
        }

        // Set editor values
        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', data.TerritoryID());
            form.getEditor('RegionID').option('value', data.RegionID());
            form.getEditor('AreaID').option('value', data.AreaID());
            form.getEditor('SiteID').option('value', data.SiteID());
            form.getEditor('Company').option('value', data.Company());
        }

        updateSiteChildEditor(form, data.SiteID());

        preventChangeSalesmanID = true;
        preventChangePeriodID = true;
        form.getEditor('SalesmanID').option('value', data.SalesmanID());
        form.getEditor('PeriodID').option('value', data.PeriodID());
        form.getEditor('SalesOrderAmount').option('value', data.SalesOrderAmount());
        form.getEditor('NewCustomer').option('value', data.NewCustomer());
        form.getEditor('Visibility').option('value', data.Visibility());
        
        form.getEditor('SalesmanID').option('readOnly', !newData);
        form.getEditor('PeriodID').option('readOnly', !newData);

        if (newData) {
            DXUtility.resetFormValidation(form);
        }

        // Set grid datasource for product targets
        var targetsDataGrid = productTargetsDataGrid();
        updateSalesmanAndPeriodChildEditor(form.getEditor('SalesmanID').option('value'),
            form.getEditor('PeriodID').option('value'), true);

        preventChangeSalesmanID = false;
        preventChangePeriodID = false;
    }

    function saveEditing() {
        showLoadingPanel();

        var form = commonPopupEdit.form();

        var isValid = commonPopupEdit.form().validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var productTargetsDataSource = productTargetsDataGrid().option('dataSource');
        var productTargets = [];
        for (var i = 0; i < productTargetsDataSource.store()._array.length; i++)
            productTargets.push(new Dismoyo_Ciptoning_Client.vSalesmanProductTargetViewModel(productTargetsDataSource.store()._array[i]));
                        
        if (isValid) {
            if (productTargets.length == 0) {
                errorMsg = 'The selected Salesman does not have any reference products.';
                isValid = false;
            }
        }

        if (isValid) {
            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            var salesmanID = form.getEditor('SalesmanID').option('value');
            var periodID = form.getEditor('PeriodID').option('value');

            new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vSalesmanTargets,
                select: ['PeriodID'],
                filter: [
                    ['SalesmanID', '=', salesmanID], 'and',
                    ['PeriodID', '=', DateTimeUtility.getFirstDayOfMonth(periodID)],
                ],
                paginate: false,
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanTargetViewModel(item); }
            }).load()
                .done(function (result) {
                    if (((data.SalesmanID() == null) && (data.PeriodID() == null)) && (result.length > 0)) {
                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The selected salesman target is already exist.'), 'Save Failed');
                        hideLoadingPanel();
                    } else {                    
                        data.SalesmanID(salesmanID);
                        data.PeriodID(periodID);
                        data.SalesOrderAmount(form.getEditor('SalesOrderAmount').option('value'));
                        data.NewCustomer(form.getEditor('NewCustomer').option('value'));
                        data.Visibility(form.getEditor('Visibility').option('value'));

                        data.ChildProductTargets(productTargets);

                        var dataJS = ko.toJS(data);

                        dataJS.PeriodID = DateTimeUtility.getFirstDayOfMonth(dataJS.PeriodID);

                        for (var i = 0; i < dataJS.ChildProductTargets.length; i++) {
                            delete dataJS.ChildProductTargets[i]['EffectiveCallValue'];
                            delete dataJS.ChildProductTargets[i]['CustomerTransactionValue'];
                        }

                        dataSource.store().insert(dataJS)
                            .done(function (result) {
                                hideLoadingPanel();

                                commonPopupEdit.popupEditOptions.visible(false);
                                dataGrid.refresh();
                            })
                            .fail(function (error) {
                                data.SalesmanID(null);
                                data.PeriodID(null);

                                DevExpress.ui.dialog.alert(error.message, 'Save Failed');
                                hideLoadingPanel();
                            });
                    }
                })
                .fail(function (error) {
                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to verify data.'), 'Save Failed');
                    hideLoadingPanel();
                });
        } else
            hideLoadingPanel();

        if (errorMsg != '') {
            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(errorMsg), 'Save Failed');
        }
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
                onEnterKey: function () { collapsibleFilter.events.performSearch(); },
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
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
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
        caption: 'Salesman Target',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'PeriodID',
            label: { text: 'Period' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                placeholder: 'mmm-yyyy',
                formatString: 'MMM-yyyy',
                maxZoomLevel: 'year',
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
        value = collapsibleFilter.form().getEditor('SalesmanID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SalesmanID', '=', value, 'and');

        // PeriodID
        value = collapsibleFilter.form().getEditor('PeriodID').option('value');
        if (value instanceof Date)
            DXUtility.addFilterExpression(filterExpr, 'PeriodID', '=', DateTimeUtility.getFirstDayOfMonth(value), 'and');

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

    commonGridView.newRowOptions.disabled = false;
    commonGridView.dataGridOptions.editing.editEnabled = false; commonGridView.dataGridOptions.editing.allowUpdating =
        true; //Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('SalesmanTarget.EditSalesmanTarget');
    commonGridView.dataGridOptions.editing.removeEnabled = false; commonGridView.dataGridOptions.editing.allowDeleting =
        true; //Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('SalesmanTarget.DeleteSalesmanTarget');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'SalesmanID', visible: false
    }, {
        dataField: 'Salesman', width: '200px',
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            commands.append($('<a class="dx-link">').text(options.data.Salesman()).on('dxclick', function () {
                openSelectedEditing(options.data.SalesmanID(), options.data.PeriodID(), false);
            }));
            commands.append('&nbsp;');

            container.append(commands);
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vSalesmanTargets_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';                
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Target' + '</td>';
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
        dataField: 'PeriodID', caption: 'Period', width: '140px',
        customizeText: function (cellInfo) {
            //////////////////////////////////////////////////////////////
            if (cellInfo.value) {
                var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

                var d = cellInfo.value;
                return monthNames[d.getMonth()] + ' ' + d.getFullYear();
            }

            return null;
        }
    }, {
        dataField: 'SalesOrderAmount', caption: 'Amount', width: '100px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 2
    }, {
        dataField: 'NewCustomer', caption: 'NOO', width: '80px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 0
    }, {
        dataField: 'Visibility', caption: 'Visibility', width: '80px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 0
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
    }, {
        width: 100,
        alignment: 'center',
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: center;">');

            commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                openSelectedEditing(options.data.SalesmanID(), options.data.PeriodID(), false);
            }));
            commands.append('&nbsp;');

            commands.append($('<a class="dx-link">').text('Delete').on('dxclick', function () {
                commonGridView.dataGrid().deleteRow(options.rowIndex);
            }));
            commands.append('&nbsp;');

            container.append(commands);
        }
    }];





    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    commonPopupEdit.okOptions.text = 'Save';
    commonPopupEdit.okOptions.icon = 'icons8-save';

    var productTargetsDataGrid = function () { return DXUtility.getDXInstance(null, '#vSalesmanTargets_productTargetsDataGrid', 'dxDataGrid'); }

    var salesmanTargetSave = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_ok', 'dxButton'); }

    var intrvl;

    var isEditorEnabled = function () {
        var dxCommandEdit = $(".dx-command-edit", "[id$=productTargetsDataGrid]");
        for (var i = 0; i < dxCommandEdit.length; i++) {
            if ($(dxCommandEdit[i]).text().trim().indexOf('Save') >= 0)
                return true;
        }

        return false;
    }

    var intrvlHandler = function () {
        var disabled = false;

        if (!isEditorEnabled()) {
            salesmanTargetSave().option('disabled', false);
            clearInterval(intrvl);
        }
    };


    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        var maxRange = 1000;
        var minRange = 0;
        var maxValue = 0;

        content.append(DXUtility.createFormItemLabelTop('Product Target', '9px'));

        content.append($('<div id="vSalesmanTargets_productTargetsDataGrid">').dxDataGrid({
            deferRendering: false,
            dataSource: [],
            showBorders: true,
            paging: { enabled: false },
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            editing: {
                editMode: 'row',
                allowAdding: false,
                allowUpdating: true,
                allowDeleting: true,
            },
            onInitNewRow: function (info) {
                salesmanTargetSave().option("disabled", true);
                
                intrvl = setInterval(intrvlHandler, 500);

                info.data.SalesOrderQty = 0;
                info.data.EffectiveCall = 0;
                info.data.CustomerTransaction = 0;
            },
            onEditorPreparing: function (e) {
                if (e.parentType == 'dataRow') {
                    if ((e.row != undefined) && (e.row.rowIndex != undefined))
                        e.component.editRowIndex = e.row.rowIndex;

                    if ((e.dataField == 'EffectiveCall') || (e.dataField == 'CustomerTransaction')) {
                        var prevKeyCode = '';
                        e.editorElement.dxTextBox({
                            value: e.value,
                            onFocusIn: function (e) { DXUtility.selectAllText(e.element, 'dxTextBox'); },
                            onKeyDown: function (ea) {
                                if (((ea.jQueryEvent.keyCode > 47) && (ea.jQueryEvent.keyCode <= 57)) ||
                                    (ea.jQueryEvent.keyCode == 190) || (ea.jQueryEvent.keyCode == 191) ||
                                    ((ea.jQueryEvent.keyCode > 95) && (ea.jQueryEvent.keyCode <= 105)))
                                    prevKeyCode = ea.jQueryEvent.target.value;
                                else if ((ea.jQueryEvent.keyCode != 8) && (ea.jQueryEvent.keyCode != 46) &&
                                    (ea.jQueryEvent.keyCode != 13) && (ea.jQueryEvent.keyCode != 9))
                                    ea.jQueryEvent.preventDefault();                                
                            },
                            onEnterKey: function (ea) {
                                productTargetsDataGrid().saveEditData();
                            },
                            onValueChanged: function (ea) {
                                if ((ea.value == null) || (ea.value == ''))
                                    ea.value = 0;

                                ea.component.option('value', ea.value);                                
                                e.setValue(ea.value);

                                DXUtility.setValue(e.row.data, e.dataField, ea.value);
                                calcSalesmanTarget(e);
                            }
                        });

                        e.cancel = true;
                    }
                }
            },
            onRowUpdated: function (info) {
                var data = commonPopupEdit.popupEditData();

                var store = productTargetsDataGrid().option('dataSource').store();
                var productTargets = [];
                for (var i = 0; i < store._array.length; i++)
                    productTargets.push(new Dismoyo_Ciptoning_Client.vSalesmanProductTargetViewModel(store._array[i]));

                data.ChildProductTargets(productTargets);
            },
            onEditingStart: function (info) {
                salesmanTargetSave().option('disabled', true);
                intrvl = setInterval(intrvlHandler, 500);
            },
            columns: [{
                dataField: 'SalesmanID', visible: false
            }, {
                dataField: 'PeriodID', visible: false
            }, {
                dataField: 'ProductID', visible: false
            }, {
                dataField: 'Product', caption: 'Product', allowEditing: false,
                editorOptions: {
                    readOnly: true
                },
                headerCellTemplate: function (columnHeader, headerInfo) {
                    var dataGrid = $(productTargetsDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'OT' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'EC' + '</td>';                        
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '</tr>'

                        var table = dataGrid.find('.dx-header-row:first-child');
                        $(tr).insertBefore(table[0].parentElement);
                        $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
                    }
                }
            }, {
                dataField: 'SalesOrderQty', caption: 'Qty', width: '80px',
                dataType: 'number',
                validationRules: [{ type: 'required' }],
                editorOptions: {
                    onKeyDown: DXUtility.preventInputCharacters
                }
            }, {
                dataField: 'CustomerTransaction', caption: 'Param (% of RO)', width: '100px',
                dataType: 'number', format: 'fixedPoint', precision: 2,
                validationRules: [{ type: 'required' }]
            }, {
                dataField: 'CustomerTransactionValue', caption: 'Target', width: '70px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }, {
                dataField: 'EffectiveCall', caption: 'Param (x of OT)', width: '100px',
                dataType: 'number', format: 'fixedPoint', precision: 2,
                validationRules: [{ type: 'required' }]
            }, {
                dataField: 'EffectiveCallValue', caption: 'Target', width: '70px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }]
        }));

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
    };

    commonGridView.events.performNewRow = function (rootView) {
        openEditing(null);
    };

    commonPopupEdit.events.performOK = function (rootView) {
        saveEditing();
    };

    commonPopupEdit.events.performCancel = function (rootView) {
        commonPopupEdit.popupEditOptions.visible(false);

        if (isDataGridRefreshRequired) {
            commonGridView.dataGrid().refresh();
            isDataGridRefreshRequired = false;
        }
    };

    // ------------------------------------------------------------------------------------------------
    // Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    commonPopupEdit.formOptions.items = [{
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Territory',
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Region',
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Area',
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    var form = commonPopupEdit.form();

                    CommonUtility.cascadeValueChanged(form, e.selectedItem, e.value, 'Site',
                         ['Area', 'Region', 'Territory'],
                         []);

                    if (e.selectedItem)
                        form.getEditor('Company').option('value', e.selectedItem.Company());                        
                    else if (e.previousValue != null)
                        form.getEditor('Company').option('value', null);

                    updateSiteChildEditor(form, e.value);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Salesman Target',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchEnabled: true,                
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function(e) {
                    var form = commonPopupEdit.form();
                    
                    if (e.value && !preventChangeSalesmanID)
                        updateSalesmanAndPeriodChildEditor(e.value, form.getEditor('PeriodID').option('value'));

                    preventChangeSalesmanID = false;
                }
            }
        }, {
            dataField: 'PeriodID',
            label: { text: 'Period' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',                
                placeholder: 'mmm-yyyy',
                formatString: 'MMM-yyyy',
                maxZoomLevel: 'year',
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    var form = commonPopupEdit.form();
                    
                    if (e.value && !preventChangePeriodID)
                        updateSalesmanAndPeriodChildEditor(form.getEditor('SalesmanID').option('value'), e.value, true);

                    preventChangePeriodID = false;
                }
            }
        }, {
            dataField: 'TotalRegisteredCustomer',
            label: { text: 'RO' },
            editorType: 'dxNumberBox',
            editorOptions: {
                value: 0,
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 2
        }, {
            dataField: 'SalesOrderAmount',
            validationRules: [{ type: 'required' }],
            label: { text: 'Amount' },
            editorType: 'dxNumberBox',
            editorOptions: {
                min: 0,
                max: 100000000000,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'NewCustomer',
            validationRules: [{ type: 'required' }],
            label: { text: 'NOO' },
            editorType: 'dxNumberBox',
            editorOptions: {
                min: 0,
                max: 1000,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'Visibility',
            validationRules: [{ type: 'required' }],
            label: { text: 'Visibility' },
            editorType: 'dxNumberBox',
            editorOptions: {
                min: 0,
                max: 1000,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }]
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

        icon: 'Images/salesman_target_32px.png',

        dataSource_vProducts: dataSource_vProducts,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,

        productTargetsDataGrid: productTargetsDataGrid
    };
};
