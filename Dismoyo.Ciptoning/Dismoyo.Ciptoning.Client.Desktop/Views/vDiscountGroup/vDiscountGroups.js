var vDiscountGroupsViewInstance;

Dismoyo_Ciptoning_Client.vDiscountGroups = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;

    function handlevDiscountGroupsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vDiscountGroups');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        vDiscountGroupsViewInstance = this;

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vDiscountGroups.off('modified', handlevDiscountGroupsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vDiscountGroups,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vDiscountGroups.on('modified', handlevDiscountGroupsModification);



    var dataSource_vDiscountStrata = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vDiscountStratas,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel(item); }
    });

    var dataSource_vProduct = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vProducts,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vProductViewModel(item); }
    });



    function createDiscountGroupProductsArrayDataSource(products) {
        return new DevExpress.data.DataSource({
            store: {
                type: 'array',
                key: 'ProductID',
                data: ko.toJS(products)
            },
            map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountGroupProductViewModel(item); }
        });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Discount Group');
        commonPopupEdit.popupEditOptions.editingKey = data.ID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);
        
        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);
        
        if (newData) {
            data.StatusID(1);
        }

        // Set editor values
        form.getEditor('Code').option('value', data.Code());
        form.getEditor('Name').option('value', data.Name());
        form.getEditor('Description').option('value', data.Description());
        
        form.getEditor('Code').option('readOnly', !newData);

        if (newData) {
            DXUtility.resetFormValidation(form);
        }

        form.getEditor('StatusID').option('value', data.StatusID());

        // Set grid datasource for products
        var productDataGrid = discountGroupProductDataGrid();
        productDataGrid.cancelEditData();
        productDataGrid.option('dataSource',
            createDiscountGroupProductsArrayDataSource(data.ChildProducts()));
    }

    function saveEditing() {
        showLoadingPanel();

        var isValid = commonPopupEdit.form().validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var productsDataSource = discountGroupProductDataGrid().option('dataSource');
        var products = [];
        for (var i = 0; i < productsDataSource.store()._array.length; i++)
            products.push(new Dismoyo_Ciptoning_Client.vDiscountGroupProductViewModel(productsDataSource.store()._array[i]));

        if (isValid) {
            if (products.length == 0) {
                errorMsg = 'Please specify at least one product discount data.';
                isValid = false;
            }
        }

        if (isValid) {
            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            data.Code(form.getEditor('Code').option('value'));
            data.Name(form.getEditor('Name').option('value'));
            data.Description(form.getEditor('Description').option('value'));
            data.StatusID(form.getEditor('StatusID').option('value'));

            data.ChildProducts(products);
            var dataJS = ko.toJS(data);
            dataSource.store().insert(dataJS)
                .done(function (result) {
                    hideLoadingPanel();

                    commonPopupEdit.popupEditOptions.visible(false);
                    dataGrid.refresh();
                })
                .fail(function (error) {
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
        name: 'DiscountGroup',
        dataField: '',
        label: { text: 'Discount Group' },
        editorOptions: {
            placeholder: 'Code/Name/Description',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); }
        }
    }, {
        dataField: '',
        label: { text: '', visible: false },
        editorOptions: { visible: false }
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        commonGridView.dataGrid().clearFilter();

        var filterExpr = [];
        var value;

        // DiscountGroup
        value = collapsibleFilter.form().getEditor('DiscountGroup').option('value');
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'Code', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'Name', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'Description', 'contains', value, 'or');
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

    commonGridView.dataGridOptions.editing.editEnabled = false;
    commonGridView.dataGridOptions.editing.removeEnabled = false;

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Code', caption: 'Code', width: '70px',
        validationRules: [{ type: 'required' }],
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            commands.append($('<a class="dx-link">').text(options.data.Code()).on('dxclick', function () {
                Dismoyo_Ciptoning_Client.DB.vDiscountGroups.byKey(
                    options.data.ID(), { expand: ['ChildProducts'] })
                    .done(function (result) {
                        var data = new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel(result);
                        openEditing(data);
                    });
            }));
            commands.append('&nbsp;');

            container.append(commands);
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vDiscountGroups_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Discount Group' + '</td>'
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
        dataField: 'Name', caption: 'Name', width: '180px'
    }, {
        dataField: 'Description', caption: 'Description', width: '250px'
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
    }, {
        alignment: 'center',
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: center;">');

            commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                Dismoyo_Ciptoning_Client.DB.vDiscountGroups.byKey(
                    options.data.ID(), { expand: ['ChildProducts'] })
                    .done(function (result) {
                        var data = new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel(result);
                        openEditing(data);
                    });
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

    var discountGroupProductDataGrid = function () { return DXUtility.getDXInstance(null, '#vDiscountGroups_discountGroupProductDataGrid', 'dxDataGrid'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Product Discounts'));

        content.append($('<div id="vDiscountGroups_discountGroupProductDataGrid">').dxDataGrid({
            deferRendering: false,
            dataSource: [],            
            showBorders: true,
            paging: { enabled: false },
            allowColumnResizing: true,
            columnAutoWidth: false,
            hoverStateEnabled: true,
            editing: {
                editMode: 'row',
                allowAdding: true,
                allowUpdating: true,
                allowDeleting: true,
            },
            onEditorPreparing: function (e) {
                if ((e.parentType == 'dataRow') &&
                    ((e.dataField == 'DiscountStrata1ID') ||
                    (e.dataField == 'DiscountStrata2ID') ||
                    (e.dataField == 'DiscountStrata3ID') ||
                    (e.dataField == 'DiscountStrata4ID') ||
                    (e.dataField == 'DiscountStrata5ID'))) {
                    e.editorElement.dxLookup({
                        dataSource: DataUtility.GetLookupDiscountStrataDataSource(null),
                        displayExpr: 'DiscountStrata',
                        valueExpr: 'ID',
                        searchExpr: ['Code', 'Name'],
                        searchPlaceholder: 'Code/Name',
                        popupWidth: '482px',
                        showPopupTitle: false,
                        fieldEditEnabled: true,
                        showClearButton: true,
                        value: e.value,
                        onContentReady: function (e) {
                            var id = 'vDiscountGroups_discountStrataIDLookup';
                            var colHeader = e.element.find('#' + id);
                            if (colHeader.length == 0) {
                                var div = '<div id="' + id + '" class="dx-datagrid datagrid-columnheader">';
                                div += '       <table class="dx-datagrid-headers dx-datagrid-nowrap">';
                                div += '           <colgroup>';
                                div += '               <col style="width: 200px;">';
                                div += '               <col style="width: 140px;">';
                                div += '               <col style="width: 140px;">';
                                div += '           </colgroup><tbody>';
                                div += '           <tr class="dx-row dx-header-row dx-column-lines">';
                                div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
                                div += '' + '</td>';
                                div += '               <td class="dx-datagrid-action" style="text-align: left;" colSpan="2">';
                                div += 'Valid Date' + '</td>';
                                div += '</tr>';

                                div += '           <tr class="dx-row dx-header-row dx-column-lines">';
                                div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
                                div += 'Discount Strata' + '</td>';
                                div += '               <td class="dx-datagrid-action" style="text-align: center; border-top: 1px solid #D3D3D3;">';
                                div += 'From' + '</td>';
                                div += '               <td class="dx-datagrid-action" style="text-align: center; border-top: 1px solid #D3D3D3;">';
                                div += 'To' + '</td>';
                                div += '</tr></tbody></table></div>';

                                var list = e.element.find('.dx-list');
                                list.attr('style', 'top: 59px !important');
                                list.before($(div));
                            }
                        },
                        itemTemplate: function (data, index, element) {
                            var title = '';
                            var div = '<div class="dx-datagrid dx-datagrid-rowsview dx-datagrid-nowrap" style="background-color: inherit;">';
                            div += '       <table class="dx-datagrid-table dx-datagrid-table-fixed" style="border-collapse: initial !important;">';
                            div += '           <colgroup>';
                            div += '               <col style="width: 200px;">';
                            div += '               <col style="width: 140px;">';
                            div += '               <col style="width: 140px;">';
                            div += '           </colgroup><tbody>';
                            div += '           <tr class="dx-row dx-data-row dx-column-lines">';
                            div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.DiscountStrata()) + '"';
                            div += '                   style="text-align: left; border-left-style: none !important;">';
                            div += HtmlUtility.htmlEncode(data.DiscountStrata()) + '</td>';

                            title = HtmlUtility.htmlEncode(DateTimeUtility.convertToLocal(data.ValidDateFrom()).toISOString().substring(0, 10));
                            div += '                <td class="dx-datagrid-action" title="' + title + '" style="text-align: center;">';
                            div += title + '</td>';

                            title = HtmlUtility.htmlEncode(DateTimeUtility.convertToLocal(data.ValidDateTo()).toISOString().substring(0, 10));
                            div += '                <td class="dx-datagrid-action" title="' + title + '" style="text-align: center;">';
                            div += title + '</td>';

                            div += '</tr></tbody></table></div>';

                            element.attr('style', 'padding: 0px');

                            return div;
                        },
                        onValueChanged: function (ea) {
                            e.setValue(ea.value);
                        }
                    });

                    e.cancel = true;
                }

                if ((e.parentType == 'dataRow') && (e.dataField == 'ProductID')) {
                    if (!e.row.inserted) {
                        e.allowEditing = false;
                        e.editorElement.append($('<td style="padding: 5px;">').text(e.row.cells[0].text));
                        e.cancel = true;
                    }
                }
            },
            onDataErrorOccurred: function (e) {
                debugger;
                var rIndex = e.component._controllers.editing._editRowIndex;
                var errorValue = e.component._controllers.data._items[rIndex].cells[1].text;
                if (e.error.__id == "E4008")
                    e.error.message = "Product value '" + errorValue + "' is already exist.";
                //else if (e.error.__id == "E4017")
                //    e.error = null;
            },
            onRowInserted: function (info) {
                $(".dx-error-row").remove();
            },
            columns: [{
                dataField: 'DiscountGroupID', visible: false
            }, {
                dataField: 'ProductID', caption: 'Product', width: '300px',
                validationRules: [{ type: 'required' }],
                lookup: {
                    dataSource: dataSource_vProduct.store(),
                    displayExpr: 'Product',
                    valueExpr: 'ID',
                    allowClearing: true
                },
                headerCellTemplate: function (columnHeader, headerInfo) {
                    var dataGrid = $(vDiscountGroupsViewInstance.discountGroupProductDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + ' ' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colspan="5">' + 'Discount Strata' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                        tr += '</tr>'

                        var table = dataGrid.find('.dx-header-row:first-child');
                        $(tr).insertBefore(table[0].parentElement);
                        $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
                    }
                }
            }, {
                dataField: 'DiscountStrata1ID', caption: '1', width: '200px',
                validationRules: [{ type: 'required' }],
                lookup: {
                    dataSource: DataUtility.vDiscountStratas.dataSource(null),
                    displayExpr: 'DiscountStrata',
                    valueExpr: 'ID',
                    allowClearing: true
                }
            }, {
                dataField: 'DiscountStrata2ID', caption: '2', width: '200px',
                lookup: {
                    dataSource: DataUtility.vDiscountStratas.dataSource(null),
                    displayExpr: 'DiscountStrata',
                    valueExpr: 'ID',
                    allowClearing: true
                }
            }, {
                dataField: 'DiscountStrata3ID', caption: '3', width: '200px',
                lookup: {
                    dataSource: DataUtility.vDiscountStratas.dataSource(null),
                    displayExpr: 'DiscountStrata',
                    valueExpr: 'ID',
                    allowClearing: true
                }
            }, {
                dataField: 'DiscountStrata4ID', caption: '4', width: '200px',
                lookup: {
                    dataSource: DataUtility.vDiscountStratas.dataSource(null),
                    displayExpr: 'DiscountStrata',
                    valueExpr: 'ID',
                    allowClearing: true
                }
            }, {
                dataField: 'DiscountStrata5ID', caption: '5', width: '200px',
                lookup: {
                    dataSource: DataUtility.vDiscountStratas.dataSource(null),
                    displayExpr: 'DiscountStrata',
                    valueExpr: 'ID',
                    allowClearing: true
                }
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

    // ------------------------------------------------------------------------------------------------
    // Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    commonPopupEdit.formOptions.items = [{
        itemType: 'group',
        caption: 'Discount Group',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'Code',
            validationRules: [{ type: 'required' }],
            label: { text: 'Code' },
            colSpan: 2,
            editorOptions: {
                maxLength: 10,
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
            dataField: 'Description',
            validationRules: [{ type: 'required' }],
            label: { text: 'Description' },
            colSpan: 3,
            editorOptions: {
                maxLength: 200,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'StatusID',
            label: { text: 'Status' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.vSystemLookups.dataSource(['Group', '=', 'DiscountGroupStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty'
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

        icon: 'Images/discount_group_32px.png',

        dataSource_vDiscountStrata: dataSource_vDiscountStrata,
        dataSource_vProduct: dataSource_vProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,

        discountGroupProductDataGrid: discountGroupProductDataGrid
    };
};
