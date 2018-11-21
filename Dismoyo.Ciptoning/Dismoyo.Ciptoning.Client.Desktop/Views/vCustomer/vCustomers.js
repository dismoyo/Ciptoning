Dismoyo_Ciptoning_Client.vCustomers = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;

    function handlevCustomersModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vCustomers');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        if (!user.IsHeadOffice()) {
            var filters = [
                ['TerritoryID', '=', user.TerritoryID()], 'and',
                ['RegionID', '=', user.RegionID()], 'and',
                ['AreaID', '=', user.AreaID()], 'and',
                ['CompanyID', '=', user.CompanyID()], 'and',
                ['SiteID', '=', user.SiteID()]
            ];

            dataSource.filter(filters);
        }

        if (!dataSourceObservable()) {
            dataSourceObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vCustomers.off('modified', handlevCustomersModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vCustomers,
        select: [
            'ID',
            'Territory',
            'Region',
            'Area',
            'Company',
            'Site',
            'Code',
            'Name',
            'Salesman',
            'StatusName',
            'Address1',
            'Address2',
            'Address3',
            'City',
            'Category1',
            'Category2',
            'Category3',
            'StatusName',
            'CreatedDate',
            'CreatedByUserName',
            'ModifiedDate',
            'ModifiedByUserName'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vCustomers.on('modified', handlevCustomersModification);



    var dataSource_vDiscountGroup = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vDiscountGroups,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vDiscountGroupViewModel(item); }
    });


    function previewCustomerCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-20-(Auto Generated)';
    }

    function updateSiteChildEditor(form, siteID) {
        if (!siteID)
            siteID = null;

        var salesmanDataSource = DataUtility.GetLookupSalesmanDataSource(['SiteID', '=', siteID]);

        var infoForm = customerGeneralInfoForm();

        infoForm.getEditor('SalesmanID').option('value', null);
        infoForm.getEditor('SalesmanID').option('dataSource', []);
        salesmanDataSource.load()
            .done(function (result) {
                infoForm.getEditor('SalesmanID').option('dataSource', salesmanDataSource);
            });
    }


    function setCategory(form, data) {
        for (var i = 1; i <= 10; i++) {
            var fieldName = 'Category' + i.toString() + 'ID';
            if (form.getEditor(fieldName)) {
                form.getEditor(fieldName).option('value', data[fieldName]());
            }
        }
    }

    function getValueFromSystemParameter(value) {
        var sysParam = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', value]);
        if (sysParam.length > 0)
            return sysParam[0].Value();
        
        return null;
    }


    function setAddressInfo(form, data, prefix, readOnly) {
        form.getEditor('Address1').option('value', data[prefix + 'Address1']());
        form.getEditor('Address2').option('value', data[prefix + 'Address2']());
        form.getEditor('Address3').option('value', data[prefix + 'Address3']());
        form.getEditor('City').option('value', data[prefix + 'City']());
        form.getEditor('StateProvince').option('value', data[prefix + 'StateProvince']());
        form.getEditor('CountryID').option('value', data[prefix + 'CountryID']());
        form.getEditor('ZipCode').option('value', data[prefix + 'ZipCode']());
        form.getEditor('Phone1').option('value', data[prefix + 'Phone1']());
        form.getEditor('Phone2').option('value', data[prefix + 'Phone2']());
        form.getEditor('Phone3').option('value', data[prefix + 'Phone3']());
        form.getEditor('Fax').option('value', data[prefix + 'Fax']());
        form.getEditor('Email').option('value', data[prefix + 'Email']());

        form.getEditor('Address1').option('readOnly', readOnly);
        form.getEditor('Address2').option('readOnly', readOnly);
        form.getEditor('Address3').option('readOnly', readOnly);
        form.getEditor('City').option('readOnly', readOnly);
        form.getEditor('StateProvince').option('readOnly', readOnly);
        form.getEditor('CountryID').option('readOnly', readOnly);
        form.getEditor('ZipCode').option('readOnly', readOnly);
        form.getEditor('Phone1').option('readOnly', readOnly);
        form.getEditor('Phone2').option('readOnly', readOnly);
        form.getEditor('Phone3').option('readOnly', readOnly);
        form.getEditor('Fax').option('readOnly', readOnly);
        form.getEditor('Email').option('readOnly', readOnly);
    }

    function setShipmentInfo(data) {
        var shipmentInfoForm = customerShipmentInfoForm();

        setAddressInfo(shipmentInfoForm, data, '', false);
        shipmentInfoForm.getEditor('Longitude').option('value', data.Longitude());
        shipmentInfoForm.getEditor('Latitude').option('value', data.Latitude());
    }

    function setBillingInfo(data, actionByUser) {
        var billingInfoForm = customerBillingInfoForm();

        billingInfoForm.getEditor('IsBillSameAsAddress').option('value', data.IsBillSameAsAddress());

        var prefix = 'Bill';
        var name = data.BillName();
        var readOnly = false;
        if (data.IsBillSameAsAddress()) {
            prefix = '';
            name = data.Name();
            readOnly = true;
        } else if (actionByUser) {
            name = null;

            data.BillName(null);
            data.BillAddress1(null);
            data.BillAddress2(null);
            data.BillAddress3(null);
            data.BillCity(null);
            data.BillStateProvince(null);
            data.BillCountryID(null);
            data.BillZipCode(null);
            data.BillPhone1(null);
            data.BillPhone2(null);
            data.BillPhone3(null);
            data.BillFax(null);
            data.BillEmail(null);
        }

        billingInfoForm.getEditor('Name').option('value', name);
        billingInfoForm.getEditor('Name').option('readOnly', readOnly);
        setAddressInfo(billingInfoForm, data, prefix, readOnly);
    }

    function setTaxInfo(data, actionByUser) {
        var taxInfoForm = customerTaxInfoForm();

        taxInfoForm.getEditor('IsTaxSameAsAddress').option('value', data.IsTaxSameAsAddress());
        taxInfoForm.getEditor('IsTaxSameAsBillAddress').option('value', data.IsTaxSameAsBillAddress());

        var prefix = 'Tax';
        var name = data.TaxName();
        var readOnly = false;
        if (data.IsTaxSameAsAddress()) {
            prefix = '';
            name = data.Name();
            readOnly = true;
        } else if (data.IsTaxSameAsBillAddress()) {
            prefix = 'Bill';
            name = data.BillName();
            readOnly = true;
        } else if (actionByUser) {
            name = null;

            data.TaxName(null);
            data.TaxAddress1(null);
            data.TaxAddress2(null);
            data.TaxAddress3(null);
            data.TaxCity(null);
            data.TaxStateProvince(null);
            data.TaxCountryID(null);
            data.TaxZipCode(null);
            data.TaxPhone1(null);
            data.TaxPhone2(null);
            data.TaxPhone3(null);
            data.TaxFax(null);
            data.TaxEmail(null);
        }

        taxInfoForm.getEditor('Name').option('value', name);
        taxInfoForm.getEditor('Name').option('readOnly', readOnly);
        setAddressInfo(taxInfoForm, data, prefix, readOnly);
    }

    function setAdditionalInfo(form, data) {
        for (var i = 1; i <= 10; i++) {
            var fieldName = 'AdditionalInfo' + i.toString();
            if (form.getEditor(fieldName))
                form.getEditor(fieldName).option('value', data[fieldName]());
        }
    }

    function retrieveCategory(form, data) {
        for (var i = 1; i <= 10; i++) {
            var fieldName = 'Category' + i.toString() + 'ID';
            data[fieldName](form.getEditor(fieldName).option('value'));
        }
    }

    function retrieveAddressInfo(form, data, prefix) {
        data[prefix + 'Address1'](form.getEditor('Address1').option('value'));
        data[prefix + 'Address2'](form.getEditor('Address2').option('value'));
        data[prefix + 'Address3'](form.getEditor('Address3').option('value'));
        data[prefix + 'City'](form.getEditor('City').option('value'));
        data[prefix + 'StateProvince'](form.getEditor('StateProvince').option('value'));
        data[prefix + 'CountryID'](form.getEditor('CountryID').option('value'));
        data[prefix + 'ZipCode'](form.getEditor('ZipCode').option('value'));
        data[prefix + 'Phone1'](form.getEditor('Phone1').option('value'));
        data[prefix + 'Phone2'](form.getEditor('Phone2').option('value'));
        data[prefix + 'Phone3'](form.getEditor('Phone3').option('value'));
        data[prefix + 'Fax'](form.getEditor('Fax').option('value'));
        data[prefix + 'Email'](form.getEditor('Email').option('value'));
    }

    function retrieveAdditionalInfo(form, data) {
        for (var i = 1; i <= 10; i++) {
            var fieldName = 'AdditionalInfo' + i.toString();
            data[fieldName](form.getEditor(fieldName).option('value'));
        }
    }

    function openSelectedEditing(id, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vCustomers.byKey(id)
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vCustomerViewModel(result));
            })        
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vCustomerViewModel();
            data.StatusID(1);
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Customer');
        commonPopupEdit.popupEditOptions.editingKey = data.ID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        customerInfoTabPanel().option('selectedIndex', 0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        var generalInfoForm = customerGeneralInfoForm();
        var shipmentInfoForm = customerShipmentInfoForm();
        var billingInfoForm = customerBillingInfoForm();
        var taxInfoForm = customerTaxInfoForm();
        var additionalInfoForm = customerAdditionalInfoForm();
        //DXUtility.resetFormValidation(form);
        //DXUtility.resetFormValidation(generalInfoForm);
        //DXUtility.resetFormValidation(shipmentInfoForm);
        //DXUtility.resetFormValidation(billingInfoForm);
        //DXUtility.resetFormValidation(taxInfoForm);
        //DXUtility.resetFormValidation(additionalInfoForm);

        var customerCode = data.Code();
        if (newData) {
            data.StatusID(1);

            if (!user.IsHeadOffice()) {
                data.TerritoryID(user.TerritoryID());
                data.RegionID(user.RegionID());
                data.AreaID(user.AreaID());
                data.SiteID(user.SiteID());
                data.SiteCode(user.SiteCode());
                data.CompanyID(user.CompanyID());
                data.Company(user.Company());
            }

            data.RegisteredDate(new Date());
            data.IsBillSameAsAddress(false);
            data.IsTaxNumberAvailable(false);
            data.IsTaxSameAsAddress(false);
            data.IsTaxSameAsBillAddress(false);

            customerCode = previewCustomerCode(data.SiteCode());
        }

        // Set editor values
        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', data.TerritoryID());
            form.getEditor('RegionID').option('value', data.RegionID());
            form.getEditor('AreaID').option('value', data.AreaID());
            form.getEditor('Company').option('value', data.Company());
            form.getEditor('SiteID').option('value', data.SiteID());
        }

        updateSiteChildEditor(form, data.SiteID());

        form.getEditor('Code').option('value', customerCode);
        form.getEditor('Name').option('value', data.Name());

        generalInfoForm.getEditor('SalesmanID').option('value', data.SalesmanID());
        generalInfoForm.getEditor('RegisteredDate').option('value', data.RegisteredDate());
        generalInfoForm.getEditor('TermOfPaymentID').option('value', data.TermOfPaymentID());
        generalInfoForm.getEditor('CreditLimit').option('value', data.CreditLimit());
        generalInfoForm.getEditor('PriceGroupID').option('value', data.PriceGroupID());
        generalInfoForm.getEditor('DiscountGroupID').option('value', data.DiscountGroupID());

        setCategory(generalInfoForm, data);
        setAdditionalInfo(additionalInfoForm, data);
        setShipmentInfo(data);
        setBillingInfo(data, false);

        taxInfoForm.getEditor('IsTaxNumberAvailable').option('value', data.IsTaxNumberAvailable());
        taxInfoForm.getEditor('TaxNumber').option('value', data.TaxNumber());
        taxInfoForm.getEditor('TaxSAPCode').option('value', data.TaxSAPCode());
        setTaxInfo(data, false);

        if (newData) {
            DXUtility.resetFormValidation(form);
            DXUtility.resetFormValidation(generalInfoForm);
            DXUtility.resetFormValidation(shipmentInfoForm);
            DXUtility.resetFormValidation(billingInfoForm);
            DXUtility.resetFormValidation(taxInfoForm);
            DXUtility.resetFormValidation(additionalInfoForm);
        }

        generalInfoForm.getEditor('StatusID').option('value', data.StatusID());
        generalInfoForm.getEditor('RegisteredDate').option('value', data.RegisteredDate());
    }

    function saveEditing() {
        showLoadingPanel();

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');

        var data = commonPopupEdit.popupEditData();
        var form = commonPopupEdit.form();
        var generalInfoForm = customerGeneralInfoForm();
        var shipmentInfoForm = customerShipmentInfoForm();
        var billingInfoForm = customerBillingInfoForm();
        var taxInfoForm = customerTaxInfoForm();
        var additionalInfoForm = customerAdditionalInfoForm();

        var isValidForm = form.validate().isValid;
        var isValidGeneralFrom = generalInfoForm.validate().isValid;
        var isValidShipmentFrom = shipmentInfoForm.validate().isValid;
        var isValidBillFrom = billingInfoForm.validate().isValid;
        var isValidTaxFrom = taxInfoForm.validate().isValid;
        var isValid = (isValidForm && isValidGeneralFrom && isValidShipmentFrom && isValidBillFrom && isValidTaxFrom) ? true : false;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        if (isValid) {
            if (form.itemOption('Organization').visible) {
                data.SiteID(form.getEditor('SiteID').option('value'));
            }

            data.Code(form.getEditor('Code').option('value'));
            data.Name(form.getEditor('Name').option('value'));

            data.SalesmanID(generalInfoForm.getEditor('SalesmanID').option('value'));
            data.RegisteredDate(generalInfoForm.getEditor('RegisteredDate').option('value'));
            data.TermOfPaymentID(generalInfoForm.getEditor('TermOfPaymentID').option('value'));
            data.CreditLimit(generalInfoForm.getEditor('CreditLimit').option('value'));
            data.PriceGroupID(generalInfoForm.getEditor('PriceGroupID').option('value'));
            data.DiscountGroupID(generalInfoForm.getEditor('DiscountGroupID').option('value'));
            data.StatusID(generalInfoForm.getEditor('StatusID').option('value'));

            retrieveCategory(generalInfoForm, data);

            data.Longitude(shipmentInfoForm.getEditor('Longitude').option('value'));
            data.Latitude(shipmentInfoForm.getEditor('Latitude').option('value'));
            retrieveAddressInfo(shipmentInfoForm, data, '');

            data.IsBillSameAsAddress(billingInfoForm.getEditor('IsBillSameAsAddress').option('value'));
            data.BillName(billingInfoForm.getEditor('Name').option('value'));
            retrieveAddressInfo(billingInfoForm, data, 'Bill');

            data.IsTaxNumberAvailable(taxInfoForm.getEditor('IsTaxNumberAvailable').option('value'));
            data.TaxSAPCode(taxInfoForm.getEditor('TaxSAPCode').option('value'));
            data.TaxNumber(taxInfoForm.getEditor('TaxNumber').option('value'));
            data.IsTaxSameAsAddress(taxInfoForm.getEditor('IsTaxSameAsAddress').option('value'));
            data.IsTaxSameAsBillAddress(taxInfoForm.getEditor('IsTaxSameAsBillAddress').option('value'));
            data.TaxName(taxInfoForm.getEditor('Name').option('value'));
            retrieveAddressInfo(taxInfoForm, data, 'Tax');

            retrieveAdditionalInfo(additionalInfoForm, data);
        }

        if (isValidForm && isValidGeneralFrom && isValidShipmentFrom && isValidBillFrom && isValidTaxFrom) {
            var dataJS = ko.toJS(data);

            dataJS.RegisteredDate.setHours(0, 0, 0, 0);

            dataSource.store().insert(dataJS)
                .done(function (result) {
                    isDataGridRefreshRequired = true;

                    commonPopupEdit.events.performCancel();
                    hideLoadingPanel();
                })
                .fail(function (error) {
                    var dc = $('.dx-popup-normal>.dx-dialog-content');
                    if (dc.length == 0)
                        DevExpress.ui.dialog.alert(error.message, 'Save Failed');

                    hideLoadingPanel();
                });
        } else
            hideLoadingPanel();

        if (errorMsg != '') {
            var dc = $('.dx-popup-normal>.dx-dialog-content');
            if (dc.length == 0)
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
        itemType: 'group',
        caption: 'Organization',
        colCount: 3,
        colSpan: 3,
        visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
        items: [{
            dataField: 'TerritoryID',
            label: { text: 'Territory' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupTerritoryDataSource(null),
                displayExpr: 'Territory',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Territory',
                        [],
                        ['Region']);
                }
            }
        }, {
            dataField: 'RegionID',
            label: { text: 'Region' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupRegionDataSource(null),
                displayExpr: 'Region',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area']);
                }
            }
        }, {
            dataField: 'AreaID',
            label: { text: 'Area' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupAreaDataSource(null),
                displayExpr: 'Area',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Company', 'Site']);
                }
            }
        }, {
            dataField: 'CompanyID',
            label: { text: 'Company' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCompanyDataSource(null),
                displayExpr: 'Company',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                        ['Company', 'Area', 'Region', 'Territory'],
                        ['Salesman']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Customer',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            name: 'Customer',
            dataField: '',
            label: { text: 'Customer' },
            editorOptions: {
                placeholder: 'Code/Name',
                onEnterKey: function () { collapsibleFilter.events.performSearch(); }
            }
        }, {
            dataField: 'StatusID',
            label: { text: 'Status' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'CustomerStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                placeholder: '(All)',
                searchEnabled: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }]
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

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var territoryID = user.TerritoryID();
        var regionID = user.RegionID();
        var areaID = user.AreaID();
        var companyID = user.CompanyID();
        var siteID = user.SiteID();

        if (form.itemOption('Organization').visible) {
            territoryID = collapsibleFilter.form().getEditor('TerritoryID').option('value');
            regionID = collapsibleFilter.form().getEditor('RegionID').option('value');
            areaID = collapsibleFilter.form().getEditor('AreaID').option('value');
            companyID = collapsibleFilter.form().getEditor('CompanyID').option('value');
            siteID = collapsibleFilter.form().getEditor('SiteID').option('value');
        }

        // TerritoryID
        DXUtility.addFilterExpression(filterExpr, 'TerritoryID', '=', territoryID, 'and');

        // RegionID
        DXUtility.addFilterExpression(filterExpr, 'RegionID', '=', regionID, 'and');

        // AreaID
        DXUtility.addFilterExpression(filterExpr, 'AreaID', '=', areaID, 'and');

        // CompanyID
        DXUtility.addFilterExpression(filterExpr, 'CompanyID', '=', companyID, 'and');

        // SiteID
        DXUtility.addFilterExpression(filterExpr, 'SiteID', '=', siteID, 'and');

        // SalesmanID
        value = form.getEditor('SalesmanID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SalesmanID', '=', value, 'and');

        // StatusID
        value = form.getEditor('StatusID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'StatusID', '=', value, 'and');

        var groupFilterExpr = [];
        value = form.getEditor('Customer').option('value');
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
    
    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Customers.AddNewCustomer');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Customers.EditCustomer');
    commonGridView.dataGridOptions.editing.allowDeleting = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('Customers.DeleteCustomer');
    
    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Territory', caption: 'Territory', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Region', caption: 'Region', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Area', caption: 'Area', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Company', caption: 'Company', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Site', caption: 'Site', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Code', Caption: 'Code', width: '135px',
        validationRules: [{ type: 'required' }],        
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vCustomers_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines data-grid-banded-header-border-top">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                if (user.IsHeadOffice()) {
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="4">' + 'Customer' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';                    
                } else {

                    tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Customer' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Address' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                    tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';
                }

                if (commonGridView.dataGridOptions.editing.allowUpdating ||
                    commonGridView.dataGridOptions.editing.allowDeleting)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        cellTemplate: function (container, options) {
            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            var lbl = $('<b>').text(options.data.Code());
            if (commonGridView.dataGridOptions.editing.allowUpdating)
                lbl = $('<a class="dx-link">').text(options.data.Code()).on('dxclick', function () {
                    openSelectedEditing(options.data.ID(), false);
                });

            commands.append(lbl);
            commands.append('&nbsp;');

            container.append(commands);
        }
    }, {
        dataField: 'Name', width: '180px'
    }, {
        dataField: 'Salesman', caption: 'Salesman', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'StatusName', caption: 'Status', width: '100px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Address1', caption: '', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Address2', caption: '', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Address3', caption: '', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'City', caption: 'City', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Category1', caption: 'Customer Type', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Category2', caption: 'Customer Group', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Category3', caption: 'Customer Location', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'StatusName', caption: 'Status', width: '100px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Salesman', caption: 'Salesman', width: '200px', visible: !Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
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

    if (commonGridView.dataGridOptions.editing.allowUpdating ||
        commonGridView.dataGridOptions.editing.allowDeleting) {
        commonGridView.dataGridOptions.columns.push({
            width: 100,
            alignment: 'center',
            cellTemplate: function (container, options) {
                var commands = $('<div class="dx-command-edit" style="text-align: center;">');

                if (commonGridView.dataGridOptions.editing.allowUpdating) {
                    commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                        openSelectedEditing(options.data.ID(), false);
                    }));
                    commands.append('&nbsp;');
                }

                if (commonGridView.dataGridOptions.editing.allowDeleting) {
                    commands.append($('<a class="dx-link">').text('Delete').on('dxclick', function () {
                        var dataGrid = commonGridView.dataGrid();
                        var dataSource = dataGrid.option('dataSource');
                        var data = options.data.toJS();
                        var selectedKey = data.ID;

                        dataSource.store().remove(selectedKey).done(function () {
                            dataGrid.refresh();
                        });
                    }));
                    commands.append('&nbsp;');
                }

                container.append(commands);
            }
        });
    }





    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();
    commonPopupEdit.popupEditOptions.title = 'Customer';

    commonPopupEdit.okOptions.text = 'Save';
    commonPopupEdit.okOptions.icon = 'icons8-save';

    var customerInfoTabPanel = function () { return DXUtility.getDXInstance(null, '#vCustomers_infoTabPanel', 'dxTabPanel'); }
    var customerGeneralInfoForm = function () { return DXUtility.getDXInstance(null, '#vCustomers_generalInfoForm', 'dxForm'); }
    var customerShipmentInfoForm = function () { return DXUtility.getDXInstance(null, '#vCustomers_shipmentInfoForm', 'dxForm'); }
    var customerBillingInfoForm = function () { return DXUtility.getDXInstance(null, '#vCustomers_billingInfoForm', 'dxForm'); }
    var customerTaxInfoForm = function () { return DXUtility.getDXInstance(null, '#vCustomers_taxInfoForm', 'dxForm'); }
    var customerAdditionalInfoForm = function () { return DXUtility.getDXInstance(null, '#vCustomers_additionalInfoForm', 'dxForm'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = $('<div>');

        var tabPanel = $('<div id="vCustomers_infoTabPanel">').dxTabPanel({
            deferRendering: false,
            dataSource: [{
                'ID': 0,
                'Title': 'General Information'
            }, {
                'ID': 1,
                'Title': 'Shipment Information'
            }, {
                'ID': 2,
                'Title': 'Billing Information'
            }, {
                'ID': 3,
                'Title': 'Tax Information'
            }, {
                'ID': 4,
                'Title': 'Additional Information'
            }],
            onTitleRendered: function (e) {
                e.itemElement.empty();
                e.itemElement.append($('<span>').append(e.itemData.Title));
            },
            onItemRendered: function (e) {
                e.itemElement.empty();

                var container = $('<div style="padding: 12px 12px 12px 12px">');

                switch (e.itemData.ID) {
                    case 0: // General Information                        
                        container.append($('<div id="vCustomers_generalInfoForm">').dxForm({
                            deferRendering: false,
                            colCount: 3,
                            colSpan: 3,
                            showColonAfterLabel: false,
                            labelLocation: 'left',
                            items: [{
                                dataField: 'SalesmanID',
                                label: { text: 'Salesman' },
                                validationRules: [{ type: 'required' }],
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupSalesmanDataSource(
                                        (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]),
                                    displayExpr: 'Salesman',
                                    valueExpr: 'ID',
                                    searchEnabled: true,
                                    showClearButton: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'RegisteredDate',
                                label: { text: 'Registered Date' },
                                validationRules: [{ type: 'required' }],
                                editorType: 'dxDateBox',
                                editorOptions: {
                                    width: '100%',
                                    showClearButton: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'StatusID',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Status', location: 'left' },
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'CustomerStatus']),
                                    displayExpr: 'Name',
                                    valueExpr: 'Value_Int32',
                                    searchEnabled: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'TermOfPaymentID',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Term of Payment' },
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'CustomerTermOfPayment']),
                                    displayExpr: 'Name',
                                    valueExpr: 'Value_Int32',
                                    searchEnabled: true,
                                    showClearButton: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'CreditLimit',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Credit Limit' },
                                editorType: 'dxNumberBox',
                                editorOptions: {
                                    min: 0,
                                    max: 1000000000,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                itemType: 'empty',
                                colSpan: 1
                            }, {
                                dataField: 'PriceGroupID',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Price Group' },
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'ProductPriceGroup']),
                                    displayExpr: 'Name',
                                    valueExpr: 'Value_Int32',
                                    searchEnabled: true,
                                    showClearButton: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'DiscountGroupID',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Discount Group' },
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupDiscountGroupDataSource(),
                                    displayExpr: 'DiscountGroup',
                                    valueExpr: 'ID',
                                    searchEnabled: true,
                                    showClearButton: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                itemType: 'empty',
                                colSpan: 1
                            }, {
                                itemType: 'group',
                                caption: 'Categories',
                                cssClass: 'form-group-padding',
                                colCount: 2,
                                colSpan: 2,
                                items: [{
                                    dataField: 'Category1ID',
                                    validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category1') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category1Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    }
                                }, {
                                    dataField: 'Category2ID',
                                    validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category2') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category2Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category3ID',
                                    validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category3') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category3Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category4ID',
                                    validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category4') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category4Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category5ID',
                                    validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category5') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category5Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category6ID',
                                    //validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category6') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category6Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category7ID',
                                    //validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category7') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category7Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category8ID',
                                    //validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category8') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category8Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category9ID',
                                    //validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category9') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category9Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'Category10ID',
                                    //validationRules: [{ type: 'required' }],
                                    label: { text: getValueFromSystemParameter('Customer.Category10') },
                                    editorType: 'dxSelectBox',
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCustomerCategoryDataSource(['Group', '=', getValueFromSystemParameter('Customer.Category10Lookup')]),
                                        displayExpr: 'Category',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        showClearButton: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }]
                            }]
                        }));


                        break;
                    case 1: // Shipment Information
                        container.append($('<div id="vCustomers_shipmentInfoForm">').dxForm({
                            deferRendering: false,
                            colCount: 3,
                            colSpan: 3,
                            showColonAfterLabel: false,
                            labelLocation: 'left',
                            items: [{
                                dataField: 'Address1',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Address' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Address1(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Address1').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Address1').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Address2',
                                label: { text: ' ' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Address2(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Address2').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Address2').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Address3',
                                label: { text: ' ' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Address3(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Address3').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Address3').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'City',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'City' },
                                editorOptions: {
                                    maxLength: 50,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.City(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('City').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('City').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'StateProvince',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Province' },
                                editorOptions: {
                                    maxLength: 50,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.StateProvince(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('StateProvince').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('StateProvince').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'CountryID', width: '120px',
                                label: { text: 'Country' },
                                validationRules: [{ type: 'required' }],
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupCountryDataSource(null),
                                    displayExpr: 'Name',
                                    valueExpr: 'ID',
                                    searchEnabled: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.CountryID(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('CountryID').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('CountryID').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'ZipCode',
                                validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                label: { text: 'Zip Code' },
                                editorOptions: {
                                    maxLength: 10,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.ZipCode(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('ZipCode').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('ZipCode').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Phone1',
                                validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                label: { text: 'Phone 1' },
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Phone1(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Phone1').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Phone1').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'Phone2',
                                label: { text: 'Phone 2' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Phone2(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Phone2').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Phone2').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Phone3',
                                label: { text: 'Phone 3' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Phone3(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Phone3').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Phone3').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'Fax',
                                label: { text: 'Fax' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Fax(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Fax').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Fax').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Email',
                                label: { text: 'Email' },
                                validationRules: [{ type: 'email' }],
                                colSpan: '2',
                                editorOptions: {
                                    maxLength: 256,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.Email(e.value);

                                        if (data.IsBillSameAsAddress())
                                            customerBillingInfoForm().getEditor('Email').option('value', e.value);

                                        if (data.IsTaxSameAsAddress())
                                            customerTaxInfoForm().getEditor('Email').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Longitude',
                                label: { text: 'Longitude' },
                                editorType: 'dxNumberBox',
                                editorOptions: {
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'Latitude',
                                label: { text: 'Latitude' },
                                editorType: 'dxNumberBox',
                                editorOptions: {
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                itemType: 'empty',
                            }]
                        }));
                        break;
                    case 2: // Billing Information
                        container.append($('<div id="vCustomers_billingInfoForm">').dxForm({
                            deferRendering: false,
                            colCount: 3,
                            colSpan: 3,
                            showColonAfterLabel: false,
                            labelLocation: 'left',
                            items: [{
                                dataField: 'IsBillSameAsAddress',
                                label: { text: 'Same as Shipment Address' },
                                colSpan: 3,
                                editorType: 'dxCheckBox',
                                editorOptions: {
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.IsBillSameAsAddress(e.value);

                                        setBillingInfo(data, true);
                                    }
                                }
                            }, {
                                dataField: 'Name',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Name' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 50,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillName(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Name').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Address1',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Address' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillAddress1(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Address1').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Address2',
                                label: { text: ' ' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillAddress2(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Address2').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Address3',
                                label: { text: ' ' },
                                colSpan: 2,
                                editorOptions: {
                                    maxLength: 100,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillAddress3(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Address3').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'City',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'City' },
                                editorOptions: {
                                    maxLength: 50,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillCity(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('City').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'StateProvince',
                                validationRules: [{ type: 'required' }],
                                label: { text: 'Province' },
                                editorOptions: {
                                    maxLength: 50,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillStateProvince(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('StateProvince').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'CountryID', caption: 'Country', width: '120px',
                                validationRules: [{ type: 'required' }],
                                editorType: 'dxSelectBox',
                                editorOptions: {
                                    dataSource: DataUtility.GetLookupCountryDataSource(null),
                                    displayExpr: 'Name',
                                    valueExpr: 'ID',
                                    searchEnabled: true,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillCountryID(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('CountryID').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'ZipCode',
                                validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                label: { text: 'Zip Code' },
                                editorOptions: {
                                    maxLength: 10,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillZipCode(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('ZipCode').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Phone1',
                                validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                label: { text: 'Phone 1' },
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillPhone1(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Phone1').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'Phone2',
                                label: { text: 'Phone 2' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillPhone2(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Phone2').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Phone3',
                                label: { text: 'Phone 3' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillPhone3(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Phone3').option('value', e.value);
                                    }
                                }
                            }, {
                                dataField: 'Fax',
                                label: { text: 'Fax' },
                                validationRules: [{ type: 'numeric' }],
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillFax(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Fax').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                            }, {
                                dataField: 'Email',
                                label: { text: 'Email' },
                                validationRules: [{ type: 'email' }],
                                editorOptions: {
                                    maxLength: 256,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.BillEmail(e.value);

                                        if (data.IsTaxSameAsBillAddress())
                                            customerTaxInfoForm().getEditor('Email').option('value', e.value);
                                    }
                                }
                            }, {
                                itemType: 'empty',
                                colSpan: 2,
                            }]
                        }));
                        break;
                    case 3: // Tax Information
                        container.append($('<div id="vCustomers_taxInfoForm">').dxForm({
                            deferRendering: false,
                            colCount: 3,
                            colSpan: 3,
                            showColonAfterLabel: false,
                            labelLocation: 'left',
                            items: [{
                                dataField: 'IsTaxNumberAvailable',
                                label: { text: 'Have Tax Number' },
                                editorType: 'dxCheckBox',
                                editorOptions: {
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                    onValueChanged: function (e) {
                                        var data = commonPopupEdit.popupEditData();
                                        data.IsTaxNumberAvailable(e.value);

                                        var taxInfoForm = customerTaxInfoForm();
                                        taxInfoForm.itemOption('TaxNumber', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.Name', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.Address1', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.City', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.StateProvince', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.CountryID', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.ZipCode', 'isRequired', e.value);
                                        taxInfoForm.itemOption('.Phone1', 'isRequired', e.value);

                                        if (!e.value) {
                                            data.TaxNumber(null);
                                            data.TaxSAPCode(null);
                                        }

                                        taxInfoForm.getEditor('TaxNumber').option('value', data.TaxNumber());
                                        taxInfoForm.getEditor('TaxSAPCode').option('value', data.TaxSAPCode());

                                        taxInfoForm.getEditor('TaxNumber').option('readOnly', !e.value);
                                        taxInfoForm.getEditor('TaxSAPCode').option('readOnly', !e.value);
                                        // added by Asep 16/8/16
                                        if (data.IsTaxSameAsAddress() || data.IsTaxSameAsBillAddress())
                                            setTaxInfo(data, true);
                                    }
                                }
                            }, {
                                dataField: 'TaxNumber',
                                label: { text: 'Tax Number' },
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                dataField: 'TaxSAPCode',
                                label: { text: 'Tax SAP Code' },
                                editorOptions: {
                                    maxLength: 20,
                                    onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                }
                            }, {
                                itemType: 'group',
                                caption: ' ',
                                cssClass: 'form-group-padding',
                                colCount: 3,
                                colSpan: 3,
                                items: [{
                                    dataField: 'IsTaxSameAsAddress',
                                    label: { text: 'Same as Shipment Address' },
                                    editorType: 'dxCheckBox',
                                    editorOptions: {
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.IsTaxSameAsAddress(e.value);

                                            var isSameAsBillAddress = customerTaxInfoForm().getEditor('IsTaxSameAsBillAddress');
                                            var isSameAsBillAddressValue = isSameAsBillAddress.option('value');
                                            if (e.value) {
                                                if (isSameAsBillAddressValue)
                                                    isSameAsBillAddress.option('value', false);
                                                                                                
                                                data.IsTaxSameAsBillAddress(!e.value);
                                                setTaxInfo(data, true);
                                            } else if (!isSameAsBillAddressValue)                                                
                                                setTaxInfo(data, true);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                    colSpan: 2
                                }, {
                                    dataField: 'IsTaxSameAsBillAddress',
                                    label: { text: 'Same as Billing Address' },
                                    editorType: 'dxCheckBox',
                                    editorOptions: {
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.IsTaxSameAsBillAddress(e.value);

                                            var isSameAsAddress = customerTaxInfoForm().getEditor('IsTaxSameAsAddress');
                                            var isSameAsAddressValue = isSameAsAddress.option('value');
                                            if (e.value) {                                                
                                                if (isSameAsAddressValue)
                                                    isSameAsAddress.option('value', false);
                                                                                                
                                                data.IsTaxSameAsAddress(!e.value);
                                                setTaxInfo(data, true);
                                            } else if (!isSameAsAddressValue)                                                
                                                setTaxInfo(data, true);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                    colSpan: 2
                                }, {
                                    dataField: 'Name',
                                    label: { text: 'Name' },
                                    validationRules: [{ type: 'required' }],
                                    colSpan: 2,
                                    editorOptions: {
                                        maxLength: 50,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxName(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Address1',
                                    label: { text: 'Address' },
                                    validationRules: [{ type: 'required' }],
                                    colSpan: 2,
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxAddress1(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Address2',
                                    label: { text: ' ' },
                                    colSpan: 2,
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxAddress2(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Address3',
                                    label: { text: ' ' },
                                    colSpan: 2,
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxAddress3(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'City',
                                    label: { text: 'City' },
                                    validationRules: [{ type: 'required' }],
                                    editorOptions: {
                                        maxLength: 50,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxCity(e.value);
                                        }
                                    }
                                }, {
                                    dataField: 'StateProvince',
                                    label: { text: 'Province' },
                                    validationRules: [{ type: 'required' }],
                                    editorOptions: {
                                        maxLength: 50,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxStateProvince(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'CountryID', caption: 'Country', width: '120px',
                                    editorType: 'dxSelectBox',
                                    validationRules: [{ type: 'required' }],
                                    editorOptions: {
                                        dataSource: DataUtility.GetLookupCountryDataSource(null),
                                        displayExpr: 'Name',
                                        valueExpr: 'ID',
                                        searchEnabled: true,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxCountryID(e.value);
                                        }
                                    }
                                }, {
                                    dataField: 'ZipCode',
                                    label: { text: 'Zip Code' },
                                    validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                    editorOptions: {
                                        maxLength: 10,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxZipCode(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Phone1',
                                    validationRules: [{ type: 'required' }, { type: 'numeric' }],
                                    label: { text: 'Phone 1' },
                                    editorOptions: {
                                        maxLength: 20,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxPhone1(e.value);
                                        }
                                    }
                                }, {
                                    dataField: 'Phone2',
                                    label: { text: 'Phone 2' },
                                    validationRules: [{ type: 'numeric' }],
                                    editorOptions: {
                                        maxLength: 20,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxPhone2(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Phone3',
                                    label: { text: 'Phone 3' },
                                    validationRules: [{ type: 'numeric' }],
                                    editorOptions: {
                                        maxLength: 20,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxPhone3(e.value);
                                        }
                                    }
                                }, {
                                    dataField: 'Fax',
                                    label: { text: 'Fax' },
                                    validationRules: [{ type: 'numeric' }],
                                    editorOptions: {
                                        maxLength: 20,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxFax(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }, {
                                    dataField: 'Email',
                                    label: { text: 'Email' },
                                    validationRules: [{ type: 'email' }],
                                    editorOptions: {
                                        maxLength: 256,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                                        onValueChanged: function (e) {
                                            var data = commonPopupEdit.popupEditData();
                                            data.TaxEmail(e.value);
                                        }
                                    }
                                }, {
                                    itemType: 'empty',
                                }]
                            }]
                        }));
                        break;
                    case 4: // Additional Information
                        container.append($('<div id="vCustomers_additionalInfoForm">').dxForm({
                            deferRendering: false,
                            colCount: 2,
                            showColonAfterLabel: false,
                            labelLocation: 'left',
                            items: [{
                                itemType: 'group',
                                cssClass: 'form-group-padding',
                                colCount: 2,
                                colSpan: 2,
                                items: [{
                                    dataField: 'AdditionalInfo1',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo1') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo2',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo2') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo3',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo3') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo4',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo4') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo5',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo5') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo6',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo6') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo7',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo7') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo8',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo8') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo9',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo9') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }, {
                                    dataField: 'AdditionalInfo10',
                                    label: { text: getValueFromSystemParameter('Customer.AdditionalInfo10') },
                                    editorOptions: {
                                        maxLength: 100,
                                        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
                                    }
                                }]
                            }]
                        }));
                        break;
                }

                e.itemElement.append(container);
            }
        });

        content.append(tabPanel);

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
    };

    // ------------------------------------------------------------------------------------------------
    // Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    commonPopupEdit.formOptions.items = [{
        itemType: 'group',
        caption: 'Organization',
        colCount: 3,
        colSpan: 3,
        visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
        items: [{
            dataField: 'TerritoryID',
            label: { text: 'Territory' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupTerritoryDataSource(null),
                displayExpr: 'Territory',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Territory',
                        [],
                        ['Region']);
                }
            }
        }, {
            dataField: 'RegionID',
            label: { text: 'Region' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupRegionDataSource(null),
                displayExpr: 'Region',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area']);
                }
            }
        }, {
            dataField: 'AreaID',
            label: { text: 'Area' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupAreaDataSource(null),
                displayExpr: 'Area',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Site']);
                }
            }
        }, {
            dataField: 'Company',
            label: { text: 'Company' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            validationRules: [{ type: 'required' }],
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(commonPopupEdit.form(), e.selectedItem, e.value, 'Site',
                         ['Area', 'Region', 'Territory'],
                         []);

                    if (e.selectedItem) {
                        commonPopupEdit.form().getEditor('Company').option('value', e.selectedItem.Company());
                        commonPopupEdit.form().getEditor('Code').option('value', previewCustomerCode(e.selectedItem.Code()));
                    } else if (e.previousValue != null)
                        commonPopupEdit.form().getEditor('Company').option('value', null);

                    updateSiteChildEditor(commonPopupEdit.form(), e.value);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Customer',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'Code',
            //validationRules: [{ type: 'required' }],

            label: { text: 'Code' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
            }
        }, {
            dataField: 'Name',
            validationRules: [{ type: 'required' }],
            label: { text: 'Name' },
            colSpan: 3,
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    var data = commonPopupEdit.popupEditData();
                    data.Name(e.value);

                    if (data.IsBillSameAsAddress())
                        customerBillingInfoForm().getEditor('Name').option('value', e.value);

                    if (data.IsTaxSameAsAddress())
                        customerTaxInfoForm().getEditor('Name').option('value', e.value);
                }
            }
        }, {
            itemType: 'empty'
        }]
    }];

    commonGridView.events.performNewRow = function (rootView) {
        openEditing(null);
    };

    commonPopupEdit.events.performOK = function (rootView) {
        saveEditing();
    };

    commonPopupEdit.events.performCancel = function (rootView) {
        commonPopupEdit.popupEditOptions.visible(false);

        if (isDataGridRefreshRequired) {
            commonGridView.dataGrid().refresh();
            isDataGridRefreshRequired = false;
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

        icon: '/Images/customer_32px.png',

        dataSource_vDiscountGroup: dataSource_vDiscountGroup,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        customerInfoTabPanel: customerInfoTabPanel,
        customerGeneralInfoForm: customerGeneralInfoForm,
        customerShipmentInfoForm: customerShipmentInfoForm,
        customerBillingInfoForm: customerBillingInfoForm,
        customerTaxInfoForm: customerTaxInfoForm,
        customerAdditionalInfoForm: customerAdditionalInfoForm
    };
};
