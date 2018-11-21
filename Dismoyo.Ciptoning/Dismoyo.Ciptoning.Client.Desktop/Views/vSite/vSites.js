Dismoyo_Ciptoning_Client.vSites = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;

    function handlevSitesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vSites');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vSites.off('modified', handlevSitesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSites,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSiteViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vSites.on('modified', handlevSitesModification);



    function createSiteProductArrayDataSource(productBrands) {
        var siteProducts = ko.toJS(productBrands);
        for (var i = 0; i < siteProducts.length; i++) {
            var item = siteProducts[i];
            item.key = item.ID;
            item.text = item.Brand;
            item.items = item.ChildProducts;
            for (var j = 0; j < item.items.length; j++) {
                var subItem = item.items[j];
                subItem.key = item.ID + '_' + subItem.ID;
                subItem.text = subItem.Product;
            }
        }

        return siteProducts;
    }

    function createSOWarehouseArrayDataSource(warehouses) {
        var soWarehouses = ko.toJS(warehouses);
        for (var i = 0; i < soWarehouses.length; i++) {
            var item = soWarehouses[i];
            item.key = item.ID;
            item.text = item.Warehouse;
            item.selected = item.IsSOAllowed;
        }

        return soWarehouses;
    }

    function getValueFromSystemParameter(value) {
        var sysParam = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', value]);
        if (sysParam.length > 0)
            return sysParam[0].Value();

        return null;
    }


    function openSelectedEditing(id, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vSites.byKey(id, { expand: ['ChildProducts', 'ChildWarehouses'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vSiteViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vSiteViewModel();
            data.StatusID(1);
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Site');
        commonPopupEdit.popupEditOptions.editingKey = data.ID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);

        var soWarehouses = [];
        var siteProducts = [];

        if (newData) {
            data.StatusID(1);

            data.IsLotNumberEntryRequired(false);
        } else {
            soWarehouses = createSOWarehouseArrayDataSource(data.ChildWarehouses());

            for (var i = 0; i < data.ChildProducts().length; i++) {
                var item = data.ChildProducts()[i];
                item.key = item.ProductBrandID() + '_' + item.ProductID();
                siteProducts.push(item);
            }
        }

        // Set editor values
        form.getEditor('TerritoryID').option('value', data.TerritoryID());
        form.getEditor('RegionID').option('value', data.RegionID());
        form.getEditor('AreaID').option('value', data.AreaID());
        form.getEditor('CompanyID').option('value', data.CompanyID());
        form.getEditor('SAPCode').option('value', data.SAPCode());
        form.getEditor('Code').option('value', data.Code());
        form.getEditor('Name').option('value', data.Name());
        form.getEditor('DistributionTypeID').option('value', data.DistributionTypeID());
        
        form.getEditor('Address1').option('value', data.Address1());
        form.getEditor('Address2').option('value', data.Address2());
        form.getEditor('Address3').option('value', data.Address3());
        form.getEditor('City').option('value', data.City());
        form.getEditor('StateProvince').option('value', data.StateProvince());
        form.getEditor('CountryID').option('value', data.CountryID());
        form.getEditor('ZipCode').option('value', data.ZipCode());
        form.getEditor('Phone1').option('value', data.Phone1());
        form.getEditor('Phone2').option('value', data.Phone2());
        form.getEditor('Fax').option('value', data.Fax());
        form.getEditor('Email').option('value', data.Email());
        form.getEditor('AdditionalInfo1').option('value', data.AdditionalInfo1());
        form.getEditor('AdditionalInfo2').option('value', data.AdditionalInfo2());
        form.getEditor('AdditionalInfo3').option('value', data.AdditionalInfo3());
        form.getEditor('AdditionalInfo4').option('value', data.AdditionalInfo4());
        form.getEditor('AdditionalInfo5').option('value', data.AdditionalInfo5());
        form.getEditor('AdditionalInfo6').option('value', data.AdditionalInfo6());
        form.getEditor('AdditionalInfo7').option('value', data.AdditionalInfo7());
        form.getEditor('AdditionalInfo8').option('value', data.AdditionalInfo8());
        form.getEditor('AdditionalInfo9').option('value', data.AdditionalInfo9());
        form.getEditor('AdditionalInfo10').option('value', data.AdditionalInfo10());
        
        form.getEditor('Code').option('readOnly', !newData);
        
        if (newData) {
            DXUtility.resetFormValidation(form);
        }

        form.getEditor('StatusID').option('value', data.StatusID());
        form.getEditor('IsLotNumberEntryRequired').option('value', data.IsLotNumberEntryRequired());

        soWarehouseTreeView().option('dataSource', soWarehouses);

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
            map: function (item) { return new Dismoyo_Ciptoning_Client.vProductBrandViewModel(item); }
        }).load()
            .done(function (result) {
                var siteProductDataSource = createSiteProductArrayDataSource(result);
                
                DXUtility.setSelectedTreeViewItems(siteProductDataSource, siteProducts);
                siteProductTreeView().option('dataSource', siteProductDataSource);
            });
    }

    function saveEditing() {
        showLoadingPanel();

        var isValid = commonPopupEdit.form().validate().isValid;
        
        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');

        if (isValid) {
            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            data.TerritoryID(form.getEditor('TerritoryID').option('value'));
            data.RegionID(form.getEditor('RegionID').option('value'));
            data.AreaID(form.getEditor('AreaID').option('value'));
            data.CompanyID(form.getEditor('CompanyID').option('value'));
            data.SAPCode(form.getEditor('SAPCode').option('value'));
            data.Code(form.getEditor('Code').option('value'));
            data.Name(form.getEditor('Name').option('value'));
            data.DistributionTypeID(form.getEditor('DistributionTypeID').option('value'));
            data.StatusID(form.getEditor('StatusID').option('value'));
            data.Address1(form.getEditor('Address1').option('value'));
            data.Address2(form.getEditor('Address2').option('value'));
            data.Address3(form.getEditor('Address3').option('value'));
            data.City(form.getEditor('City').option('value'));
            data.StateProvince(form.getEditor('StateProvince').option('value'));
            data.CountryID(form.getEditor('CountryID').option('value'));
            data.ZipCode(form.getEditor('ZipCode').option('value'));
            data.Phone1(form.getEditor('Phone1').option('value'));
            data.Phone2(form.getEditor('Phone2').option('value'));
            data.Fax(form.getEditor('Fax').option('value'));
            data.Email(form.getEditor('Email').option('value'));
            data.IsLotNumberEntryRequired(form.getEditor('IsLotNumberEntryRequired').option('value'));
            data.AdditionalInfo1(form.getEditor('AdditionalInfo1').option('value'));
            data.AdditionalInfo2(form.getEditor('AdditionalInfo2').option('value'));
            data.AdditionalInfo3(form.getEditor('AdditionalInfo3').option('value'));
            data.AdditionalInfo4(form.getEditor('AdditionalInfo4').option('value'));
            data.AdditionalInfo5(form.getEditor('AdditionalInfo5').option('value'));
            data.AdditionalInfo6(form.getEditor('AdditionalInfo6').option('value'));
            data.AdditionalInfo7(form.getEditor('AdditionalInfo7').option('value'));
            data.AdditionalInfo8(form.getEditor('AdditionalInfo8').option('value'));
            data.AdditionalInfo9(form.getEditor('AdditionalInfo9').option('value'));
            data.AdditionalInfo10(form.getEditor('AdditionalInfo10').option('value'));

            var siteProducts = [];
            DXUtility.getSelectedTreeViewItems(siteProductTreeView().option('items'), siteProducts);
            var i = 0;
            while (i < siteProducts.length) {
                var item = siteProducts[i];
                if (!item.Product) {
                    siteProducts.splice(i, 1);
                    continue;
                }

                i++;
            }

            for (i = 0; i < siteProducts.length; i++) {
                var item = siteProducts[i];
                siteProducts[i] = new Dismoyo_Ciptoning_Client.vSiteProductViewModel({
                    SiteID: data.ID(),
                    ProductID: item.ID
                });
            }

            var soWarehouses = soWarehouseTreeView().option('items');
            for (i = 0; i < soWarehouses.length; i++) {
                var item = soWarehouses[i];
                soWarehouses[i] = new Dismoyo_Ciptoning_Client.vWarehouseViewModel(item);
            }

            data.ChildProducts(siteProducts);
            data.ChildWarehouses(soWarehouses);
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
                    ['Company']);
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
        name: 'Site',
        dataField: '',        
        label: { text: 'Site' },
        editorOptions: {
            placeholder: 'Code/Name',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
        }
    }, {
        dataField: 'DistributionTypeID',
        label: { text: 'Distribution Type' },
        editorType: 'dxSelectBox',
        editorOptions: {
            dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SiteDistributionType']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            placeholder: '(All)',
            searchEnabled: true,
            showClearButton: true,
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

        // AreaID
        value = form.getEditor('AreaID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'AreaID', '=', value, 'and');

        // CompanyID
        value = form.getEditor('CompanyID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'CompanyID', '=', value, 'and');

        // DistributionTypeID
        value = form.getEditor('DistributionTypeID').option('value');
        if (!isNaN(value) && value !== null)
            DXUtility.addFilterExpression(filterExpr, 'DistributionTypeID', '=', parseInt(value), 'and');

        // Site
        value = form.getEditor('Site').option('value');
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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Sites.AddNewSite');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Sites.EditSite');
    commonGridView.dataGridOptions.editing.allowDeleting = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Sites.DeleteSite');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Territory', caption: "Territory", width: '200px'
    }, {
        dataField: 'Region', caption: 'Region', width: '200px'
    }, {
        dataField: 'Area', caption: 'Area', width: '200px'
    }, {
        dataField: 'Company', caption: 'Company', width: '200px'
    }, {
        dataField: 'Code', Caption: 'Code', width: '70px',
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vSites_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines data-grid-banded-header-border-top">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Site' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
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
        dataField: 'DistributionTypeName', caption: 'Distribution Type', width: '150px'
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
    commonPopupEdit.popupEditOptions.title = "Site";

    commonPopupEdit.okOptions.text = 'Save';
    commonPopupEdit.okOptions.icon = 'icons8-save';

    var siteProductTreeView = function () { return DXUtility.getDXInstance(null, '#vSites_siteProductTreeView', 'dxTreeView'); }
    var soWarehouseTreeView = function () { return DXUtility.getDXInstance(null, '#vSites_soWarehouseTreeView', 'dxTreeView'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = $('<div>');

        var table = $('<table width="100%">');
        var tr = $('<tr>');

        tr.append($('<td width="50%" style="vertical-align: top;">')
            .append(DXUtility.createFormItemGroupWithCaption('Products').css('padding', '0px 12px 0px 0px')
            .append(DXUtility.createFormItemGroupContent().css('padding', '16px 12px 0px 0px'))
            .append($('<div id="vSites_siteProductTreeView">').dxTreeView({
                dataSource: [],
                dataStructure: 'tree',
                keyExpr: 'key',
                displayExpr: 'text',
                rootValue: null,
                showCheckBoxesMode: 'normal'
            }))));

        tr.append($('<td width="50%" style="vertical-align: top;">')
            .append(DXUtility.createFormItemGroupWithCaption('SO Allowed Warehouses').css('padding', '0px 0px 0px 12px')
            .append(DXUtility.createFormItemGroupContent().css('padding', '16px 0px 0px 12px'))
            .append($('<div id="vSites_soWarehouseTreeView">').dxTreeView({
                dataSource: [],
                dataStructure: 'tree',
                keyExpr: 'key',
                displayExpr: 'text',
                rootValue: null,
                showCheckBoxesMode: 'normal',
                onItemSelected: function (e) {
                    e.node.itemData.IsSOAllowed = e.node.selected;
                }
            }))));

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
                        ['Company']);
                }
            }
        }, {
            dataField: 'CompanyID',
            label: { text: 'Company' },
            colSpan: 3,
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCompanyDataSource(null),
                displayExpr: 'Company',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
            }
        }, {
            itemType: 'empty',
            colSpan: 2,
        }]
    }, {
        itemType: 'group',
        caption: 'Site',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'Code',
            validationRules: [{ type: 'required' }],
            label: { text: 'Code' },
            editorOptions: {
                maxLength: 5,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'Name',
            validationRules: [{ type: 'required' }],
            label: { text: 'Name' },
            colSpan: 2,
            editorOptions: {
                width: '500px',
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }                
            }
        }, {
            dataField: 'DistributionTypeID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Distribution Type' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SiteDistributionType']),
                displayExpr: "Name",
                valueExpr: "Value_Int32",
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'StatusID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Status' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'SiteStatus']),
                displayExpr: "Name",
                valueExpr: "Value_Int32",
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'Address1',
            validationRules: [{ type: 'required' }],
            label: { text: 'Address' },
            colSpan: 2,
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'Address2',
            label: { text: ' ' },
            colSpan: 2,
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'Address3',
            label: { text: ' ' },
            colSpan: 2,
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'City',
            validationRules: [{ type: 'required' }],
            label: { text: 'City' },
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'StateProvince',
            validationRules: [{ type: 'required' }],
            label: { text: 'Province' },
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'CountryID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Country' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCountryDataSource(null),
                displayExpr: "Name",
                valueExpr: "ID",
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'ZipCode',
            validationRules: [{ type: 'required' }, { type: 'numeric' }],
            label: { text: 'Zip code' },
            editorOptions: {
                maxLength: 10,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'Phone1',
            validationRules: [{ type: 'required' }, { type: 'numeric' }],
            label: { text: 'Phone 1' },
            editorOptions: {
                maxLength: 20,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'Phone2',
            validationRules: [{ type: 'numeric' }],
            label: { text: 'Phone 2' },
            editorOptions: {
                maxLength: 20,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'Fax',
            validationRules: [{ type: 'numeric' }],
            label: { text: 'Fax' },
            editorOptions: {
                maxLength: 20,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'Email',
            validationRules: [{ type: 'email' }],
            label: { text: 'Email' },
            editorOptions: {
                maxLength: 256,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'SAPCode',
            validationRules: [{ type: 'required' }],
            label: { text: 'SAP Code' },
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 2
        }, {
            dataField: 'IsLotNumberEntryRequired',
            editorType: 'dxCheckBox'
        }]
    }, {
        itemType: 'group',
        caption: 'Additional Info',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'AdditionalInfo1',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo1') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AdditionalInfo2',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo2') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'AdditionalInfo3',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo3') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AdditionalInfo4',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo4') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'AdditionalInfo5',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo5') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AdditionalInfo6',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo6') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'AdditionalInfo7',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo7') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AdditionalInfo8',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo8') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
        }, {
            dataField: 'AdditionalInfo9',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo9') },
            editorOptions: {
                maxLength: 100,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AdditionalInfo10',
            label: { text: getValueFromSystemParameter('Site.AdditionalInfo10') },
            editorOptions: {
                maxLength: 100,
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

        icon: "/Images/site_32px.png",

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit
    };
};
