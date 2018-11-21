Dismoyo_Ciptoning_Client.vSalesOrderSamples = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isLotNumberEntryRequired;

    function handlevSalesOrderSamplesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vSalesOrderSamples');
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

        if (!dataObservable()) {
            dataObservable(dataSource);
            dataSource.load().always(function () { isReady.resolve(); });
        }
        else if (shouldReload)
            refreshList();
    }

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vSalesOrderSamples.off('modified', handlevSalesOrderSamplesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSamples,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vSalesOrderSamples.on('modified', handlevSalesOrderSamplesModification);

    var dataSource_vSalesOrderSampleDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSampleDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleDetailsViewModel(item); }
    });

    var dataSource_vSalesOrderSampleSummary = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSampleSummaries,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleSummaryViewModel(item); }
    });

    var dataSource_vStockOnHandAvailable;
    var dataSource_vStockOnHandAvailableByProduct;
    var dataSource_vSelectedProductPrices;
    var dataSource_vSelectedDiscountGroup;

    var conversionValidationRule = {
        type: 'pattern',
        pattern: '(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)',
        message: 'Format must be L/M/S or M/S or S.'
    };

    function previewDocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-04-(Auto Generated)';
    }

    function previewDODocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-10-(Auto Generated)';
    }

    function updateSiteChildEditor(form, siteID) {
        if (siteID) {
            Dismoyo_Ciptoning_Client.DB.vSites.byKey(siteID)
                .done(function (result) {
                    isLotNumberEntryRequired = result.IsLotNumberEntryRequired;
                });
        } else {
            siteID = null;
            isLotNumberEntryRequired = undefined;
        }

        var customerDataSource = new DevExpress.data.DataSource({
            store: Dismoyo_Ciptoning_Client.DB.vCustomers,
            select: [
                'ID',
                'Customer',
                'Address',
                'Category1',
                'SalesmanID',
                'Salesman',
                'WarehouseID',
                'TermOfPaymentID',
                'PriceGroupID',
                'DiscountGroupID',
                'SiteID'
            ],
            filter: [
                ['IsDeleted', '=', false], 'and',
                ['StatusID', '=', 1], 'and',
                ['SiteID', '=', siteID]
            ],
            map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); }
        });

        var salesmanDataSource = DataUtility.GetLookupSalesmanDataSource([
            ['IsDeleted', '=', false], 'and',
            ['StatusID', '=', 1], 'and',
            ['SiteID', '=', siteID]
        ]);

        form.getEditor('CustomerID').option('value', null);
        form.getEditor('CustomerID').option('dataSource', customerDataSource);
        customerDataSource.load();

        form.getEditor('SalesmanID').option('value', null);
        form.getEditor('SalesmanID').option('dataSource', salesmanDataSource);
        salesmanDataSource.load();
    }

    function updateTermOfPaymentEditor(form, termOfPaymentID) {
        var filter = [
            ['Group', '=', 'CustomerTermOfPayment']
        ];

        if ((termOfPaymentID != undefined) && (termOfPaymentID != null)) {
            filter.push('and');
            filter.push(['Value_Int32', '<=', termOfPaymentID]);
        }

        var termOfPaymentDataSource = DataUtility.GetLookupSystemLookupDataSource(filter);

        form.getEditor('TermOfPaymentID').option('value', null);
        form.getEditor('TermOfPaymentID').option('dataSource', termOfPaymentDataSource);
        form.getEditor('TermOfPaymentID').option('value', termOfPaymentID);
        termOfPaymentDataSource.load();
    }


    function getValueFromSystemParameter(value) {
        var sysParam = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', value]);
        if (sysParam.length > 0)
            return sysParam[0].Value();

        return null;
    }

    function calcProductPriceAndDiscount(e) {
        return CommonUtility.calcProductPriceAndDiscount(
            commonPopupEdit.form().getEditor('TransactionDate').option('value'),
            e.component,
            e.row.rowIndex,
            e.row.data,
            dataSource_vSelectedProductPrices,
            dataSource_vSelectedDiscountGroup,
            true
        );
    }


    function updateSummariesArrayStore(summary) {
        CommonUtility.updateSummariesArrayStore(
            salesOrderSampleSummaryDataGrid().option('dataSource').store(),
            summary
        );
    }

    function updateDeferSummariesArrayStore(productID, summary) {
        CommonUtility.updateDeferSummariesArrayStore(
            salesOrderSampleSummaryDataGrid().option('dataSource').store(),
            productID,
            summary
        );
    }

    function validateSummaryArrayStore(summary) {
        return CommonUtility.validateSummaryArrayStore(
            salesOrderSampleSummaryDataGrid().option('dataSource').store(),
            'vSalesOrderSampleSummaryViewModel',
            summary
        );
    }

    function createSummaryDataSource(summaries) {
        return CommonUtility.createArrayDataSource(
            'vSalesOrderSampleSummaryViewModel',
            ['ProductID'],
            summaries
        );
    }

    function createProductLotEditCommands(data, qtyOrderConvColumn, itemStatusID) {
        var commands = $('<div class="dx-command-edit" style="text-align: right; padding-right: 5px;">');

        commands.append($('<a style="color: inherit;">').text(data[qtyOrderConvColumn]()));
        commands.append('&nbsp;');

        if (isLotNumberEntryRequired) {
            var column = qtyOrderConvColumn.replace("Conv", "");
            var qty = data[column]();
            var childDetails = data["ChildDetails"]();
            var total = 0;
            for (var o in childDetails) {
                total += childDetails[o][column]();
            }

            commands.append($('<a class="dx-link dxcustom-linkbutton dx-icon-icons8-view-details" title="Edit Lot Number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><span id="LotMark_' + data["ProductID"]() + '_' + qtyOrderConvColumn + '" class="dx-icon-overflow ' + (total == qty ? 'hidden' : '') + '" style="color:red; font-size: 14px; margin-left: -6px;"></span>').on('dxclick', function () {
                downloadProductLot(function () {
                    openProductLotEditing(data, itemStatusID); // Open product lot popup entry
                });
            }));
            commands.append('&nbsp;');
        }

        return commands;
    }

    function setSummaryDataGridEditing(allowed) {
        var option = salesOrderSampleSummaryDataGrid().option('editing');
        var selection = salesOrderSampleSummaryDataGrid().option('selection');

        selection.mode = (allowed) ? 'multiple' : 'none';

        //option.allowAdding = allowed;
        option.allowUpdating = allowed;
        option.allowDeleting = allowed;
        salesOrderSampleSummaryDataGrid().option('editing', option);
        salesOrderSampleSummaryDataGrid().option('selection', selection);
        salesOrderSampleSummaryNewRow().option('disabled', !allowed);
        salesOrderSampleSummaryDeleteRows().option('disabled', true);
        salesOrderSampleSummaryDataGrid().repaint();
    }

    function openSelectedEditing(documentID, refreshRequired) {
        showLoadingPanel();

        new DevExpress.data.DataSource({
            store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSamples,
            select: [
                'DocumentID',
                'DocumentCode',
                'TransactionDate',
                'PODocumentID',
                'PODocumentCode',
                'POTransactionDate',
                'SalesmanID',
                'WarehouseID',
                'SiteID',
                'CompanyID',
                'Company',
                'AreaID',
                'RegionID',
                'TerritoryID',
                'CustomerID',
                'PriceGroupID',
                'DiscountGroupID',
                'TermOfPaymentID',
                'ReferenceNumber',
                'DODocumentID',
                'DODocumentCode',
                'DOShipmentDate',
                'DOReceivedDate',
                'DOPrintedCount',
                'DOLastPrintedDate',
                'RawTotalGrossPrice',
                'RawTotalPrice',
                'RawTotalDiscountStrata1Amount',
                'RawTotalDiscountStrata2Amount',
                'RawTotalDiscountStrata3Amount',
                'RawTotalDiscountStrata4Amount',
                'RawTotalDiscountStrata5Amount',
                'RawTotalAddDiscountStrataAmount',
                'RawTotalGross',
                'RawTotalTax',
                'RawTotal',
                'TotalGrossPrice',
                'TotalPrice',
                'TotalDiscountStrata1Amount',
                'TotalDiscountStrata2Amount',
                'TotalDiscountStrata3Amount',
                'TotalDiscountStrata4Amount',
                'TotalDiscountStrata5Amount',
                'TotalAddDiscountStrataAmount',
                'TotalGross',
                'TotalTax',
                'Total',
                'TotalWeight',
                'TotalDimension',
                'AddDiscountStrataReason',
                'DocumentStatusID',
                'DocumentStatusReason'
            ],
            filter: ['DocumentID', '=', documentID],
            paginate: false,
            map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleViewModel(item); }
        }).load()
            .done(function (result) {
                if (result.length > 0) {
                    new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSampleSummaries,
                        select: [
                            'DocumentID',
                            'ProductID',
                            'ProductCode',
                            'Product',
                            'ProductUOMLID',
                            'ProductUOMMID',
                            'ProductUOMSID',
                            'ProductWeight',
                            'ProductDimensionL',
                            'ProductDimensionW',
                            'ProductDimensionH',
                            'ProductConversionL',
                            'ProductConversionM',
                            'ProductConversionS',
                            'QtyOnHand',
                            'QtyConvL',
                            'QtyConvM',
                            'QtyConvS',
                            'Qty',
                            'QtyOrderConv',
                            'QtyOrder',
                            'UnitGrossPrice',
                            'UnitPrice',
                            'DiscountStrata1Percentage',
                            'DiscountStrata2Percentage',
                            'DiscountStrata3Percentage',
                            'DiscountStrata4Percentage',
                            'DiscountStrata5Percentage',
                            'AddDiscountStrataPercentage',
                            'TaxPercentage',
                            'RawSubtotalGrossPrice',
                            'RawSubtotalPrice',
                            'RawSubtotalDiscountStrata1',
                            'RawDiscountStrata1Amount',
                            'RawSubtotalDiscountStrata2',
                            'RawDiscountStrata2Amount',
                            'RawSubtotalDiscountStrata3',
                            'RawDiscountStrata3Amount',
                            'RawSubtotalDiscountStrata4',
                            'RawDiscountStrata4Amount',
                            'RawSubtotalDiscountStrata5',
                            'RawDiscountStrata5Amount',
                            'RawAddDiscountStrataAmount',
                            'RawSubtotalGross',
                            'RawSubtotalTax',
                            'RawSubtotal',
                            'SubtotalGrossPrice',
                            'SubtotalPrice',
                            'SubtotalDiscountStrata1',
                            'DiscountStrata1Amount',
                            'SubtotalDiscountStrata2',
                            'DiscountStrata2Amount',
                            'SubtotalDiscountStrata3',
                            'DiscountStrata3Amount',
                            'SubtotalDiscountStrata4',
                            'DiscountStrata4Amount',
                            'SubtotalDiscountStrata5',
                            'DiscountStrata5Amount',
                            'AddDiscountStrataAmount',
                            'SubtotalGross',
                            'SubtotalTax',
                            'Subtotal',
                            'SubtotalWeight',
                            'SubtotalDimension'
                        ],
                        filter: ['DocumentID', '=', documentID],
                        sort: ['ProductID'],
                        paginate: false,
                        map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleSummaryViewModel(item); }
                    }).load()
                        .done(function (result2) {
                            if (result2.length > 0) {
                                new DevExpress.data.DataSource({
                                    store: Dismoyo_Ciptoning_Client.DB.vSalesOrderSampleDetails,
                                    select: [
                                        'DocumentID',
                                        'ProductID',
                                        'ProductLotID',
                                        'ProductLotCode',
                                        'QtyOnHand',
                                        'QtyConvL',
                                        'QtyConvM',
                                        'QtyConvS',
                                        'Qty',
                                        'QtyOrderConv',
                                        'QtyOrder'
                                    ],
                                    filter: ['DocumentID', '=', documentID],
                                    sort: ['ProductID', 'ProductLotID'],
                                    paginate: false,
                                    map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesOrderSampleDetailsViewModel(item); }
                                }).load()
                                    .done(function (result3) {
                                        if (result3.length > 0) {
                                            var summaries = result2;
                                            var j = -1;
                                            for (var i = 0; i < result3.length; i++) {
                                                var details = result3[i];
                                                if ((i == 0) || (summaries[j].ProductID() != details.ProductID())) {
                                                    j++;
                                                    summaries[j].ChildDetails = ko.observableArray([]);
                                                }

                                                details.ProductCode(summaries[j].ProductCode());
                                                details.Product(summaries[j].Product());
                                                details.ProductUOMLID(summaries[j].ProductUOMLID());
                                                details.ProductUOMMID(summaries[j].ProductUOMMID());
                                                details.ProductUOMSID(summaries[j].ProductUOMSID());
                                                details.ProductConversionL(summaries[j].ProductConversionL());
                                                details.ProductConversionM(summaries[j].ProductConversionM());
                                                details.ProductConversionS(summaries[j].ProductConversionS());

                                                summaries[j].ChildDetails().push(details);
                                            }

                                            result[0].ChildSummaries(summaries);

                                            hideLoadingPanel();

                                            isDataGridRefreshRequired = refreshRequired;
                                            openEditing(result[0]);
                                        } else {
                                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The details of selected data is not found.'), 'Load Failed');
                                            hideLoadingPanel();
                                        }

                                    })
                                    .fail(function (error) {
                                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load details of selected data.'), 'Load Failed');
                                        hideLoadingPanel();
                                    });
                            } else {
                                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The summary of selected data is not found.'), 'Load Failed');
                                hideLoadingPanel();
                            }
                        })
                        .fail(function (error) {
                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load summary of selected data.'), 'Load Failed');
                            hideLoadingPanel();
                        });
                } else {
                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The selected data is not found.'), 'Load Failed');
                    hideLoadingPanel();
                }
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });

        //Dismoyo_Ciptoning_Client.DB.vSalesOrderSamples.byKey(
        //    documentID, { expand: ['ChildSummaries/ChildDetails'] })
        //    .done(function (result) {
        //        hideLoadingPanel();

        //        isDataGridRefreshRequired = refreshRequired;
        //        openEditing(new Dismoyo_Ciptoning_Client.vSalesOrderSampleViewModel(result));
        //    })
        //    .fail(function (error) {
        //        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
        //        hideLoadingPanel();
        //    });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vSalesOrderSampleViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Sales Order Sample');
        commonPopupEdit.popupEditOptions.editingKey = data.DocumentID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        var summaryForm = salesOrderSampleSummaryForm();
        DXUtility.resetFormValidation(form);

        // Disable/enable operation buttons
        var documentCode = data.DocumentCode();
        var doDocumentCode = data.DODocumentCode();
        var disabled = false;
        var summaries = [];

        isLotNumberEntryRequired = data.IsSiteLotNumberEntryRequired();

        if (newData) {
            data.DocumentID(new DevExpress.data.Guid());
            data.DocumentStatusID(null);

            if (!user.IsHeadOffice()) {
                data.TerritoryID(user.TerritoryID());
                data.RegionID(user.RegionID());
                data.AreaID(user.AreaID());
                data.SiteID(user.SiteID());
                data.SiteCode(user.SiteCode());
                data.CompanyID(user.CompanyID());
                data.Company(user.Company());
            }

            documentCode = previewDocumentCode(data.SiteCode());
            doDocumentCode = previewDODocumentCode(data.SiteCode());
        } else {
            summaries = data.ChildSummaries();
            if (data.DocumentStatusID() == 1 && !isLotNumberEntryRequired) { // Draft
                // Check whether it required download product lot or not to keep performance.
                var downloadSummaries = [];
                var indexSummaries = 0;

                for (var i = 0; i < summaries.length; i++) {
                    var childDetails = summaries[i].ChildDetails();
                    var notDummy = 0;

                    for (var j = 0; j < childDetails.length; j++) {
                        if (childDetails[j].ProductLotCode().indexOf("DUMMY") < 0) {
                            notDummy++;
                        }
                    }

                    if (notDummy > 0) {
                        downloadSummaries[indexSummaries] = summaries[i];
                        indexSummaries++;
                    }
                }

                if (downloadSummaries.length > 0) {
                    dataSource_vStockOnHandAvailable = [];
                    dataSource_vStockOnHandAvailableByProduct = [];
                    form.getEditor('SalesmanID').option('value', data.SalesmanID());

                    downloadProductLot(function () {
                        for (var i = 0; i < downloadSummaries.length; i++) {
                            var e = {
                                data: downloadSummaries[i].toJS()
                            };
                            addDummyData(e, downloadSummaries);
                        }
                    });
                }
            } else if ((data.DocumentStatusID() == 2) || (data.DocumentStatusID() == 3) ||
                (data.DocumentStatusID() == 4)) // Posted, Discarded or Voided
                disabled = true;
        }

        setSummaryDataGridEditing(!disabled);

        salesOrderSamplePrintDO().option('disabled', newData);
        salesOrderSamplePost().option('disabled', newData || disabled);
        salesOrderSampleDiscard().option('disabled', newData || disabled);
        salesOrderSampleVoid().option('disabled', (data.DocumentStatusID() != 2));
        salesOrderSampleSaveAsDraftAndNew().option('disabled', disabled);
        commonPopupEdit.ok().option('disabled', disabled);

        var priceGroupID = data.PriceGroupID();
        var discountGroupID = data.DiscountGroupID();

        // Set editor values
        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', data.TerritoryID());
            form.getEditor('RegionID').option('value', data.RegionID());
            form.getEditor('AreaID').option('value', data.AreaID());
            form.getEditor('SiteID').option('value', data.SiteID());
            form.getEditor('Company').option('value', data.Company());

            form.getEditor('TerritoryID').option('readOnly', disabled);
            form.getEditor('RegionID').option('readOnly', disabled);
            form.getEditor('AreaID').option('readOnly', disabled);
            form.getEditor('SiteID').option('readOnly', disabled);
        }

        updateSiteChildEditor(form, data.SiteID());
        updateTermOfPaymentEditor(form, data.TermOfPaymentID());

        form.getEditor('DocumentCode').option('value', documentCode);
        form.getEditor('TransactionDate').option('value', data.TransactionDate());
        form.getEditor('CustomerID').option('value', data.CustomerID());
        form.getEditor('SalesmanID').option('value', data.SalesmanID());
        form.getEditor('WarehouseID').option('value', data.WarehouseID());
        form.getEditor('TermOfPaymentID').option('value', data.TermOfPaymentID());
        form.getEditor('ReferenceNumber').option('value', data.ReferenceNumber());
        form.getEditor('DocumentStatusID').option('value', data.DocumentStatusID());

        //summaryForm.getEditor('DocumentStatusReason').option('value', data.DocumentStatusReason());

        form.getEditor('PODocumentCode').option('value', data.PODocumentCode());
        form.getEditor('POTransactionDate').option('value', data.POTransactionDate());

        form.getEditor('DODocumentCode').option('value', doDocumentCode);
        form.getEditor('DOShipmentDate').option('value', data.DOShipmentDate());
        form.getEditor('DOReceivedDate').option('value', data.DOReceivedDate());
        form.getEditor('DOPrintedCount').option('value', data.DOPrintedCount());
        form.getEditor('DOLastPrintedDate').option('value', data.DOLastPrintedDate());

        summaryForm.getEditor('TotalGross').option('value', CommonUtility.getNumberFormat(data.TotalGross()));
        summaryForm.getEditor('TotalTax').option('value', CommonUtility.getNumberFormat(data.TotalTax()));
        summaryForm.getEditor('Total').option('value', CommonUtility.getNumberFormat(data.Total()));

        form.getEditor('TransactionDate').option('readOnly', disabled);
        form.getEditor('CustomerID').option('readOnly', disabled);
        form.getEditor('SalesmanID').option('readOnly', disabled);
        form.getEditor('TermOfPaymentID').option('readOnly', disabled);
        form.getEditor('ReferenceNumber').option('readOnly', disabled);

        //summaryForm.getEditor('DocumentStatusReason').option('readOnly', disabled);

        form.getEditor('PODocumentCode').option('readOnly', disabled);
        form.getEditor('POTransactionDate').option('readOnly', disabled);

        form.getEditor('DOShipmentDate').option('readOnly', disabled);
        form.getEditor('DOReceivedDate').option('readOnly', disabled);

        var today = new Date();

        if (newData) {
            DXUtility.resetFormValidation(form);

            form.getEditor('TransactionDate').option('value', today);
            form.getEditor('DOShipmentDate').option('value', today);
            //form.getEditor('DOReceivedDate').option('value', today);
        } else {
            if (priceGroupID)
                data.PriceGroupID(priceGroupID);

            if (discountGroupID)
                data.DiscountGroupID(discountGroupID);

            dataSource_vSelectedProductPrices = Dismoyo_Ciptoning_Client.LocalStore.vProductPrices.dataByFilter(
                ['PriceGroupID', '=', data.PriceGroupID()]);

            dataSource_vSelectedDiscountGroup =
                Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.expandedDataByKey(data.DiscountGroupID());
        }

        // Set grid datasource for summary including details
        var summaryDataGrid = salesOrderSampleSummaryDataGrid();
        summaryDataGrid.cancelEditData();

        data.ChildSummaries(summaries);
        summaryDataGrid.option('dataSource',
            createSummaryDataSource(data.ChildSummaries()));
    }

    function saveEditing(statusID, action) {
        showLoadingPanel();

        var form = commonPopupEdit.form();
        var summaryForm = salesOrderSampleSummaryForm();

        var isValid = form.validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var summaryDataSource = salesOrderSampleSummaryDataGrid().option('dataSource');
        var summaries = [];
        for (var i = 0; i < summaryDataSource.store()._array.length; i++)
            summaries.push(new Dismoyo_Ciptoning_Client.vSalesOrderSampleSummaryViewModel(summaryDataSource.store()._array[i]));

        if (isValid) {
            if (summaries.length <= 0) {
                errorMsg = 'Please specify at least one item in Order Details.';
                isValid = false;
            }
        }

        //var documentStatusReason = summaryForm.getEditor('DocumentStatusReason').option('value');
        //if (isValid && ((documentStatusReason == null) || (documentStatusReason == ''))) {
        //    for (var i = 0; i < summaries.length; i++) {
        //        if (((summaries[i].PriceDate() != undefined) || (summaries[i].PriceDate() != null)) ||
        //            (summaries[i].AddDiscountStrataPercentage() > 0.0)) {
        //            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Price Date/Additional Disc has changed. ' +
        //                'Please specify the Reason for changing Price Date/Additional Disc.'), 'Save Failed');
        //            isValid = false;
        //            break;
        //        }
        //    }
        //}

        var rawTotalGrossPrice = 0;
        var rawTotalPrice = 0;
        var rawTotalDiscountStrata1Amount = 0;
        var rawTotalDiscountStrata2Amount = 0;
        var rawTotalDiscountStrata3Amount = 0;
        var rawTotalDiscountStrata4Amount = 0;
        var rawTotalDiscountStrata5Amount = 0;
        var rawTotalAddDiscountStrataAmount = 0;
        var rawTotalGross = 0;
        var rawTotalTax = 0;
        var rawTotal = 0;
        var totalGrossPrice = 0;
        var totalPrice = 0;
        var totalDiscountStrata1Amount = 0;
        var totalDiscountStrata2Amount = 0;
        var totalDiscountStrata3Amount = 0;
        var totalDiscountStrata4Amount = 0;
        var totalDiscountStrata5Amount = 0;
        var totalAddDiscountStrataAmount = 0;
        var totalGross = 0;
        var totalTax = 0;
        var total = 0;
        var totalWeight = 0;
        var totalDimension = 0;

        if (isValid) {
            for (var i = 0; i < summaries.length; i++) {
                var summary = summaries[i];
                var sumQtyOrder = 0;

                rawTotalGrossPrice += summary.RawSubtotalGrossPrice();
                rawTotalPrice += summary.RawSubtotalPrice();
                rawTotalDiscountStrata1Amount += summary.RawDiscountStrata1Amount();
                rawTotalDiscountStrata2Amount += summary.RawDiscountStrata2Amount();
                rawTotalDiscountStrata3Amount += summary.RawDiscountStrata3Amount();
                rawTotalDiscountStrata4Amount += summary.RawDiscountStrata4Amount();
                rawTotalDiscountStrata5Amount += summary.RawDiscountStrata5Amount();
                rawTotalAddDiscountStrataAmount += summary.RawAddDiscountStrataAmount();
                rawTotalGross += summary.RawSubtotalGross();
                rawTotalTax += summary.RawSubtotalTax();
                rawTotal += summary.RawSubtotal();
                totalGrossPrice += summary.SubtotalGrossPrice();
                totalPrice += summary.SubtotalPrice();
                totalDiscountStrata1Amount += summary.DiscountStrata1Amount();
                totalDiscountStrata2Amount += summary.DiscountStrata2Amount();
                totalDiscountStrata3Amount += summary.DiscountStrata3Amount();
                totalDiscountStrata4Amount += summary.DiscountStrata4Amount();
                totalDiscountStrata5Amount += summary.DiscountStrata5Amount();
                totalAddDiscountStrataAmount += summary.AddDiscountStrataAmount();
                totalGross += summary.SubtotalGross();
                totalTax += summary.SubtotalTax();
                total += summary.Subtotal();
                totalWeight += summary.SubtotalWeight();
                totalDimension += summary.SubtotalDimension();
                for (var j = 0; j < summary.ChildDetails().length; j++) {
                    var details = summary.ChildDetails()[j];

                    sumQtyOrder += details.QtyOrder();
                }

                if (summary.QtyOrder() != sumQtyOrder) {
                    if (errorMsg == '')
                        errorMsg = 'Following products quantity of Order Details items is not matched: ';
                    else
                        errorMsg += ', ';

                    errorMsg += summary.Product();
                    isValid = false;
                }
            }
        }

        var siteID = Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID();
        if (form.itemOption('Organization').visible)
            siteID = form.getEditor('SiteID').option('value');

        if (isValid) {
            var data = commonPopupEdit.popupEditData();

            data.TransactionDate(form.getEditor('TransactionDate').option('value'));
            data.CustomerID(form.getEditor('CustomerID').option('value'));
            data.SalesmanID(form.getEditor('SalesmanID').option('value'));
            data.WarehouseID(form.getEditor('WarehouseID').option('value'));
            data.TermOfPaymentID(form.getEditor('TermOfPaymentID').option('value'));
            data.ReferenceNumber(form.getEditor('ReferenceNumber').option('value'));

            //data.DocumentStatusReason(documentStatusReason);

            data.PODocumentCode(form.getEditor('PODocumentCode').option('value'));
            data.POTransactionDate(form.getEditor('POTransactionDate').option('value'));

            data.DOShipmentDate(form.getEditor('DOShipmentDate').option('value'));
            data.DOReceivedDate(form.getEditor('DOReceivedDate').option('value'));
            data.DOPrintedCount(form.getEditor('DOPrintedCount').option('value'));
            data.DOLastPrintedDate(form.getEditor('DOLastPrintedDate').option('value'));

            data.RawTotalGrossPrice(rawTotalGrossPrice);
            data.RawTotalPrice(rawTotalPrice);
            data.RawTotalDiscountStrata1Amount(rawTotalDiscountStrata1Amount);
            data.RawTotalDiscountStrata2Amount(rawTotalDiscountStrata2Amount);
            data.RawTotalDiscountStrata3Amount(rawTotalDiscountStrata3Amount);
            data.RawTotalDiscountStrata4Amount(rawTotalDiscountStrata4Amount);
            data.RawTotalDiscountStrata5Amount(rawTotalDiscountStrata5Amount);
            data.RawTotalAddDiscountStrataAmount(rawTotalAddDiscountStrataAmount);
            data.RawTotalGross(rawTotalGross);
            data.RawTotalTax(rawTotalTax);
            data.RawTotal(rawTotal);
            data.TotalGrossPrice(totalGrossPrice);
            data.TotalPrice(totalPrice);
            data.TotalDiscountStrata1Amount(totalDiscountStrata1Amount);
            data.TotalDiscountStrata2Amount(totalDiscountStrata2Amount);
            data.TotalDiscountStrata3Amount(totalDiscountStrata3Amount);
            data.TotalDiscountStrata4Amount(totalDiscountStrata4Amount);
            data.TotalDiscountStrata5Amount(totalDiscountStrata5Amount);
            data.TotalAddDiscountStrataAmount(totalAddDiscountStrataAmount);
            data.TotalGross(totalGross);
            data.TotalTax(totalTax);
            data.Total(total);
            data.TotalWeight(totalWeight);
            data.TotalDimension(totalDimension);

            data.ChildSummaries(summaries);
            var dataJS = ko.toJS(data);

            if (statusID)
                dataJS.DocumentStatusID = statusID;

            if (!dataJS.DocumentStatusID)
                dataJS.DocumentStatusID = 1; // Draft

            dataJS.TransactionDate = DateTimeUtility.getFirstTimeOfDay(dataJS.TransactionDate);

            if (dataJS.POTransactionDate)
                dataJS.POTransactionDate = DateTimeUtility.getFirstTimeOfDay(dataJS.POTransactionDate);

            dataJS.DOShipmentDate = DateTimeUtility.getFirstTimeOfDay(dataJS.DOShipmentDate);
            dataJS.DOReceivedDate = DateTimeUtility.getFirstTimeOfDay(dataJS.DOReceivedDate);

            for (var i = 0; i < dataJS.ChildSummaries.length; i++) {
                var summary = dataJS.ChildSummaries[i];
                summary.DocumentID = dataJS.DocumentID;
                for (var j = 0; j < summary.ChildDetails.length; j++) {
                    var details = summary.ChildDetails[j];

                    details.DocumentID = dataJS.DocumentID;
                    details.Qty = details.QtyOrder * -1;
                }

                summary.Qty = summary.QtyOrder * -1;
            }

            dataSource.store().insert(dataJS)
                .done(function (result) {
                    CommonUtility.documentSuccessMessage(result.DocumentStatusID, function () { });
                    isDataGridRefreshRequired = true;

                    switch (action) {
                        case 1: // Close dialog
                            commonPopupEdit.events.performCancel();
                            hideLoadingPanel();
                            break;
                        case 2: // New entry dialog
                            openEditing(null);
                            hideLoadingPanel();
                            break;
                        case 3: // Reload dialog
                            openSelectedEditing(data.DocumentID(), true);
                            break;
                    }
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

    function printDOEditing(doDocumentID) {
        commonPopupIFrame.popupEdit().option('title', 'Print Delivery Order');
        commonPopupIFrame.popupEditOptions.visible(true);

        var iframe = commonPopupIFrame.iframe();

        commonPopupIFrame.showLoadingPanel();
        iframe.attr('src', Dismoyo_Ciptoning_Client.ReportWebsite.ExtDeliveryOrderReport.url([['DocumentID', '=', doDocumentID]]));
    }

    function addDummyData(e, summaries) {
        if (!isLotNumberEntryRequired) {
            var data = commonPopupEdit.popupEditData();
            var summaryDataGrid = salesOrderSampleSummaryDataGrid();
            var dataSourceItems = [];

            if (!summaries) {
                var store = summaryDataGrid.option('dataSource').store();
                for (var i = 0; i < store._array.length; i++)
                    dataSourceItems.push(new Dismoyo_Ciptoning_Client.vSalesOrderSampleSummaryViewModel(store._array[i]));
            } else {
                for (var i = 0; i < summaries.length; i++)
                    summaries[i].ChildDetails([]);

                dataSourceItems = summaries;
            }

            var details = e.data;

            var productLots = $.grep(dataSource_vStockOnHandAvailable, function (e) {
                return ((e.ProductID() == DXUtility.getValue(details, 'ProductID')) &&
                    (e.ProductLotCode().indexOf('DUMMY') >= 0));
            });

            if (productLots.length > 0) {
                var dummyLot = productLots[0];

                DXUtility.setValue(details, 'ProductLotID', dummyLot.ProductLotID());
                DXUtility.setValue(details, 'ProductLotCode', dummyLot.ProductLotCode());
                DXUtility.setValue(details, 'QtyOnHandGood', dummyLot.QtyOnHandGood());
                DXUtility.setValue(details, 'QtyOnHandHold', dummyLot.QtyOnHandHold());
                DXUtility.setValue(details, 'QtyOnHandBad', dummyLot.QtyOnHandBad());

                for (var i = 0; i < dataSourceItems.length; i++) {
                    if (dataSourceItems[i].ProductID() == DXUtility.getValue(details, 'ProductID')) {
                        var items = $.grep(dataSourceItems[i].ChildDetails(), function (e) {
                            return (e.ProductLotID() == DXUtility.getValue(details, 'ProductLotID'));
                        });

                        if (items.length == 0) {
                            items = [new Dismoyo_Ciptoning_Client.vSalesOrderSampleDetailsViewModel(details)];
                            dataSourceItems[i].ChildDetails().push(items[0]);
                        }

                        var item = items[0];
                        item.QtyConvL(DXUtility.getValue(dataSourceItems[i], 'QtyConvL'));
                        item.QtyConvM(DXUtility.getValue(dataSourceItems[i], 'QtyConvM'));
                        item.QtyConvS(DXUtility.getValue(dataSourceItems[i], 'QtyConvS'));
                        item.QtyOrder(DXUtility.getValue(dataSourceItems[i], 'QtyOrder'));
                        item.QtyOrderConv(DXUtility.getValue(dataSourceItems[i], 'QtyOrderConv'));

                        updateSummariesArrayStore(dataSourceItems[i]);
                    }
                }
            } else {
                DevExpress.ui.dialog.alert('DUMMY Lot Number for the selected product is not available.', 'Save Failed');
            }
        }
    }

    function getProductLotColumns(itemStatusID) {
        var itemStatusName = null;
        switch (itemStatusID) {
            case 1: itemStatusName = 'Good'; break; // Good
            case 2: itemStatusName = 'Hold'; break; // Hold
            case 3: itemStatusName = 'Bad'; break; // Bad
        }

        var qtyOnHandColumn = 'QtyOnHand' + itemStatusName;
        var qtyConvLColumn = 'QtyConvL' + itemStatusName;
        var qtyConvMColumn = 'QtyConvM' + itemStatusName;
        var qtyConvSColumn = 'QtyConvS' + itemStatusName;
        var qtyOrderColumn = 'QtyOrder' + itemStatusName;
        var qtyOrderConvColumn = 'QtyOrderConv' + itemStatusName;

        return {
            itemStatusName: itemStatusName,
            qtyOnHandColumn: qtyOnHandColumn,
            qtyConvLColumn: qtyConvLColumn,
            qtyConvMColumn: qtyConvMColumn,
            qtyConvSColumn: qtyConvSColumn,
            qtyOrderColumn: qtyOrderColumn,
            qtyOrderConvColumn: qtyOrderConvColumn
        }
    }

    function openProductLotEditing(data, itemStatusID) {
        var editData = commonPopupEdit.popupEditData();

        productLotPopupEdit.popupEditData(data);

        productLotPopupEdit.popupEditOptions.editingKey = data.ProductID();
        productLotPopupEdit.popupEditOptions.itemStatusID = itemStatusID;
        productLotPopupEdit.popupEditOptions.visible(true);

        var dataGrid = productLotPopupEdit.dataGrid();
        var form = productLotPopupEdit.form();

        var disabled = false;
        if ((editData.DocumentStatusID() == 2) || (editData.DocumentStatusID() == 3) ||
            (editData.DocumentStatusID() == 4))
            disabled = true;

        var option = productLotPopupEdit.dataGrid().option('editing');
        option.allowUpdating = !disabled;
        option.allowDeleting = !disabled;
        option.editEnabled = !disabled;
        option.removeEnabled = !disabled;
        productLotPopupEdit.dataGrid().option('editing', option);
        productLotPopupEdit.dataGrid().option('selection', { mode: (disabled) ? 'none' : 'multiple' });
        productLotPopupEdit.newRow().option('disabled', disabled);
        productLotPopupEdit.dataGrid().repaint();

        form.getEditor('Product').option('value', data.Product());
        form.getEditor('QtyOnHand').option('value', data.QtyOnHand());
        form.getEditor('QtyOrderConv').option('value', data.QtyOrderConv());

        var conversion = CommonUtility.getConversion(
            data.QtyOrderConv(),
            DXUtility.getValue(data, 'ProductConversionL'),
            DXUtility.getValue(data, 'ProductConversionM'),
            DXUtility.getValue(data, 'ProductConversionS')
        );

        form.getEditor('QtyOrder').option('value', conversion.qtyTransaction);

        data = validateSummaryArrayStore(data);

        var detailsDataSource = CommonUtility.createArrayDataSource(
            'vSalesOrderSampleDetailsViewModel',
            ['ProductID', 'ProductLotID'],
            data.ChildDetails()
        );

        dataGrid.cancelEditData();
        dataGrid.option('dataSource', detailsDataSource);
    }

    function saveProductLotEditing() {
        var data = productLotPopupEdit.popupEditData();
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        if (CommonUtility.validateProductLotEditing(
            data,
            productLotPopupEdit.dataGrid().option('dataSource'),
            productLotPopupEdit.form().getEditor('QtyOrder').option('value'),
            'Order',
            'vSalesOrderSampleDetailsViewModel',
            'QtyConvL',
            'QtyConvM',
            'QtyConvS',
            'QtyOrderConv',
            'QtyOrder',
            false)) {
            updateSummariesArrayStore(data);

            productLotPopupEdit.popupEditOptions.visible(false);
            salesOrderSampleSummaryDataGrid().refresh();
        }
    }

    function downloadProductLot(productLotLoaded) {
        if ((dataSource_vStockOnHandAvailable.length == 0) && (dataSource_vStockOnHandAvailableByProduct.length == 0)) {
            showLoadingPanel();

            var form = commonPopupEdit.form();

            var salesmanID = form.getEditor('SalesmanID').option('value');
            new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vSalesmanProducts,
                select: [
                    'ProductID',
                    'ProductCode',
                    'Product',
                    'ProductUOMLID',
                    'ProductUOMMID',
                    'ProductUOMSID',
                    'ProductConversionL',
                    'ProductConversionM',
                    'ProductConversionS'
                ],
                filter: [
                    ['SalesmanID', '=', salesmanID], 'and',
                    ['ProductName', 'contains', 'SAMPLE']
                ],
                paginate: false,
                map: function (item) { return new Dismoyo_Ciptoning_Client.vSalesmanProductViewModel(item); }
            }).load()
                .done(function (result) {
                    if (result.length > 0) {
                        var productDataSource = result;

                        var warehouseID = form.getEditor('WarehouseID').option('value');
                        var filters = [];
                        var groupFilterExpr = [];

                        for (var i = 0; i < result.length; i++)
                            DXUtility.addFilterExpression(groupFilterExpr, 'ProductID', '=', result[i].ProductID(), 'or');

                        DXUtility.addGroupFilterExpression(filters, groupFilterExpr, 'and');
                        DXUtility.addFilterExpression(filters, 'WarehouseID', '=', warehouseID, 'and');
                        DXUtility.addFilterExpression(filters, 'QtyOnHandGood', '>', 0, 'and');

                        var dataSource = new DevExpress.data.DataSource({
                            store: Dismoyo_Ciptoning_Client.DB.vStockOnHandAvailables,
                            select: [
                                'ProductID',
                                'ProductLotID',
                                'ProductLotCode',
                                'ProductLot',
                                'ProductLotExpiredDate',
                                'QtyOnHandGood'
                            ],
                            filter: filters,
                            sort: ['WarehouseID', 'ProductID', 'ProductLotID'],
                            paginate: false,
                            map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOnHandAvailableViewModel(item); }
                        });

                        dataSource.load()
                            .done(function (result2) {
                                var product = null;
                                var stockOnHandAvailable = [];
                                var stockOnHandAvailableByProduct = [];
                                for (var i = 0; i < result2.length; i++) {
                                    stockOnHandAvailable.push(new Dismoyo_Ciptoning_Client.vStockOnHandAvailableViewModel(result2[i].toJS()));

                                    var j = stockOnHandAvailableByProduct.length - 1;
                                    var productID = result2[i].ProductID();
                                    if ((i == 0) || (stockOnHandAvailableByProduct[j].ProductID() != productID)) {
                                        stockOnHandAvailableByProduct.push(new Dismoyo_Ciptoning_Client.vStockOnHandAllViewModel(result2[i].toJS()));
                                        j++;
                                        product = $.grep(result, function (e) { return (e.ProductID() == productID); });
                                    } else {
                                        stockOnHandAvailableByProduct[j].QtyOnHandGood(stockOnHandAvailableByProduct[j].QtyOnHandGood() +
                                            result2[i].QtyOnHandGood());
                                        stockOnHandAvailableByProduct[j].QtyOnHandHold(stockOnHandAvailableByProduct[j].QtyOnHandHold() +
                                            result2[i].QtyOnHandHold());
                                        stockOnHandAvailableByProduct[j].QtyOnHandBad(stockOnHandAvailableByProduct[j].QtyOnHandBad() +
                                            result2[i].QtyOnHandBad());
                                    }

                                    stockOnHandAvailable[i].ProductCode(product[0].ProductCode());
                                    stockOnHandAvailable[i].Product(product[0].Product());
                                    stockOnHandAvailable[i].ProductUOMLID(product[0].ProductUOMLID());
                                    stockOnHandAvailable[i].ProductUOMMID(product[0].ProductUOMMID());
                                    stockOnHandAvailable[i].ProductUOMSID(product[0].ProductUOMSID());
                                    stockOnHandAvailable[i].ProductConversionL(product[0].ProductConversionL());
                                    stockOnHandAvailable[i].ProductConversionM(product[0].ProductConversionM());
                                    stockOnHandAvailable[i].ProductConversionS(product[0].ProductConversionS());

                                    stockOnHandAvailableByProduct[j].ProductCode(product[0].ProductCode());
                                    stockOnHandAvailableByProduct[j].Product(product[0].Product());
                                    stockOnHandAvailableByProduct[j].ProductUOMLID(product[0].ProductUOMLID());
                                    stockOnHandAvailableByProduct[j].ProductUOMMID(product[0].ProductUOMMID());
                                    stockOnHandAvailableByProduct[j].ProductUOMSID(product[0].ProductUOMSID());
                                    stockOnHandAvailableByProduct[j].ProductConversionL(product[0].ProductConversionL());
                                    stockOnHandAvailableByProduct[j].ProductConversionM(product[0].ProductConversionM());
                                    stockOnHandAvailableByProduct[j].ProductConversionS(product[0].ProductConversionS());
                                }

                                dataSource_vStockOnHandAvailable = stockOnHandAvailable;
                                dataSource_vStockOnHandAvailableByProduct = stockOnHandAvailableByProduct;

                                if (dataSource_vStockOnHandAvailable.length == 0)
                                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(
                                        'Product (Sample) lot stock with item status Good for the selected warehouse is empty.'),
                                        'New Order Details Failed');
                                else
                                    productLotLoaded();

                                hideLoadingPanel();
                            })
                            .fail(function (error) {
                                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download product lot data.'), 'Download Product Lot Failed');
                                hideLoadingPanel();
                            });
                    } else {
                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('The selected Salesman does not have any reference products.'),
                            'New Order Details Failed');
                        hideLoadingPanel();
                    }
                })
                .fail(function (error) {
                    DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download product data.'), 'Download Product Failed');
                    hideLoadingPanel();
                });
        } else
            productLotLoaded();
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
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
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
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
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
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Company', 'Site']);
                }
            }
        }, {
            dataField: 'CompanyID',
            label: { text: 'Company' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCompanyDataSource(null),
                displayExpr: 'Company',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                        ['Company', 'Area', 'Region', 'Territory'],
                        ['Salesman', 'Warehouse']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Sales Order Sample',
        colCount: 3,
        colSpan: 3,
        items: [{
            name: 'DocumentCode',
            dataField: '',
            label: { text: 'Document Number' },
            editorOptions: {
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'TransactionDateFrom',
            label: { text: 'Transaction Date From' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                placeholder: 'mm/dd/yyyy',
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'TransactionDateTo',
            label: { text: 'Transaction Date To' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                placeholder: 'mm/dd/yyyy',
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Salesman',
                        ['Warehouse'],
                        []);
                }
            }
        }, {
            dataField: 'WarehouseID',
            label: { text: 'Warehouse' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupWarehouseDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Warehouse',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    var siteID = null;

                    if (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) {
                        siteID = collapsibleFilter.form().getEditor('SiteID').option('value');
                    } else {
                        siteID = Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID();
                    }

                    var childEditor = collapsibleFilter.form().getEditor('SalesmanID');
                    var childSelectedItem = childEditor.option('selectedItem');
                    if (childSelectedItem && (childSelectedItem['WarehouseID']() != e.value))
                        childEditor.option('value', null);

                    if (siteID == undefined) {
                        childEditor.option('dataSource',
                        DataUtility['GetLookupSalesmanDataSource']((e.value) ?
                            ['WarehouseID', '=', e.value] : null));
                    } else {
                        childEditor.option('dataSource',
                        DataUtility['GetLookupSalesmanDataSource']((e.value) ?
                            [['WarehouseID', '=', e.value], "and",
                            ['SiteID', '=', siteID]] : ['SiteID', '=', siteID]));
                    }
                }
            }
        }, {
            dataField: 'CustomerID',
            label: { text: 'Customer' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: new DevExpress.data.DataSource({
                    store: Dismoyo_Ciptoning_Client.DB.vCustomers,
                    select: ['ID', 'Customer', 'SiteID'],
                    map: function (item) { return new Dismoyo_Ciptoning_Client.vCustomerViewModel(item); },
                    filter: (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                }),
                displayExpr: 'Customer',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'DocumentStatusID',
            label: { text: 'Status' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'DocumentStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
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
            territoryID = form.getEditor('TerritoryID').option('value');
            regionID = form.getEditor('RegionID').option('value');
            areaID = form.getEditor('AreaID').option('value');
            companyID = form.getEditor('CompanyID').option('value');
            siteID = form.getEditor('SiteID').option('value');
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

        // WarehouseID
        value = form.getEditor('WarehouseID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'WarehouseID', '=', value, 'and');

        // DocumentCode
        value = form.getEditor('DocumentCode').option('value');
        DXUtility.addFilterExpression(filterExpr, 'DocumentCode', 'contains', value, 'and');

        // TransactionDateFrom
        value = form.getEditor('TransactionDateFrom').option('value');
        DXUtility.addFilterExpression(filterExpr, 'TransactionDate', '>=', value, 'and');

        // TransactionDateTo
        value = form.getEditor('TransactionDateTo').option('value');
        DXUtility.addFilterExpression(filterExpr, 'TransactionDate', '<=', value, 'and');

        // CustomerID
        value = form.getEditor('CustomerID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'CustomerID', '=', value, 'and');

        // DocumentStatusID
        value = form.getEditor('DocumentStatusID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'DocumentStatusID', '=', value, 'and');

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

    commonGridView.dataGridOptions.editing.editEnabled = false,
    commonGridView.dataGridOptions.editing.removeEnabled = false;
    commonGridView.dataGridOptions.selection.mode = 'single';

    commonGridView.deleteRowsOptions.visible = false;

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('SalesOrderSamples.AddNewSalesOrderSample');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('SalesOrderSamples.EditSalesOrderSample');

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
        dataField: 'DocumentCode', caption: 'Document Number', width: '140px', sortOrder: 'desc',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vSalesOrderSamples_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';

                var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
                if (user.IsHeadOffice()) {
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                }

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
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Created' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Modified' + '</td>';

                if (commonGridView.dataGridOptions.editing.allowUpdating)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        cellTemplate: function (container, options) {
            var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
            var allowUpdating = user.isAuthorized('SalesOrderSamples.EditSalesOrderSample');

            var commands = $('<div class="dx-command-edit" style="text-align: left;">');

            var lbl = $('<b>').text(options.data.DocumentCode());
            if (allowUpdating)
                lbl = $('<a class="dx-link">').text(options.data.DocumentCode()).on('dxclick', function () {
                    openSelectedEditing(options.data.DocumentID(), false);
                });

            commands.append(lbl);
            commands.append('&nbsp;');

            container.append(commands);
        }
    }, {
        dataField: 'TransactionDate', caption: 'Transaction Date', width: '100px',
        customizeText: function (cellInfo) {
            if (cellInfo.value)
                return cellInfo.value.toLocaleDateString();

            return null;
        }
    }, {
        dataField: 'Customer', caption: 'Customer', width: '200px'
    }, {
        dataField: 'Salesman', caption: 'Salesman', width: '200px'
    }, {
        dataField: 'Warehouse', caption: 'Warehouse', width: '200px'
    }, {
        dataField: 'TotalGross', caption: 'Total DPP', width: '100px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 2
    }, {
        dataField: 'TotalTax', caption: 'Total VAT', width: '80px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 2
    }, {
        dataField: 'Total', caption: 'Total', width: '100px', allowEditing: false,
        dataType: 'number', format: 'fixedPoint', precision: 2
    }, {
        dataField: 'ReferenceNumber', caption: 'Reference Number', width: '120px',
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'DocumentStatusName', caption: 'Status', width: '80px',
    }, {
        dataField: 'PostedDate', caption: 'Posted Date', width: '100px',
        customizeText: function (cellInfo) {
            if (cellInfo.value)
                return DateTimeUtility.convertToLocal(cellInfo.value).toLocaleDateString();

            return null;
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
    
    if (commonGridView.dataGridOptions.editing.allowUpdating) {
        commonGridView.dataGridOptions.columns.push({
            width: 100,
            alignment: 'center',
            cellTemplate: function (container, options) {
                var commands = $('<div class="dx-command-edit" style="text-align: center;">');

                commands.append($('<a class="dx-link">').text('Edit').on('dxclick', function () {
                    openSelectedEditing(options.data.DocumentID(), false);
                }));
                commands.append('&nbsp;');

                container.append(commands);
            }
        });
    }





    // ------------------------------------------------------------------------------------------------
    // commonPopupEdit
    // ------------------------------------------------------------------------------------------------
    var commonPopupEdit = new Dismoyo_Ciptoning_Client.CommonPopupEdit();

    commonPopupEdit.okOptions.text = 'Save';
    commonPopupEdit.okOptions.icon = 'icons8-save';

    var salesOrderSampleSummaryDataGrid = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleSummaryDataGrid', 'dxDataGrid'); }
    var salesOrderSampleSummaryForm = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleSummaryForm', 'dxForm'); }

    var salesOrderSamplePrintDO = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSamplePrintDO', 'dxButton'); }
    var salesOrderSamplePost = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSamplePost', 'dxButton'); }
    var salesOrderSampleDiscard = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleDiscard', 'dxButton'); }
    var salesOrderSampleVoid = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleVoid', 'dxButton'); }
    var salesOrderSampleSaveAsDraftAndNew = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleSaveAsDraftAndNew', 'dxButton'); }
    var salesOrderSampleSave = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_ok', 'dxButton'); }

    var salesOrderSampleSummaryNewRow = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleSummaryNewRow', 'dxButton'); }
    var salesOrderSampleSummaryDeleteRows = function () { return DXUtility.getDXInstance(null, '#vSalesOrderSamples_salesOrderSampleSummaryDeleteRows', 'dxButton'); }
    var intrvlSOSample;

    var isEditorEnabledSOSample = function () {
        var dxCommandEdit = $(".dx-command-edit", "[id$=SummaryDataGrid]");
        for (var i = 0; i < dxCommandEdit.length; i++) {
            if ($(dxCommandEdit[i]).text().trim().indexOf("Save") >= 0) {
                return true;
            }
        }
        return false;
    }

    var intrvlHandlerSOSample = function () {
        var disabled = false;
        var newData = true;
        var data = commonPopupEdit.popupEditData();
        if (data.DocumentStatusID()) {
            newData = false;
        }
        if ((data.DocumentStatusID() == 2) || (data.DocumentStatusID() == 3) || (data.DocumentStatusID() == 4)) {
            disabled = true;
        }
        if (!isEditorEnabledSOSample()) {
            if (salesOrderSampleSave() && salesOrderSamplePost() && salesOrderSampleVoid() & salesOrderSampleSaveAsDraftAndNew())
                //asdsadsad
                salesOrderSampleSave().option("disabled", disabled);
            salesOrderSampleSave().option("disabled", disabled);
            salesOrderSamplePost().option("disabled", newData || disabled);
            salesOrderSampleDiscard().option("disabled", newData || disabled);
            salesOrderSampleVoid().option("disabled", (data.DocumentStatusID() != 2));
            salesOrderSampleSaveAsDraftAndNew().option("disabled", disabled);
            clearInterval(intrvlSOSample);
        }
    };

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Order Details'));

        var commands = $('<div class="desktop-commonGridView-commands">');

        var commandSummaryNewRow = $('<div id="vSalesOrderSamples_salesOrderSampleSummaryNewRow">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () {
                var isValid = commonPopupEdit.form().validate().isValid;

                if (isValid) {
                    downloadProductLot(function () {
                        salesOrderSampleSummaryDataGrid().addRow();
                    });
                }
                else
                    DevExpress.ui.dialog.alert('Please specify the required fields.', 'New Order Details Failed');
            }
        });

        var commandSummaryDeleteRows = $('<div id="vSalesOrderSamples_salesOrderSampleSummaryDeleteRows">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            DXUtility.deleteSelectedRows(salesOrderSampleSummaryDataGrid());
                        }
                    });
            }
        });

        commands.append(commandSummaryNewRow);
        commands.append(commandSummaryDeleteRows);

        content.append(commands);

        content.append($('<div id="vSalesOrderSamples_salesOrderSampleSummaryDataGrid">').dxDataGrid({
            dataSource: [],
            showBorders: true,
            paging: { enabled: false },
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            editing: {
                editMode: 'row',
                allowAdding: false,
                allowUpdating: true,
                allowDeleting: true,
            },
            onInitNewRow: function (info) {
                salesOrderSampleSave().option("disabled", true);
                salesOrderSamplePost().option("disabled", true);
                salesOrderSampleDiscard().option("disabled", true);
                salesOrderSampleVoid().option("disabled", true);
                salesOrderSampleSaveAsDraftAndNew().option("disabled", true);

                intrvlSOSample = setInterval(intrvlHandlerSOSample, 500);
                info.data.QtyOrder = 0;
                info.data.QtyOrderConv = '0/0/0';
                info.data.AddDiscountStrataPercentage = 0;
            },
            onEditorPreparing: function (e) {
                if (e.parentType == 'dataRow') {
                    if ((e.row != undefined) && (e.row.rowIndex != undefined))
                        e.component.editRowIndex = e.row.rowIndex;

                    if (e.dataField == 'Product') {
                        if (e.row.inserted) {
                            e.editorElement.dxLookup({
                                dataSource: dataSource_vStockOnHandAvailableByProduct,
                                displayExpr: 'Product',
                                valueExpr: 'Product',
                                searchExpr: 'Product',
                                searchPlaceholder: 'Product',
                                popupWidth: '712px',
                                showPopupTitle: false,
                                fieldEditEnabled: true,
                                value: e.value,
                                onContentReady: function (ea) {
                                    CommonUtility.createProductLookupHeader('vSalesOrderSamples_productIDLookup', ea.element, 1); // Good
                                },
                                itemTemplate: function (data, index, element) {
                                    return CommonUtility.createProductLookupItem(data, element, 1); // Good
                                },
                                onValueChanged: function (ea) {
                                    if (ea.value) {
                                        var item = this.option('selectedItem');
                                        if (item) {
                                            e.component.cellValue(e.row.rowIndex, 'QtyOnHand', item.QtyOnHand());

                                            DXUtility.setValue(e.row.data, 'ProductID', item.ProductID());
                                            DXUtility.setValue(e.row.data, 'ProductCode', item.ProductCode());
                                            DXUtility.setValue(e.row.data, 'Product', item.Product());
                                            DXUtility.setValue(e.row.data, 'ProductUOMLID', item.ProductUOMLID());
                                            DXUtility.setValue(e.row.data, 'ProductUOMMID', item.ProductUOMMID());
                                            DXUtility.setValue(e.row.data, 'ProductUOMSID', item.ProductUOMSID());
                                            DXUtility.setValue(e.row.data, 'ProductConversionL', item.ProductConversionL());
                                            DXUtility.setValue(e.row.data, 'ProductConversionM', item.ProductConversionM());
                                            DXUtility.setValue(e.row.data, 'ProductConversionS', item.ProductConversionS());

                                            var conversion = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyOrderConv'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            DXUtility.setValue(e.row.data, 'QtyOrder', conversion.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvL', conversion.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvM', conversion.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvS', conversion.qtyConvS);

                                            calcProductPriceAndDiscount(e);
                                        }
                                    }

                                    e.component.cellValue(e.row.rowIndex, 'Product', ea.value);
                                    e.setValue(ea.value);
                                }
                            });
                        } else {
                            downloadProductLot(function () { });
                            e.allowEditing = false;
                            e.editorElement.append($('<td style="padding: 5px;">').text(e.row.data.Product()));
                        }

                        e.cancel = true;
                    } else if (e.dataField == 'PriceDate') {
                        e.editorElement.dxDateBox({
                            showClearButton: true,
                            placeholder: 'Transaction Date',
                            value: e.value,
                            onValueChanged: function (ea) {
                                ea.component.option('value', ea.value);
                                e.setValue(ea.value);

                                calcProductPriceAndDiscount(e);
                            }
                        });

                        e.cancel = true;
                    } else if (e.dataField == 'QtyOrderConv') {
                        var valueBefore = '';
                        e.editorElement.dxTextBox({
                            value: e.value,
                            onFocusIn: function (e) { DXUtility.selectAllText(e.element, 'dxTextBox'); },
                            //onKeyDown: DXUtility.preventInputCharacters,
                            onKeyDown: function (ea) {
                                if ((ea.jQueryEvent.keyCode > 47 && ea.jQueryEvent.keyCode <= 57) || ea.jQueryEvent.keyCode == 191 || (ea.jQueryEvent.keyCode > 95 && ea.jQueryEvent.keyCode <= 105)) {
                                    valueBefore = ea.jQueryEvent.target.value;
                                } else if (ea.jQueryEvent.keyCode != 8 && ea.jQueryEvent.keyCode != 46 && ea.jQueryEvent.keyCode != 13 && ea.jQueryEvent.keyCode != 9) {
                                    ea.jQueryEvent.preventDefault();
                                }
                            },
                            onKeyUp: function (ea) {
                                if (/(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)/.test(ea.jQueryEvent.target.value)) {
                                    // do nothing
                                } else if (ea.jQueryEvent.keyCode != 8 && ea.jQueryEvent.keyCode != 46 && ea.jQueryEvent.keyCode != 13 && ea.jQueryEvent.keyCode != 9) {
                                    ea.jQueryEvent.target.value = valueBefore;
                                }
                            },
                            onEnterKey: function (ea) {
                                salesOrderSampleSummaryDataGrid().saveEditData();
                            },
                            onValueChanged: function (ea) {
                                var conversion = CommonUtility.getConversion(
                                    (ea.value) ? ea.value : '0/0/0',
                                    DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionS')
                                );

                                DXUtility.setValue(e.row.data, 'QtyOrder', conversion.qtyTransaction);
                                DXUtility.setValue(e.row.data, 'QtyConvL', conversion.qtyConvL);
                                DXUtility.setValue(e.row.data, 'QtyConvM', conversion.qtyConvM);
                                DXUtility.setValue(e.row.data, 'QtyConvS', conversion.qtyConvS);

                                ea.value = conversion.qtyTransactionConv;
                                ea.component.option('value', ea.value);
                                e.setValue(ea.value);

                                calcProductPriceAndDiscount(e);
                            }
                        });

                        e.cancel = true;
                    } else if (e.dataField == 'AddDiscountStrataPercentage') {
                        var valueBefore = '';
                        e.editorElement.dxTextBox({
                            value: e.value,
                            onFocusIn: function (e) { DXUtility.selectAllText(e.element, 'dxTextBox'); },
                            // Added by Andhika 2016.03.17 Fixing Additional Discount Decimal Input ------------------
                            onKeyDown: function (ea) {
                                if ((ea.jQueryEvent.keyCode > 47 && ea.jQueryEvent.keyCode <= 57) || ea.jQueryEvent.keyCode == 190 || ea.jQueryEvent.keyCode == 191 || (ea.jQueryEvent.keyCode > 95 && ea.jQueryEvent.keyCode <= 105)) {
                                    valueBefore = ea.jQueryEvent.target.value;
                                } else if (ea.jQueryEvent.keyCode != 8 && ea.jQueryEvent.keyCode != 46 && ea.jQueryEvent.keyCode != 13 && ea.jQueryEvent.keyCode != 9) {
                                    ea.jQueryEvent.preventDefault();
                                }
                            },
                            //----------------------------------------------------------------------------------------
                            onValueChanged: function (ea) {
                                if ((ea.value == null) || (ea.value == ''))
                                    ea.value = 0;

                                ea.component.option('value', ea.value);
                                e.setValue(ea.value);

                                calcProductPriceAndDiscount(e);
                            }
                        });

                        e.cancel = true;
                    }
                }
            },
            onRowInserted: function (info) {
                CommonUtility.validateDataGridInsertedTransactionSummary(
                    info.component,
                    new Dismoyo_Ciptoning_Client.vSalesOrderSampleSummaryViewModel(info.data).toJS()
                );

                addDummyData(info);
                CommonUtility.updateSalesOrderSummaryForm(salesOrderSampleSummaryForm(), info.component);
                salesOrderSampleSummaryDataGrid().clearSelection();
            },
            onRowUpdated: function (info) {
                info.data.ProductID = info.key.ProductID;
                addDummyData(info);
                CommonUtility.updateSalesOrderSummaryForm(salesOrderSampleSummaryForm(), info.component);
                salesOrderSampleSummaryDataGrid().clearSelection();
            },
            onRowRemoved: function (info) {
                CommonUtility.validateDataGridRemovedTransactionSummary(
                    info.component,
                    info.data.toJS()
                );

                CommonUtility.updateSalesOrderSummaryForm(salesOrderSampleSummaryForm(), info.component);
            },
            onEditingStart: function (info) {
                salesOrderSampleSave().option('disabled', true);
                salesOrderSamplePost().option('disabled', true);
                salesOrderSampleDiscard().option('disabled', true);
                salesOrderSampleVoid().option('disabled', true);
                salesOrderSampleSaveAsDraftAndNew().option('disabled', true);
                intrvlSOSample = setInterval(intrvlHandlerSOSample, 500);
            },
            onRowUpdating: function (info) {
                if (info.newData.QtyOrderConv) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyOrderConv,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvL = conversion.qtyConvL;
                    info.newData.QtyConvM = conversion.qtyConvM;
                    info.newData.QtyConvS = conversion.qtyConvS;
                    info.newData.QtyOrder = conversion.qtyTransaction;
                }

                info.newData.SubtotalWeight = DXUtility.getValue(info.oldData, 'SubtotalWeight');
                info.newData.SubtotalDimension = DXUtility.getValue(info.oldData, 'SubtotalDimension');
                info.newData.UnitGrossPrice = DXUtility.getValue(info.oldData, 'UnitGrossPrice');

                info.newData.RawSubtotalGrossPrice = DXUtility.getValue(info.oldData, 'RawSubtotalGrossPrice');
                info.newData.RawSubtotalPrice = DXUtility.getValue(info.oldData, 'RawSubtotalPrice');
                info.newData.RawDiscountStrata1Amount = DXUtility.getValue(info.oldData, 'RawDiscountStrata1Amount');
                info.newData.RawDiscountStrata2Amount = DXUtility.getValue(info.oldData, 'RawDiscountStrata2Amount');
                info.newData.RawDiscountStrata3Amount = DXUtility.getValue(info.oldData, 'RawDiscountStrata3Amount');
                info.newData.RawDiscountStrata4Amount = DXUtility.getValue(info.oldData, 'RawDiscountStrata4Amount');
                info.newData.RawDiscountStrata5Amount = DXUtility.getValue(info.oldData, 'RawDiscountStrata5Amount');
                info.newData.RawAddDiscountStrataAmount = DXUtility.getValue(info.oldData, 'RawAddDiscountStrataAmount');
                info.newData.RawSubtotalDiscountStrata1 = DXUtility.getValue(info.oldData, 'RawSubtotalDiscountStrata1');
                info.newData.RawSubtotalDiscountStrata2 = DXUtility.getValue(info.oldData, 'RawSubtotalDiscountStrata2');
                info.newData.RawSubtotalDiscountStrata3 = DXUtility.getValue(info.oldData, 'RawSubtotalDiscountStrata3');
                info.newData.RawSubtotalDiscountStrata4 = DXUtility.getValue(info.oldData, 'RawSubtotalDiscountStrata4');
                info.newData.RawSubtotalDiscountStrata5 = DXUtility.getValue(info.oldData, 'RawSubtotalDiscountStrata5');
                info.newData.RawSubtotalGross = DXUtility.getValue(info.oldData, 'RawSubtotalGross');
                info.newData.RawSubtotal = DXUtility.getValue(info.oldData, 'RawSubtotal');

                info.newData.SubtotalDiscountStrata1 = DXUtility.getValue(info.oldData, 'SubtotalDiscountStrata1');
                info.newData.SubtotalDiscountStrata2 = DXUtility.getValue(info.oldData, 'SubtotalDiscountStrata2');
                info.newData.SubtotalDiscountStrata3 = DXUtility.getValue(info.oldData, 'SubtotalDiscountStrata3');
                info.newData.SubtotalDiscountStrata4 = DXUtility.getValue(info.oldData, 'SubtotalDiscountStrata4');
                info.newData.SubtotalDiscountStrata5 = DXUtility.getValue(info.oldData, 'SubtotalDiscountStrata5');
                info.newData.TaxPercentage = DXUtility.getValue(info.oldData, 'TaxPercentage');
                info.newData.SubtotalGrossPrice = DXUtility.getValue(info.oldData, 'SubtotalGrossPrice');
                info.newData.SubtotalPrice = DXUtility.getValue(info.oldData, 'SubtotalPrice');

                info.newData.UnitPrice = info.component.cellValue(info.component.editRowIndex, 'UnitPrice');

                //info.newData.DiscountStrata1Percentage = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata1Percentage');
                //info.newData.DiscountStrata1Amount = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata1Amount');

                //info.newData.DiscountStrata2Percentage = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata2Percentage');
                //info.newData.DiscountStrata2Amount = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata2Amount');

                //info.newData.DiscountStrata3Percentage = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata3Percentage');
                //info.newData.DiscountStrata3Amount = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata3Amount');

                //info.newData.DiscountStrata4Percentage = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata4Percentage');
                //info.newData.DiscountStrata4Amount = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata4Amount');

                //info.newData.DiscountStrata5Percentage = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata5Percentage');
                //info.newData.DiscountStrata5Amount = info.component.cellValue(info.component.editRowIndex, 'DiscountStrata5Amount');

                info.newData.DiscountStrata1Percentage = DXUtility.getValue(info.oldData, 'DiscountStrata1Percentage');
                info.newData.DiscountStrata1Amount = DXUtility.getValue(info.oldData, 'DiscountStrata1Amount');

                info.newData.DiscountStrata2Percentage = DXUtility.getValue(info.oldData, 'DiscountStrata2Percentage');
                info.newData.DiscountStrata2Amount = DXUtility.getValue(info.oldData, 'DiscountStrata2Amount');

                info.newData.DiscountStrata3Percentage = DXUtility.getValue(info.oldData, 'DiscountStrata3Percentage');
                info.newData.DiscountStrata3Amount = DXUtility.getValue(info.oldData, 'DiscountStrata3Amount');

                info.newData.DiscountStrata4Percentage = DXUtility.getValue(info.oldData, 'DiscountStrata4Percentage');
                info.newData.DiscountStrata4Amount = DXUtility.getValue(info.oldData, 'DiscountStrata4Amount');

                info.newData.DiscountStrata5Percentage = DXUtility.getValue(info.oldData, 'DiscountStrata5Percentage');
                info.newData.DiscountStrata5Amount = DXUtility.getValue(info.oldData, 'DiscountStrata5Amount');


                info.newData.AddDiscountStrataAmount = info.component.cellValue(info.component.editRowIndex, 'AddDiscountStrataAmount');

                info.newData.SubtotalGross = info.component.cellValue(info.component.editRowIndex, 'SubtotalGross');
                info.newData.SubtotalTax = info.component.cellValue(info.component.editRowIndex, 'SubtotalTax');
                info.newData.Subtotal = info.component.cellValue(info.component.editRowIndex, 'Subtotal');

                updateDeferSummariesArrayStore(info.oldData.ProductID(), info.newData);
            },
            onRowValidating: function (e) {
                var qtyOnHand = DXUtility.getValue(e.newData, 'QtyOnHand');
                if (qtyOnHand == undefined)
                    qtyOnHand = DXUtility.getValue(e.oldData, 'QtyOnHand');

                var qtyOrder = DXUtility.getValue(e.newData, 'QtyOrder');
                if (qtyOrder == undefined)
                    qtyOrder = DXUtility.getValue(e.oldData, 'QtyOrder');
                
                if (qtyOrder <= 0) {
                    e.errorText = 'Order Qty must be greater than 0.';
                    e.isValid = false;
                }

                if (e.isValid && (qtyOrder > qtyOnHand)) {
                    e.errorText = 'Order Qty must be less than or equal to On Hand Qty.';
                    e.isValid = false;
                }

                if (e.errorText)
                    CommonUtility.hideErrorMessageOnDataGrid();
            },
            onDataErrorOccurred: function (e) {
                var errorValue = e.component._controllers.editing._editData[0].data.Product;
                switch (e.error.__id) {
                    case 'E4008':
                        e.error.message = 'Product \'' + errorValue + '\' is already exist.';
                        break;
                }

                CommonUtility.hideErrorMessageOnDataGrid();
            },
            columns: [{
                dataField: 'DocumentID', visible: false
            }, {
                dataField: 'ProductID', visible: false
            }, {
                dataField: 'Product', caption: 'Product', // width: '250px',
                validationRules: [{ type: 'required' }],
                headerCellTemplate: function (columnHeader, headerInfo) {
                    var dataGrid = $(salesOrderSampleSummaryDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var isEditable = (salesOrderSampleSummaryDataGrid().option('selection').mode == 'none') ? false : true;

                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        //tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Disc 1' + '</td>';
                        //tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Disc 2' + '</td>';
                        //tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Disc 3' + '</td>';
                        //tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Disc 4' + '</td>';
                        //tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Disc 5' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colSpan="1">' + 'Disc 1-5' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colSpan="2">' + 'Additional Disc' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';
                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;">' + '' + '</td>';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '</tr>'

                        var table = dataGrid.find('.dx-header-row:first-child');
                        $(tr).insertBefore(table[0].parentElement);
                        $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
                    }
                }
            }, {
                dataField: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '120px', allowEditing: false,
                dataType: 'number'
            }, {
                dataField: 'PriceDate', caption: 'Price Date', width: '140px',
                dataType: 'date'
            }, {
                dataField: 'UnitPrice', caption: 'Unit Price', width: '80px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2,
            }, {
                dataField: 'QtyOrderConv', caption: 'Qty (L/M/S)', width: '100px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyOrderConv', 1)); // Good
                }
            },
            //{
            //    dataField: 'DiscountStrata1Percentage', caption: '%', width: '40px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata1Amount', caption: 'Amount', width: '80px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata2Percentage', caption: '%', width: '40px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata2Amount', caption: 'Amount', width: '80px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata3Percentage', caption: '%', width: '40px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata3Amount', caption: 'Amount', width: '80px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata4Percentage', caption: '%', width: '40px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata4Amount', caption: 'Amount', width: '80px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata5Percentage', caption: '%', width: '40px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //}, {
            //    dataField: 'DiscountStrata5Amount', caption: 'Amount', width: '80px', allowEditing: false,
            //    dataType: 'number', format: 'fixedPoint', precision: 2
            //},
            {
                dataField: 'DiscountStrataDefaultAmount', caption: 'Amount', width: '80px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2,
                calculateCellValue: function (data) {
                    var discountStrata1Amount = DXUtility.getValue(data, 'DiscountStrata1Amount');
                    var discountStrata2Amount = DXUtility.getValue(data, 'DiscountStrata2Amount');
                    var discountStrata3Amount = DXUtility.getValue(data, 'DiscountStrata3Amount');
                    var discountStrata4Amount = DXUtility.getValue(data, 'DiscountStrata4Amount');
                    var discountStrata5Amount = DXUtility.getValue(data, 'DiscountStrata5Amount');

                    if (isNaN(discountStrata1Amount)) discountStrata1Amount = 0;
                    if (isNaN(discountStrata2Amount)) discountStrata2Amount = 0;
                    if (isNaN(discountStrata3Amount)) discountStrata3Amount = 0;
                    if (isNaN(discountStrata4Amount)) discountStrata4Amount = 0;
                    if (isNaN(discountStrata5Amount)) discountStrata5Amount = 0;

                    return discountStrata1Amount + discountStrata2Amount + discountStrata3Amount +
                        discountStrata4Amount + discountStrata5Amount;
                }
            }, {
                dataField: 'AddDiscountStrataPercentage', caption: '%', width: '40px',
                dataType: 'number', format: 'fixedPoint', precision: 2
            }, {
                dataField: 'AddDiscountStrataAmount', caption: 'Amount', width: '80px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }, {
                dataField: 'SubtotalGross', caption: 'DPP', width: '100px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }, {
                dataField: 'SubtotalTax', caption: 'VAT', width: '80px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }, {
                dataField: 'Subtotal', caption: 'Subtotal', width: '100px', allowEditing: false,
                dataType: 'number', format: 'fixedPoint', precision: 2
            }]
        }));

        content.append($('<div id="vSalesOrderSamples_salesOrderSampleSummaryForm" style="margin-top: 9px;">').dxForm({
            deferRendering: false,
            colCount: 4,
            showColonAfterLabel: false,
            labelLocation: 'left',
            alignItemLabels: true,
            items: [{
                itemType: 'empty',
                colSpan: 3
            }, {
                dataField: 'TotalGross',
                label: { text: 'Total DPP' },
                colSpan: 1,
                cssClass: 'salesOrderSummaryForm-item-label salesOrderSummaryForm-item-textInput',
                editorOptions: {
                    readOnly: true
                }
            }, {
                itemType: 'empty',
                colSpan: 2
            },
            //{
            //    dataField: 'DocumentStatusReason',
            //    label: { location: 'top', text: 'Reason for changing Price Date/Additional Disc' },
            //    colSpan: 2,
            //    editorOptions: {
            //        maxLength: 200,
            //        onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            //    }
            //},
            {
                itemType: 'empty',
                colSpan: 1
            }, {
                dataField: 'TotalTax',
                label: { text: 'Total VAT' },
                colSpan: 1,
                cssClass: 'salesOrderSummaryForm-item-label salesOrderSummaryForm-item-textInput',
                editorOptions: {
                    readOnly: true
                }
            }, {
                itemType: 'empty',
                colSpan: 3
            }, {
                dataField: 'Total',
                label: { text: 'Total' },
                colSpan: 1,
                cssClass: 'salesOrderSummaryForm-item-label salesOrderSummaryForm-item-textInput',
                editorOptions: {
                    readOnly: true
                }
            }]
        }));

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPrintDO = $('<div id="vSalesOrderSamples_salesOrderSamplePrintDO" style="margin-right: 32px;">').dxButton({
            text: 'Print DO', icon: 'icons8-print',
            onClick: function () { commonPopupEdit.events.performPrintDO(this); }
        });

        var commandPost = $('<div id="vSalesOrderSamples_salesOrderSamplePost">').dxButton({
            text: 'Post', icon: 'icons8-check-green',
            onClick: function () { commonPopupEdit.events.performPost(this); }
        });

        var commandDiscard = $('<div id="vSalesOrderSamples_salesOrderSampleDiscard">').dxButton({
            text: 'Discard', icon: 'icons8-trash-red',
            onClick: function () { commonPopupEdit.events.performDiscard(this); }
        });

        var commandVoid = $('<div id="vSalesOrderSamples_salesOrderSampleVoid" style="margin-right: 16px;">').dxButton({
            text: 'Void', icon: 'icons8-delete-red',
            onClick: function () { commonPopupEdit.events.performVoid(this); }
        });

        var commandSaveAsDraftAndNew = $('<div id="vSalesOrderSamples_salesOrderSampleSaveAsDraftAndNew">').dxButton({
            text: 'Save & New', icon: 'icons8-save',
            onClick: function () { commonPopupEdit.events.performSaveAsDraftAndNew(this); }
        });

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
        extCommands.append(commandPrintDO);
        extCommands.append(commandPost);
        extCommands.append(commandDiscard);
        extCommands.append(commandVoid);
        extCommands.append(commandSaveAsDraftAndNew);
    };

    commonGridView.events.performNewRow = function (rootView) {
        openEditing(null);
    };

    commonPopupEdit.events.performOK = function (rootView) {
        saveEditing(null, 3); // Save with no status changes and Reload data
    };

    commonPopupEdit.events.performPrintDO = function (rootView) {
        var data = commonPopupEdit.popupEditData();

        printDOEditing(data.DODocumentID());
    };

    commonPopupEdit.events.performPost = function (rootView) {
        DevExpress.ui.dialog.confirm('Are you sure want to Post this transaction?', 'Post Confirmation').done(function (dialogResult) {
            if (dialogResult)
                saveEditing(2, 3); // Post and Reload data
        });
    };

    commonPopupEdit.events.performDiscard = function (rootView) {
        DevExpress.ui.dialog.confirm('Are you sure want to Discard this transaction?', 'Discard Confirmation').done(function (dialogResult) {
            if (dialogResult)
                saveEditing(3, 3); // Discard and Reload data
        });
    };

    commonPopupEdit.events.performVoid = function (rootView) {
        DevExpress.ui.dialog.confirm('Are you sure want to Void this transaction?', 'Void Confirmation').done(function (dialogResult) {
            if (dialogResult)
                saveEditing(4, 3); // Void and Reload data
        });
    };

    commonPopupEdit.events.performSaveAsDraftAndNew = function (rootView) {
        saveEditing(1, 2); // Save as Draft and Reload data
    };

    commonPopupEdit.events.performCancel = function (rootView) {
        commonPopupEdit.popupEditOptions.visible(false);

        if (isDataGridRefreshRequired) {
            commonGridView.dataGrid().refresh();
            isDataGridRefreshRequired = false;
        }
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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
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
                searchExpr: ['Code', 'Name'],
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    var form = commonPopupEdit.form();

                    CommonUtility.cascadeValueChanged(form, e.selectedItem, e.value, 'Site',
                       ['Area', 'Region', 'Territory'],
                       []);

                    var preDocumentCode = '';
                    var preDODocumentCode = '';

                    if (e.selectedItem) {
                        preDocumentCode = previewDocumentCode(e.selectedItem.Code());
                        preDODocumentCode = previewDODocumentCode(e.selectedItem.Code());
                        form.getEditor('Company').option('value', e.selectedItem.Company());
                    } else if (e.previousValue != null)
                        form.getEditor('Company').option('value', null);

                    updateSiteChildEditor(form, e.value);

                    form.getEditor('DocumentCode').option('value', preDocumentCode);
                    form.getEditor('DODocumentCode').option('value', preDODocumentCode);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Sales Order Sample',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'DocumentCode',
            label: { text: 'Document Number' },
            colSpan: 3,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'TransactionDate',
            label: { text: 'Transaction Date' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (data) {
                    var form = commonPopupEdit.form();

                    form.getEditor('DOShipmentDate').option('min', data.value);
                }
            }
        }, {
            dataField: 'DocumentStatusID',
            label: { text: 'Status' },
            colSpan: 1,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSystemLookupDataSource(['Group', '=', 'DocumentStatus']),
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                placeholder: 'NEW',
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'CustomerID',
            label: { text: 'Customer' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxLookup',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Customer',
                valueExpr: 'ID',
                searchExpr: [
                    'Code',
                    'Name',
                    'Address1',
                    'Address2',
                    'Address3'
                ],
                searchPlaceholder: 'Customer/Address',
                searchEnabled: false,
                popupWidth: '1082px',
                showPopupTitle: false,
                fieldEditEnabled: true,
                onOpened: function (e) { },
                onClosed: function (e) { },
                onContentReady: function (e) {
                    var form = commonPopupEdit.form();
                    var user = Dismoyo_Ciptoning_Client.app.CurrentUser;

                    CommonUtility.createCustomerLookupHeader('vSalesOrderSamples_customerIDLookup', e.element,
                        getValueFromSystemParameter('Customer.Category1'),
                        user.SiteID(), form);
                },
                itemTemplate: function (data, index, element) {
                    return CommonUtility.createCustomerLookupItem(data, element);
                },
                onValueChanged: function (e) {
                    if (e.value) {
                        var item = e.selectedItem;
                        if (item) {
                            var data = commonPopupEdit.popupEditData();
                            var form = commonPopupEdit.form();
                            var salesmanID = null;
                            var warehouseID = null;
                            var termOfPaymentID = null;

                            dataSource_vSelectedProductPrices = undefined;
                            dataSource_vSelectedDiscountGroup = undefined;

                            data.PriceGroupID(undefined);
                            data.DiscountGroupID(undefined);
                            if (item) {
                                salesmanID = item.SalesmanID();
                                warehouseID = item.WarehouseID();
                                termOfPaymentID = item.TermOfPaymentID();
                                dataSource_vSelectedProductPrices = Dismoyo_Ciptoning_Client.LocalStore.vProductPrices.dataByFilter(
                                    ['PriceGroupID', '=', item.PriceGroupID()]);

                                dataSource_vSelectedDiscountGroup =
                                    Dismoyo_Ciptoning_Client.LocalStore.vDiscountGroups.expandedDataByKey(item.DiscountGroupID());

                                data.PriceGroupID(item.PriceGroupID());
                                data.DiscountGroupID(item.DiscountGroupID());
                            }

                            e.component.option('value', e.value);
                            form.getEditor('SalesmanID').option('value', salesmanID);
                            form.getEditor('WarehouseID').option('value', warehouseID);

                            updateTermOfPaymentEditor(form, termOfPaymentID);
                        }
                    }
                }
            }
        }, {
            itemType: 'empty',
            colSpan: 3
        }, {
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    dataSource_vStockOnHandAvailable = [];
                    dataSource_vStockOnHandAvailableByProduct = [];

                    if (e.value) {
                        var data = commonPopupEdit.popupEditData();

                        salesOrderSampleSummaryDataGrid().cancelEditData();
                        data.ChildSummaries([]);
                        salesOrderSampleSummaryDataGrid().option('dataSource',
                            createSummaryDataSource(data.ChildSummaries()));
                    } else
                        salesOrderSampleSummaryDataGrid().endCustomLoading();

                    var form = commonPopupEdit.form();
                    var warehouseID = null;

                    if (e.selectedItem) {
                        warehouseID = e.selectedItem.WarehouseID();
                    }

                    form.getEditor('WarehouseID').option('value', warehouseID);
                }
            }
        }, {
            dataField: 'WarehouseID',
            label: { text: 'Warehouse' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupWarehouseDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Warehouse',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '',
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    dataSource_vStockOnHandAvailable = [];
                    dataSource_vStockOnHandAvailableByProduct = [];

                    if (e.value) {
                        var data = commonPopupEdit.popupEditData();

                        var summaryDataGrid = salesOrderSampleSummaryDataGrid();
                        summaryDataGrid.cancelEditData();

                        data.ChildSummaries([]);
                        summaryDataGrid.option('dataSource',
                            createSummaryDataSource(data.ChildSummaries()));
                    }
                }
            }
        }, {
            itemType: 'empty',
            colSpan: 1
        }, {
            dataField: 'TermOfPaymentID',
            validationRules: [{ type: 'required' }],
            label: { text: 'Term of Payment' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Name',
                valueExpr: 'Value_Int32',
                searchEnabled: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'ReferenceNumber',
            label: { text: 'Reference Number' },
            colSpan: 3,
            editorOptions: {
                maxLength: 30,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 1
        }]
    }, {
        itemType: 'group',
        caption: 'Purchase Order',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'PODocumentCode',
            label: { text: 'Document Number' },
            //validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorOptions: {
                maxLength: 30,
                onEnterKey: function () { commSonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'POTransactionDate',
            label: { text: 'Transaction Date' },
            //validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (data) {
                    var form = commonPopupEdit.form();

                    //form.getEditor('DOShipmentDate').option('min', data.value);
                }
            }
        }, {
            itemType: 'empty'
        }]
    }, {
        itemType: 'group',
        caption: 'Delivery Order',
        colCount: 6,
        colSpan: 3,
        items: [{
            dataField: 'DODocumentCode',
            label: { text: 'Document Number' },
            colSpan: 3,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commSonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'DOShipmentDate',
            label: { text: 'Shipment Date' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (data) {
                    var form = commonPopupEdit.form();

                    form.getEditor('DOReceivedDate').option('min', data.value);
                }
            }
        }, {
            itemType: 'empty'
        }, {
            dataField: 'DOPrintedCount',
            label: { text: 'Printed Count' },
            colSpan: 1,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'DOLastPrintedDate',
            label: { text: 'Last Printed Date' },
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'DOReceivedDate',
            label: { text: 'Received Date' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }]
    }];





    // ------------------------------------------------------------------------------------------------
    // commonPopupIFrame
    // ------------------------------------------------------------------------------------------------
    var commonPopupIFrame = new Dismoyo_Ciptoning_Client.CommonPopupIFrame();

    commonPopupIFrame.okOptions.visible = false;

    commonPopupIFrame.cancelOptions.text = 'Close';





    // ------------------------------------------------------------------------------------------------
    // productLotPopupEdit
    // ------------------------------------------------------------------------------------------------
    var productLotPopupEdit = new Dismoyo_Ciptoning_Client.ProductLotPopupEdit();
    productLotPopupEdit.formOptions.colCount = 4;

    productLotPopupEdit.saveOptions.icon = 'icons8-save';

    productLotPopupEdit.events.performSave = function () {
        saveProductLotEditing();
    };

    productLotPopupEdit.dataGridOptions.onInitNewRow = function (info) {
        info.data.QtyOrder = 0;
        info.data.QtyOrderConv = '0/0/0';
    };

    productLotPopupEdit.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow') {
            if (e.dataField == 'ProductLotCode') {
                if (e.row.inserted) {
                    var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
                    var productLotColumns = getProductLotColumns(itemStatusID);

                    e.editorElement.dxLookup({
                        dataSource: new DevExpress.data.DataSource({
                            store: dataSource_vStockOnHandAvailable,
                            filter: [
                                ['ProductID', '=', productLotPopupEdit.popupEditData().ProductID()], 'and',
                                [productLotColumns.qtyOnHandColumn, '>', 0]
                            ],
                            sort: [{ getter: 'ProductLotExpiredDate', desc: true }]
                        }),
                        displayExpr: 'ProductLotCode',
                        valueExpr: 'ProductLotCode',
                        searchExpr: 'ProductLotCode',
                        searchPlaceholder: 'Lot Number',
                        popupWidth: '582px',
                        showPopupTitle: false,
                        fieldEditEnabled: true,
                        value: e.value,
                        onContentReady: function (ea) {
                            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;

                            CommonUtility.createProductLotLookupHeader('vSalesOrderSamples_productLotIDLookup', ea.element, itemStatusID);
                        },
                        itemTemplate: function (data, index, element) {
                            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
                            var productLotColumns = getProductLotColumns(itemStatusID);

                            return CommonUtility.createProductLotLookupItem(data, element, productLotColumns.qtyOnHandColumn);
                        },
                        onValueChanged: function (ea) {
                            if (ea.value) {
                                var item = this.option('selectedItem');
                                if (item) {
                                    var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
                                    var productLotColumns = getProductLotColumns(itemStatusID);

                                    e.component.cellValue(e.row.rowIndex, 'QtyOnHand', item[productLotColumns.qtyOnHandColumn]());

                                    DXUtility.setValue(e.row.data, 'QtyOnHand', item[productLotColumns.qtyOnHandColumn]());

                                    DXUtility.setValue(e.row.data, 'ProductID', item.ProductID());
                                    DXUtility.setValue(e.row.data, 'ProductLotID', item.ProductLotID());
                                    DXUtility.setValue(e.row.data, 'ProductCode', item.ProductCode());
                                    DXUtility.setValue(e.row.data, 'Product', item.Product());
                                    DXUtility.setValue(e.row.data, 'ProductLotCode', item.ProductLotCode());
                                    DXUtility.setValue(e.row.data, 'ProductUOMLID', item.ProductUOMLID());
                                    DXUtility.setValue(e.row.data, 'ProductUOMMID', item.ProductUOMMID());
                                    DXUtility.setValue(e.row.data, 'ProductUOMSID', item.ProductUOMSID());
                                    DXUtility.setValue(e.row.data, 'ProductConversionL', item.ProductConversionL());
                                    DXUtility.setValue(e.row.data, 'ProductConversionM', item.ProductConversionM());
                                    DXUtility.setValue(e.row.data, 'ProductConversionS', item.ProductConversionS());

                                    var conversion = CommonUtility.getConversion(
                                        e.component.cellValue(e.row.rowIndex, 'QtyOrderConv'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionS')
                                    );

                                    DXUtility.setValue(e.row.data, 'QtyOrder', conversion.qtyTransaction);
                                    DXUtility.setValue(e.row.data, 'QtyConvL', conversion.qtyConvL);
                                    DXUtility.setValue(e.row.data, 'QtyConvM', conversion.qtyConvM);
                                    DXUtility.setValue(e.row.data, 'QtyConvS', conversion.qtyConvS);
                                };
                            }

                            e.component.cellValue(e.row.rowIndex, 'ProductLotCode', ea.value);
                            e.setValue(ea.value);
                        }
                    });
                } else {
                    e.allowEditing = false;
                    e.editorElement.append($('<td style="padding: 5px;">').text(
                        e.row.data.ProductLotCode()));
                }

                e.cancel = true;
            } else if (e.dataField == 'QtyOrderConv') {
                var valueBefore = '';
                e.editorElement.dxTextBox({
                    value: e.value,
                    onFocusIn: function (e) { DXUtility.selectAllText(e.element, 'dxTextBox'); },
                    // Added by Andhika 2016.03.17 Fixing Issue Negatif Value -----
                    onKeyDown: function (ea) {
                        if ((ea.jQueryEvent.keyCode > 47 && ea.jQueryEvent.keyCode <= 57) || ea.jQueryEvent.keyCode == 191 || (ea.jQueryEvent.keyCode > 95 && ea.jQueryEvent.keyCode <= 105)) {
                            valueBefore = ea.jQueryEvent.target.value;
                        } else if (ea.jQueryEvent.keyCode != 8 && ea.jQueryEvent.keyCode != 46 && ea.jQueryEvent.keyCode != 13 && ea.jQueryEvent.keyCode != 9) {
                            ea.jQueryEvent.preventDefault();
                        }
                    },
                    onKeyUp: function (ea) {
                        if (/(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)/.test(ea.jQueryEvent.target.value)) {
                            // do nothing
                        } else if (ea.jQueryEvent.keyCode != 8 && ea.jQueryEvent.keyCode != 46 && ea.jQueryEvent.keyCode != 13 && ea.jQueryEvent.keyCode != 9) {
                            ea.jQueryEvent.target.value = valueBefore;
                        }
                    },
                    //-----------------------------------------------------------
                    onValueChanged: function (ea) {
                        var conversion = CommonUtility.getConversion(
                            (ea.value) ? ea.value : '0/0/0',
                            DXUtility.getValue(e.row.data, 'ProductConversionL'),
                            DXUtility.getValue(e.row.data, 'ProductConversionM'),
                            DXUtility.getValue(e.row.data, 'ProductConversionS')
                        );

                        DXUtility.setValue(e.row.data, 'QtyOrder', conversion.qtyTransaction);
                        DXUtility.setValue(e.row.data, 'QtyConvL', conversion.qtyConvL);
                        DXUtility.setValue(e.row.data, 'QtyConvM', conversion.qtyConvM);
                        DXUtility.setValue(e.row.data, 'QtyConvS', conversion.qtyConvS);

                        ea.value = conversion.qtyTransactionConv;
                        ea.component.option('value', ea.value);
                        e.setValue(ea.value);
                    }
                });

                e.cancel = true;
            }
        }
    };

    productLotPopupEdit.dataGridOptions.onRowInserted = function (info) {
        CommonUtility.validateDataGridInsertedTransactionDetails(
            info.component,
            new Dismoyo_Ciptoning_Client.vSalesOrderSampleDetailsViewModel(info.data).toJS()
        );
    };

    productLotPopupEdit.dataGridOptions.onRowRemoved = function (info) {
        CommonUtility.validateDataGridRemovedTransactionDetails(
            info.component,
            info.data.toJS()
        );
    };

    productLotPopupEdit.dataGridOptions.onRowUpdating = function (info) {
        CommonUtility.validateDataGridUpdatingTransactionDetails(
            info,
            'QtyConvL',
            'QtyConvM',
            'QtyConvS',
            'QtyOrderConv',
            'QtyOrder'
        );
    };

    productLotPopupEdit.dataGridOptions.onRowValidating = function (e) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var qtyOnHand = DXUtility.getValue(e.newData, 'QtyOnHand');
        if (qtyOnHand == undefined)
            qtyOnHand = DXUtility.getValue(e.oldData, 'QtyOnHand');

        var qtyOrder = DXUtility.getValue(e.newData, 'QtyOrder');
        if (qtyOrder == undefined)
            qtyOrder = DXUtility.getValue(e.oldData, 'QtyOrder');

        if (qtyOrder <= 0) {
            e.errorText = 'Order Qty must be greater than 0.';
            e.isValid = false;
        }

        if (e.isValid && (qtyOrder > qtyOnHand)) {
            e.errorText = 'Order Qty must be less than or equal to On Hand Qty.';
            e.isValid = false;
        }

        if (e.errorText)
            CommonUtility.hideErrorMessageOnDataGrid();
    };

    productLotPopupEdit.dataGridOptions.onDataErrorOccurred = function (e) {
        var errorValue = e.component._controllers.editing._editData[0].data.ProductLotCode;
        switch (e.error.__id) {
            case 'E4008':
                e.error.message = 'Lot Number \'' + errorValue + '\' is already exist.';
                break;
        }

        CommonUtility.hideErrorMessageOnDataGrid();
    };

    productLotPopupEdit.dataGridOptions.summary = {
        totalItems: [{
            name: 'TotalQtyPcs',
            showInColumn: 'QtyOrderConv',
            displayFormat: 'Total Qty (Pcs): {0}',
            valueFormat: 'decimal',
            summaryType: 'custom'
        }, {
            name: 'TotalQtyLMS',
            showInColumn: 'QtyOrderConv',
            displayFormat: '(L/M/S): {0}',
            valueFormat: 'string',
            summaryType: 'custom'
        }],
        calculateCustomSummary: function (options) {
            CommonUtility.updateProductLotEditingSummary(options,
                'QtyOrderConv',
                'QtyOrder');
        }
    };

    // ------------------------------------------------------------------------------------------------
    // Product Lot Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    productLotPopupEdit.dataGridOptions.columns = [{
        dataField: 'DocumentID', visible: false
    }, {
        dataField: 'ProductID', visible: false
    }, {
        dataField: 'ProductLotID', visible: false
    }, {
        dataField: 'ProductLotCode', caption: 'Lot Number',
        validationRules: [{ type: 'required' }]
    }, {
        dataField: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '120px', allowEditing: false,
        dataType: 'number'
    }, {
        dataField: 'QtyOrderConv', caption: 'Order Qty (L/M/S)', width: '150px',
        alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule]
    }]

    // ------------------------------------------------------------------------------------------------
    // Product Lot Popup Edit Items: Specify items of the edit data here.
    // ------------------------------------------------------------------------------------------------    
    productLotPopupEdit.formOptions.items = [{
        itemType: 'group',
        caption: 'Product',
        colCount: 4,
        colSpan: 4,
        items: [{
            dataField: 'Product',
            label: { text: 'Product' },
            colSpan: 4,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyOnHand',
            label: { text: 'On Hand Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 2
        }, {
            dataField: 'QtyOrder',
            label: { text: 'Order Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyOrderConv',
            label: { text: '(L/M/S)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
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

        icon: 'Images/sales_order_sample_32px.png',

        dataSource_vSalesOrderSampleDetails: dataSource_vSalesOrderSampleDetails,
        dataSource_vSalesOrderSampleSummary: dataSource_vSalesOrderSampleSummary,
        dataSource_vStockOnHandAvailable: dataSource_vStockOnHandAvailable,
        dataSource_vStockOnHandAvailableByProduct: dataSource_vStockOnHandAvailableByProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        commonPopupIFrame: commonPopupIFrame,
        productLotPopupEdit: productLotPopupEdit,

        salesOrderSampleSummaryDataGrid: salesOrderSampleSummaryDataGrid,
        salesOrderSamplePost: salesOrderSamplePost,
        salesOrderSampleDiscard: salesOrderSampleDiscard,
        salesOrderSampleVoid: salesOrderSampleVoid,
        salesOrderSampleSaveAsDraftAndNew: salesOrderSampleSaveAsDraftAndNew,
        isLotNumberEntryRequired: isLotNumberEntryRequired
    };
};
