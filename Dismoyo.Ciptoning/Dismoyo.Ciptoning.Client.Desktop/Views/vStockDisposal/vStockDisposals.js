Dismoyo_Ciptoning_Client.vStockDisposals = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isLotNumberEntryRequired;

    function handlevStockDisposalsModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vStockDisposals');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vStockDisposals.off('modified', handlevStockDisposalsModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockDisposals,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockDisposalViewModel(item); }
    });


    Dismoyo_Ciptoning_Client.DB.vStockDisposals.on('modified', handlevStockDisposalsModification);



    var dataSource_vStockDisposalDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockDisposalDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockDisposalDetailsViewModel(item); }
    });

    var dataSource_vStockDisposalSummary = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockDisposalSummaries,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockDisposalSummaryViewModel(item); }
    });

    var dataSource_vStockOnHandAvailable;
    var dataSource_vStockOnHandAvailableByProduct;

    var conversionValidationRule = {
        type: 'pattern',
        pattern: '(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)',
        message: 'Format must be L/M/S or M/S or S.'
    };

    function previewDocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-09-(Auto Generated)';
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
        var warehouseDataSource = DataUtility.GetLookupWarehouseDataSource([
            ['SiteID', '=', siteID], 'and',
            ['TypeID', '=', 1] // Main warehouse only
        ]);

        form.getEditor('WarehouseID').option('value', null);
        form.getEditor('WarehouseID').option('dataSource', []);
        warehouseDataSource.load()
            .done(function (result) {
                form.getEditor('WarehouseID').option('dataSource', warehouseDataSource);
            });
    }


    function updateSummariesArrayStore(summary) {
        CommonUtility.updateSummariesArrayStore(
            stockDisposalSummaryDataGrid().option('dataSource').store(),
            summary
        );
    }

    function updateDeferSummariesArrayStore(productID, summary) {
        CommonUtility.updateDeferSummariesArrayStore(
            stockDisposalSummaryDataGrid().option('dataSource').store(),
            productID,
            summary
        );
    }

    function validateSummariesArrayStore(summary) {
        return CommonUtility.validateSummaryArrayStore(
            stockDisposalSummaryDataGrid().option('dataSource').store(),
            'vStockDisposalSummaryViewModel',
            summary
        );
    }

    function createSummaryArrayDataSource(summaries) {
        return CommonUtility.createArrayDataSource(
            'vStockDisposalSummaryViewModel',
            ['ProductID'],
            summaries
        );
    }

    function createProductLotEditCommands(data, qtyDisposalConvColumn, itemStatusID) {
        var commands = $('<div class="dx-command-edit" style="text-align: right; padding-right: 5px;">');

        commands.append($('<a style="color: inherit;">').text(data[qtyDisposalConvColumn]()));
        commands.append('&nbsp;');
        if (isLotNumberEntryRequired) {
            var column = qtyDisposalConvColumn.replace("Conv", "");
            var qty = data[column]();
            var childDetails = data["ChildDetails"]();
            var total = 0;
            for (var o in childDetails) {
                total += childDetails[o][column]();
            }

            commands.append($('<a class="dx-link dxcustom-linkbutton dx-icon-icons8-view-details" title="Edit Lot Number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><span id="LotMark_' + data["ProductID"]() + '_' + qtyDisposalConvColumn + '" class="dx-icon-overflow ' + (total == qty ? 'hidden' : '') + '" style="color:red; font-size: 14px; margin-left: -6px;"></span>').on('dxclick', function () {
                downloadProductLot(function () {
                    openProductLotEditing(data, itemStatusID); // Open product lot popup entry
                });
            }));
            commands.append('&nbsp;');
        }

        return commands;
    }

    function setSummaryDataGridEditing(allowed) {
        var option = stockDisposalSummaryDataGrid().option('editing');
        var selection = stockDisposalSummaryDataGrid().option('selection');

        selection.mode = (allowed) ? 'multiple' : 'none';

        //option.allowAdding = allowed;
        option.allowUpdating = allowed;
        option.allowDeleting = allowed;
        stockDisposalSummaryDataGrid().option('editing', option);
        stockDisposalSummaryDataGrid().option('selection', selection);
        stockDisposalSummaryNewRow().option('disabled', !allowed);
        stockDisposalSummaryDeleteRows().option('disabled', true);
        stockDisposalSummaryDataGrid().repaint();
    }

    function openSelectedEditing(documentID, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vStockDisposals.byKey(
            documentID, { expand: ['ChildSummaries/ChildDetails'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vStockDisposalViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vStockDisposalViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Stock Disposal');
        commonPopupEdit.popupEditOptions.editingKey = data.DocumentID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);

        // Disable/enable operation buttons
        var documentCode = data.DocumentCode();
        var disabled = false;
        var summaries = [];

        isLotNumberEntryRequired = data.IsSiteLotNumberEntryRequired();

        if (newData) {
            data.DocumentID(new DevExpress.data.Guid());
            data.DocumentStatusID(null);

            data.TerritoryID(user.TerritoryID());
            data.RegionID(user.RegionID());
            data.AreaID(user.AreaID());
            data.SiteID(user.SiteID());
            data.SiteCode(user.SiteCode());
            data.CompanyID(user.CompanyID());
            data.Company(user.Company());

            documentCode = previewDocumentCode(data.SiteCode());
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
                    downloadProductLot(function () {
                        for (var i = 0; i < downloadSummaries.length; i++) {
                            var e = {
                                data: downloadSummaries[i].toJS()
                            };
                            addDummyData(e, downloadSummaries);
                        }
                    });
                }
            } else if ((data.DocumentStatusID() == 2) || (data.DocumentStatusID() == 3)) // Posted or Discard
                disabled = true;
        }

        setSummaryDataGridEditing(!disabled);

        stockDisposalPost().option('disabled', newData || disabled);
        stockDisposalDiscard().option('disabled', newData || disabled);
        stockDisposalSaveAsDraftAndNew().option('disabled', disabled);
        commonPopupEdit.ok().option('disabled', disabled);

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

        form.getEditor('DocumentCode').option('value', documentCode);
        form.getEditor('TransactionDate').option('value', data.TransactionDate());
        form.getEditor('WarehouseID').option('value', data.WarehouseID());
        form.getEditor('PIC').option('value', data.PIC());
        form.getEditor('ReferenceNumber').option('value', data.ReferenceNumber());

        var fileUploader = stockDisposalEditDataAttachmentFile();
        CommonUtility.createEditDataAttachmentFileDownloader('vStockDisposals', fileUploader,
            'StockDisposals', data.AttachmentFile());
        fileUploader.option('value', null);

        form.getEditor('DocumentStatusID').option('value', data.DocumentStatusID());

        form.getEditor('TransactionDate').option('readOnly', disabled);
        form.getEditor('WarehouseID').option('readOnly', disabled);
        form.getEditor('PIC').option('readOnly', disabled);
        form.getEditor('ReferenceNumber').option('readOnly', disabled);
        
        var fileUploaderInput = $('.dx-fileuploader-input-wrapper');
        if (disabled)
            fileUploaderInput.hide();
        else
            fileUploaderInput.show();

        var today = new Date();

        if (newData) {
            DXUtility.resetFormValidation(form);

            form.getEditor('TransactionDate').option('value', today);
        }

        // Set grid datasource for summary including details
        var summaryDataGrid = stockDisposalSummaryDataGrid();
        summaryDataGrid.cancelEditData();

        data.ChildSummaries(summaries);
        summaryDataGrid.option('dataSource',
            createSummaryArrayDataSource(data.ChildSummaries()));
    }

    function addDummyData(e, summaries) {
        if (!isLotNumberEntryRequired) {
            var data = commonPopupEdit.popupEditData();
            var summaryDataGrid = stockDisposalSummaryDataGrid();
            var dataSourceItems = [];

            if (!summaries) {
                var store = summaryDataGrid.option('dataSource').store();
                for (var i = 0; i < store._array.length; i++)
                    dataSourceItems.push(new Dismoyo_Ciptoning_Client.vStockDisposalSummaryViewModel(store._array[i]));
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

                        if (items.length > 0) {
                            var item = items[0];
                            item.QtyConvL(DXUtility.getValue(details, 'QtyConvL'));
                            item.QtyConvM(DXUtility.getValue(details, 'QtyConvM'));
                            item.QtyConvS(DXUtility.getValue(details, 'QtyConvS'));
                            item.QtyDisposal(DXUtility.getValue(details, 'QtyDisposal'));
                            item.QtyDisposalConv(DXUtility.getValue(details, 'QtyDisposalConv'));
                        } else
                            dataSourceItems[i].ChildDetails().push(
                                new Dismoyo_Ciptoning_Client.vStockDisposalDetailsViewModel(details));

                        updateSummariesArrayStore(dataSourceItems[i]);
                    }
                }
            } else {
                DevExpress.ui.dialog.alert('DUMMY Lot Number for the selected product is not available.', 'Save Failed');
            }
        }
    }

    function saveEditing(statusID, action) {
        showLoadingPanel();

        var form = commonPopupEdit.form();

        var isValid = form.validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var summaryDataSource = stockDisposalSummaryDataGrid().option('dataSource');
        var summaries = [];
        for (var i = 0; i < summaryDataSource.store()._array.length; i++)
            summaries.push(new Dismoyo_Ciptoning_Client.vStockDisposalSummaryViewModel(summaryDataSource.store()._array[i]));

        if (isValid) {
            if (summaries.length <= 0) {
                errorMsg = 'Please specify at least one item in Disposal Details.';
                isValid = false;
            }
        }

        if (isValid) {
            for (var i = 0; i < summaries.length; i++) {
                var summary = summaries[i];
                var sumQtyDisposal = 0;
                for (var j = 0; j < summary.ChildDetails().length; j++) {
                    var details = summary.ChildDetails()[j];
                    sumQtyDisposal += details.QtyDisposal();
                }

                if (summary.QtyDisposal() != sumQtyDisposal) {
                    if (errorMsg == '')
                        errorMsg = 'Following products quantity of Disposal Details items is not matched: ';
                    else
                        errorMsg += ', ';

                    errorMsg += summary.Product();
                    isValid = false;
                }
            }
        }

        if (isValid && ($('.dx-fileuploader-button.dx-fileuploader-upload-button.dx-widget.dx-button-has-icon.dx-button.dx-button-normal').length > 0)) {
            errorMsg = 'You have selected an attachment file. Please upload or cancel the attachment file.';
            isValid = false;
        }

        var siteID = Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID();
        if (form.itemOption('Organization').visible)
            siteID = form.getEditor('SiteID').option('value');
        
        if (isValid) {
            var data = commonPopupEdit.popupEditData();

            data.TransactionDate(form.getEditor('TransactionDate').option('value'));
            data.WarehouseID(form.getEditor('WarehouseID').option('value'));
            data.PIC(form.getEditor('PIC').option('value'));
            data.ReferenceNumber(form.getEditor('ReferenceNumber').option('value'));

            var fileUploader = stockDisposalEditDataAttachmentFile();
            data.AttachmentFile((fileUploader.option('values').length > 0) ? fileUploader.fileName : null);

            data.ChildSummaries(summaries);
            var dataJS = ko.toJS(data);

            if (statusID)
                dataJS.DocumentStatusID = statusID;

            if (!dataJS.DocumentStatusID)
                dataJS.DocumentStatusID = 1; // Draft

            dataJS.TransactionDate = DateTimeUtility.getFirstTimeOfDay(dataJS.TransactionDate);

            for (var i = 0; i < dataJS.ChildSummaries.length; i++) {
                var summary = dataJS.ChildSummaries[i];
                summary.DocumentID = dataJS.DocumentID;
                for (var j = 0; j < summary.ChildDetails.length; j++) {
                    var details = summary.ChildDetails[j];

                    details.DocumentID = dataJS.DocumentID;
                    details.Qty = details.QtyDisposal * -1;
                }

                summary.Qty = summary.QtyDisposal * -1;
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
                    DevExpress.ui.dialog.alert(error.message, 'Save Failed');
                    hideLoadingPanel();
                });
        } else
            hideLoadingPanel();

        if (errorMsg != '') {
            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(errorMsg), 'Save Failed');
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
        var qtyDisposalColumn = 'QtyDisposal' + itemStatusName;
        var qtyDisposalConvColumn = 'QtyDisposalConv' + itemStatusName;

        return {
            itemStatusName: itemStatusName,
            qtyOnHandColumn: qtyOnHandColumn,
            qtyConvLColumn: qtyConvLColumn,
            qtyConvMColumn: qtyConvMColumn,
            qtyConvSColumn: qtyConvSColumn,
            qtyDisposalColumn: qtyDisposalColumn,
            qtyDisposalConvColumn: qtyDisposalConvColumn
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
        if ((editData.DocumentStatusID() == 2) || (editData.DocumentStatusID() == 3))
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
        form.getEditor('QtyDisposalConv').option('value', data.QtyDisposalConv());

        var conversion = CommonUtility.getConversion(
            data.QtyDisposalConv(),
            DXUtility.getValue(data, 'ProductConversionL'),
            DXUtility.getValue(data, 'ProductConversionM'),
            DXUtility.getValue(data, 'ProductConversionS')
        );

        form.getEditor('QtyDisposal').option('value', conversion.qtyTransaction);

        data = validateSummariesArrayStore(data);

        var detailsDataSource = CommonUtility.createArrayDataSource(
            'vStockDisposalDetailsViewModel',
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
            productLotPopupEdit.form().getEditor('QtyDisposal').option('value'),
            'Disposal',
            'vStockDisposalDetailsViewModel',
            'QtyConvL',
            'QtyConvM',
            'QtyConvS',
            'QtyDisposalConv',
            'QtyDisposal',
            false)) {
            updateSummariesArrayStore(data);

            productLotPopupEdit.popupEditOptions.visible(false);
            stockDisposalSummaryDataGrid().refresh();
        }
    }

    function downloadProductLot(productLotLoaded) {
        if ((dataSource_vStockOnHandAvailable.length == 0) && (dataSource_vStockOnHandAvailableByProduct.length == 0)) {
            showLoadingPanel();

            var form = commonPopupEdit.form();

            new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vProducts,
                select: [
                    'ID',
                    'Code',
                    'Product',
                    'UOMLID',
                    'UOMMID',
                    'UOMSID',
                    'ConversionL',
                    'ConversionM',
                    'ConversionS'
                ],
                sort: ['ID'],
                paginate: false,
                map: function (item) { return new Dismoyo_Ciptoning_Client.vProductViewModel(item); }
            }).load()
            .done(function (result) {
                var productDataSource = result;
                var warehouseID = form.getEditor('WarehouseID').option('value');

                var dataSource = new DevExpress.data.DataSource({
                    store: Dismoyo_Ciptoning_Client.DB.vStockOnHandAvailables,
                    select: [
                        'ProductID',
                        'ProductLotID',
                        'ProductLotCode',
                        'ProductLot',
                        'ProductLotExpiredDate',
                        'QtyOnHandBad'
                    ],
                    filter: [
                        ['WarehouseID', '=', warehouseID], 'and',
                        ['QtyOnHandBad', '>', 0]
                    ],
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
                                stockOnHandAvailableByProduct.push(new Dismoyo_Ciptoning_Client.vStockOnHandAvailableViewModel(result2[i].toJS()));
                                j++;
                                product = $.grep(result, function (e) { return (e.ID() == productID); });
                            } else {
                                stockOnHandAvailableByProduct[j].QtyOnHandGood(stockOnHandAvailableByProduct[j].QtyOnHandGood() +
                                    result2[i].QtyOnHandGood());
                                stockOnHandAvailableByProduct[j].QtyOnHandHold(stockOnHandAvailableByProduct[j].QtyOnHandHold() +
                                    result2[i].QtyOnHandHold());
                                stockOnHandAvailableByProduct[j].QtyOnHandBad(stockOnHandAvailableByProduct[j].QtyOnHandBad() +
                                    result2[i].QtyOnHandBad());
                            }

                            stockOnHandAvailable[i].ProductCode(product[0].Code());
                            stockOnHandAvailable[i].Product(product[0].Product());
                            stockOnHandAvailable[i].ProductUOMLID(product[0].UOMLID());
                            stockOnHandAvailable[i].ProductUOMMID(product[0].UOMMID());
                            stockOnHandAvailable[i].ProductUOMSID(product[0].UOMSID());
                            stockOnHandAvailable[i].ProductConversionL(product[0].ConversionL());
                            stockOnHandAvailable[i].ProductConversionM(product[0].ConversionM());
                            stockOnHandAvailable[i].ProductConversionS(product[0].ConversionS());

                            stockOnHandAvailableByProduct[j].ProductCode(product[0].Code());
                            stockOnHandAvailableByProduct[j].Product(product[0].Product());
                            stockOnHandAvailableByProduct[j].ProductUOMLID(product[0].UOMLID());
                            stockOnHandAvailableByProduct[j].ProductUOMMID(product[0].UOMMID());
                            stockOnHandAvailableByProduct[j].ProductUOMSID(product[0].UOMSID());
                            stockOnHandAvailableByProduct[j].ProductConversionL(product[0].ConversionL());
                            stockOnHandAvailableByProduct[j].ProductConversionM(product[0].ConversionM());
                            stockOnHandAvailableByProduct[j].ProductConversionS(product[0].ConversionS());
                        }

                        dataSource_vStockOnHandAvailable = stockOnHandAvailable;
                        dataSource_vStockOnHandAvailableByProduct = stockOnHandAvailableByProduct;

                        if (dataSource_vStockOnHandAvailable.length == 0)
                            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(
                                'Product lot stock with item status Bad for the selected warehouse is empty.'),
                                'New Disposal Details Failed');
                        else
                            productLotLoaded();

                        hideLoadingPanel();
                    })
                    .fail(function (error) {
                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download product lot data.'), 'Download Product Lot Failed');
                        hideLoadingPanel();
                    });
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
                        ['Warehouse']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock Disposal',
        colCount: 3,
        colSpan: 3,
        items: [{
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
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
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
            dataField: 'PIC',
            label: { text: 'PIC' },
            editorOptions: {
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

        // PIC
        value = form.getEditor('PIC').option('value');
        DXUtility.addFilterExpression(filterExpr, 'PIC', 'contains', value, 'and');

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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockDisposals.AddNewStockDisposal');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockDisposals.EditStockDisposal');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'Territory', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Region', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Area', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Company', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'Site', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'DocumentCode', caption: 'Document Number', width: '140px', sortOrder: 'desc',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vStockDisposals_commonGridView').find('.dx-datagrid:first-child');
            if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader">';
                tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

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
            var allowUpdating = user.isAuthorized('StockDisposals.EditStockDisposal');

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
        dataField: 'Warehouse', caption: 'Warehouse', width: '200px'
    }, {
        dataField: 'ReferenceNumber', caption: 'Reference Number', width: '120px'
    }, {
        dataField: 'PIC', caption: 'PIC', width: '180px'
    }, {
        dataField: 'DocumentStatusName', caption: 'Status', width: '80px'
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

    var stockDisposalEditDataAttachmentFile = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_editDataAttachmentFile', 'dxFileUploader'); }

    var stockDisposalSummaryDataGrid = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalSummaryDataGrid', 'dxDataGrid'); }

    var stockDisposalPost = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalPost', 'dxButton'); }
    var stockDisposalDiscard = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalDiscard', 'dxButton'); }
    var stockDisposalSaveAsDraftAndNew = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalSaveAsDraftAndNew', 'dxButton'); }
    var stockDisposalSummaryNewRow = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalSummaryNewRow', 'dxButton'); }
    var stockDisposalSummaryDeleteRows = function () { return DXUtility.getDXInstance(null, '#vStockDisposals_stockDisposalSummaryDeleteRows', 'dxButton'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Disposal Details'));

        var commands = $('<div class="desktop-commonGridView-commands">');

        var commandSummaryNewRow = $('<div id="vStockDisposals_stockDisposalSummaryNewRow">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () {
                var isValid = commonPopupEdit.form().validate().isValid;

                if (isValid) {
                    downloadProductLot(function () {
                        stockDisposalSummaryDataGrid().addRow();
                    });
                }
                else
                    DevExpress.ui.dialog.alert('Please specify the required fields.', 'New Disposal Details Failed');
            }
        });

        var commandSummaryDeleteRows = $('<div id="vStockDisposals_stockDisposalSummaryDeleteRows">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            DXUtility.deleteSelectedRows(stockDisposalSummaryDataGrid());
                        }
                    });
            }
        });

        commands.append(commandSummaryNewRow);
        commands.append(commandSummaryDeleteRows);

        content.append(commands);

        content.append($('<div id="vStockDisposals_stockDisposalSummaryDataGrid">').dxDataGrid({
            deferRendering: false,
            dataSource: [],
            showBorders: true,
            paging: { enabled: false },
            allowColumnResizing: false,
            columnAutoWidth: true,
            hoverStateEnabled: true,
            selection: {
                mode: 'multiple',
                allowSelectAll: true
            },
            editing: {
                editMode: 'row',
                allowAdding: false,
                allowUpdating: true,
                allowDeleting: true,
            },
            onInitNewRow: function (info) {
                info.data.QtyDisposal = 0;
                info.data.QtyDisposalConv = '0/0/0';
            },
            onSelectionChanged: function (e) {
                stockDisposalSummaryDeleteRows().option('disabled', !e.selectedRowsData.length);
            },
            onEditorPreparing: function (e) {
                if (e.parentType == 'dataRow') {
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
                                    CommonUtility.createProductLookupHeader('vStockDisposals_productIDLookup', ea.element, 3); // Bad
                                },
                                itemTemplate: function (data, index, element) {
                                    return CommonUtility.createProductLookupItem(data, element, 3); // Bad
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
                                                e.component.cellValue(e.row.rowIndex, 'QtyDisposalConv'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            DXUtility.setValue(e.row.data, 'QtyDisposal', conversion.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvL', conversion.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvM', conversion.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvS', conversion.qtyConvS);
                                        }
                                    }

                                    e.component.cellValue(e.row.rowIndex, 'Product', ea.value);
                                    e.setValue(ea.value);
                                }
                            });
                        } else {
                            downloadProductLot(function () { });
                            e.allowEditing = false;
                            e.editorElement.append($('<td style="padding: 5px;">').text(
                                e.row.data.Product()));
                        }

                        e.cancel = true;
                    } else if (e.dataField == 'QtyDisposalConv') {
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
                                stockDisposalSummaryDataGrid().saveEditData();
                            },
                            onValueChanged: function (ea) {
                                if (DXUtility.getValue(e.row.data, 'Product') == undefined) {
                                    ea.value = '';
                                }

                                // will convert the units to quantity (in the input is in units)
                                if (ea.value.indexOf('/') > -1) {
                                    var qty = 0;
                                    var units = ea.value.split('/');
                                    for (var unitIndex = 0; unitIndex < units.length; unitIndex++) {
                                        if (units[unitIndex] == '')
                                            break;
                                        var value = parseInt(units[unitIndex]);
                                        if (unitIndex == 0)
                                            qty += value * DXUtility.getValue(e.row.data, 'ProductConversionL');
                                        else if (unitIndex == 1) {
                                            if (units.length == 2 && DXUtility.getValue(e.row.data, 'Product').indexOf('Single') > -1)
                                                qty += value;
                                            else if (DXUtility.getValue(e.row.data, 'ProductConversionM') != null)
                                                qty += value * DXUtility.getValue(e.row.data, 'ProductConversionM');
                                        }
                                        else if (unitIndex == 2)
                                            qty += value;
                                    }
                                    ea.value = qty + "";
                                    DXUtility.setValue(e.row.data, e.dataField.replace('QtyDisposalConv', 'QtyDisposal'), qty);
                                }

                                var conversion = CommonUtility.getConversion(
                                    (ea.value) ? ea.value : '0/0/0',
                                    DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionS')
                                );

                                //DXUtility.setValue(e.row.data, e.dataField.replace('QtyDisposalConv', 'QtyDisposal'), conversion.qtyTransaction);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyDisposalConv', 'QtyConvL'), conversion.qtyConvL);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyDisposalConv', 'QtyConvM'), conversion.qtyConvM);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyDisposalConv', 'QtyConvS'), conversion.qtyConvS);

                                ea.value = conversion.qtyTransactionConv;
                                ea.component.option('value', ea.value);
                                e.setValue(ea.value);
                            }
                        });

                        e.cancel = true;
                    }
                }
            },
            onRowInserted: function (info) {
                CommonUtility.validateDataGridInsertedTransactionSummary(
                    info.component,
                    new Dismoyo_Ciptoning_Client.vStockDisposalSummaryViewModel(info.data).toJS()
                );

                addDummyData(info);
                stockDisposalSummaryDataGrid().clearSelection();
            },
            onRowUpdated: function (info) {
                info.data.ProductID = info.key.ProductID;
                addDummyData(info);
                stockDisposalSummaryDataGrid().clearSelection();
            },
            onRowRemoved: function (info) {
                CommonUtility.validateDataGridRemovedTransactionSummary(
                    info.component,
                    info.data.toJS()
                );
            },
            onRowUpdating: function (info) {
                if (info.newData.QtyDisposalConv) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyDisposalConv,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvL = conversion.qtyConvL;
                    info.newData.QtyConvM = conversion.qtyConvM;
                    info.newData.QtyConvS = conversion.qtyConvS;
                    info.newData.QtyDisposal = conversion.qtyTransaction;
                }

                updateDeferSummariesArrayStore(info.oldData.ProductID(), info.newData);
            },
            onRowValidating: function (e) {
                var qtyOnHand = DXUtility.getValue(e.newData, 'QtyOnHand');
                if (qtyOnHand == undefined)
                    qtyOnHand = DXUtility.getValue(e.oldData, 'QtyOnHand');

                var qtyDisposal = DXUtility.getValue(e.newData, 'QtyDisposal');
                if (qtyDisposal == undefined)
                    qtyDisposal = DXUtility.getValue(e.oldData, 'QtyDisposal');

                if (qtyDisposal <= 0) {
                    e.errorText = 'Disposal Qty must be greater than 0.';
                    e.isValid = false;
                }

                if (e.isValid && (qtyDisposal > qtyOnHand)) {
                    e.errorText = 'Disposal Qty must be less than or equal to On Hand Qty.';
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
                dataField: 'Product', caption: 'Product',
                validationRules: [{ type: 'required' }],
                headerCellTemplate: function (columnHeader, headerInfo) {
                    var dataGrid = $(stockDisposalSummaryDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var isEditable = (stockDisposalSummaryDataGrid().option('selection').mode == 'none') ? false : true;

                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
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
                dataField: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '150px', allowEditing: false,
                dataType: 'number'
            }, {
                dataField: 'QtyDisposalConv', caption: 'Disposal Qty (L/M/S)', width: '180px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyDisposalConv', 3)); // Bad
                }
            }]
        }));

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPost = $('<div id="vStockDisposals_stockDisposalPost">').dxButton({
            text: 'Post', icon: 'icons8-check-green',
            onClick: function () { commonPopupEdit.events.performPost(this); }
        });

        var commandDiscard = $('<div id="vStockDisposals_stockDisposalDiscard" style="margin-right: 16px;">').dxButton({
            text: 'Discard', icon: 'icons8-trash-red',
            onClick: function () { commonPopupEdit.events.performDiscard(this); }
        });

        var commandSaveAsDraftAndNew = $('<div id="vStockDisposals_stockDisposalSaveAsDraftAndNew">').dxButton({
            text: 'Save & New', icon: 'icons8-save',
            onClick: function () { commonPopupEdit.events.performSaveAsDraftAndNew(this); }
        });

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
        extCommands.append(commandPost);
        extCommands.append(commandDiscard);
        extCommands.append(commandSaveAsDraftAndNew);
    };

    commonGridView.events.performNewRow = function (rootView) {
        openEditing(null);
    };

    commonPopupEdit.events.performOK = function (rootView) {
        saveEditing(null, 3); // Save with no status changes and Reload data
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

    commonPopupEdit.events.performSaveAsDraftAndNew = function (rootView) {
        saveEditing(1, 2); // Save as Draft and Reload data
    };

    commonPopupEdit.formOptions.customizeItem = function (item) {
        if (item.dataField == 'AttachmentFile') {
            item.template = function (data, itemElement) {
                itemElement.append(CommonUtility.createEditDataAttachmentFileUploader('vStockDisposals', 'StockDisposals'));
            }
        }
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
                    var company = null;

                    if (e.selectedItem) {
                        preDocumentCode = previewDocumentCode(e.selectedItem.Code());
                        company = e.selectedItem.Company();
                    }

                    form.getEditor('Company').option('value', company);

                    updateSiteChildEditor(form, e.value);

                    form.getEditor('DocumentCode').option('value', preDocumentCode);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock Disposal',
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
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
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
            dataField: 'WarehouseID',
            label: { text: 'Warehouse' },
            validationRules: [{ type: 'required' }],
            colSpan: 3,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Warehouse',
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

                        var summaryDataGrid = stockDisposalSummaryDataGrid();
                        summaryDataGrid.cancelEditData();

                        data.ChildSummaries([]);
                        summaryDataGrid.option('dataSource',
                            createSummaryArrayDataSource(data.ChildSummaries()));
                    }
                }
            }
        }, {
            dataField: 'PIC',
            label: { text: 'PIC' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 1
        }, {
            dataField: 'ReferenceNumber',
            label: { text: 'Reference Number' },
            colSpan: 3,
            editorOptions: {
                maxLength: 30,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'AttachmentFile',
            label: { text: 'Attachment File' },
            colSpan: 2,
            editorOptions: {
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 1
        }]
    }];





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
        info.data.QtyDisposal = 0;
        info.data.QtyDisposalConv = '0/0/0';
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

                            CommonUtility.createProductLotLookupHeader('vStockDisposals_productLotIDLookup', ea.element, itemStatusID);
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
                                        e.component.cellValue(e.row.rowIndex, 'QtyDisposalConv'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionS')
                                    );

                                    DXUtility.setValue(e.row.data, 'QtyDisposal', conversion.qtyTransaction);
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
            } else if (e.dataField == 'QtyDisposalConv') {
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
                    onValueChanged: function (ea) {
                        //if (DXUtility.getValue(e.row.data, 'Product') == undefined) {
                        //    ea.value = '';
                        //}

                        //// will convert the units to quantity (in the input is in units)
                        //if (ea.value.indexOf('/') > -1) {
                        //    var qty = 0;
                        //    var units = ea.value.split('/');
                        //    for (var unitIndex = 0; unitIndex < units.length; unitIndex++) {
                        //        if (units[unitIndex] == '')
                        //            break;
                        //        var value = parseInt(units[unitIndex]);
                        //        if (unitIndex == 0)
                        //            qty += value * DXUtility.getValue(e.row.data, 'ProductConversionL');
                        //        else if (unitIndex == 1) {
                        //            if (units.length == 2 && DXUtility.getValue(e.row.data, 'Product').indexOf('Single') > -1)
                        //                qty += value;
                        //            else if (DXUtility.getValue(e.row.data, 'ProductConversionM') != null)
                        //                qty += value * DXUtility.getValue(e.row.data, 'ProductConversionM');
                        //        }
                        //        else if (unitIndex == 2)
                        //            qty += value;
                        //    }
                        //    ea.value = qty + "";
                        //    DXUtility.setValue(e.row.data, 'QtyDisposal', qty);
                        //}

                        var conversion = CommonUtility.getConversion(
                            (ea.value) ? ea.value : '0/0/0',
                            DXUtility.getValue(e.row.data, 'ProductConversionL'),
                            DXUtility.getValue(e.row.data, 'ProductConversionM'),
                            DXUtility.getValue(e.row.data, 'ProductConversionS')
                        );

                        DXUtility.setValue(e.row.data, 'QtyDisposal', conversion.qtyTransaction);
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
            new Dismoyo_Ciptoning_Client.vStockDisposalDetailsViewModel(info.data).toJS()
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
            'QtyDisposalConv',
            'QtyDisposal'
        );
    };

    productLotPopupEdit.dataGridOptions.onRowValidating = function (e) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var qtyOnHand = DXUtility.getValue(e.newData, 'QtyOnHand');
        if (qtyOnHand == undefined)
            qtyOnHand = DXUtility.getValue(e.oldData, 'QtyOnHand');

        var qtyDisposal = DXUtility.getValue(e.newData, 'QtyDisposal');
        if (qtyDisposal == undefined)
            qtyDisposal = DXUtility.getValue(e.oldData, 'QtyDisposal');

        if (qtyDisposal <= 0) {
            e.errorText = 'Disposal Qty must be greater than 0.';
            e.isValid = false;
        }

        if (e.isValid && (qtyDisposal > qtyOnHand)) {
            e.errorText = 'Disposal Qty must be less than or equal to On Hand Qty.';
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
            showInColumn: 'QtyDisposalConv',
            displayFormat: 'Total Qty (Pcs): {0}',
            valueFormat: 'decimal',
            summaryType: 'custom'
        }, {
            name: 'TotalQtyLMS',
            showInColumn: 'QtyDisposalConv',
            displayFormat: '(L/M/S): {0}',
            valueFormat: 'string',
            summaryType: 'custom'
        }],
        calculateCustomSummary: function (options) {
            CommonUtility.updateProductLotEditingSummary(options,
                'QtyDisposalConv',
                'QtyDisposal');
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
        dataField: 'QtyDisposalConv', caption: 'Disposal Qty (L/M/S)', width: '150px',
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
            dataField: 'QtyDisposal',
            label: { text: 'Disposal Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyDisposalConv',
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

        icon: 'Images/stock_disposal_32px.png',

        dataSource_vStockDisposalDetails: dataSource_vStockDisposalDetails,
        dataSource_vStockDisposalSummary: dataSource_vStockDisposalSummary,
        dataSource_vStockOnHandAvailable: dataSource_vStockOnHandAvailable,
        dataSource_vStockOnHandAvailableByProduct: dataSource_vStockOnHandAvailableByProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        productLotPopupEdit: productLotPopupEdit,

        stockDisposalSummaryDataGrid: stockDisposalSummaryDataGrid,
        stockDisposalPost: stockDisposalPost,
        stockDisposalDiscard: stockDisposalDiscard,
        stockDisposalSaveAsDraftAndNew: stockDisposalSaveAsDraftAndNew
    };
};
