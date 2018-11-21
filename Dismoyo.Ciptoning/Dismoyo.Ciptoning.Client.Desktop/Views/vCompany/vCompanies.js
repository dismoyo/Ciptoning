Dismoyo_Ciptoning_Client.vCompanies = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;

    function handlevCompaniesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vCompanies');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vCompanies.off('modified', handlevCompaniesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vCompanies,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vCompanyViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vCompanies.on('modified', handlevCompaniesModification);



    

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
        name: 'Company',
        dataField: '',
        label: { text: 'Company' },
        editorOptions: {
            placeholder: 'Code/Name',
            onEnterKey: function () { collapsibleFilter.events.performSearch(); },
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

        // Company
        value = collapsibleFilter.form().getEditor('Company').option('value');
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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Companies.AddNewCompany');
    commonGridView.dataGridOptions.editing.editEnabled = commonGridView.dataGridOptions.editing.allowUpdating =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Companies.EditCompany');
    commonGridView.dataGridOptions.editing.removeEnabled = commonGridView.dataGridOptions.editing.allowDeleting =
        Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Companies.DeleteCompany');

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
        dataField: 'Code', width: '70px',
        validationRules: [{ type: 'required' }],
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vCompanies_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Company' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Address' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                if (commonGridView.dataGridOptions.editing.allowUpdating ||
                    commonGridView.dataGridOptions.editing.allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        editorOptions: {
            maxLength: 10
        }
    }, {
        dataField: 'Name', width: '180px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 50
        }
    }, {
        dataField: 'Address1', caption: '', width: '150px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'Address2', caption: '', width: '150px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'Address3', caption: '', width: '150px',
        editorOptions: {
            maxLength: 100
        }
    }, {
        dataField: 'City', width: '120px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 50
        }
    }, {
        dataField: 'StateProvince', caption: 'State/Province', width: '120px',
        validationRules: [{ type: 'required' }],
        editorOptions: {
            maxLength: 50
        }
    }, {
        dataField: 'CountryID', caption: 'Country', width: '120px',
        validationRules: [{ type: 'required' }],
        lookup: {
            dataSource: DataUtility.vCountries.dataSource(null),
            displayExpr: "Name",
            valueExpr: "ID",
            allowClearing: true,
            sortOrder: "asc"
        }
    }, {
        dataField: 'ZipCode', caption: 'Zip Code', width: '70px',
        validationRules: [{ type: 'required' }, { type: "numeric" }],
        editorOptions: {
            maxLength: 10
        }
    }, {
        dataField: 'TaxNumber', caption: 'Tax Number', width: '180px',
        validationRules: [{ type: 'required' }, { type: "numeric" }],
        editorOptions: {
            maxLength: 20
        }
    }, {
        dataField: 'Phone1', caption: 'Phone 1', width: '120px',
        validationRules: [{ type: 'required' }, { type: "numeric" }],
        editorOptions: {
            maxLength: 20
        }
    }, {
        dataField: 'Phone2', caption: 'Phone 2', width: '120px',
        validationRules: [{ type: "numeric" }],
        editorOptions: {
            maxLength: 20
        }
    }, {
        dataField: 'Fax', caption: 'Fax', width: '120px',
        validationRules: [{ type: "numeric" }],
        editorOptions: {
            maxLength: 20
        }
    }, {
        dataField: 'Email', caption: 'Email', width: '150px',
        validationRules: [{ type: 'email' }],
        editorOptions: {
            maxLength: 256
        }
    }, {
        dataField: 'StatusID', caption: 'Status', width: '100px',
        defaultValue: 1,
        lookup: {
            dataSource: DataUtility.vSystemLookups.dataSource(['Group', '=', 'CompanyStatus']),
            displayExpr: 'Name',
            valueExpr: 'Value_Int32',
            allowClearing: true
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

        icon: "Images/company_32px.png",


        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView
    };
};
