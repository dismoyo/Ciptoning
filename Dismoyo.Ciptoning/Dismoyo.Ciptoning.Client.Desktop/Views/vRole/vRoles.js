Dismoyo_Ciptoning_Client.vRoles = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isUserRolesDataGridRefreshRequired;

    function handlevRolesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vRoles');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vRoles.off('modified', handlevRolesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vRoles,
        select: [
            'ID',
            'Name',
            'Description',
            'CreatedDate',
            'CreatedByUserName',
            'ModifiedDate',
            'ModifiedByUserName',
            'ChildUserRoles.RoleID',
            'ChildUserRoles.UserID'
        ],
        expand: 'ChildUserRoles',
        map: function (item) { return new Dismoyo_Ciptoning_Client.vRoleViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vRoles.on('modified', handlevRolesModification);

    var dataSource_vUserRole = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vUserRoles,
        select: [
            'RoleID',
            'UserID',
            'UserName',
            'IsUserHeadOffice',
            'UserTerritory',
            'UserRegion',
            'UserArea',
            'UserCompany',
            'UserSite'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vUserRoleViewModel(item); }
    });

    var dataSource_vUser = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vUsers,
        select:[
            'ID',
            'Name',
            'IsHeadOffice',
            'Territory',
            'Region',
            'Area',
            'Company',
            'Site'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vUserViewModel(item); }
    });

    var selectedRoleID;



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
        name: 'Role',
        dataField: '',
        label: { text: 'Group' },
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

        // Group
        value = form.getEditor('Role').option('value');
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'Name', 'contains', value, 'or');
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

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Name', caption: 'Group Name', width: '180px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 256
        },
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vRoles_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
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
        dataField: 'Description', caption: 'Description', width: '250px',
        editorOptions: {
            maxLength: 512
        },
    }, {
        dataField: 'UserCount', caption: 'Users', width: '60px', allowEditing: false,
        alignment: 'center',
        calculateCellValue: function (e) {
            return (e.ChildUserRoles) ? e.ChildUserRoles().length : 0;
        },
        cellTemplate: function (container, options) {
            if (!options.row.inserted) {
                container.append($('<a>').addClass('dx-link').text(options.value)
                    .on('dxclick', function () {
                        dataGridEvents.performShowUsers(options);
                    })
                );
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



    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    var userRolesPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vRoles_userRolesPopupEdit_dataGrid', 'dxDataGrid'); };
    var userRolesPopupEditNew = function () { return DXUtility.getDXInstance(null, '#vRoles_userRolesPopupEdit_new', 'dxButton'); };
    var userRolesPopupEditDelete = function () { return DXUtility.getDXInstance(null, '#vRoles_userRolesPopupEdit_delete', 'dxButton'); };

    commonPopupEdit.popupEditOptions.title = 'Group Users';

    commonPopupEdit.okOptions.visible = false;
    commonPopupEdit.cancelOptions.text = 'Close';
    commonPopupEdit.cancelOptions.onClick = function () { userRolesPopupEditEvents.performCancel(); };

    commonPopupEdit.popupEditOptions.onHiding = function (options) {
        if (isDataGridRefreshRequired) {
            commonGridView.dataGrid().refresh();
            isDataGridRefreshRequired = false;
        }
    }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append($('<div id="vRoles_userRolesPopupEdit_new" style="margin: 7px 4px 7px 0;">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () { userRolesPopupEditEvents.performNewRow(); }
        }));

        content.append($('<div id="vRoles_userRolesPopupEdit_delete" style="margin: 7px 0 7px 0;">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                userRolesPopupEditEvents.performDeleteRows();
            }
        }));

        content.append($('<div id="vRoles_userRolesPopupEdit_dataGrid">').dxDataGrid({
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
                userRolesPopupEditDelete().option('disabled', (info.selectedRowsData.length <= 0));
            },
            onRowRemoved: function (info) {
                isDataGridRefreshRequired = true;
            },
            columns: [{
                dataField: 'RoleID', visible: false
            }, {
                dataField: 'UserID', visible: false
            }, {
                dataField: 'UserName', caption: 'User Name', width: '300px'
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
            dataField: 'RoleID',
            label: { text: 'Group Name' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: Dismoyo_Ciptoning_Client.DB.vRoles,
                displayExpr: 'Name',
                valueExpr: 'ID',
                readOnly: true
            }
        }, {
            dataField: 'RoleDescription',
            label: { text: 'Description' },
            colSpan: 3,
            editorOptions: {
                readOnly: true
            }
        }]
    }];

    



    // ------------------------------------------------------------------------------------------------
    // New User Popup Edit
    // ------------------------------------------------------------------------------------------------
    var newUserPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    newUserPopupEdit.popupEdit = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit', 'dxPopup'); }
    newUserPopupEdit.popupContent = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit_popupContent', 'dxScrollView'); }
    newUserPopupEdit.form = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit_form', 'dxForm'); }
    newUserPopupEdit.extContent = function () { return $('#vRoles_newUserPopupEdit_extContent'); }
    newUserPopupEdit.ok = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit_ok', 'dxButton'); }
    newUserPopupEdit.cancel = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit_cancel', 'dxButton'); }

    var newUserPopupEditDataGrid = function () { return DXUtility.getDXInstance(null, '#vRoles_newUserPopupEdit_dataGrid', 'dxDataGrid'); };

    newUserPopupEdit.popupEditOptions.title = 'New Group Users';

    newUserPopupEdit.popupEditOptions.fullScreen = false;
    newUserPopupEdit.popupEditOptions.width = 1200;
    newUserPopupEdit.popupEditOptions.height = 600;

    newUserPopupEdit.okOptions.disabled = true;
    newUserPopupEdit.okOptions.text = 'Save';
    newUserPopupEdit.okOptions.onClick = function () { newUserPopupEditEvents.performSave(); };
    newUserPopupEdit.cancelOptions.onClick = function () { newUserPopupEditEvents.performCancel(); };

    newUserPopupEdit.popupEditOptions.onHiding = function (options) {
        if (isUserRolesDataGridRefreshRequired) {
            userRolesPopupEditDataGrid().refresh();
            isUserRolesDataGridRefreshRequired = false;
            isDataGridRefreshRequired = true;
        }
    }

    newUserPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#vRoles_newUserPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop(''));

        content.append($('<div id="vRoles_newUserPopupEdit_dataGrid">').dxDataGrid({
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
                newUserPopupEdit.ok().option('disabled', (e.selectedRowsData.length <= 0));
            },
            columns: [{
                dataField: 'ID', visible: false
            }, {
                dataField: 'Name', caption: 'User Name', width: '300px'
            }, {
                dataField: 'IsHeadOffice', caption: 'Head Office', width: '100px', dataType: 'boolean'
            }, {
                dataField: 'Territory', caption: 'Territory', width: '200px'
            }, {
                dataField: 'Region', caption: 'Region', width: '200px'
            }, {
                dataField: 'Area', caption: 'Area', width: '200px'
            }, {
                dataField: 'Company', caption: 'Company', width: '200px'
            }, {
                dataField: 'Site', caption: 'Site', width: '200px'
            }]
        }));

        extContent.append(content);
    };

    // ------------------------------------------------------------------------------------------------
    // New User Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    newUserPopupEdit.formOptions.items = [{
        dataField: 'Search',
        label: { visible: false },
        colSpan: 3,
        editorOptions: {
            placeholder: 'User Name/Territory/Region/Area/Company/Site',
            mode: 'search',
            onEnterKey: function () { newUserPopupEditEvents.performSearch(); }
        }
    }];





    var dataGridEvents = {
        performShowUsers: function (options) {
            commonPopupEdit.popupEditData(options.data);
            commonPopupEdit.popupEditOptions.visible(true);
            commonPopupEdit.popupContent().scrollTo(0);

            var data = commonPopupEdit.popupEditData();
            var form = commonPopupEdit.form();

            selectedRoleID = data.ID();

            form.getEditor('RoleID').option('value', selectedRoleID);
            form.getEditor('RoleDescription').option('value', data.Description());

            var filter = ['RoleID', '=', selectedRoleID];

            var userRolesDataGrid = userRolesPopupEditDataGrid();

            userRolesDataGrid.option('dataSource', []);
            userRolesDataGrid.pageIndex(0);
            userRolesDataGrid.refresh().done(function (result) {
                userRolesDataGrid.option('dataSource', dataSource_vUserRole);
                userRolesDataGrid.filter(filter);
            });
        }
    };

    var userRolesPopupEditEvents = {
        performNewRow: function () {
            newUserPopupEdit.popupEditOptions.visible(true);
            newUserPopupEdit.popupContent().scrollTo(0);

            newUserPopupEdit.form().getEditor('Search').option('value', null);
            newUserPopupEditEvents.performSearch();
        },
        performDeleteRows: function () {
            DevExpress.ui.dialog.confirm(
                'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                    if (dialogResult) {
                        DXUtility.deleteSelectedRows(userRolesPopupEditDataGrid(), commonGridView);
                        isDataGridRefreshRequired = true;
                    }
                });
        },
        performCancel: function () {
            commonPopupEdit.popupEditOptions.visible(false);
        }
    };

    var newUserPopupEditEvents = {
        performSave: function () {
            var selectedData = newUserPopupEditDataGrid().getSelectedRowsData();
            for (var i = 0; i < selectedData.length; i++) {
                var data = new Dismoyo_Ciptoning_Client.vUserRoleViewModel();

                data.RoleID(selectedRoleID);
                data.UserID(DXUtility.getValue(selectedData[i], 'ID'));

                dataSource_vUserRole.store().insert(data.toJS()).done(function (result) {
                    isDataGridRefreshRequired = true;
                    isUserRolesDataGridRefreshRequired = true;

                    newUserPopupEditEvents.performCancel();
                });
            }
        },
        performCancel: function () {
            newUserPopupEdit.popupEditOptions.visible(false);
        },
        performSearch: function () {
            var newUserForm = newUserPopupEdit.form();

            var searchValue = newUserForm.getEditor('Search').option('value');
            if (searchValue == undefined)
                searchValue = null;

            var filter = null;

            if (searchValue != null) {
                filter = [
                    ['Name', 'contains', searchValue], 'or',
                    ['Territory', 'contains', searchValue], 'or',
                    ['Region', 'contains', searchValue], 'or',
                    ['Area', 'contains', searchValue], 'or',
                    ['Company', 'contains', searchValue], 'or',
                    ['Site', 'contains', searchValue]
                ];
            }

            var newUserDataGrid = newUserPopupEditDataGrid();

            newUserDataGrid.option('dataSource', []);
            newUserDataGrid.pageIndex(0);
            newUserDataGrid.refresh().done(function (result) {
                newUserDataGrid.option('dataSource', dataSource_vUser);
                newUserDataGrid.filter(filter);
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

        icon: 'Images/role_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        newUserPopupEdit: newUserPopupEdit
    };
};
