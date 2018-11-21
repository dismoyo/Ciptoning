Dismoyo_Ciptoning_Client.vCustomerCategories = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var parentID = -1;

    function handlevCustomerCategoriesModification() { shouldReload = true; }

    function checkContainer() {
        if ($('#vCustomerCategories_commonGridView').is(':visible')) {
            $('#vCustomerCategories_viewContent').layout({
                name: 'vCustomerCategoriesViewContent',
                north: {
                    paneSelector: '#vCustomerCategories_viewContentHeader',
                    resizable: false,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                center: {
                    paneSelector: '#vCustomerCategories_viewSubContent',
                    onresize: $.layout.callbacks.resizeTabLayout,
                    children: {
                        //north: {
                        //    paneSelector: '#vCustomerCategories_collapsibleFilter',
                        //    resizable: false,
                        //    spacing_open: 0,
                        //    spacing_closed: 0
                        //},
                        west: {
                            paneSelector: '#vCustomerCategories_commonTreeView',
                            width: '300px'
                        },
                        center: {
                            paneSelector: '#vCustomerCategories_commonGridView'
                        }
                    }
                }
            });

            refreshTreeView();
        }
        else
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        dataSource.filter(['ParentID', '=', parentID]);

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        } else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vCustomerCategories.off('modified', handlevCustomerCategoriesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vCustomerCategories,        
        map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerCategoryViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vCustomerCategories.on('modified', handlevCustomerCategoriesModification);



    var dataSource_vCustomerCategory = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vCustomerCategories,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerCategoryViewModel(item); }
    });

    function refreshTreeView() {
        commonTreeView.showLoadingPanel();

        commonTreeView.treeView().option('dataSource', null);
        dataSource_vCustomerCategory.load()
            .done(function (result) {
                commonTreeView.treeView().option('dataSource', dataSource_vCustomerCategory);
                commonTreeView.hideLoadingPanel();
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load data.'), 'Load Failed');
                commonTreeView.hideLoadingPanel();
            });
    }





    // ------------------------------------------------------------------------------------------------
    // collapsibleFilter
    // ------------------------------------------------------------------------------------------------
    var collapsibleFilter = new Dismoyo_Ciptoning_Client.CollapsibleFilter();

    // ------------------------------------------------------------------------------------------------
    // Filter Items: Specify items of the filter here.
    // ------------------------------------------------------------------------------------------------    
    collapsibleFilter.formOptions.items = [{
        name: 'Category',
        dataField: '',
        label: { text: 'Category' },
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
        var dataGrid = commonGridView.dataGrid();
        var form = collapsibleFilter.form();

        var filterExpr = [];
        var value;

        dataGrid.clearFilter();

        // CustomerCategory
        value = collapsibleFilter.form().getEditor('Category').option('value');
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
    // commonTreeView
    // ------------------------------------------------------------------------------------------------
    var commonTreeView = new Dismoyo_Ciptoning_Client.CommonTreeView();
    commonTreeView.treeViewOptions.dataStructure = 'plain';
    commonTreeView.treeViewOptions.keyExpr = 'ID';
    commonTreeView.treeViewOptions.parentIdExpr = 'ParentID';
    commonTreeView.treeViewOptions.displayExpr = 'Name';
    
    commonTreeView.loadingPanelOptions.position = { of: '#vCustomerCategories_commonTreeView' };

    commonTreeView.treeViewOptions.itemTemplate = function (itemData, itemIndex, itemElement) {
        return '<div/><img src="Images/file_32px.png" class="dx-icon"><b>' +
            HtmlUtility.htmlEncode(DXUtility.getValue(itemData, 'Group')) + ':</b> ' +
            HtmlUtility.htmlEncode(DXUtility.getValue(itemData, 'Name')) + '</div>';
    };

    
    
    // ------------------------------------------------------------------------------------------------
    // Event handler when tree view item is clicked.
    // ------------------------------------------------------------------------------------------------
    commonTreeView.events.itemClick = function (e) {
        parentID = DXUtility.getValue(e.itemData, 'ID');
        commonGridView.newRow().option('disabled',
            !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('CustomerCategories.AddNewCustomerCategory'));

        var dataGrid = commonGridView.dataGrid();

        dataGrid.clearFilter();
        dataGrid.filter(['ParentID', '=', parentID]);
    };





    // ------------------------------------------------------------------------------------------------
    // commonGridView
    // ------------------------------------------------------------------------------------------------
    var commonGridView = new Dismoyo_Ciptoning_Client.CommonGridView();
    commonGridView.dataGridOptions.dataSource = dataSource;

    commonGridView.newRowOptions.disabled = true;
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('CustomerCategories.EditCustomerCategory');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('CustomerCategories.DeleteCustomerCategory');

    commonGridView.dataGridOptions.onInitNewRow = function (info) {
        info.data.ParentID = parentID;
    };

    commonGridView.dataGridOptions.onEditorPreparing = function (info) {
        if (info.parentType == 'data') {
            if (info.row && info.row.inserted) {
                switch (info.dataField) {
                    case 'ParentID':
                        info.editorOptions.value = parentID;
                        break;
                }
            }
        }
    };

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Code', caption: 'Code', width: '70px',
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vCustomerCategories_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Category' + '</td>';
                //tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                if (commonGridView.dataGridOptions.editing.allowUpdating ||
                    commonGridView.dataGridOptions.editing.allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>'

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        }
    }, {
        dataField: 'Name', width: '180px',
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'ParentID', width: '70px', visible: false
    }, {
        dataField: 'Group', width: '140px',
        validationRules: [{ type: 'required' }]
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
    // Event handler when grid view row is added/updated/removed.
    // ------------------------------------------------------------------------------------------------
    commonGridView.events.rowInserted = function (info) {
        refreshTreeView();
    };

    commonGridView.events.rowUpdated = function (info) {
        refreshTreeView();
    };

    commonGridView.events.rowRemoved = function (info) {
        refreshTreeView();
    };

    commonGridView.events.rowsRemoved = function () {
        refreshTreeView();
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

        icon: 'Images/territory_32px.png',

        commonTreeView: commonTreeView,
        
        commonGridView: commonGridView
    };
};
