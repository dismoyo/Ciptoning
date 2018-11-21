
Dismoyo_Ciptoning_Client.CommonGridView = function () {
    var events = {
        performNewRow: function (rootView) {
            dataGrid().addRow();
        },
        performDeleteRows: function (dataGrid, selectedRows) {
            var dataSource = dataGrid.option('dataSource');
            var selectedKeys = dataGrid.getSelectedRowKeys();

            if (selectedKeys.length > 0)
                dataGrid.beginCustomLoading();

            var x = 0;
            for (var i = 0; i < selectedKeys.length; i++) {
                dataSource.store().remove(selectedKeys[i])
                    .done(function (result) {
                        x++;
                        if (x >= (selectedKeys.length - 1)) {
                            dataSource.load()
                                .done(function (result2) {
                                    dataGrid.clearSelection();
                                    dataGrid.endCustomLoading();
                                    dataGrid.refresh();
                                    events.rowsRemoved();
                                })
                                .fail(function (error2) {
                                    dataGrid.endCustomLoading();
                                });
                        }
                    })
                    .fail(function (error) {
                        var dc = $('.dx-popup-normal>.dx-dialog-content');
                        if (dc.length == 0)
                            DevExpress.ui.dialog.alert(error.message, 'Delete Failed');

                        x++;
                        if (x >= (selectedKeys.length - 1)) {
                            dataSource.load()
                                .done(function (result2) {
                                    dataGrid.clearSelection();
                                    dataGrid.endCustomLoading();
                                    dataGrid.refresh();
                                    events.rowsRemoved();
                                })
                                .fail(function (error2) {
                                    dataGrid.endCustomLoading();
                                });
                        }
                    });
            }
        },
        rowInserted: function (info) { },
        rowUpdated: function (info) { },
        rowRemoved: function (info) { },
        rowsRemoved: function () { },
        rowChanged: function (info) { },
        initRow: function (info) { },
        editingStart: function (info) { },
        selectionChanged: function (e) { },
        rowValidation: function (e) { }
    };

    var commands = function () { return $('#commonGridView_commands') }

    var newRow = function () { return DXUtility.getDXInstance(null, '#commonGridView_newRow', 'dxButton'); }

    var newRowOptions = {
        text: 'New', icon: 'add',
        onClick: function () {
            events.performNewRow(this);
        }
    };

    var deleteRows = function () { return DXUtility.getDXInstance(null, '#commonGridView_deleteRows', 'dxButton'); }

    var deleteRowsOptions = {
        text: 'Delete', icon: 'remove', disabled: true,
        onClick: function () {
            DevExpress.ui.dialog.confirm(
                'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                    if (dialogResult) {
                        var _dataGrid = dataGrid();
                        events.performDeleteRows(_dataGrid, _dataGrid.getSelectedRowsData());
                    }
                });
        }
    };

    var hideErrorMessage = function () {
        $(".dx-error-row").remove();
    }

    var showErrorMessage = function (message) {
        hideErrorMessage();
        var table = $(".dx-datagrid-table.dx-datagrid-table-fixed", "#commonGridView_dataGrid").first();
        var trMessage = "<tr class='dx-error-row'><td colspan='" + $("col", $(table).first()).length + "' role='presentation'><div class='dx-closebutton dx-datagrid-action' onclick='javascript: $(this).parent().parent().remove();'></div><div class='dx-error-message'>";
        trMessage += message;
        trMessage += "</div></td></tr>";
        $("tbody", $(table).first()).append(trMessage);
    };

    var isItRequired = function (e, dataField) {
        var validationRules = e.component.columnOption(dataField, "validationRules");
        //Add by Kevin 26/04/16
        // add check value if is null
        var value = e.component.columnOption(dataField, "value");
        for (var i in validationRules) {
            if (validationRules[i].type == "required" && value != null) {
                return true;
            }
        }
        return false;
    }


    var dataGrid = function () { return DXUtility.getDXInstance(null, '#commonGridView_dataGrid', 'dxDataGrid'); }

    var dataGridOptions = {
        height: '100%',
        paging: {
        },
        pager: {
            showPageSizeSelector: true,
            allowedPageSizes: [5, 10, 20],
            showInfo: true,
            showNavigationButtons: true
        },
        allowColumnResizing: true,
        columnAutoWidth: false,
        hoverStateEnabled: true,
        selection: {
            mode: 'multiple'
        },
        editing: {
            editMode: 'row',
            
            allowUpdating: true,
            allowDeleting: true,

            editEnabled: true,
            removeEnabled: true
        },
        onRowInserted: function (info) {
            events.rowInserted(info);
            events.rowChanged(info);

            // Added by Rika 26/4/16
            hideErrorMessage();
        },
        onRowUpdated: function (info) {
            events.rowUpdated(info);
            events.rowChanged(info);

            // Added by Rika 26/4/16
            hideErrorMessage();
        },
        onRowRemoved: function (info) {
            events.rowRemoved(info);
            events.rowChanged(info);

            // Added by Rika 26/4/16
            hideErrorMessage();
        },
        onCellClick: function (e) {
            hideErrorMessage();
        },
        onSelectionChanged: function (e) {
            var editing = e.component.option('editing');

            deleteRows().option('disabled', !(editing.allowDeleting && (e.selectedRowsData.length > 0)));
            events.selectionChanged(e);

            // Added by Rika 26/4/16
            hideErrorMessage();
        },
        onEditingStart: function (e) {
            events.editingStart(e);
            // Added by Asep 22/4/16
            var columns = e.component.option('columns');
            for (var i in columns) {
                if (e.component.columnOption(columns[i].dataField, "onlyAllowAdd"))
                    e.component.columnOption(columns[i].dataField, "allowEditing", false);

                if (columns[i].dataField == "Code")
                    e.component.columnOption(columns[i].dataField, "allowEditing", false);

                //if (columns[i].dataField == "StatusID" && e.model.name != "vSalesmen")
                //    e.data[columns[i].dataField] = 1;

                if (e.component.columnOption(columns[i].dataField, "dataType") == "number") {
                    var validationRules = e.component.columnOption(columns[i].dataField, "validationRules");
                    if (!validationRules) {
                        validationRules = [];
                    }

                    var format = e.component.columnOption(columns[i].dataField, "format");
                    if (format == "fixedPoint")
                        validationRules.push({ type: 'pattern', pattern: '^[0-9]+(\.[0-9][0-9]?)?', message: columns[i].caption + ' must be positive number' });
                    else
                        validationRules.push({ type: 'pattern', pattern: '^[0-9]+$', message: columns[i].caption + ' must be positive number' });

                    e.component.columnOption(columns[i].dataField, "validationRules", validationRules);
                }
            }
            e.component.repaint();
        },
        onInitNewRow: function (e) {
            events.initRow(e);
            // Added by Asep 22/4/16
            var columns = e.component.option("columns");
            for (var i in columns) {
                if (e.component.columnOption(columns[i].dataField, "onlyAllowAdd"))
                    e.component.columnOption(columns[i].dataField, "allowEditing", true);

                if (columns[i].dataField == "Code")
                    e.component.columnOption(columns[i].dataField, "allowEditing", true);

                //if (columns[i].dataField == "StatusID")
                //    e.data[columns[i].dataField] = 1;

                if (e.component.columnOption(columns[i].dataField, "dataType") == "number") {
                    var validationRules = e.component.columnOption(columns[i].dataField, "validationRules");
                    if (!validationRules) {
                        validationRules = [];
                    }

                    var format = e.component.columnOption(columns[i].dataField, "format");
                    if (format == "fixedPoint")
                        validationRules.push({ type: 'pattern', pattern: '^[0-9]+(\.[0-9][0-9]?)?', message: columns[i].caption + ' must be positive number' });
                    else
                        validationRules.push({ type: 'pattern', pattern: '^[0-9]+$', message: columns[i].caption + ' must be positive number' });

                    e.component.columnOption(columns[i].dataField, "validationRules", validationRules);
                }

                if (e.component.columnOption(columns[i].dataField, "defaultValue") !== undefined) {
                    e.data[columns[i].dataField] = e.component.columnOption(columns[i].dataField, "defaultValue");
                }
            }
            e.component.repaint();
        },
        onRowValidating: function (e) {
            hideErrorMessage();
            // Added by Asep 22/4/16
            var columns = e.component.option("columns");
            var errorDataField = "";
            var errorCaption = "";
            // mandatory
            for (var i in columns) {
                if (isItRequired(e, columns[i].dataField) && !e.newData[columns[i].dataField]) {
                    errorDataField = columns[i].dataField;
                    errorCaption = columns[i].caption;
                    showErrorMessage((errorCaption? errorCaption: errorDataField) + " is required");
                    e.isValid = false;
                    break;
                }
            }
            // numeric validation
            for (var i in columns) {
                if (e.component.columnOption(columns[i].dataField, "dataType") == "number") {
                    if (e.newData[columns[i].dataField] < 0) {
                        errorDataField = columns[i].dataField;
                        errorCaption = columns[i].caption;
                        showErrorMessage((errorCaption ? errorCaption : errorDataField) + " must be positive value");
                        e.isValid = false;
                        break;
                    }
                }
            }

            events.rowValidation(e);
        },
        onDataErrorOccurred: function (e) {
            setTimeout(function () { hideErrorMessage(); }, 5000);
        }
    };

    $("#cancelRow").dxButton({
        onClick: function (e) {
            hideErrorMessage();
        }
    });

    return {
        events: events,

        commands: commands,

        newRow: newRow,
        newRowOptions: newRowOptions,

        deleteRows: deleteRows,
        deleteRowsOptions: deleteRowsOptions,

        dataGrid: dataGrid,
        dataGridOptions: dataGridOptions
    };
};
