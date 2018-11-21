Dismoyo_Ciptoning_Client.vProductPrices = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevProductPricesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vProductPrices');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vProductPrices.off('modified', handlevProductPricesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vProductPrices,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vProductPriceViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vProductPrices.on('modified', handlevProductPricesModification);



    var dataSource_vSystemLookup = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSystemLookups,
        paginate: false,
        map: function (item) {
            return new Dismoyo_Ciptoning_Client.vSystemLookupViewModel(item);
        }
    });

    //var dataSource_vProductBrand = new DevExpress.data.DataSource({
    //    store: Dismoyo_Ciptoning_Client.DB.vProductBrands,
    //    map: function (item) { return new Dismoyo_Ciptoning_Client.vProductBrandViewModel(item); }
    //});

    //var dataSource_vProduct = new DevExpress.data.DataSource({
    //    store: Dismoyo_Ciptoning_Client.DB.vProducts,
    //    map: function (item) { return new Dismoyo_Ciptoning_Client.vProductViewModel(item); }
    //});





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
        dataField: 'ProductBrandID',
        label: { text: 'Brand' },
        editorType: 'dxSelectBox',
        editorOptions: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.dataSource(),
            displayExpr: 'Brand',
            valueExpr: 'ID',
            placeholder: '(All)',
            searchEnabled: true,
            showClearButton: true,
            onEnterKey: function () {
                collapsibleFilter.events.performSearch();
            },
            onValueChanged: function (e) {
                var childEditor = collapsibleFilter.form().getEditor('ProductID');
                var childSelectedItem = childEditor.option('selectedItem');
                if (childSelectedItem && (childSelectedItem['BrandID']() != e.value))
                    childEditor.option('value', null);

                if(e.selectedItem)
                    childEditor.option('dataSource',
                        Dismoyo_Ciptoning_Client.LocalStore.vProducts.dataByFilter(['BrandID', '=', e.value]));
                else {
                    collapsibleFilter.form().getEditor('ProductID').option('dataSource',
                        Dismoyo_Ciptoning_Client.LocalStore.vProducts.dataSource());
                }
            }
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
            onEnterKey: function () {
                collapsibleFilter.events.performSearch();
            },
            onValueChanged: function (e) {
                if (e.selectedItem) {
                    collapsibleFilter.form().getEditor('ProductBrandID').option('value', e.selectedItem.BrandID());
                }else
                    collapsibleFilter.form().getEditor('ProductBrandID').option('value', null);

                e.component.option('value', e.value);
            }
        }
    }, {
        name: 'Code',
        dataField: '',
        label: { text: 'Code' },
        editorOptions: {
            onEnterKey: function () {
                collapsibleFilter.events.performSearch();
            }
        }
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        commonGridView.dataGrid().clearFilter();

        var filterExpr = [];
        var value;

        // ProductBrandID
        value = collapsibleFilter.form().getEditor('ProductBrandID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'ProductBrandID', '=', value, 'and');

        // ProductID
        value = collapsibleFilter.form().getEditor('ProductID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'ProductID', '=', value, 'and');

        // Code
        value = collapsibleFilter.form().getEditor('Code').option('value');
        DXUtility.addFilterExpression(filterExpr, 'Code', 'contains', value, 'and');

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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('ProductPrices.AddNewProductPrice');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('ProductPrices.EditProductPrice');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('ProductPrices.DeleteProductPrice');

    commonGridView.dataGridOptions.onOptionChanged = function (e) {
        var dataGrid = commonGridView.dataGrid();
        var rowIndex = e.component._controllers.data._editingController._editRowIndex;

        if (e.fullName == "columns[5].editorOptions.min")
            dataGrid.cellValue(rowIndex, "ValidDateFrom", e.value);

        //if (e.fullName == "columns[4].editorOptions.max")
        //    dataGrid.cellValue(rowIndex, "ValidDateTo", e.value);

    };
    commonGridView.events.editingStart = function (info) {
        info.component.columnOption("ValidDateTo", "editorOptions", {min: info.data.ValidDateFrom()});
    }

    // commented by asep, if you want to use default value for some field(s), use defaultValue attribute on column item
    //commonGridView.dataGridOptions.onInitNewRow = function (info) {
    //    info.data.StatusID = 1; // Active
    //};

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'ProductBrand', caption: 'Brand', width: '200px', allowEditing: false
    }, {
        dataField: 'ProductID', caption: 'Product', width: '200px', onlyAllowAdd: true,
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource:  Dismoyo_Ciptoning_Client.LocalStore.vProducts.dataSource().store(),
            displayExpr: "Product",
            valueExpr: "ID",
            sortOrder: "asc"
        },
        editorOptions:{
            onValueChanged: function (e) {
                var rowIndex = commonGridView.dataGrid()._controllers.data._editingController._editRowIndex;
                commonGridView.dataGrid().cellValue(rowIndex, "ProductBrand", e.itemData.Brand);
                commonGridView.dataGrid().cellValue(rowIndex, "ProductID", e.value);
            },
            itemTemplate: function (data, index, element) {
                var div = "<p title='" + data.Product + "'>" + data.Product + "</p>";
                return div;
            }
        }
    }, {
        dataField: 'Code', width: '120px', onlyAllowAdd: true,
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 20
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vProductPrices_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;

                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Validity Period' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                var allowUpdating = user.isAuthorized('ProductPrices.EditProductPrice');
                var allowDeleting = user.isAuthorized('ProductPrices.DeleteProductPrice');
                if (allowUpdating || allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }, {
        dataField: 'ValidDateFrom', caption: 'From', width: '140px',
        dataType: "date", validationRules: [{ type: 'required' }],
        editorOptions: {
            onValueChanged: function (data) {
                var dataGrid = commonGridView.dataGrid();
                var rowIndex = dataGrid._controllers.data._editingController._editRowIndex

                var validateto = dataGrid.cellValue(rowIndex, "ValidDateTo");
                if (data.value > validateto) {
                    dataGrid.cellValue(rowIndex, "ValidDateTo", null);
                }

                if (data.value != null)
                    dataGrid.option('columns[5].editorOptions.min', data.value);
                else
                    dataGrid.option('columns[5].editorOptions.min', undefined);
            }
        }
    }, {
        dataField: 'ValidDateTo', caption: 'To', width: '140px',
        dataType: "date", validationRules: [{ type: 'required' }],
        editorOptions: {
            //onValueChanged: function (data) {
            //    var dataGrid = commonGridView.dataGrid();
            //    if (data.value != null)
            //        dataGrid.option('columns[4].editorOptions.max', data.value);
            //    else
            //        dataGrid.option('columns[4].editorOptions.max', undefined);
            //},
            min: undefined
        }
    }, {
        dataField: 'PriceGroupID', caption: 'Group', width: '120px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductPriceGroup']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32'
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
        dataField: 'GrossPrice', caption: 'Gross Price (Rp)', width: '100px',
        dataType: 'number', format: 'fixedPoint', precision: 2, validationRules: [{ type: 'required' }, { type: 'numeric' }],
        editorOptions: {
            onValueChanged: function (data) {
                var dataGrid = commonGridView.dataGrid();
                var rowIndex = dataGrid._controllers.data._editingController._editRowIndex;
                var tax = dataGrid.cellValue(rowIndex, "TaxPercentage");
                var price = data.value + (data.value * tax / 100);
                dataGrid.cellValue(rowIndex, "Price", price.toFixed(2));
                dataGrid.cellValue(rowIndex, "GrossPrice", data.value);
            }
        }
    }, {
        dataField: 'TaxPercentage', caption: 'Tax (%)', width: '70px',
        dataType: 'number', format: 'fixedPoint', precision: 2, validationRules: [{ type: 'required' }, { type: 'numeric' }],
        editorOptions: {
            onValueChanged: function (data) {
                //var dataGrid = commonGridView.dataGrid();
                //var rowIndex = dataGrid._controllers.data._editingController._editRowIndex;
                //var grossPrice = dataGrid.cellValue(rowIndex, "GrossPrice");
                //if (grossPrice) {
                //    var percentage = (data.value * grossPrice) / 100;
                //    dataGrid.cellValue(rowIndex, "Price", grossPrice + percentage);
                //}

                //dataGrid.cellValue(rowIndex, "TaxPercentage", data.value);
            },
            readOnly: true
        },
        defaultValue: 10
    }, {
        dataField: 'Price', caption: 'Price (Rp)', width: '100px',
        dataType: 'number', format: 'fixedPoint', precision: 2, validationRules: [{ type: 'required' }, { type: 'numeric' }],
        editorOptions: {
            onValueChanged: function (data) {
                var dataGrid = commonGridView.dataGrid();
                var rowIndex = dataGrid._controllers.data._editingController._editRowIndex;
                var tax = dataGrid.cellValue(rowIndex, "TaxPercentage");
                var grossPrice = data.value / ((tax + 100) / 100);

                dataGrid.cellValue(rowIndex, "GrossPrice", grossPrice.toFixed(2));
                dataGrid.cellValue(rowIndex, "Price", data.value);
            }
        }
    }, {
        dataField: 'StatusID', caption: 'Status', width: '80px',
        validationRules: [{ type: 'required' }],
        defaultValue: 1, // added by Asep
        lookup: {
            dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'ProductPriceStatus']),
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

        icon: "Images/product_price_32px.png",

        dataSource_vSystemLookup: dataSource_vSystemLookup,
        dataSource_vProductBrand: Dismoyo_Ciptoning_Client.LocalStore.vProductBrands.data,
        dataSource_vProduct: Dismoyo_Ciptoning_Client.LocalStore.vProducts.data,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
