var vDiscountStratasViewInstance;

Dismoyo_Ciptoning_Client.vDiscountStratas = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevDiscountStratasModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vDiscountStratas');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        vDiscountStratasViewInstance = this;

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vDiscountStratas.off('modified', handlevDiscountStratasModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vDiscountStratas,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vDiscountStratas.on('modified', handlevDiscountStratasModification);



    var dataSource_vDiscountStrataDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vDiscountStrataDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountStrataDetailsViewModel(item); }
    });



    function createDiscountStrataDetailsArrayDataSource(details) {
        return new DevExpress.data.DataSource({
            store: {
                type: 'array',
                key: 'ID',
                data: ko.toJS(details)
            },
            map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountStrataDetailsViewModel(item); }
        });
    }

    function getDiscountStrataDetailsTempID(items) {
        var id = -1;
        for (var i = 0; i < items.length; i++) {
            var existingID = DXUtility.getValue(items[i], 'ID');
            if (existingID <= id)
                id = existingID - 1;
        };

        return id;
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Discount Strata');
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
        form.getEditor('ValidDateFrom').option('value', data.ValidDateFrom());
        form.getEditor('ValidDateTo').option('value', data.ValidDateTo());
        
        form.getEditor('Code').option('readOnly', !newData);

        if (newData) {
            DXUtility.resetFormValidation(form);
        }

        form.getEditor('StatusID').option('value', data.StatusID());

        // Set grid datasource for details
        var detailsDataGrid = discountStrataDetailsDataGrid();
        detailsDataGrid.cancelEditData();
        detailsDataGrid.option('dataSource',
            createDiscountStrataDetailsArrayDataSource(data.ChildDetails()));
    }

    function saveEditing() {
        showLoadingPanel();

        var isValid = commonPopupEdit.form().validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var detailsDataSource = discountStrataDetailsDataGrid().option('dataSource');
        var details = [];
        for (var i = 0; i < detailsDataSource.store()._array.length; i++)
            details.push(new Dismoyo_Ciptoning_Client.vDiscountStrataDetailsViewModel(detailsDataSource.store()._array[i]));

        if (isValid) {
            if (details.length == 0) {
                errorMsg = 'Please specify at least one strata details data.';
                isValid = false;
            }
        }

        if (isValid) {
            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            data.Code(form.getEditor('Code').option('value'));
            data.Name(form.getEditor('Name').option('value'));
            data.ValidDateFrom(form.getEditor('ValidDateFrom').option('value'));
            data.ValidDateTo(form.getEditor('ValidDateTo').option('value'));
            data.StatusID(form.getEditor('StatusID').option('value'));

            data.ChildDetails(details);
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
        name: 'DiscountStrata',
        dataField: '',
        label: { text: 'Discount Strata' },
        editorOptions: {
            placeholder: 'Code/Name',
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
        var dataGrid = vDiscountStratasViewInstance.commonGridView.dataGrid();
        var form = vDiscountStratasViewInstance.collapsibleFilter.form();

        var filterExpr = [];
        var value;

        dataGrid.clearFilter();

        // Product
        value = collapsibleFilter.form().getEditor('DiscountStrata').option('value');
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

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Code', width: '70px',
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            commands.append($('<a class="dx-link">').text(options.data.Code()).on('dxclick', function () {
                Dismoyo_Ciptoning_Client.DB.vDiscountStratas.byKey(
                    options.data.ID(), { expand: ['ChildDetails'] })
                    .done(function (result) {
                        var data = new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel(result);
                        openEditing(data);
                    });
            }));
            commands.append('&nbsp;');

            container.append(commands);
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vDiscountStratas_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Discount Strata' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Validity Period' + '</td>';
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
        dataField: 'ValidDateFrom', caption: 'From', width: '140px',
        dataType: "date"
    }, {
        dataField: 'ValidDateTo', caption: 'To', width: '140px',
        dataType: "date"
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
        width: 100,
        alignment: 'center',
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: center;">');

            commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                Dismoyo_Ciptoning_Client.DB.vDiscountStratas.byKey(
                    options.data.ID(), { expand: ['ChildDetails'] })
                    .done(function (result) {
                        var data = new Dismoyo_Ciptoning_Client.vDiscountStrataViewModel(result);
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

    var discountStrataDetailsDataGrid = function () { return DXUtility.getDXInstance(null, '#vDiscountStratas_discountStrataDetailsDataGrid', 'dxDataGrid'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        var maxRange = 1000;
        var minRange = 0;
        var maxValue = 0;

        content.append(DXUtility.createFormItemLabelTop('Strata Details'));

        content.append($('<div id="vDiscountStratas_discountStrataDetailsDataGrid">').dxDataGrid({
            deferRendering: false,
            dataSource: [],
            showBorders: true,
            paging: { enabled: false },
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            height: '200px',
            editing: {
                editMode: 'row',
                allowAdding: true,
                allowUpdating: true,
                allowDeleting: true,
            },
            onInitNewRow: function (info) {
                var dataSource = info.component.option('dataSource');

                info.data.ID = getDiscountStrataDetailsTempID(dataSource.items());
            },
            onRowValidating: function (e) {
                var removeErrorMessage = function () {
                    $(".dx-error-row").remove();
                }

                removeErrorMessage();

                var showErrorMessage = function (message) {
                    removeErrorMessage();
                    var table = $(".dx-datagrid-table.dx-datagrid-table-fixed", "#vDiscountStratas_discountStrataDetailsDataGrid").first();
                    var trMessage = "<tr class='dx-error-row'><td colspan='" + $("col", $(table).first()).length + "' role='presentation'><div class='dx-closebutton dx-datagrid-action' onclick='javascript: $(this).parent().parent().remove();'></div><div class='dx-error-message'>";
                    trMessage += message;
                    trMessage += "</div></td></tr>";
                    $("tbody", $(table).first()).append(trMessage);
                };

                if (e.brokenRules.length > 0) {
                    showErrorMessage(e.brokenRules[0].message);
                    valid = false;
                    return;
                }

                var discountGrid = discountStrataDetailsDataGrid();
                var items = discountGrid.option("dataSource").items();

                //if (e.oldData == undefined) {
                //    // if insert new row
                //    e.oldData = { ID: function () { return -1; } };
                //}

                var compare2Obj = function (a, b) {
                    if (a === undefined)
                        return false;

                    return a.ID() == b.ID()
                        && a.Maximum() == b.Maximum()
                        && a.Minimum() == b.Minimum()
                        && a.DiscountPercentage() == b.DiscountPercentage();
                }
                var valid = true;
                for (var i in items) {
                    if (!compare2Obj(e.oldData, items[i])) {
                        if ((e.newData.Minimum >= (typeof items[i].Minimum == 'function' ? items[i].Minimum() : items[i].Minimum)
                            && e.newData.Minimum <= (typeof items[i].Maximum == 'function' ? items[i].Maximum() : items[i].Maximum))) {
                            showErrorMessage("Minimum '" + e.newData.Minimum + "' is already in range");
                            valid = false;
                        }
                        if ((e.newData.Maximum >= (typeof items[i].Minimum == 'function' ? items[i].Minimum() : items[i].Minimum)
                            && e.newData.Maximum <= (typeof items[i].Maximum == 'function' ? items[i].Maximum() : items[i].Maximum))) {
                            showErrorMessage("Maximum '" + e.newData.Maximum + "' is already in range");
                            valid = false;
                        }

                        if ((typeof items[i].Minimum == 'function' ? items[i].Minimum() : items[i].Minimum) > e.newData.Minimum
                            && (typeof items[i].Minimum == 'function' ? items[i].Minimum() : items[i].Minimum) < e.newData.Maximum
                            && (typeof items[i].Maximum == 'function' ? items[i].Maximum() : items[i].Maximum) > e.newData.Minimum
                            && (typeof items[i].Maximum == 'function' ? items[i].Maximum() : items[i].Maximum) < e.newData.Maximum) {
                            showErrorMessage("The new data range shouldn't be contain the existing data range");
                            valid = false;
                        }
                    }
                }

                var rIndex = e.component._controllers.editing._editRowIndex;
                var minEdit = e.component._controllers.data._items[rIndex].cells[0].value;
                var maxEdit = e.component._controllers.data._items[rIndex].cells[1].value;

                if (minEdit > maxEdit) {
                    debugger;
                    showErrorMessage("Minimum value must be less than Maximum");
                    valid = false;
                }

                e.isValid = valid;
            },
            //onOptionChanged: function (e) {
            //    var dataGrid = discountStrataDetailsDataGrid();
            //    var rowIndex = e.component._controllers.data._editingController._editRowIndex;

            //    if (e.fullName == "columns[2].validationRules[1].min")
            //        dataGrid.cellValue(rowIndex, "Minimum", e.value);

            //    if (e.fullName == "columns[1].validationRules[1].max")
            //        dataGrid.cellValue(rowIndex, "Maximum", e.value);

            //},
            columns: [{
                dataField: 'ID', visible: false
            }, {
                dataField: 'Minimum', caption: 'Minimum', width: '120px',
                dataType: 'number',
                validationRules: [{ type: 'required' }],
                editorOptions: {
                    onKeyDown: DXUtility.preventInputCharacters
                }
            }, {
                dataField: 'Maximum', caption: 'Maximum', width: '120px',
                dataType: 'number',
                validationRules: [{ type: 'required' }],
                editorOptions: {
                    onKeyDown: DXUtility.preventInputCharacters
                }
            }, {
                dataField: 'DiscountPercentage', caption: 'Percentage (%)', width: '150px',
                dataType: 'number',
                validationRules: [{
                    type: 'required'
                }, {
                    type: "range",
                    min: 0.01,
                    message: "Percentage must be greater than 0."
                }]
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
        caption: 'Discount Strata',
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
            dataField: 'ValidDateFrom',
            label: { text: 'Valid Date From' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (data) {
                    var form = commonPopupEdit.form();

                    form.getEditor('ValidDateTo').option('min', data.value);
                },
                max: undefined
            }
        }, {
            dataField: 'ValidDateTo',
            label: { text: 'To' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (data) {
                    var form = commonPopupEdit.form();

                    form.getEditor('ValidDateFrom').option('max', data.value);
                },
                max: undefined
            }
        }, {
            itemType: 'empty',
            colSpan: 2
        }, {
            dataField: 'StatusID',
            label: { text: 'Status' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemLookups.dataByFilter(['Group', '=', 'DiscountStrataStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 2
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

        icon: 'Images/discount_strata_32px.png',

        dataSource_vDiscountStrataDetails: dataSource_vDiscountStrataDetails,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,

        discountStrataDetailsDataGrid: discountStrataDetailsDataGrid
    };
};
