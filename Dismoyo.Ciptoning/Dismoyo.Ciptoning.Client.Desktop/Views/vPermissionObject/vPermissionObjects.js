Dismoyo_Ciptoning_Client.vPermissionObjects = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isUserRolePermissionsDataGridRefreshRequired;

    function handlevPermissionObjectsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vPermissionObjects');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vPermissionObjects.off('modified', handlevPermissionObjectsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vPermissionObjects,
        select: [
            'ID',
            'Description',
            'CreatedDate',
            'CreatedByUserName',
            'ChildUserRolePermissions.PermissionObjectID',
            'ChildUserRolePermissions.UserRoleID',
            'ChildUserRolePermissions.IsUser'
        ],
        expand: 'ChildUserRolePermissions',
        map: function (item) { return new Dismoyo_Ciptoning_Client.vPermissionObjectViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vPermissionObjects.on('modified', handlevPermissionObjectsModification);

    var dataSource_vUserRolePermission = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vUserRolePermissions,
        select: [
            'PermissionObjectID',
            'UserRoleID',
            'IsUser',
            'UserRoleName',
            'IsUserHeadOffice',
            'UserTerritory',
            'UserRegion',
            'UserArea',
            'UserCompany',
            'UserSite'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vUserRolePermissionViewModel(item); }
    });

    var dataSource_vUserRoleAll = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vUserRoleAlls,
        select: [
            'UserRoleID',
            'IsUser',
            'UserRoleName',
            'IsUserHeadOffice',
            'UserTerritory',
            'UserRegion',
            'UserArea',
            'UserCompany',
            'UserSite'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vUserRoleAllViewModel(item); }
    });

    var selectedPermissionObjectID;

    function userRoleCellTemplate(container, options) {
        var icon = 'dx-icon dx-icon-icons8-role';
        var title = 'Group';
        if (options.data.IsUser()) {
            icon = 'dx-icon dx-icon-icons8-user';
            title = 'User';
        }

        container.append($('<span class="' + icon + '" title="' + title + '" style="width: 16px; height: 16px; background-size: contain;">&nbsp;</span>'));
    };



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
        name: 'PermissionObject',
        dataField: '',
        label: { text: 'Permission' },
        editorOptions: {
            placeholder: 'Name/Description',
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
        var dataGrid = commonGridView.dataGrid();
        var form = collapsibleFilter.form();

        var filterExpr = [];
        var value;

        dataGrid.clearFilter();

        // Permission
        value = form.getEditor('PermissionObject').option('value');
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'ID', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'Description', 'contains', value, 'or');
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

    commonGridView.newRowOptions.visible = false;
    commonGridView.deleteRowsOptions.visible = false;

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', caption: 'Permission Name', width: '180px',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vPermissionObjects_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '</tr>'

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }, {
        dataField: 'Description', caption: 'Description', width: '250px',
    }, {
        dataField: 'UserRoleCount', caption: 'Groups/Users', width: '100px', allowEditing: false,
        alignment: 'center',
        calculateCellValue: function (e) {
            return (e.ChildUserRolePermissions) ? e.ChildUserRolePermissions().length : 0;
        },
        cellTemplate: function (container, options) {
            container.append($('<a>').addClass('dx-link').text(options.value)
                .on('dxclick', function () {
                    dataGridEvents.performShowUsers(options);
                })
            );
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
    }];



    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    var userRolePermissionsPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_userRolePermissionsPopupEdit_dataGrid', 'dxDataGrid'); };
    var userRolePermissionsPopupEditNew = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_userRolePermissionsPopupEdit_new', 'dxButton'); };
    var userRolePermissionsPopupEditDelete = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_userRolePermissionsPopupEdit_delete', 'dxButton'); };

    commonPopupEdit.popupEditOptions.title = 'Permission Groups/Users';

    commonPopupEdit.okOptions.visible = false;
    commonPopupEdit.cancelOptions.text = 'Close';
    commonPopupEdit.cancelOptions.onClick = function () { userRolePermissionsPopupEditEvents.performCancel(); };

    commonPopupEdit.popupEditOptions.onHiding = function (options) {
        if (isDataGridRefreshRequired) {
            commonGridView.dataGrid().refresh();
            isDataGridRefreshRequired = false;
        }
    }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append($('<div id="vPermissionObjects_userRolePermissionsPopupEdit_new" style="margin: 7px 4px 7px 0;">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () { userRolePermissionsPopupEditEvents.performNewRow(); }
        }));

        content.append($('<div id="vPermissionObjects_userRolePermissionsPopupEdit_delete" style="margin: 7px 0 7px 0;">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                userRolePermissionsPopupEditEvents.performDeleteRows();
            }
        }));

        content.append($('<div id="vPermissionObjects_userRolePermissionsPopupEdit_dataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            paging: {
            },
            pager: {
                showPageSizeSelector: true,
                allowedPageSizes: [5, 10, 20],
                showInfo: true,
                showNavigationButtons: true
            },
            selection: {
                mode: 'multiple'
            },
            editing: {
                editMode: 'row',
                allowUpdating: false,
                allowDeleting: true,

                editEnabled: false,
                removeEnabled: true
            },
            onSelectionChanged: function (info) {
                userRolePermissionsPopupEditDelete().option('disabled', (info.selectedRowsData.length <= 0));
            },
            onRowRemoved: function (info) {
                isDataGridRefreshRequired = true;
            },
            columns: [{
                dataField: 'PermissionObjectID', visible: false
            }, {
                dataField: 'UserRoleID', visible: false
            }, {
                dataField: 'IsUser', caption: 'Type', width: '60px',
                cellTemplate: userRoleCellTemplate
            }, {
                dataField: 'UserRoleName', caption: 'Name', width: '300px'
            }, {
                dataField: 'IsUserHeadOffice', caption: 'Head Office', width: '100px', dataType: 'boolean'
            }, {
                dataField: 'UserTerritory', caption: 'Territory', width: '200px'
            }, {
                dataField: 'UserRegion', caption: 'Region', width: '200px'
            }, {
                dataField: 'UserArea', caption: 'Area', width: '200px'
            }, {
                dataField: 'UserCompany', caption: 'Company', width: '200px'
            }, {
                dataField: 'UserSite', caption: 'Site', width: '200px'
            }]
        }));

        extContent.append(content);
    };

    // ------------------------------------------------------------------------------------------------
    // Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    commonPopupEdit.formOptions.items = [{
        itemType: 'group',
        colCount: 5,
        colSpan: 3,
        items: [{
            dataField: 'PermissionObjectID',
            label: { text: 'Permission Name' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: Dismoyo_Ciptoning_Client.DB.vPermissionObjects,
                displayExpr: 'ID',
                valueExpr: 'ID',
                readOnly: true
            }
        }, {
            dataField: 'PermissionObjectDescription',
            label: { text: 'Description' },
            colSpan: 3,
            editorOptions: {
                readOnly: true
            }
        }]
    }];





    // ------------------------------------------------------------------------------------------------
    // New User Role Popup Edit
    // ------------------------------------------------------------------------------------------------
    var newUserRolePopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    newUserRolePopupEdit.popupEdit = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit', 'dxPopup'); }
    newUserRolePopupEdit.popupContent = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit_popupContent', 'dxScrollView'); }
    newUserRolePopupEdit.form = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit_form', 'dxForm'); }
    newUserRolePopupEdit.extContent = function () { return $('#vPermissionObjects_newUserRolePopupEdit_extContent'); }
    newUserRolePopupEdit.ok = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit_ok', 'dxButton'); }
    newUserRolePopupEdit.cancel = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit_cancel', 'dxButton'); }

    var newUserRolePopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vPermissionObjects_newUserRolePopupEdit_dataGrid', 'dxDataGrid'); };

    newUserRolePopupEdit.popupEditOptions.title = 'New Permission Groups/Users';

    newUserRolePopupEdit.popupEditOptions.fullScreen = false;
    newUserRolePopupEdit.popupEditOptions.width = 1200;
    newUserRolePopupEdit.popupEditOptions.height = 600;

    newUserRolePopupEdit.okOptions.disabled = true;
    newUserRolePopupEdit.okOptions.text = 'Save';
    newUserRolePopupEdit.okOptions.onClick = function () { newUserRolePopupEditEvents.performSave(); };
    newUserRolePopupEdit.cancelOptions.onClick = function () { newUserRolePopupEditEvents.performCancel(); };

    newUserRolePopupEdit.popupEditOptions.onHiding = function (options) {
        if (isUserRolePermissionsDataGridRefreshRequired) {
            userRolePermissionsPopupEditDataGrid().refresh();
            isUserRolePermissionsDataGridRefreshRequired = false;
            isDataGridRefreshRequired = true;
        }
    }

    newUserRolePopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#vPermissionObjects_newUserRolePopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop(''));

        content.append($('<div id="vPermissionObjects_newUserRolePopupEdit_dataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            paging: {
            },
            pager: {
                showPageSizeSelector: true,
                allowedPageSizes: [5, 10, 20],
                showInfo: true,
                showNavigationButtons: true
            },
            selection: {
                mode: 'multiple'
            },
            onSelectionChanged: function (e) {
                newUserRolePopupEdit.ok().option('disabled', (e.selectedRowsData.length <= 0));
            },
            columns: [{
                dataField: 'UserRoleID', visible: false
            }, {
                dataField: 'IsUser', caption: 'Type', width: '60px',
                cellTemplate: userRoleCellTemplate
            }, {
                dataField: 'UserRoleName', caption: 'Name', width: '300px'
            }, {
                dataField: 'IsUserHeadOffice', caption: 'Head Office', width: '100px', dataType: 'boolean'
            }, {
                dataField: 'UserTerritory', caption: 'Territory', width: '200px'
            }, {
                dataField: 'UserRegion', caption: 'Region', width: '200px'
            }, {
                dataField: 'UserArea', caption: 'Area', width: '200px'
            }, {
                dataField: 'UserCompany', caption: 'Company', width: '200px'
            }, {
                dataField: 'UserSite', caption: 'Site', width: '200px'
            }]
        }));

        extContent.append(content);
    };
        
    // ------------------------------------------------------------------------------------------------
    // New User Role Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    newUserRolePopupEdit.formOptions.items = [{
        dataField: 'Search',
        label: { visible: false },
        colSpan: 3,
        editorOptions: {
            placeholder: 'Group/User Name/Territory/Region/Area/Company/Site',
            mode: 'search',
            onEnterKey: function () { newUserRolePopupEditEvents.performSearch(); }
        }
    }];





    var dataGridEvents = {
        performShowUsers: function (options) {
            commonPopupEdit.popupEditData(options.data);
            commonPopupEdit.popupEditOptions.visible(true);
            commonPopupEdit.popupContent().scrollTo(0);

            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            selectedPermissionObjectID = data.ID();

            form.getEditor('PermissionObjectID').option('value', selectedPermissionObjectID);
            form.getEditor('PermissionObjectDescription').option('value', data.Description());

            var filter = ['PermissionObjectID', '=', selectedPermissionObjectID];

            var userRolePermissionsDataGrid = userRolePermissionsPopupEditDataGrid();

            userRolePermissionsDataGrid.option('dataSource', []);
            userRolePermissionsDataGrid.pageIndex(0);
            userRolePermissionsDataGrid.refresh().done(function (result) {
                userRolePermissionsDataGrid.option('dataSource', dataSource_vUserRolePermission);
                userRolePermissionsDataGrid.filter(filter);
            });
        }
    };

    var userRolePermissionsPopupEditEvents = {
        performNewRow: function () {
            newUserRolePopupEdit.popupEditOptions.visible(true);
            newUserRolePopupEdit.popupContent().scrollTo(0);

            newUserRolePopupEdit.form().getEditor('Search').option('value', null);
            newUserRolePopupEditEvents.performSearch();
        },
        performDeleteRows: function () {
            DevExpress.ui.dialog.confirm(
                'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                    if (dialogResult) {
                        DXUtility.deleteSelectedRows(userRolePermissionsPopupEditDataGrid(), commonGridView);
                        isDataGridRefreshRequired = true;
                    }
                });
        },
        performCancel: function () {
            commonPopupEdit.popupEditOptions.visible(false);
        }
    };

    var newUserRolePopupEditEvents = {
        performSave: function () {
            var selectedData = newUserRolePopupEditDataGrid().getSelectedRowsData();
            for (var i = 0; i < selectedData.length; i++) {
                var data = new Dismoyo_Ciptoning_Client.vUserRolePermissionViewModel();

                data.PermissionObjectID(selectedPermissionObjectID);
                data.UserRoleID(DXUtility.getValue(selectedData[i], 'UserRoleID'));
                data.IsUser(DXUtility.getValue(selectedData[i], 'IsUser'));

                dataSource_vUserRolePermission.store().insert(data.toJS()).done(function (result) {
                    isDataGridRefreshRequired = true;
                    isUserRolePermissionsDataGridRefreshRequired = true;

                    newUserRolePopupEditEvents.performCancel();
                });
            }
        },
        performCancel: function () {
            newUserRolePopupEdit.popupEditOptions.visible(false);
        },
        performSearch: function () {
            var newUserRoleForm = newUserRolePopupEdit.form();

            var searchValue = newUserRoleForm.getEditor('Search').option('value');
            if (searchValue == undefined)
                searchValue = null;

            var filter = null;

            if (searchValue != null) {
                filter = [
                    ['UserRoleName', 'contains', searchValue], 'or',
                    ['UserTerritory', 'contains', searchValue], 'or',
                    ['UserRegion', 'contains', searchValue], 'or',
                    ['UserArea', 'contains', searchValue], 'or',
                    ['UserCompany', 'contains', searchValue], 'or',
                    ['UserSite', 'contains', searchValue]
                ];
            }

            var newUserRoleDataGrid = newUserRolePopupEditDataGrid();

            newUserRoleDataGrid.option('dataSource', []);
            newUserRoleDataGrid.pageIndex(0);
            newUserRoleDataGrid.refresh().done(function (result) {
                newUserRoleDataGrid.option('dataSource', dataSource_vUserRoleAll);
                newUserRoleDataGrid.filter(filter);
            });
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

        icon: 'Images/permission_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        newUserRolePopupEdit: newUserRolePopupEdit
    };
};
