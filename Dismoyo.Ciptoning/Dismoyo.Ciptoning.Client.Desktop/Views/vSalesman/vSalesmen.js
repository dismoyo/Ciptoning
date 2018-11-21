Dismoyo_Ciptoning_Client.vSalesmen = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;

    function handlevSalesmenModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vSalesmen');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vSalesmen.off('modified', handlevSalesmenModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesmen,
        select: [
            'ID',
            'Territory',
            'Region',
            'Area',
            'Company',
            'Site',
            'Code',
            'Name',
            'Warehouse',
            'GroupName',
            'CategoryName',
            'StatusName',
            'CreatedDate',
            'CreatedByUserName',
            'ModifiedByUserName'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vSalesmen.on('modified', handlevSalesmenModification);



    var dataSource_vSalesmanProduct = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesmanProducts,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanProductViewModel(item); }
    });


    function previewSalesmanCode(siteCode) {
        var data = commonPopupEdit.popupEditData();
        if (data.ID())
            return data.Code();

        var form = commonPopupEdit.form();

        var selectedItem = null;
        var categoryCode = null;

        selectedItem = form.getEditor('CategoryID').option('selectedItem');
        if (selectedItem)
            categoryCode = selectedItem.Value_String();

        return ((siteCode) ? siteCode : '(Site Code)') + '-' + ((categoryCode) ? categoryCode : '(Salesman Category Code)') + '(Auto Generated)';
    }

    function createSalesmanProductArrayDataSource(productBrands) {
        var salesmanProducts = ko.toJS(productBrands);
        for (var i = 0; i < salesmanProducts.length; i++) {
            var item = salesmanProducts[i];
            item.key = item.ID;
            item.text = item.Brand;
            item.items = item.ChildProducts;
            for (var j = 0; j < item.items.length; j++) {
                var subItem = item.items[j];
                subItem.key = item.ID + '_' + subItem.ID;
                subItem.text = subItem.Product;
            }
        }

        return salesmanProducts;
    }

    function loadProductTreeview(siteID) {

        if (siteID) {
            var salesmanProducts = [];
            var siteProducts = [];
            var data = commonPopupEdit.popupEditData();
            for (var i = 0; i < data.ChildProducts().length; i++) {
                var item = data.ChildProducts()[i];
                item.key = item.ProductBrandID() + '_' + item.ProductID();
                salesmanProducts.push(item);
            }

            new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vSiteProducts,
                select: [
                    'ProductID',
                    'ProductBrand'
                ],
                filter: ['SiteID', '=', siteID],
                paginate: false,
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSiteProductViewModel(item); }
            }).load()
               .done(function (result) {
                   var filters = [];
                   var groupFilterExpr = [];
                   new DevExpress.data.DataSource({
                       store: Dismoyo_Ciptoning_Client.DB.vProductBrands,
                       select: [
                           'ID',
                           'Brand',
                           'ChildProducts',
                           'ChildProducts.ID',
                           'ChildProducts.Product'
                       ],
                       expand: ['ChildProducts'],
                       paginate: false,
                       map: function (item) { return new Dismoyo_Ciptoning_Client.vProductBrandViewModel(item); }
                   }).load()
                        .done(function (result2) {
                            var product = [];
                            var siteProducts = result;
                            var newCP = [];
                            for (var i = 0; i < result2.length; i++) {
                                newCP = [];
                                for (var j = 0; j < result2[i].ChildProducts().length; j++) {
                                    for (var k = 0; k < siteProducts.length; k++) {
                                        if (result2[i].ChildProducts()[j].ID() == siteProducts[k].ProductID()) {
                                            newCP.push(result2[i].ChildProducts()[j]);
                                        }
                                    }
                                }
                                result2[i].ChildProducts(newCP);
                                if (result2[i].ChildProducts().length < 1) {
                                    result2.splice(i, 1);
                                    i--;
                                }
                            }

                            var salesmanProductDataSource = createSalesmanProductArrayDataSource(result2);
                            DXUtility.setSelectedTreeViewItems(salesmanProductDataSource, salesmanProducts);
                            salesmanProductTreeView().option('dataSource', salesmanProductDataSource);
                        });

               });
        }
    }


    function updateSiteChildEditor(form, siteID) {
        if (!siteID)
            siteID = null;

        var warehouseDataSource = DataUtility.GetLookupWarehouseDataSource([['SiteID', '=', siteID],['StatusID', '=', 1]]);

        form.getEditor('WarehouseID').option('value', null);
        form.getEditor('WarehouseID').option('dataSource', []);
        warehouseDataSource.load()
            .done(function (result) {
                form.getEditor('WarehouseID').option('dataSource', warehouseDataSource);
            });
    }


    function openSelectedEditing(id, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vSalesmen.byKey(id, { expand: ['ChildProducts'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vSalesmanViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
         if (!data) {
            data = new Dismoyo_Ciptoning_Client.vSalesmanViewModel();
            data.StatusID(1);
            newData = true;
        }
        commonPopupEdit.popupEditData(data);

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Salesman');
        commonPopupEdit.popupEditOptions.editingKey = data.ID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);

        var salesmanCode = data.Code();
        if (newData) {
            data.StatusID(1);

            if (!user.IsHeadOffice()) {
                data.TerritoryID(user.TerritoryID());
                data.RegionID(user.RegionID());
                data.AreaID(user.AreaID());
                data.SiteID(user.SiteID());
                data.SiteCode(user.SiteCode());
                data.CompanyID(user.CompanyID());
                data.Company(user.Company());
            }

            data.SFAFlag(false);
            salesmanCode = previewSalesmanCode(data.SiteCode());
        }

        // Set editor values
        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', data.TerritoryID());
            form.getEditor('RegionID').option('value', data.RegionID());
            form.getEditor('AreaID').option('value', data.AreaID());
            form.getEditor('SiteID').option('value', data.SiteID());
            form.getEditor('Company').option('value', data.Company());

            form.getEditor('TerritoryID').option('readOnly', !newData);
            form.getEditor('RegionID').option('readOnly', !newData);
            form.getEditor('AreaID').option('readOnly', !newData);
            form.getEditor('SiteID').option('readOnly', !newData);
            form.getEditor('Company').option('readOnly', !newData);
        }

        loadProductTreeview(data.SiteID());

        updateSiteChildEditor(form, data.SiteID());

        form.getEditor('Name').option('value', data.Name());
        form.getEditor('Code').option('value', salesmanCode);

        form.getEditor('WarehouseID').option('value', data.WarehouseID());
        form.getEditor('GroupID').option('value', data.GroupID());
        form.getEditor('CategoryID').option('value', data.CategoryID());
        form.getEditor('Phone').option('value', data.Phone());
        form.getEditor('SFAFlag').option('value', data.SFAFlag());
        form.getEditor('SFA').option('value', data.SFA());

        form.getEditor('SFA').option('readOnly', !data.SFAFlag());

        if (newData) {
            DXUtility.resetFormValidation(form);
            form.getEditor('Code').option('value', salesmanCode);
        }

        form.getEditor('StatusID').option('value', data.StatusID());
    }

    function saveEditing() {
        showLoadingPanel();

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');

        var data = commonPopupEdit.popupEditData();
        var form = commonPopupEdit.form();

        var isValid = form.validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        if (isValid) {
            if (form.itemOption('Organization').visible) {
                data.SiteID(form.getEditor('SiteID').option('value'));
            }

            data.Code(form.getEditor('Code').option('value'));
            data.Name(form.getEditor('Name').option('value'));

            data.WarehouseID(form.getEditor('WarehouseID').option('value'));
            data.GroupID(form.getEditor('GroupID').option('value'));
            data.CategoryID(form.getEditor('CategoryID').option('value'));
            data.Phone(form.getEditor('Phone').option('value'));
            data.SFAFlag(form.getEditor('SFAFlag').option('value'));
            data.SFA(form.getEditor('SFA').option('value'));
            data.StatusID(form.getEditor('StatusID').option('value'));

            var salesmanProducts = [];
            DXUtility.getSelectedTreeViewItems(salesmanProductTreeView().option('items'), salesmanProducts);
            var i = 0;
            while (i < salesmanProducts.length) {
                var item = salesmanProducts[i];
                if (!item.Product) {
                    salesmanProducts.splice(i, 1);
                    continue;
                }

                i++;
            }
        }

        if (isValid) {
            for (i = 0; i < salesmanProducts.length; i++) {
                var item = salesmanProducts[i];
                salesmanProducts[i] = new Dismoyo_Ciptoning_Client.vSalesmanProductViewModel({
                    SalesmanID: data.ID(),
                    ProductID: item.ID
                });
            }

            if (salesmanProducts.length < 1) {
                DevExpress.ui.dialog.alert("Product is required.", 'Error');
                hideLoadingPanel();
                return;
            }
            if (form.getEditor('CategoryID').option('value') == 1) {
                var dataSource_whs = form.getEditor('WarehouseID').option('dataSource').items();
                for (var i = 0; i < dataSource_whs.length; i++) {
                    if (dataSource_whs[i].ID().toString() == form.getEditor('WarehouseID').option('value').toString()) {
                        if (dataSource_whs[i].Warehouse().indexOf("[MAIN]") >= 0) {
                            DevExpress.ui.dialog.alert("Salesman with Category Direct Sales (DSA) can only choose Warehouse with SALESMAN type", 'Error');
                            hideLoadingPanel();
                            return;
                        }
                    }
                }
            }

            data.ChildProducts(salesmanProducts);
            var dataJS = ko.toJS(data);
            dataSource.store().insert(dataJS)
                .done(function (result) {
                    isDataGridRefreshRequired = true;

                    commonPopupEdit.events.performCancel();
                    hideLoadingPanel();
                })
                .fail(function (error) {
                    var dc = $('.dx-popup-normal>.dx-dialog-content');
                    if (dc.length == 0)
                        DevExpress.ui.dialog.alert(error.message, 'Save Failed');

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
                        ['Warehouse']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Salesman',
        colCount: 3,
        colSpan: 3,
        items: [{
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
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },

            }
        }, {
            name: 'Salesman',
            dataField: '',
            label: { text: 'Salesman' },
            editorOptions: {
                placeholder: 'Code/Name',
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }, {
            dataField: 'GroupID',
            label: { text: 'Group' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SalesmanGroup']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }, {
            dataField: 'CategoryID',
            label: { text: 'Category' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SalesmanCategory']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }
        ]
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

        // WarehouseID
        value = form.getEditor('WarehouseID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'WarehouseID', '=', value, 'and');

        // GroupID
        value = form.getEditor('GroupID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'GroupID', '=', (value ? parseInt(value) : value), 'and');

        // CategoryID
        value = form.getEditor('CategoryID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'CategoryID', '=', (value ? parseInt(value) : value), 'and');

        // Salesman
        value = form.getEditor('Salesman').option('value');
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

    commonGridView.dataGridOptions.editing.editEnabled = false;
    commonGridView.dataGridOptions.editing.removeEnabled = false;

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Salesman.AddNewSalesman');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Salesman.EditSalesman');
    commonGridView.dataGridOptions.editing.allowDeleting = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Salesman.DeleteSalesman');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Territory', caption: 'Territory', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Region', caption: 'Region', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Area', caption: 'Area', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Company', caption: 'Company', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Site', caption: 'Site', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Code', Caption: 'Code', width: '120px',
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vSalesmen_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines data-grid-banded-header-border-top">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                if (user.IsHeadOffice()) {
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                }

                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Salesman' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                if (commonGridView.dataGridOptions.editing.allowUpdating || commonGridView.dataGridOptions.editing.allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            var lbl = $('<b>').text(options.data.Code());
            if (commonGridView.dataGridOptions.editing.allowUpdating)
                lbl = $('<a class="dx-link">').text(options.data.Code()).on('dxclick', function () {
                    openSelectedEditing(options.data.ID(), false);
                });

            commands.append(lbl);
            commands.append('&nbsp;');

            container.append(commands);
        }
    }, {
        dataField: 'Name', width: '180px'
    }, {
        dataField: 'Warehouse', caption: 'Warehouse', width: '200px'
    }, {
        dataField: 'GroupName', caption: 'Group', width: '150px'
    }, {
        dataField: 'CategoryName', caption: 'Category', width: '150px'
    }, {
        dataField: 'StatusName', caption: 'Status', width: '100px'
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

    if (commonGridView.dataGridOptions.editing.allowUpdating ||
        commonGridView.dataGridOptions.editing.allowDeleting) {
        commonGridView.dataGridOptions.columns.push({
            width: 100,
            alignment: 'center',
            cellTemplate: function (container, options) {
                var commands = $('<div class="dx-command-edit" style="text-align: center;">');

                if (commonGridView.dataGridOptions.editing.allowUpdating) {
                    commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                        openSelectedEditing(options.data.ID(), false);
                    }));
                    commands.append('&nbsp;');
                }

                if (commonGridView.dataGridOptions.editing.allowDeleting) {
                    commands.append($('<a class="dx-link">').text('Delete').on('dxclick', function () {
                        var dataGrid = commonGridView.dataGrid();
                        var dataSource = dataGrid.option('dataSource');
                        var data = options.data.toJS();
                        var selectedKey = data.ID;

                        dataSource.store().remove(selectedKey).done(function () {
                            dataGrid.refresh();
                        });
                    }));
                    commands.append('&nbsp;');
                }

                container.append(commands);
            }
        });
    }





    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();
    commonPopupEdit.popupEditOptions.title = 'Salesman';

    commonPopupEdit.okOptions.text = 'Save';
    commonPopupEdit.okOptions.icon = 'icons8-save';

    var salesmanProductTreeView = function () { return DXUtility.getDXInstance(null, '#vSalesmen_salesmanProductTreeView', 'dxTreeView'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = $('<div>');

        var table = $('<table width="100%">');
        var tr = $('<tr>');

        tr.append($('<td width="50%" style="vertical-align: top;">')
            .append(DXUtility.createFormItemGroupWithCaption('Products').css('padding', '0px 12px 0px 0px')
            .append(DXUtility.createFormItemGroupContent().css('padding', '16px 12px 0px 0px'))
            .append($('<div id="vSalesmen_salesmanProductTreeView">').dxTreeView({
                dataSource: [],
                dataStructure: 'tree',
                keyExpr: 'key',
                displayExpr: 'text',
                rootValue: null,
                showCheckBoxesMode: 'normal'
            }))));

        tr.append($('<td width="50%" style="vertical-align: top;">'));

        table.append(tr);
        content.append(table);

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
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
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Site',
                         ['Area', 'Region', 'Territory'],
                         ['Warehouse']);
                    updateSiteChildEditor(commonPopupEdit.form(), e.value);
                    if (e.selectedItem) {
                        loadProductTreeview(e.value);
                        commonPopupEdit.form().getEditor('Company').option('value', e.selectedItem.Company());
                        commonPopupEdit.form().getEditor('Code').option('value', previewSalesmanCode(e.selectedItem.Code()));
                    } else if (e.previousValue != null) {
                        commonPopupEdit.form().getEditor('Company').option('value', null);
                    }
                    
                    updateSiteChildEditor(commonPopupEdit.form(), e.value);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Salesman',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'Code',
            validationRules: [{ type: 'required' }],
            label: { text: 'Code' },
            colSpan: 2,
            editorOptions: {                
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'Name',
            validationRules: [{ type: 'required' }],
            label: { text: 'Name' },
            colSpan: 3,
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty'
        }, {
            dataField: 'WarehouseID',
            label: { text: 'Warehouse' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupWarehouseDataSource(
                        (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? ['StatusID', '=', 1] : [['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()], ['StatusID', '=', 1]]
                    ),
                displayExpr: 'Warehouse',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'StatusID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Status' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SalesmanStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty'
        }, {
            dataField: 'GroupID',
            label: { text: 'Group' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SalesmanGroup']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'CategoryID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Category' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SalesmanCategory']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {                    
                    if (e.selectedItem) {
                        var siteCode = null;
                        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                        if (user.IsHeadOffice()) {
                            var selectedSite = commonPopupEdit.form().getEditor('SiteID').option('selectedItem');
                            if (selectedSite)
                                siteCode = selectedSite.Code();
                        } else
                            siteCode = user.SiteCode();

                        commonPopupEdit.form().getEditor('Code').option('value', previewSalesmanCode(siteCode));
                    }
                }
            }
        }, {
            itemType: 'empty',
            colSpan: 2
        }, {
            dataField: 'Phone',
            label: { text: 'Phone' },
            validationRules: [{ type: "numeric" }],
            colSpan: 2,
            editorOptions: {
                maxLength: 20,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 4
        }, {
            dataField: 'SFAFlag',
            label: { text: 'SFA Flag' },
            editorType: 'dxCheckBox',
            editorOptions: {
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    var data = commonPopupEdit.popupEditData();
                    var form = commonPopupEdit.form();
                                        
                    form.itemOption('Salesman.SFA', 'isRequired', e.value);

                    var editorOptions = form.itemOption('Salesman.SFA').editorOptions;
                    editorOptions.readOnly = !e.value;
                    form.itemOption('Salesman.SFA', 'editorOptions', editorOptions);
                }
            }
        }, {
            dataField: 'SFA',
            label: { text: 'SFA Password' },
            editorOptions: {
                mode: 'password',
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }]
    }];

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

        icon: '/Images/salesman_32px.png',

        dataSource_vSalesmanProduct: dataSource_vSalesmanProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit
    };
};
