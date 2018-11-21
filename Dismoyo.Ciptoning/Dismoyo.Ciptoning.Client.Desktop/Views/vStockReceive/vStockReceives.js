Dismoyo_Ciptoning_Client.vStockReceives = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isLotNumberEntryRequired;

    function handlevStockReceivesModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vStockReceives');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vStockReceives.off('modified', handlevStockReceivesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockReceives,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockReceiveViewModel(item); }
    });


    Dismoyo_Ciptoning_Client.DB.vStockReceives.on('modified', handlevStockReceivesModification);



    var dataSource_vStockReceiveDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockReceiveDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockReceiveDetailsViewModel(item); }
    });

    var dataSource_vStockReceiveSummary = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockReceiveSummaries,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockReceiveSummaryViewModel(item); }
    });

    var dataSource_vStockOnHandAll;
    var dataSource_vStockOnHandAllByProduct;

    var conversionValidationRule = {
        type: 'pattern',
        pattern: '(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)',
        message: 'Format must be L/M/S or M/S or S.'
    };

    function previewDocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-12-(Auto Generated)';
    }

    function updateSiteChildEditor(form, siteID) {
        if (siteID) {
            Dismoyo_Ciptoning_Client.DB.vSites.byKey(siteID)
                .done(function (result) {
                    isLotNumberEntryRequired = result.IsLotNumberEntryRequired;
                });
        } else
            isLotNumberEntryRequired = undefined;

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
            stockReceiveSummaryDataGrid().option('dataSource').store(),
            summary
        );
    }

    function updateDeferSummariesArrayStore(productID, summary) {
        CommonUtility.updateDeferSummariesArrayStore(
            stockReceiveSummaryDataGrid().option('dataSource').store(),
            productID,
            summary
        );
    }

    function validateSummariesArrayStore(summary) {
        return CommonUtility.validateSummaryArrayStore(
            stockReceiveSummaryDataGrid().option('dataSource').store(),
            'vStockReceiveSummaryViewModel',
            summary
        );
    }

    function createSummaryArrayDataSource(summaries) {
        return CommonUtility.createArrayDataSource(
            'vStockReceiveSummaryViewModel',
            ['ProductID'],
            summaries
        );
    }

    function createProductLotEditCommands(data, qtyReceiveConvColumn, itemStatusID) {
        var commands = $('<div class="dx-command-edit" style="text-align: right; padding-right: 5px;">');

        commands.append($('<a style="color: inherit;">').text(data[qtyReceiveConvColumn]()));
        commands.append('&nbsp;');

        if (isLotNumberEntryRequired) {
            var column = qtyReceiveConvColumn.replace("Conv", "");
            var qty = data[column]();
            var childDetails = data["ChildDetails"]();
            var total = 0;
            for (var o in childDetails) {
                total += childDetails[o][column]();
            }

            commands.append($('<a class="dx-link dxcustom-linkbutton dx-icon-icons8-view-details" title="Edit Lot Number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><span id="LotMark_' + data["ProductID"]() + '_' + qtyReceiveConvColumn + '" class="dx-icon-overflow ' + (total == qty ? 'hidden' : '') + '" style="color:red; font-size: 14px; margin-left: -6px;"></span>').on('dxclick', function () {
                downloadProductLot(function () {
                    openProductLotEditing(data, itemStatusID); // Open product lot popup entry
                });
            }));
            commands.append('&nbsp;');
        }

        return commands;
    }

    function setSummaryDataGridEditing(allowed) {
        var option = stockReceiveSummaryDataGrid().option('editing');
        var selection = stockReceiveSummaryDataGrid().option('selection');

        selection.mode = (allowed) ? 'multiple' : 'none';

        //option.allowAdding = allowed;
        option.allowUpdating = allowed;
        option.allowDeleting = allowed;
        stockReceiveSummaryDataGrid().option('editing', option);
        stockReceiveSummaryDataGrid().option('selection', selection);
        stockReceiveSummaryNewRow().option('disabled', !allowed);
        stockReceiveSummaryDeleteRows().option('disabled', true);
        stockReceiveSummaryDataGrid().repaint();
    }

    function openSelectedEditing(documentID, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vStockReceives.byKey(
            documentID, { expand: ['ChildSummaries/ChildDetails'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vStockReceiveViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vStockReceiveViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Stock Receival');
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
            if ((data.DocumentStatusID() == 1) && !isLotNumberEntryRequired) { // Draft
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
            } else if ((data.DocumentStatusID() == 2) || (data.DocumentStatusID() == 3)) { // Posted or Discarded
                disabled = true;
            }
        }

        setSummaryDataGridEditing(!disabled);

        stockReceivePost().option('disabled', newData || disabled);
        stockReceiveDiscard().option('disabled', newData || disabled);
        stockReceiveSaveAsDraftAndNew().option('disabled', disabled);
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

        form.getEditor('PrincipalName').option('value', 'PT. Amerta Indah Otsuka');

        form.getEditor('DocumentCode').option('value', documentCode);
        form.getEditor('TransactionDate').option('value', data.TransactionDate());
        form.getEditor('WarehouseID').option('value', data.WarehouseID());
        form.getEditor('PIC').option('value', data.PIC());
        form.getEditor('ReferenceNumber').option('value', data.ReferenceNumber());

        var fileUploader = stockReceiveEditDataAttachmentFile();
        CommonUtility.createEditDataAttachmentFileDownloader('vStockReceives', fileUploader,
            'StockReceives', data.AttachmentFile());
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
        var summaryDataGrid = stockReceiveSummaryDataGrid();
        summaryDataGrid.cancelEditData();

        data.ChildSummaries(summaries);
        summaryDataGrid.option('dataSource',
            createSummaryArrayDataSource(data.ChildSummaries()));
    }

    function saveEditing(statusID, action) {
        showLoadingPanel();

        var form = commonPopupEdit.form();

        var isValid = form.validate().isValid;
        var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

        var dataGrid = commonGridView.dataGrid();
        var dataSource = dataGrid.option('dataSource');
        var summaryDataSource = stockReceiveSummaryDataGrid().option('dataSource');
        var summaries = [];
        for (var i = 0; i < summaryDataSource.store()._array.length; i++)
            summaries.push(new Dismoyo_Ciptoning_Client.vStockReceiveSummaryViewModel(summaryDataSource.store()._array[i]));

        if (isValid) {
            if (summaries.length < 1) {
                errorMsg = 'Please specify at least one item in Receival Details.';
                isValid = false;
            }
        }

        if (isValid) {
            for (var i = 0; i < summaries.length; i++) {
                var summary = summaries[i];
                var sumQtyReceive = 0;
                for (var j = 0; j < summary.ChildDetails().length; j++) {
                    var details = summary.ChildDetails()[j];
                    sumQtyReceive += details.QtyReceive();
                }

                if (summary.QtyReceive() != sumQtyReceive) {
                    if (errorMsg == '')
                        errorMsg = 'Following products quantity of Receival Details items is not matched: ';
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

            var fileUploader = stockReceiveEditDataAttachmentFile();
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
                    details.Qty = details.QtyReceive * -1;
                }

                summary.Qty = summary.QtyReceive * -1;
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
        var qtyReceiveColumn = 'QtyReceive' + itemStatusName;
        var qtyReceiveConvColumn = 'QtyReceiveConv' + itemStatusName;

        return {
            itemStatusName: itemStatusName,
            qtyOnHandColumn: qtyOnHandColumn,
            qtyConvLColumn: qtyConvLColumn,
            qtyConvMColumn: qtyConvMColumn,
            qtyConvSColumn: qtyConvSColumn,
            qtyReceiveColumn: qtyReceiveColumn,
            qtyReceiveConvColumn: qtyReceiveConvColumn
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
        form.getEditor('QtyReceiveConv').option('value', data.QtyReceiveConv());
        form.getEditor('QtyReceive').option('value', data.QtyReceive());

        data = validateSummariesArrayStore(data);

        var detailsDataSource = CommonUtility.createArrayDataSource(
            'vStockReceiveDetailsViewModel',
            ['ProductID', 'ProductLotID'],
            ko.toJS(data.ChildDetails()));

        dataGrid.cancelEditData();
        dataGrid.option('dataSource', detailsDataSource);
    }

    function addDummyData(e, summaries) {
        if (!isLotNumberEntryRequired) {
            var data = commonPopupEdit.popupEditData();
            var summaryDataGrid = stockReceiveSummaryDataGrid();
            var dataSourceItems = [];

            if (!summaries) {
                var store = summaryDataGrid.option('dataSource').store();
                for (var i = 0; i < store._array.length; i++)
                    dataSourceItems.push(new Dismoyo_Ciptoning_Client.vStockReceiveSummaryViewModel(store._array[i]));
            } else {
                for (var i = 0; i < summaries.length; i++)
                    summaries[i].ChildDetails([]);

                dataSourceItems = summaries;
            }

            var details = e.data;

            var productLots = $.grep(dataSource_vStockOnHandAll, function (e) {
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
                            item.QtyReceive(DXUtility.getValue(details, 'QtyReceive'));
                            item.QtyReceiveConv(DXUtility.getValue(details, 'QtyReceiveConv'));
                        } else
                            dataSourceItems[i].ChildDetails().push(
                                new Dismoyo_Ciptoning_Client.vStockReceiveDetailsViewModel(details));

                        updateSummariesArrayStore(dataSourceItems[i]);
                    }
                }
            } else {
                DevExpress.ui.dialog.alert('DUMMY Lot Number for the selected product is not available.', 'Save Failed');
            }
        }
    }

    function saveProductLotEditing() {
        var data = productLotPopupEdit.popupEditData();
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        if (CommonUtility.validateProductLotEditing(
            data,
            productLotPopupEdit.dataGrid().option('dataSource'),
            productLotPopupEdit.form().getEditor('QtyReceive').option('value'),
            'Receive',
            'vStockReceiveDetailsViewModel',
            'QtyConvL',
            'QtyConvM',
            'QtyConvS',
            'QtyReceiveConv',
            'QtyReceive',
            false)) {
            updateSummariesArrayStore(data);

            productLotPopupEdit.popupEditOptions.visible(false);
            stockReceiveSummaryDataGrid().refresh();
        }
    }

    function downloadProductLot(productLotLoaded) {
        if ((dataSource_vStockOnHandAll.length == 0) && (dataSource_vStockOnHandAllByProduct.length == 0)) {
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
                    store: Dismoyo_Ciptoning_Client.DB.vStockOnHandAlls,
                    select: [
                        'ProductID',
                        'ProductLotID',
                        'ProductLotCode',
                        'ProductLot',
                        'ProductLotExpiredDate',
                        'QtyOnHandGood'
                    ],
                    filter: [
                        ['WarehouseID', '=', warehouseID]
                    ],
                    sort: ['WarehouseID', 'ProductID', 'ProductLotID'],
                    paginate: false,
                    map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOnHandAllViewModel(item); }
                });

                dataSource.load()
                    .done(function (result2) {
                        var product = null;
                        var stockOnHandAll = [];
                        var stockOnHandAllByProduct = [];
                        for (var i = 0; i < result2.length; i++) {
                            stockOnHandAll.push(new Dismoyo_Ciptoning_Client.vStockOnHandAllViewModel(result2[i].toJS()));

                            var j = stockOnHandAllByProduct.length - 1;
                            var productID = result2[i].ProductID();
                            if ((i == 0) || (stockOnHandAllByProduct[j].ProductID() != productID)) {
                                stockOnHandAllByProduct.push(new Dismoyo_Ciptoning_Client.vStockOnHandAllViewModel(result2[i].toJS()));
                                j++;
                                product = $.grep(result, function (e) { return (e.ID() == productID); });
                            } else {
                                stockOnHandAllByProduct[j].QtyOnHandGood(stockOnHandAllByProduct[j].QtyOnHandGood() +
                                    result2[i].QtyOnHandGood());
                                stockOnHandAllByProduct[j].QtyOnHandHold(stockOnHandAllByProduct[j].QtyOnHandHold() +
                                    result2[i].QtyOnHandHold());
                                stockOnHandAllByProduct[j].QtyOnHandBad(stockOnHandAllByProduct[j].QtyOnHandBad() +
                                    result2[i].QtyOnHandBad());
                            }

                            stockOnHandAll[i].ProductCode(product[0].Code());
                            stockOnHandAll[i].Product(product[0].Product());
                            stockOnHandAll[i].ProductUOMLID(product[0].UOMLID());
                            stockOnHandAll[i].ProductUOMMID(product[0].UOMMID());
                            stockOnHandAll[i].ProductUOMSID(product[0].UOMSID());
                            stockOnHandAll[i].ProductConversionL(product[0].ConversionL());
                            stockOnHandAll[i].ProductConversionM(product[0].ConversionM());
                            stockOnHandAll[i].ProductConversionS(product[0].ConversionS());

                            stockOnHandAllByProduct[j].ProductCode(product[0].Code());
                            stockOnHandAllByProduct[j].Product(product[0].Product());
                            stockOnHandAllByProduct[j].ProductUOMLID(product[0].UOMLID());
                            stockOnHandAllByProduct[j].ProductUOMMID(product[0].UOMMID());
                            stockOnHandAllByProduct[j].ProductUOMSID(product[0].UOMSID());
                            stockOnHandAllByProduct[j].ProductConversionL(product[0].ConversionL());
                            stockOnHandAllByProduct[j].ProductConversionM(product[0].ConversionM());
                            stockOnHandAllByProduct[j].ProductConversionS(product[0].ConversionS());
                        }

                        dataSource_vStockOnHandAll = stockOnHandAll;
                        dataSource_vStockOnHandAllByProduct = stockOnHandAllByProduct;

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
        caption: 'Stock Receival',
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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockReceives.AddNewStockReceive');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockReceives.EditStockReceive');

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
            var dataGrid = $('#vStockReceives_commonGridView').find('.dx-datagrid:first-child');
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

                var allowUpdating = user.isAuthorized('StockReceives.EditStockReceive');                
                if (allowUpdating)
                    tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                tr += '</tr>';

                var table = dataGrid.find('.dx-header-row:first-child');
                $(tr).insertBefore(table[0].parentElement);
                $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
            }
        },
        cellTemplate: function (container, options) {
            var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
            var allowUpdating = user.isAuthorized('StockReceives.EditStockReceive');

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

    var stockReceiveEditDataAttachmentFile = function () { return DXUtility.getDXInstance(null, '#vStockReceives_editDataAttachmentFile', 'dxFileUploader'); }

    var stockReceiveSummaryDataGrid = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceiveSummaryDataGrid', 'dxDataGrid'); }

    var stockReceivePost = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceivePost', 'dxButton'); }
    var stockReceiveDiscard = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceiveDiscard', 'dxButton'); }
    var stockReceiveSaveAsDraftAndNew = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceiveSaveAsDraftAndNew', 'dxButton'); }
    var stockReceiveSummaryNewRow = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceiveSummaryNewRow', 'dxButton'); }
    var stockReceiveSummaryDeleteRows = function () { return DXUtility.getDXInstance(null, '#vStockReceives_stockReceiveSummaryDeleteRows', 'dxButton'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Receival Details'));

        var commands = $('<div class="desktop-commonGridView-commands">');

        var commandSummaryNewRow = $('<div id="vStockReceives_stockReceiveSummaryNewRow">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () {
                var isValid = commonPopupEdit.form().validate().isValid;

                if (isValid) {
                    downloadProductLot(function () {
                        stockReceiveSummaryDataGrid().addRow();
                    });
                }
                else
                    DevExpress.ui.dialog.alert('Please specify the required fields.', 'New Receival Details Failed');
            }
        });

        var commandSummaryDeleteRows = $('<div id="vStockReceives_stockReceiveSummaryDeleteRows">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            DXUtility.deleteSelectedRows(stockReceiveSummaryDataGrid());
                        }
                    });
            }
        });

        commands.append(commandSummaryNewRow);
        commands.append(commandSummaryDeleteRows);

        content.append(commands);

        content.append($('<div id="vStockReceives_stockReceiveSummaryDataGrid">').dxDataGrid({
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
                info.data.QtyReceive = 0;
                info.data.QtyReceiveConv = '0/0/0';
            },
            onSelectionChanged: function (e) {
                stockReceiveSummaryDeleteRows().option('disabled', !e.selectedRowsData.length);
            },
            onEditorPreparing: function (e) {
                if (e.parentType == 'dataRow') {
                    if (e.dataField == 'Product') {
                        if (e.row.inserted) {
                            e.editorElement.dxLookup({
                                dataSource: dataSource_vStockOnHandAllByProduct,
                                displayExpr: 'Product',
                                valueExpr: 'Product',
                                searchExpr: 'Product',
                                searchPlaceholder: 'Product',
                                popupWidth: '712px',
                                showPopupTitle: false,
                                fieldEditEnabled: true,
                                value: e.value,
                                onContentReady: function (ea) {
                                    CommonUtility.createProductLookupHeader('vStockReceives_productIDLookup', ea.element, 1); // Good
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
                                                e.component.cellValue(e.row.rowIndex, 'QtyReceiveConv'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            DXUtility.setValue(e.row.data, 'QtyReceive', conversion.qtyTransaction);
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
                    } else if (e.dataField == 'QtyReceiveConv') {
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
                                stockReceiveSummaryDataGrid().saveEditData();
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
                                    DXUtility.setValue(e.row.data, e.dataField.replace('QtyReceiveConv', 'QtyReceive'), qty);
                                }

                                var conversion = CommonUtility.getConversion(
                                    (ea.value) ? ea.value : '0/0/0',
                                    DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionS')
                                );

                                //DXUtility.setValue(e.row.data, e.dataField.replace('QtyReceiveConv', 'QtyReceive'), conversion.qtyTransaction);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyReceiveConv', 'QtyConvL'), conversion.qtyConvL);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyReceiveConv', 'QtyConvM'), conversion.qtyConvM);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyReceiveConv', 'QtyConvS'), conversion.qtyConvS);

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
                    new Dismoyo_Ciptoning_Client.vStockReceiveSummaryViewModel(info.data).toJS()
                );

                addDummyData(info);
                stockReceiveSummaryDataGrid().clearSelection();
            },
            onRowUpdated: function (info) {
                info.data.ProductID = info.key.ProductID;
                addDummyData(info);
                stockReceiveSummaryDataGrid().clearSelection();
            },
            onRowRemoved: function (info) {
                CommonUtility.validateDataGridRemovedTransactionSummary(
                    info.component,
                    info.data.toJS()
                );
            },
            onRowUpdating: function (info) {
                if (info.newData.QtyReceiveConv) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyReceiveConv,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvL = conversion.qtyConvL;
                    info.newData.QtyConvM = conversion.qtyConvM;
                    info.newData.QtyConvS = conversion.qtyConvS;
                    info.newData.QtyReceive = conversion.qtyTransaction;
                }

                updateDeferSummariesArrayStore(info.oldData.ProductID(), info.newData);
            },
            onRowValidating: function (e) {
                var qtyReceive = DXUtility.getValue(e.newData, 'QtyReceive');
                if (qtyReceive == undefined)
                    qtyReceive = DXUtility.getValue(e.oldData, 'QtyReceive');

                if (qtyReceive <= 0) {
                    e.errorText = 'Receival Qty must be greater than 0.';
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
                    var dataGrid = $(stockReceiveSummaryDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var isEditable = (stockReceiveSummaryDataGrid().option('selection').mode == 'none') ? false : true;

                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

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
                dataField: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '150px', allowEditing: false,
                dataType: 'number'
            }, {
                dataField: 'QtyReceiveConv', caption: 'Receival Qty (L/M/S)', width: '180px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyReceiveConv', 1)); // Good
                }
            }]
        }));

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPost = $('<div id="vStockReceives_stockReceivePost">').dxButton({
            text: 'Post', icon: 'icons8-check-green',
            onClick: function () { commonPopupEdit.events.performPost(this); }
        });

        var commandDiscard = $('<div id="vStockReceives_stockReceiveDiscard" style="margin-right: 16px;">').dxButton({
            text: 'Discard', icon: 'icons8-trash-red',
            onClick: function () { commonPopupEdit.events.performDiscard(this); }
        });

        var commandSaveAsDraftAndNew = $('<div id="vStockReceives_stockReceiveSaveAsDraftAndNew">').dxButton({
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
                itemElement.append(CommonUtility.createEditDataAttachmentFileUploader('vStockReceives', 'StockReceives'));
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
        caption: 'Stock Receival',
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
                    dataSource_vStockOnHandAll = [];
                    dataSource_vStockOnHandAllByProduct = [];

                    if (e.value) {
                        var data = commonPopupEdit.popupEditData();

                        var summaryDataGrid = stockReceiveSummaryDataGrid();
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
            dataField: 'PrincipalName',
            label: { text: 'Principal' },
            colSpan: 3,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 3
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
        info.data.QtyReceive = 0;
        info.data.QtyReceiveConv = '0/0/0';
    };

    productLotPopupEdit.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow') {
            if (e.dataField == 'ProductLotCode') {
                if (e.row.inserted) {
                    e.editorElement.dxLookup({
                        dataSource: new DevExpress.data.DataSource({
                            store: dataSource_vStockOnHandAll,
                            filter: ['ProductID', '=', productLotPopupEdit.popupEditData().ProductID()],
                            sort: [{ getter: 'ProductLotExpiredDate', desc: true }]
                        }),
                        displayExpr: 'ProductLotCode',
                        valueExpr: 'ProductLotCode',
                        searchExpr: 'ProductLotCode',
                        searchPlaceholder: 'Lot Number',
                        popupWidth: '602px',
                        showPopupTitle: false,
                        fieldEditEnabled: true,
                        value: e.value,
                        onContentReady: function (ea) {
                            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;

                            CommonUtility.createProductLotLookupHeader('vStockReceives_productLotIDLookup', ea.element, itemStatusID);
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
                                        e.component.cellValue(e.row.rowIndex, 'QtyReceiveConv'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionS')
                                    );

                                    DXUtility.setValue(e.row.data, 'QtyReceive', conversion.qtyTransaction);
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
            } else if (e.dataField == 'QtyReceiveConv') {
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
                        var conversion = CommonUtility.getConversion(
                            (ea.value) ? ea.value : '0/0/0',
                            DXUtility.getValue(e.row.data, 'ProductConversionL'),
                            DXUtility.getValue(e.row.data, 'ProductConversionM'),
                            DXUtility.getValue(e.row.data, 'ProductConversionS')
                        );

                        DXUtility.setValue(e.row.data, 'QtyReceive', conversion.qtyTransaction);
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
            new Dismoyo_Ciptoning_Client.vStockReceiveDetailsViewModel(info.data).toJS()
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
            'QtyReceiveConv',
            'QtyReceive'
        );
    };

    productLotPopupEdit.dataGridOptions.onRowValidating = function (e) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var qtyReceive = DXUtility.getValue(e.newData, 'QtyReceive');
        if (qtyReceive == undefined)
            qtyReceive = DXUtility.getValue(e.oldData, 'QtyReceive');

        if (qtyReceive <= 0) {
            e.errorText = 'Receival Qty must be greater than 0.';
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
            showInColumn: 'QtyReceiveConv',
            displayFormat: 'Total Qty (Pcs): {0}',
            valueFormat: 'decimal',
            summaryType: 'custom'
        }, {
            name: 'TotalQtyLMS',
            showInColumn: 'QtyReceiveConv',
            displayFormat: '(L/M/S): {0}',
            valueFormat: 'string',
            summaryType: 'custom'
        }],
        calculateCustomSummary: function (options) {
            CommonUtility.updateProductLotEditingSummary(options,
                'QtyReceiveConv',
                'QtyReceive');
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
        dataField: 'QtyReceiveConv', caption: 'Receival Qty (L/M/S)', width: '150px',
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
            dataField: 'QtyReceive',
            label: { text: 'Receival Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyReceiveConv',
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

        icon: 'Images/stock_receive_32px.png',

        dataSource_vStockReceiveDetails: dataSource_vStockReceiveDetails,
        dataSource_vStockReceiveSummary: dataSource_vStockReceiveSummary,
        dataSource_vStockOnHandAll: dataSource_vStockOnHandAll,
        dataSource_vStockOnHandAllByProduct: dataSource_vStockOnHandAllByProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        productLotPopupEdit: productLotPopupEdit,

        stockReceiveSummaryDataGrid: stockReceiveSummaryDataGrid,
        stockReceivePost: stockReceivePost,
        stockReceiveDiscard: stockReceiveDiscard,
        stockReceiveSaveAsDraftAndNew: stockReceiveSaveAsDraftAndNew,
        isLotNumberEntryRequired: isLotNumberEntryRequired
    };
};
