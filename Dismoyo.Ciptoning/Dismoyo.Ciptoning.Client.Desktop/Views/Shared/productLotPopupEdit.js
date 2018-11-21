
Dismoyo_Ciptoning_Client.ProductLotPopupEdit = function () {
    var intrvl;

    var events = {
        performSave: function () {
            popupEditOptions.visible(false);
        },
        performCancel: function () {
            popupEditOptions.visible(false);
        },
        performNewRow: function () {
            dataGrid().addRow();

            save().option("disabled", true);
            intrvl = setInterval(intrvlHandler, 500);
        },
        performEditingStart: function () {
            if (save()) {
                save().option("disabled", true);
                intrvl = setInterval(intrvlHandler, 500);
            }
        },
        performDeleteRows: function (dataGrid, selectedRows) {
            var dataSource = dataGrid.option('dataSource');
            var selectedKeys = dataGrid.getSelectedRowKeys();

            for (var i = 0; i < selectedKeys.length; i++) {
                dataSource.store().remove(selectedKeys[i])
                    .done(function (result) {
                        if (i >= (selectedKeys.length - 1))
                            dataSource.load().done(function (result) { dataGrid.refresh(); });
                    })
                    .fail(function (error) {
                        if (i >= (selectedKeys.length - 1))
                            dataSource.load().done(function (result) { dataGrid.refresh(); });
                    });
            }
        }
    };

    var isEditorEnabled = function () {
        var dxCommandEdit = $(".dx-command-edit", "#productLotPopupEdit_dataGrid");
        for (var i=0; i < dxCommandEdit.length; i++) {
            if ($(dxCommandEdit[i]).text().trim().indexOf("Save") >= 0) {
                return true;
            }
        }
        return false;
    }

    var intrvlHandler = function () {
        if (!isEditorEnabled()) {
            if (save())
                save().option("disabled", false);
        }
    };

    var newRow = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_newRow', 'dxButton'); }
    
    var newRowOptions = {
        text: 'New', icon: 'add',
        onClick: function () {
            events.performNewRow();
        }
    };

    var deleteRows = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_deleteRows', 'dxButton'); }
    
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
        
    var dataGrid = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_dataGrid', 'dxDataGrid'); }

    var dataGridOptions = {
        showBorders: true,
        paging: { enabled: false },
        allowColumnResizing: false,
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
        onSelectionChanged: function (e) {
            deleteRows().option('disabled', !e.selectedRowsData.length);
        },
        onEditorPrepared: function (e) {
            events.performEditingStart();
        }
    };
    
    var popupEdit = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_popupEdit', 'dxPopup'); }

    var popupEditOptions = {
        editingKey: null,
        itemStatusID: null,
        showTitle: true,
        width: 700,
        title: 'Edit Lot Number',
        visible: ko.observable(false)
    };

    var popupContent = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_popupContent', 'dxScrollView'); }

    var popupContentOptions = {
        scrollByContent: true,
        scrollByThumb: true
    };

    var form = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_form', 'dxForm'); }

    var formOptions = {
        colCount: 3,
        showColonAfterLabel: false,
        labelLocation: 'left',
        onEnterKey: function () { events.performSearch(); }
    };

    var save = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_save', 'dxButton'); }

    var saveOptions = {
        text: 'Save', type: 'apply',
        onClick: function () { events.performSave(); }
    };

    var cancel = function () { return DXUtility.getDXInstance(null, '#productLotPopupEdit_cancel', 'dxButton'); }

    var cancelOptions = {
        text: 'Cancel',
        onClick: function () { events.performCancel(); }
    };

    return {
        events: events,

        popupEdit: popupEdit,
        popupEditOptions: popupEditOptions,

        popupEditData: ko.observable(),

        popupContent: popupContent,
        popupContentOptions: popupContentOptions,

        form: form,
        formOptions: formOptions,

        save: save,
        saveOptions: saveOptions,

        cancel: cancel,
        cancelOptions: cancelOptions,

        newRow: newRow,
        newRowOptions: newRowOptions,

        deleteRows: deleteRows,
        deleteRowsOptions: deleteRowsOptions,

        dataGrid: dataGrid,
        dataGridOptions: dataGridOptions
    };
};
