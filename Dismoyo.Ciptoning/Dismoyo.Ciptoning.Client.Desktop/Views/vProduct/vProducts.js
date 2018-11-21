Dismoyo_Ciptoning_Client.vProducts = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevProductsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vProducts');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vProducts.off('modified', handlevProductsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vProducts,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vProductViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vProducts.on('modified', handlevProductsModification);

    function getValueFromSystemParameter(value) {
        var sysParam = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', value]);
        if (sysParam.length > 0)
            return sysParam[0].Value();

        return null;
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
        dataField: 'BrandID',
        label: { text: 'Brand' },
        editorType: 'dxSelectBox',
        editorOptions: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.dataSource(),
            displayExpr: 'Brand',
            valueExpr: 'ID',
            placeholder: '(All)',
            searchEnabled: true,
            showClearButton: true,
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
        }
    }, {
        name: 'Product',
        dataField: '',
        label: { text: 'Product' },
        editorOptions: {
            placeholder: 'Code/Name',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
        }
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        commonGridView.dataGrid().clearFilter();

        var filterExpr = [];
        var value;

        // BrandID
        value = collapsibleFilter.form().getEditor('BrandID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'BrandID', '=', value, 'and');

        // Product
        value = collapsibleFilter.form().getEditor('Product').option('value');
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'Code', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'Name', 'contains', value, 'or');
        DXUtility.addGroupFilterExpression(filterExpr, groupFilterExpr, 'and');

        if (filterExpr.length > 0)
            commonGridView.dataGrid().filter(filterExpr);
        else
            commonGridView.dataGrid().refresh();
    };





    // ------------------------------------------------------------------------------------------------
    // commonGridView
    // ------------------------------------------------------------------------------------------------
    var commonGridView = new Dismoyo_Ciptoning_Client.CommonGridView();
    commonGridView.dataGridOptions.dataSource = dataSource;
    
    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Products.AddNewProduct');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Products.EditProduct');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Products.DeleteProduct');

    commonGridView.events.rowChanged = function (info) {
        Dismoyo_Ciptoning_Client.LocalStore.vProducts.loadWithSort('Product');
    };

    // commented by asep, if you want to use default value for some field(s), use defaultValue attribute on column item
    //commonGridView.events.initRow = function (info) {
    //    info.Weight = 0;
    //    info.DimensionL = 0;
    //    info.DimensionW = 0;
    //    info.DimensionH = 0;
    //    info.data.StatusID = 1; // Active
    //};

    commonGridView.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow' && e.dataField == 'Code') {
            if (!e.row.inserted) {
                e.allowEditing = false;
                e.editorElement.append($('<td style="padding: 5px;">').text(e.row.data.Code()));
                e.cancel = true;
            }
        }
    };

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'BrandID', caption: 'Brand', width: '200px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.dataSource().store(),
            displayExpr: "Brand",
            valueExpr: "ID",
            allowClearing: true,
            sortOrder: "asc"
        },
        editorOptions: {
            itemTemplate: function (data, index, element) {
                if (typeof data.Brand == "function")
                    data = data.toJS();

                var div = "<p title='" + data.Brand + "'>" + data.Brand + "</p>";
                return div;
            }
        }
    }, {
        dataField: 'Code', width: '70px',
        editorOptions: {
            maxLength: 10
        },
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vProducts_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;

                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Product' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'UOM' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Conversion' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Dimension' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="10">' + 'Additional Info' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                var allowUpdating = user.isAuthorized('Products.EditProduct');
                var allowDeleting = user.isAuthorized('Products.DeleteProduct');
                if (allowUpdating || allowDeleting)
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
        dataField: 'ShortName', caption: 'Short Name', width: '100px',
        editorOptions: {
            maxLength: 30
        },
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'Weight', format: 'fixedPoint', precision: 2, caption: 'Weight (g)', width: '100px',
        defaultValue: 0,
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'UOMLID', caption: 'Large', width: '100px',
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductUOM']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        },
        editorOptions: {
            itemTemplate: function (data, index, element) {
                if (typeof data.Name == "function")
                    data = data.toJS();

                var div = "<p title='" + data.Name + "'>" + data.Name + "</p>";
                return div;
            }
        }
    }, {
        dataField: 'UOMMID', caption: 'Medium', width: '100px',
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductUOM']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        },
        editorOptions: {
            itemTemplate: function (data, index, element) {
                if (typeof data.Name == "function")
                    data = data.toJS();

                var div = "<p title='" + data.Name + "'>" + data.Name + "</p>";
                return div;
            }
        }
    }, {
        dataField: 'UOMSID', caption: 'Small', width: '100px',
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductUOM']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        },
        editorOptions: {
            itemTemplate: function (data, index, element) {
                if (typeof data.Name == "function")
                    data = data.toJS();

                var div = "<p title='" + data.Name + "'>" + data.Name + "</p>";
                return div;
            }
        }
    }, {
        dataField: 'ConversionL', caption: 'Large', width: '70px',
        dataType: 'number'
    }, {
        dataField: 'ConversionM', caption: 'Medium', width: '70px',
        dataType: 'number'
    }, {
        dataField: 'ConversionS', caption: 'Small', width: '70px',
        dataType: 'number'
    }, {
        dataField: 'DimensionL', caption: 'Long', width: '70px',
        defaultValue: 0,
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'DimensionW', caption: 'Width', width: '70px',
        defaultValue: 0,
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'DimensionH', caption: 'Height', width: '70px',
        defaultValue: 0,
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'AdditionalInfo1', caption: getValueFromSystemParameter('Product.AdditionalInfo1'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo2', caption: getValueFromSystemParameter('Product.AdditionalInfo2'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo3', caption: getValueFromSystemParameter('Product.AdditionalInfo3'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo4', caption: getValueFromSystemParameter('Product.AdditionalInfo4'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo5', caption: getValueFromSystemParameter('Product.AdditionalInfo5'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo6', caption: getValueFromSystemParameter('Product.AdditionalInfo6'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo7', caption: getValueFromSystemParameter('Product.AdditionalInfo7'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo8', caption: getValueFromSystemParameter('Product.AdditionalInfo8'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo9', caption: getValueFromSystemParameter('Product.AdditionalInfo9'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'AdditionalInfo10', caption: getValueFromSystemParameter('Product.AdditionalInfo10'), width: '100px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'StatusID', caption: 'Status', width: '100px',
        defaultValue: 1,
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource:  Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductStatus']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
        },
        editorOptions: {
            itemTemplate: function (data, index, element) {
                if (typeof data.Name == "function")
                    data = data.toJS();

                var div = "<p title='" + data.Name + "'>" + data.Name + "</p>";
                return div;
            }
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

        icon: "Images/product_32px.png",

        dataSource_vSystemLookup:  Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductStatus']),
        dataSource_vProductBrand: Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.data,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
