Dismoyo_Ciptoning_Client.vStockOpnames = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isLotNumberEntryRequired;

    function handlevStockOpnamesModification() { shouldReload = true; }

    var preventChangeWarehouseID = false;
    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vStockOpnames');
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vStockOpnames.off('modified', handlevStockOpnamesModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockOpnames,
        select: [
            'DocumentID',
            'DocumentCode',
            'Territory',
            'Region',
            'Area',
            'Company',
            'TransactionDate',
            'Warehouse',
            'ReferenceNumber',
            'DocumentStatusName',
            'PIC',
            'PostedDate',
            'CreatedByUserName',
            'CreatedDate',
            'ModifiedByUserName',
            'ModifiedDate'
        ],
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOpnameViewModel(item); }
    });



    Dismoyo_Ciptoning_Client.DB.vStockOpnames.on('modified', handlevStockOpnamesModification);



    var dataSource_vStockOpnameDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockOpnameDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOpnameDetailsViewModel(item); }
    });

    var dataSource_vStockOpnameSummary = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockOpnameSummaries,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOpnameSummaryViewModel(item); }
    });

    var dataSource_vStockOnHandAll;
    var dataSource_vStockOnHandAllByProduct;

    var conversionValidationRule = {
        type: 'pattern',
        pattern: '(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)',
        message: 'Format must be L/M/S or M/S or S.'
    };

    function previewDocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-06-(Auto Generated)';
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

        var warehouseDataSource = DataUtility.GetLookupWarehouseDataSource(['SiteID', '=', siteID]);

        form.getEditor('WarehouseID').option('value', null);
        form.getEditor('WarehouseID').option('dataSource', []);
        warehouseDataSource.load()
            .done(function (result) {
                form.getEditor('WarehouseID').option('dataSource', warehouseDataSource);
            });
    }


    function updateSummariesArrayStore(summary) {
        CommonUtility.updateSummariesArrayStore(
            stockOpnameSummaryDataGrid().option('dataSource').store(),
            summary
        );
    }

    function updateDeferSummariesArrayStore(productID, summary) {
        CommonUtility.updateDeferSummariesArrayStore(
            stockOpnameSummaryDataGrid().option('dataSource').store(),
            productID,
            summary
        );
    }

    function validateSummariesArrayStore(summary) {
        return CommonUtility.validateSummaryArrayStore(
            stockOpnameSummaryDataGrid().option('dataSource').store(),
            'vStockOpnameSummaryViewModel',
            summary
        );
    }

    function createSummaryArrayDataSource(summaries) {
        return CommonUtility.createArrayDataSource(
            'vStockOpnameSummaryViewModel',
            ['ProductID'],
            summaries
        );
    }

    function createProductLotEditCommands(data, qtyOpnameConvColumn, itemStatusID) {
        var commands = $('<div class="dx-command-edit" style="text-align: right; padding-right: 5px;">');

        commands.append($('<a style="color: inherit;">').text(data[qtyOpnameConvColumn]()));
        commands.append('&nbsp;');
        if (isLotNumberEntryRequired) {
            var column = qtyOpnameConvColumn.replace("Conv", "");
            var qty = data[column]();
            var childDetails = data["ChildDetails"]();
            var total = 0;
            for (var o in childDetails) {
                total += childDetails[o][column]();
            }

            commands.append($('<a class="dx-link dxcustom-linkbutton dx-icon-icons8-view-details" title="Edit Lot Number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><span id="LotMark_' + data["ProductID"]() + '_' + qtyOpnameConvColumn + '" class="dx-icon-overflow ' + (total == qty ? 'hidden' : '') + '" style="color:red; font-size: 14px; margin-left: -6px;"></span>').on('dxclick', function () {
                downloadProductLot(function () {
                    openProductLotEditing(data, itemStatusID); // Open product lot popup entry
                });
            }));
            commands.append('&nbsp;');
        }

        return commands;
    }

    function setSummaryDataGridEditing(allowed) {
        var option = stockOpnameSummaryDataGrid().option('editing');
        var selection = stockOpnameSummaryDataGrid().option('selection');

        selection.mode = (allowed) ? 'multiple' : 'none';

        //option.allowAdding = allowed;
        option.allowUpdating = allowed;
        option.allowDeleting = allowed;
        stockOpnameSummaryDataGrid().option('editing', option);
        stockOpnameSummaryDataGrid().option('selection', selection);
        stockOpnameSummaryNewRow().option('disabled', !allowed);
        stockOpnameSummaryDeleteRows().option('disabled', true);
        stockOpnameSummaryDataGrid().repaint();
    }

    function openSelectedEditing(documentID, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vStockOpnames.byKey(
            documentID, { expand: ['ChildSummaries/ChildDetails'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vStockOpnameViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vStockOpnameViewModel();
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Stock Opname');
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
            } else if ((data.DocumentStatusID() == 2) || (data.DocumentStatusID() == 3)) // Posted or Discarded
                disabled = true;
        }

        setSummaryDataGridEditing(!disabled);

        stockOpnamePrint().option('disabled', newData);
        stockOpnamePost().option('disabled', newData || disabled);
        stockOpnameDiscard().option('disabled', newData || disabled);
        stockOpnameSaveAsDraftAndNew().option('disabled', disabled);
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

        preventChangeWarehouseID = true;
        form.getEditor('WarehouseID').option('value', data.WarehouseID());
        form.getEditor('TransactionDate').option('value', data.TransactionDate());
        form.getEditor('PIC').option('value', data.PIC());
        form.getEditor('ReferenceNumber').option('value', data.ReferenceNumber());

        var fileUploader = stockOpnameEditDataAttachmentFile();
        CommonUtility.createEditDataAttachmentFileDownloader('vStockOpnames', fileUploader,
            'StockOpnames', data.AttachmentFile());
        fileUploader.option('value', null);

        form.getEditor('DocumentStatusID').option('value', data.DocumentStatusID());

        form.getEditor('TransactionDate').option('readOnly', true);
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
        } else {
            if (data.DocumentStatusID() == 1)
                form.getEditor('TransactionDate').option('value', today);
        }

        // Set grid datasource for summary including details
        var summaryDataGrid = stockOpnameSummaryDataGrid();
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
        var summaryDataSource = stockOpnameSummaryDataGrid().option('dataSource');
        var summaries = [];
        for (var i = 0; i < summaryDataSource.store()._array.length; i++)
            summaries.push(new Dismoyo_Ciptoning_Client.vStockOpnameSummaryViewModel(summaryDataSource.store()._array[i]));

        if (isValid) {
            if (summaries.length <= 0) {
                errorMsg = 'Please specify at least one item in Opname Details.';
                isValid = false;
            }
        }

        if (isValid) {
            for (var i = 0; i < summaries.length; i++) {
                var summary = summaries[i];
                var sumQtyOpnameGood = 0;
                var sumQtyOpnameHold = 0;
                var sumQtyOpnameBad = 0;
                for (var j = 0; j < summary.ChildDetails().length; j++) {
                    var details = summary.ChildDetails()[j];
                    sumQtyOpnameGood += details.QtyOpnameGood();
                    sumQtyOpnameHold += details.QtyOpnameHold();
                    sumQtyOpnameBad += details.QtyOpnameBad();
                }

                if ((summary.QtyOpnameGood() != sumQtyOpnameGood) ||
                    (summary.QtyOpnameHold() != sumQtyOpnameHold) ||
                    (summary.QtyOpnameBad() != sumQtyOpnameBad)) {
                    if (errorMsg == '')
                        errorMsg = 'Following products quantity of Opname Details items is not matched: ';
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

            var fileUploader = stockOpnameEditDataAttachmentFile();
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
                    details.QtyGood = details.QtyOpnameGood - details.QtyOnHandGood;
                    details.QtyHold = details.QtyOpnameHold - details.QtyOnHandHold;
                    details.QtyBad = details.QtyOpnameBad - details.QtyOnHandBad;
                }

                summary.QtyGood = summary.QtyOpnameGood - summary.QtyOnHandGood;
                summary.QtyHold = summary.QtyOpnameHold - summary.QtyOnHandHold;
                summary.QtyBad = summary.QtyOpnameBad - summary.QtyOnHandBad;
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

    function printEditing(documentID) {
        commonPopupIFrame.popupEdit().option('title', 'Print Stock Opname');        
        commonPopupIFrame.popupEditOptions.visible(true);
        
        var iframe = commonPopupIFrame.iframe();

        commonPopupIFrame.showLoadingPanel();
        iframe.attr('src', Dismoyo_Ciptoning_Client.ReportWebsite.StockOpnameReport.url([['DocumentID', '=', documentID]]));
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
        var qtyOpnameColumn = 'QtyOpname' + itemStatusName;
        var qtyOpnameConvColumn = 'QtyOpnameConv' + itemStatusName;

        return {
            itemStatusName: itemStatusName,
            qtyOnHandColumn: qtyOnHandColumn,
            qtyConvLColumn: qtyConvLColumn,
            qtyConvMColumn: qtyConvMColumn,
            qtyConvSColumn: qtyConvSColumn,
            qtyOpnameColumn: qtyOpnameColumn,
            qtyOpnameConvColumn: qtyOpnameConvColumn
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

        var productLotColumns = getProductLotColumns(itemStatusID);

        var colQtyOnHand = dataGrid.columnOption('QtyOnHand');
        var colQtyOpnameConv = dataGrid.columnOption('QtyOpnameConv');

        colQtyOnHand.dataField = productLotColumns.qtyOnHandColumn;
        colQtyOpnameConv.dataField = productLotColumns.qtyOpnameConvColumn;

        dataGrid.columnOption('QtyOnHand', colQtyOnHand);
        dataGrid.columnOption('QtyOpnameConv', colQtyOpnameConv);

        form.getEditor('Product').option('value', data.Product());
        form.getEditor('QtyOnHand').option('value', data[productLotColumns.qtyOnHandColumn]());
        form.getEditor('QtyOpnameConv').option('value', data[productLotColumns.qtyOpnameConvColumn]());

        var conversion = CommonUtility.getConversion(
            data[productLotColumns.qtyOpnameConvColumn](),
            DXUtility.getValue(data, 'ProductConversionL'),
            DXUtility.getValue(data, 'ProductConversionM'),
            DXUtility.getValue(data, 'ProductConversionS')
        );

        form.getEditor('QtyOpname').option('value', conversion.qtyTransaction);

        data = validateSummariesArrayStore(data);

        var childDetails = [];
        if (data.ChildDetails().length > 0) {
            var items = $.grep(data.ChildDetails(), function (e) {
                return ((e[productLotColumns.qtyOnHandColumn]() > 0) ||
                    ((e[productLotColumns.qtyConvLColumn]() > 0) ||
                    (e[productLotColumns.qtyConvMColumn]() > 0) ||
                    (e[productLotColumns.qtyConvSColumn]() > 0)))
            });

            for (var i = 0; i < items.length; i++)
                childDetails.push(items[i]);
        }

        var detailsDataSource = CommonUtility.createArrayDataSource(
            'vStockOpnameDetailsViewModel',
            ['ProductID', 'ProductLotID'],
            childDetails
        );

        dataGrid.cancelEditData();
        dataGrid.option('dataSource', detailsDataSource);
    }

    function addDummyData(e, summaries) {
        if (!isLotNumberEntryRequired) {
            var data = commonPopupEdit.popupEditData();
            var summaryDataGrid = stockOpnameSummaryDataGrid();
            var dataSourceItems = [];

            if (!summaries) {
                var store = summaryDataGrid.option("dataSource").store();
                for (var i = 0; i < store._array.length; i++)
                    dataSourceItems.push(new Dismoyo_Ciptoning_Client.vStockOpnameSummaryViewModel(store._array[i]));
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
                    var data = dataSourceItems[i];
                    if (data.ProductID() == DXUtility.getValue(details, 'ProductID')) {
                        var items = $.grep(data.ChildDetails(), function (e) {
                            return (e.ProductLotID() == DXUtility.getValue(details, 'ProductLotID'));
                        });

                        if (items.length > 0) {
                            var item = items[0];
                            var qty;

                            qty = DXUtility.getValue(details, 'QtyOpnameGood');
                            if (qty != undefined) {
                                item.QtyConvLGood(DXUtility.getValue(details, 'QtyConvLGood'));
                                item.QtyConvMGood(DXUtility.getValue(details, 'QtyConvMGood'));
                                item.QtyConvSGood(DXUtility.getValue(details, 'QtyConvSGood'));
                                item.QtyOpnameGood(qty);
                                item.QtyOpnameConvGood(DXUtility.getValue(details, 'QtyOpnameConvGood'));
                            }

                            qty = DXUtility.getValue(details, 'QtyOpnameHold');
                            if (qty != undefined) {
                                item.QtyConvLHold(DXUtility.getValue(details, 'QtyConvLHold'));
                                item.QtyConvMHold(DXUtility.getValue(details, 'QtyConvMHold'));
                                item.QtyConvSHold(DXUtility.getValue(details, 'QtyConvSHold'));
                                item.QtyOpnameHold(qty);
                                item.QtyOpnameConvHold(DXUtility.getValue(details, 'QtyOpnameConvHold'));
                            }

                            qty = DXUtility.getValue(details, 'QtyOpnameBad')
                            if (qty != undefined) {
                                item.QtyConvLBad(DXUtility.getValue(details, 'QtyConvLBad'));
                                item.QtyConvMBad(DXUtility.getValue(details, 'QtyConvMBad'));
                                item.QtyConvSBad(DXUtility.getValue(details, 'QtyConvSBad'));
                                item.QtyOpnameBad(qty);
                                item.QtyOpnameConvBad(DXUtility.getValue(details, 'QtyOpnameConvBad'));
                            }
                        } else {
                            if (details.QtyOpnameGood == undefined) {
                                DXUtility.setValue(details, 'QtyConvLGood', 0);
                                DXUtility.setValue(details, 'QtyConvMGood', 0);
                                DXUtility.setValue(details, 'QtyConvSGood', 0);
                                DXUtility.setValue(details, 'QtyOpnameGood', 0);
                                DXUtility.setValue(details, 'QtyOpnameConvGood', '0/0/0');
                            }

                            if (details.QtyOpnameHold == undefined) {
                                DXUtility.setValue(details, 'QtyConvLHold', 0);
                                DXUtility.setValue(details, 'QtyConvMHold', 0);
                                DXUtility.setValue(details, 'QtyConvSHold', 0);
                                DXUtility.setValue(details, 'QtyOpnameHold', 0);
                                DXUtility.setValue(details, 'QtyOpnameConvHold', '0/0/0');
                            }

                            if (details.QtyOpnameBad == undefined) {
                                DXUtility.setValue(details, 'QtyConvLBad', 0);
                                DXUtility.setValue(details, 'QtyConvMBad', 0);
                                DXUtility.setValue(details, 'QtyConvSBad', 0);
                                DXUtility.setValue(details, 'QtyOpnameBad', 0);
                                DXUtility.setValue(details, 'QtyOpnameConvBad', '0/0/0');
                            }

                            dataSourceItems[i].ChildDetails().push(
                                new Dismoyo_Ciptoning_Client.vStockOpnameDetailsViewModel(details));
                        }

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
            productLotPopupEdit.form().getEditor('QtyOpname').option('value'),
            'Opname',
            'vStockOpnameDetailsViewModel',
            productLotColumns.qtyConvLColumn,
            productLotColumns.qtyConvMColumn,
            productLotColumns.qtyConvSColumn,
            productLotColumns.qtyOpnameConvColumn,
            productLotColumns.qtyOpnameColumn,
            true)) {
            updateSummariesArrayStore(data);

            productLotPopupEdit.popupEditOptions.visible(false);
            stockOpnameSummaryDataGrid().refresh();
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
                            'QtyOnHandGood',
                            'QtyOnHandHold',
                            'QtyOnHandBad'
                        ],
                        filter: ['WarehouseID', '=', warehouseID],
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
        caption: 'Stock Opname',
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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockOpnames.AddNewStockOpname');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockOpnames.EditStockOpname');

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
    }, {
        dataField: 'DocumentCode', caption: 'Document Number', width: '140px', sortOrder: 'desc',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vStockOpnames_commonGridView').find('.dx-datagrid:first-child');
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
            var allowUpdating = user.isAuthorized('StockOpnames.EditStockOpname');

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

    var stockOpnameEditDataAttachmentFile = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_editDataAttachmentFile', 'dxFileUploader'); }

    var stockOpnameSummaryDataGrid = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnameSummaryDataGrid', 'dxDataGrid'); }

    var stockOpnamePrint = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnamePrint', 'dxButton'); }
    var stockOpnamePost = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnamePost', 'dxButton'); }
    var stockOpnameDiscard = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnameDiscard', 'dxButton'); }
    var stockOpnameSaveAsDraftAndNew = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnameSaveAsDraftAndNew', 'dxButton'); }

    var stockOpnameSummaryNewRow = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnameSummaryNewRow', 'dxButton'); }
    var stockOpnameSummaryDeleteRows = function () { return DXUtility.getDXInstance(null, '#vStockOpnames_stockOpnameSummaryDeleteRows', 'dxButton'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Opname Details'));

        var commands = $('<div class="desktop-commonGridView-commands">');

        var commandSummaryNewRow = $('<div id="vStockOpnames_stockOpnameSummaryNewRow">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () {
                var isValid = commonPopupEdit.form().validate().isValid;

                if (isValid) {
                    downloadProductLot(function () {
                        stockOpnameSummaryDataGrid().addRow();
                    });
                }
                else
                    DevExpress.ui.dialog.alert('Please specify the required fields.', 'New Opname Details Failed');
            }
        });

        var commandSummaryDeleteRows = $('<div id="vStockOpnames_stockOpnameSummaryDeleteRows">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            DXUtility.deleteSelectedRows(stockOpnameSummaryDataGrid());
                        }
                    });
            }
        });

        commands.append(commandSummaryNewRow);
        commands.append(commandSummaryDeleteRows);

        content.append(commands);

        content.append($('<div id="vStockOpnames_stockOpnameSummaryDataGrid">').dxDataGrid({
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
            onSelectionChanged: function (e) {
                stockOpnameSummaryDeleteRows().option('disabled', !e.selectedRowsData.length);
            },
            onInitNewRow: function (info) {
                info.data.QtyOpnameGood = 0;
                info.data.QtyOpnameHold = 0;
                info.data.QtyOpnameBad = 0;

                info.data.QtyOpnameConvGood = '0/0/0';
                info.data.QtyOpnameConvHold = '0/0/0';
                info.data.QtyOpnameConvBad = '0/0/0';
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
                                popupWidth: '832px',
                                showPopupTitle: false,
                                fieldEditEnabled: true,
                                value: e.value,
                                onContentReady: function (ea) {
                                    CommonUtility.createProductLookupHeader('vStockOpnames_productIDLookup', ea.element, null);
                                },
                                itemTemplate: function (data, index, element) {
                                    return CommonUtility.createProductLookupItem(data, element, null);
                                },
                                onValueChanged: function (ea) {
                                    if (ea.value) {
                                        var item = this.option('selectedItem');
                                        if (item) {
                                            e.component.cellValue(e.row.rowIndex, 'QtyOnHandGood', item.QtyOnHandGood());
                                            e.component.cellValue(e.row.rowIndex, 'QtyOnHandHold', item.QtyOnHandHold());
                                            e.component.cellValue(e.row.rowIndex, 'QtyOnHandBad', item.QtyOnHandBad());

                                            DXUtility.setValue(e.row.data, 'ProductID', item.ProductID());
                                            DXUtility.setValue(e.row.data, 'ProductCode', item.ProductCode());
                                            DXUtility.setValue(e.row.data, 'Product', item.Product());
                                            DXUtility.setValue(e.row.data, 'ProductUOMLID', item.ProductUOMLID());
                                            DXUtility.setValue(e.row.data, 'ProductUOMMID', item.ProductUOMMID());
                                            DXUtility.setValue(e.row.data, 'ProductUOMSID', item.ProductUOMSID());
                                            DXUtility.setValue(e.row.data, 'ProductConversionL', item.ProductConversionL());
                                            DXUtility.setValue(e.row.data, 'ProductConversionM', item.ProductConversionM());
                                            DXUtility.setValue(e.row.data, 'ProductConversionS', item.ProductConversionS());

                                            var conversionGood = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyOpnameConvGood'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            var conversionHold = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyOpnameConvHold'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            var conversionBad = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyOpnameConvBad'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            DXUtility.setValue(e.row.data, 'QtyOpnameGood', conversionGood.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvLGood', conversionGood.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvMGood', conversionGood.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvSGood', conversionGood.qtyConvS);

                                            DXUtility.setValue(e.row.data, 'QtyOpnameHold', conversionHold.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvLHold', conversionHold.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvMHold', conversionHold.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvSHold', conversionHold.qtyConvS);

                                            DXUtility.setValue(e.row.data, 'QtyOpnameBad', conversionBad.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvLBad', conversionBad.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvMBad', conversionBad.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvSBad', conversionBad.qtyConvS);
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
                    } else if ((e.dataField == 'QtyOpnameConvGood') || (e.dataField == 'QtyOpnameConvHold') ||
                        (e.dataField == 'QtyOpnameConvBad')) {
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
                                stockOpnameSummaryDataGrid().saveEditData();
                            },
                            onValueChanged: function (ea) {
                                var conversion = CommonUtility.getConversion(
                                    (ea.value) ? ea.value : '0/0/0',
                                    DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionS')
                                );

                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyOpname'), conversion.qtyTransaction);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvL'), conversion.qtyConvL);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvM'), conversion.qtyConvM);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvS'), conversion.qtyConvS);

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
                    new Dismoyo_Ciptoning_Client.vStockOpnameSummaryViewModel(info.data).toJS()
                );

                addDummyData(info);
                stockOpnameSummaryDataGrid().clearSelection();
            },
            onRowUpdated: function (info) {
                info.data.ProductID = info.key.ProductID;
                addDummyData(info);
                stockOpnameSummaryDataGrid().clearSelection();
            },
            onRowRemoved: function (info) {
                CommonUtility.validateDataGridRemovedTransactionSummary(
                    info.component,
                    info.data.toJS()
                );
            },
            onRowUpdating: function (info) {
                if (info.newData.QtyOpnameConvGood) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyOpnameConvGood,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvLGood = conversion.qtyConvL;
                    info.newData.QtyConvMGood = conversion.qtyConvM;
                    info.newData.QtyConvSGood = conversion.qtyConvS;
                    info.newData.QtyOpnameGood = conversion.qtyTransaction;
                }

                if (info.newData.QtyOpnameConvHold) {
                    var conversion = CommonUtility.getConversion(
                        info.newData.QtyOpnameConvHold,
                        DXUtility.getValue(info.oldData, 'ProductConversionL'),
                        DXUtility.getValue(info.oldData, 'ProductConversionM'),
                        DXUtility.getValue(info.oldData, 'ProductConversionS')
                    );

                    info.newData.QtyConvLHold = conversion.qtyConvL;
                    info.newData.QtyConvMHold = conversion.qtyConvM;
                    info.newData.QtyConvSHold = conversion.qtyConvS;
                    info.newData.QtyOpnameHold = conversion.qtyTransaction;
                }

                if (info.newData.QtyOpnameConvBad) {
                    var conversion = CommonUtility.getConversion(
                        info.newData.QtyOpnameConvBad,
                        DXUtility.getValue(info.oldData, 'ProductConversionL'),
                        DXUtility.getValue(info.oldData, 'ProductConversionM'),
                        DXUtility.getValue(info.oldData, 'ProductConversionS')
                    );

                    info.newData.QtyConvLBad = conversion.qtyConvL;
                    info.newData.QtyConvMBad = conversion.qtyConvM;
                    info.newData.QtyConvSBad = conversion.qtyConvS;
                    info.newData.QtyOpnameBad = conversion.qtyTransaction;
                }

                updateDeferSummariesArrayStore(info.oldData.ProductID(), info.newData);
            },
            onRowValidating: function (e) {
                var qtyOnHandGood = DXUtility.getValue(e.newData, 'QtyOnHandGood');
                if (qtyOnHandGood == undefined)
                    qtyOnHandGood = DXUtility.getValue(e.oldData, 'QtyOnHandGood');

                var qtyOnHandHold = DXUtility.getValue(e.newData, 'QtyOnHandHold');
                if (qtyOnHandHold == undefined)
                    qtyOnHandHold = DXUtility.getValue(e.oldData, 'QtyOnHandHold');

                var qtyOnHandBad = DXUtility.getValue(e.newData, 'QtyOnHandBad');
                if (qtyOnHandBad == undefined)
                    qtyOnHandBad = DXUtility.getValue(e.oldData, 'QtyOnHandBad');

                var qtyOpnameGood = DXUtility.getValue(e.newData, 'QtyOpnameGood');
                if (qtyOpnameGood == undefined)
                    qtyOpnameGood = DXUtility.getValue(e.oldData, 'QtyOpnameGood');

                var qtyOpnameHold = DXUtility.getValue(e.newData, 'QtyOpnameHold');
                if (qtyOpnameHold == undefined)
                    qtyOpnameHold = DXUtility.getValue(e.oldData, 'QtyOpnameHold');

                var qtyOpnameBad = DXUtility.getValue(e.newData, 'QtyOpnameBad');
                if (qtyOpnameBad == undefined)
                    qtyOpnameBad = DXUtility.getValue(e.oldData, 'QtyOpnameBad');

                if ((qtyOnHandGood == 0) && (qtyOpnameGood <= 0) &&
                    (qtyOnHandHold == 0) && (qtyOpnameHold <= 0) &&
                    (qtyOnHandBad == 0) && (qtyOpnameBad <= 0)) {
                    e.errorText = 'Opname Qty Good/Hold/Bad must be greater than 0 when On Hand Qty Good/Hold/Bad is 0.';
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
                    var dataGrid = $(stockOpnameSummaryDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var isEditable = (stockOpnameSummaryDataGrid().option('selection').mode == 'none') ? false : true;

                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                        tr += '       <td class="dx-datagrid-action" colspan="3">' + 'On Hand Qty (Pcs)' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Opname Qty (L/M/S)' + '</td>';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '</tr>'

                        var table = dataGrid.find('.dx-header-row:first-child');
                        $(tr).insertBefore(table[0].parentElement);
                        $(columnHeader).append(HtmlUtility.htmlEncode(headerInfo.column.caption));
                    }
                }
            }, {
                dataField: 'QtyOnHandGood', caption: 'Good', width: '70px', allowEditing: false,
                dataType: 'number'
            }, {
                dataField: 'QtyOnHandHold', caption: 'Hold', width: '70px', allowEditing: false,
                dataType: 'number',
            }, {
                dataField: 'QtyOnHandBad', caption: 'Bad', width: '70px', allowEditing: false,
                dataType: 'number',
            }, {
                dataField: 'QtyOpnameConvGood', caption: 'Good', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyOpnameConvGood', 1)); // Good
                }
            }, {
                dataField: 'QtyOpnameConvHold', caption: 'Hold', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyOpnameConvHold', 2)); // Hold
                }
            }, {
                dataField: 'QtyOpnameConvBad', caption: 'Bad', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyOpnameConvBad', 3)); // Bad
                }
            }]
        }));

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPrint = $('<div id="vStockOpnames_stockOpnamePrint" style="margin-right: 32px;">').dxButton({
            text: 'Print', icon: 'icons8-print',
            onClick: function () { commonPopupEdit.events.performPrint(this); }
        });

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPost = $('<div id="vStockOpnames_stockOpnamePost">').dxButton({
            text: 'Post', icon: 'icons8-check-green',
            onClick: function () { commonPopupEdit.events.performPost(this); }
        });

        var commandDiscard = $('<div id="vStockOpnames_stockOpnameDiscard" style="margin-right: 16px;">').dxButton({
            text: 'Discard', icon: 'icons8-trash-red',
            onClick: function () { commonPopupEdit.events.performDiscard(this); }
        });

        var commandSaveAsDraftAndNew = $('<div id="vStockOpnames_stockOpnameSaveAsDraftAndNew">').dxButton({
            text: 'Save & New', icon: 'icons8-save',
            onClick: function () { commonPopupEdit.events.performSaveAsDraftAndNew(this); }
        });

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
        extCommands.append(commandPrint);
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

    commonPopupEdit.events.performPrint = function (rootView) {
        var data = commonPopupEdit.popupEditData();

        printEditing(data.DocumentID());
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
                itemElement.append(CommonUtility.createEditDataAttachmentFileUploader('vStockOpnames', 'StockOpnames'));
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

                    if (e.selectedItem) {
                        preDocumentCode = previewDocumentCode(e.selectedItem.Code());
                        form.getEditor('Company').option('value', e.selectedItem.Company());
                    } else if (e.previousValue != null)
                        form.getEditor('Company').option('value', null);

                    updateSiteChildEditor(form, e.value);

                    form.getEditor('DocumentCode').option('value', preDocumentCode);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock Opname',
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
                    var form = commonPopupEdit.form();
                    if (e.value) {
                        var filters = [
                          ['WarehouseID', '=', e.value], 'and',
                          ['DocumentStatusID', '=', 2]
                        ];
                        var dataSource = new DevExpress.data.DataSource({
                            select: [
                                "TransactionDate",
                            ],
                            filter: filters,
                            store: Dismoyo_Ciptoning_Client.DB.vStockOpnames,
                            map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOpnameViewModel(item); }
                        });

                        dataSource.load()
                            .done(function (result) {
                                result.sort(function (a, b) {
                                    var c = new Date(a.TransactionDate());
                                    var d = new Date(b.TransactionDate());
                                    return c - d;
                                });
                                if (result.length > 0) {
                                    form.getEditor('TransactionDate').option('min', result[result.length - 1].TransactionDate());
                                    if (new Date(form.getEditor('TransactionDate').option('value')).setHours(0, 0, 0, 0) < new Date(form.getEditor('TransactionDate').option('min')).setHours(0, 0, 0, 0)) {
                                        form.validate().isValid = false
                                        form.getEditor('TransactionDate').option('isValid', false);

                                    }
                                }
                            });
                    }

                    if (e.value && !preventChangeWarehouseID) {
                        var data = commonPopupEdit.popupEditData();

                        var summaryDataGrid = stockOpnameSummaryDataGrid();
                        summaryDataGrid.cancelEditData();

                        showLoadingPanel();

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

                                var dataSource = new DevExpress.data.DataSource({
                                    store: Dismoyo_Ciptoning_Client.DB.vStockOnHandAvailables,
                                    select: [
                                        'ProductID',
                                        'ProductLotID',
                                        'ProductLotCode',
                                        'QtyOnHandGood',
                                        'QtyOnHandHold',
                                        'QtyOnHandBad'
                                    ],
                                    filter: [
                                        ['WarehouseID', '=', e.value], 'and',
                                        [
                                            ['QtyOnHandGood', '>', 0], 'or',
                                            ['QtyOnHandHold', '>', 0], 'or',
                                            ['QtyOnHandBad', '>', 0],
                                        ]
                                    ],
                                    sort: ['WarehouseID', 'ProductID', 'ProductLotID'],
                                    paginate: false,
                                    map: function (item) { return new Dismoyo_Ciptoning_Client.vStockOnHandAvailableViewModel(item); }
                                });

                                dataSource.load()
                                    .done(function (result2) {
                                        var product = null;
                                        var summaries = [];
                                        for (var i = 0; i < result2.length; i++) {
                                            var j = summaries.length - 1;
                                            var productID = result2[i].ProductID();
                                            if ((i == 0) || (summaries[j].ProductID() != productID)) {
                                                summaries.push(new Dismoyo_Ciptoning_Client.vStockOpnameSummaryViewModel());

                                                j++;
                                                product = $.grep(result, function (e) { return (e.ID() == productID); });

                                                summaries[j].ProductID(product[0].ID());
                                                summaries[j].ProductCode(product[0].Code());
                                                summaries[j].Product(product[0].Product());
                                                summaries[j].ProductUOMLID(product[0].UOMLID());
                                                summaries[j].ProductUOMMID(product[0].UOMMID());
                                                summaries[j].ProductUOMSID(product[0].UOMSID());
                                                summaries[j].ProductConversionL(product[0].ConversionL());
                                                summaries[j].ProductConversionM(product[0].ConversionM());
                                                summaries[j].ProductConversionS(product[0].ConversionS());

                                                summaries[j].QtyOpnameConvGood('0/0/0');
                                                summaries[j].QtyOpnameConvHold('0/0/0');
                                                summaries[j].QtyOpnameConvBad('0/0/0');

                                                summaries[j].QtyOpnameGood(0);
                                                summaries[j].QtyOpnameHold(0);
                                                summaries[j].QtyOpnameBad(0);

                                                summaries[j].QtyOnHandGood(result2[i].QtyOnHandGood());
                                                summaries[j].QtyOnHandHold(result2[i].QtyOnHandHold());
                                                summaries[j].QtyOnHandBad(result2[i].QtyOnHandBad());

                                                summaries[j].ChildDetails([]);
                                            } else {
                                                summaries[j].QtyOnHandGood(summaries[j].QtyOnHandGood() + result2[i].QtyOnHandGood());
                                                summaries[j].QtyOnHandHold(summaries[j].QtyOnHandHold() + result2[i].QtyOnHandHold());
                                                summaries[j].QtyOnHandBad(summaries[j].QtyOnHandBad() + result2[i].QtyOnHandBad());
                                            }

                                            var details = new Dismoyo_Ciptoning_Client.vStockOpnameDetailsViewModel();

                                            details.ProductID(product[0].ID());
                                            details.ProductCode(product[0].Code());
                                            details.Product(product[0].Product());
                                            details.ProductUOMLID(product[0].UOMLID());
                                            details.ProductUOMMID(product[0].UOMMID());
                                            details.ProductUOMSID(product[0].UOMSID());
                                            details.ProductConversionL(product[0].ConversionL());
                                            details.ProductConversionM(product[0].ConversionM());
                                            details.ProductConversionS(product[0].ConversionS());

                                            details.ProductLotID(result2[i].ProductLotID());
                                            details.ProductLotCode(result2[i].ProductLotCode());

                                            details.QtyOpnameConvGood('0/0/0');
                                            details.QtyOpnameConvHold('0/0/0');
                                            details.QtyOpnameConvBad('0/0/0');

                                            details.QtyOpnameGood(0);
                                            details.QtyOpnameHold(0);
                                            details.QtyOpnameBad(0);

                                            details.QtyOnHandGood(result2[i].QtyOnHandGood());
                                            details.QtyOnHandHold(result2[i].QtyOnHandHold());
                                            details.QtyOnHandBad(result2[i].QtyOnHandBad());

                                            summaries[j].ChildDetails().push(details);
                                        }

                                        data.ChildSummaries(summaries);
                                        summaryDataGrid.option('dataSource',
                                            createSummaryArrayDataSource(data.ChildSummaries()));

                                        hideLoadingPanel();
                                    })
                                    .fail(function (error) {
                                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download product lot data.'), 'Download Product Lot Failed');

                                        data.ChildSummaries([]);
                                        summaryDataGrid.option('dataSource',
                                            createSummaryArrayDataSource(data.ChildSummaries()));

                                        hideLoadingPanel();
                                    });
                            })
                            .fail(function (error) {
                                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to download product data.'), 'Download Product Failed');

                                data.ChildSummaries([]);
                                summaryDataGrid.option('dataSource',
                                    createSummaryArrayDataSource(data.ChildSummaries()));

                                hideLoadingPanel();
                            });
                    }

                    preventChangeWarehouseID = false;
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

    productLotPopupEdit.events.performDeleteRows = function () {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var dataGrid = productLotPopupEdit.dataGrid();
        var dataSource = dataGrid.option('dataSource');

        var selectedRowsData = dataGrid.getSelectedRowsData();
        var errorMsg = '';
        var deletedRowKeys = [];

        for (var i = 0; i < selectedRowsData.length; i++) {
            var data = selectedRowsData[i];
            if (DXUtility.getValue(data, productLotColumns.qtyOnHandColumn) > 0) {
                if (errorMsg == '')
                    errorMsg = 'Following product lot code cannot be deleted due to the On Hand Qty (Pcs) is greater than 0: ';
                else
                    errorMsg += ', ';

                errorMsg += DXUtility.getValue(data, 'ProductLotCode');
                continue;
            }

            deletedRowKeys.push({
                ProductID: DXUtility.getValue(data, 'ProductID'),
                ProductLotID: DXUtility.getValue(data, 'ProductLotID'),
            });
        }

        for (var i = 0; i < deletedRowKeys.length; i++) {
            dataSource.store().remove(deletedRowKeys[i])
                .done(function (result) {
                    if (i >= (deletedRowKeys.length - 1))
                        dataSource.load().done(function (result) { dataGrid.refresh(); });
                })
                .fail(function (error) {
                    if (i >= (deletedRowKeys.length - 1))
                        dataSource.load().done(function (result) { dataGrid.refresh(); });
                });
        }

        if (errorMsg != '') {
            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(errorMsg), 'Delete Product Lot');
        }
    };

    productLotPopupEdit.dataGridOptions.onInitNewRow = function (info) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        info.data[productLotColumns.qtyOpnameColumn] = 0;
        info.data[productLotColumns.qtyOpnameConvColumn] = '0/0/0';
    };

    productLotPopupEdit.dataGridOptions.onEditorPreparing = function (e) {
        if (e.parentType == 'dataRow') {
            if (e.dataField == 'ProductLotCode') {
                if (e.row.inserted) {
                    e.editorElement.dxLookup({
                        dataSource: new DevExpress.data.DataSource({
                            store: dataSource_vStockOnHandAll,
                            filter: ['ProductID', '=', productLotPopupEdit.popupEditData().ProductID()],
                            sort: [{ getter: 'ProductLotExpiredDate', desc: true }],
                        }),
                        displayExpr: 'ProductLotCode',
                        valueExpr: 'ProductLotCode',
                        searchExpr: 'ProductLot',
                        searchPlaceholder: 'Lot Number',
                        popupWidth: '582px',
                        showPopupTitle: false,
                        fieldEditEnabled: true,
                        value: e.value,
                        onContentReady: function (ea) {
                            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;

                            CommonUtility.createProductLotLookupHeader('vStockOpnames_productLotIDLookup', ea.element, itemStatusID);
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

                                    DXUtility.setValue(e.row.data, 'QtyOnHandGood', item.QtyOnHandGood());
                                    DXUtility.setValue(e.row.data, 'QtyOnHandHold', item.QtyOnHandHold());
                                    DXUtility.setValue(e.row.data, 'QtyOnHandBad', item.QtyOnHandBad());

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
                                        e.component.cellValue(e.row.rowIndex, 'QtyOpnameConv'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionS')
                                    );

                                    DXUtility.setValue(e.row.data, productLotColumns.qtyOpnameColumn, conversion.qtyTransaction);
                                    DXUtility.setValue(e.row.data, productLotColumns.qtyConvLColumn, conversion.qtyConvL);
                                    DXUtility.setValue(e.row.data, productLotColumns.qtyConvMColumn, conversion.qtyConvM);
                                    DXUtility.setValue(e.row.data, productLotColumns.qtyConvSColumn, conversion.qtyConvS);
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
            } else if (e.name == 'QtyOpnameConv') {
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
                        // commented by Asep 
                        //if (DXUtility.getValue(e.row.data, 'Product') == undefined) {
                        //    ea.value = '';
                        //}

                        // commented by Asep
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
                        //    DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyOpname'), qty);
                        //}

                        var conversion = CommonUtility.getConversion(
                            (ea.value) ? ea.value : '0/0/0',
                            DXUtility.getValue(e.row.data, 'ProductConversionL'),
                            DXUtility.getValue(e.row.data, 'ProductConversionM'),
                            DXUtility.getValue(e.row.data, 'ProductConversionS')
                        );

                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyOpname'), conversion.qtyTransaction);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvL'), conversion.qtyConvL);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvM'), conversion.qtyConvM);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyOpnameConv', 'QtyConvS'), conversion.qtyConvS);

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
            new Dismoyo_Ciptoning_Client.vStockOpnameDetailsViewModel(info.data).toJS()
        );
    };

    productLotPopupEdit.dataGridOptions.onRowRemoved = function (info) {
        CommonUtility.validateDataGridRemovedTransactionDetails(
            info.component,
            info.data.toJS()
        );
    };

    productLotPopupEdit.dataGridOptions.onRowUpdating = function (info) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        CommonUtility.validateDataGridUpdatingTransactionDetails(
            info,
            productLotColumns.qtyConvLColumn,
            productLotColumns.qtyConvMColumn,
            productLotColumns.qtyConvSColumn,
            productLotColumns.qtyOpnameConvColumn,
            productLotColumns.qtyOpnameColumn
        );
    };

    productLotPopupEdit.dataGridOptions.onRowRemoving = function (info) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        if (info.data[productLotColumns.qtyOnHandColumn]() > 0) {
            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(
                'Deleting product lot is not allowed when Qty On Hand (Pcs) is greater than 0.'), 'Delete Product Lot Failed');
            info.cancel = true;
        }
    };

    productLotPopupEdit.dataGridOptions.onRowValidating = function (e) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var qtyOnHand = DXUtility.getValue(e.newData, productLotColumns.qtyOnHandColumn);
        if (qtyOnHand == undefined)
            qtyOnHand = DXUtility.getValue(e.oldData, productLotColumns.qtyOnHandColumn);

        var qtyOpname = DXUtility.getValue(e.newData, productLotColumns.qtyOpnameColumn);
        if (qtyOpname == undefined)
            qtyOpname = DXUtility.getValue(e.oldData, productLotColumns.qtyOpnameColumn);

        if ((qtyOnHand == 0) && (qtyOpname <= 0)) {
            e.errorText = 'Opname Qty must be greater than 0 when On Hand Qty is 0.';
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
            showInColumn: 'QtyOpnameConv',
            displayFormat: 'Total Qty (Pcs): {0}',
            valueFormat: 'decimal',
            summaryType: 'custom'
        }, {
            name: 'TotalQtyLMS',
            showInColumn: 'QtyOpnameConv',
            displayFormat: '(L/M/S): {0}',
            valueFormat: 'string',
            summaryType: 'custom'
        }],
        calculateCustomSummary: function (options) {
            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
            var productLotColumns = getProductLotColumns(itemStatusID);

            CommonUtility.updateProductLotEditingSummary(options,
                productLotColumns.qtyOpnameConvColumn,
                productLotColumns.qtyOpnameColumn);
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
        name: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '180px', allowEditing: false,
        dataType: 'number'
    }, {
        name: 'QtyOpnameConv', caption: 'Opname Qty (L/M/S)', width: '180px',
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
            dataField: 'QtyOpname',
            label: { text: 'Opname Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyOpnameConv',
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

        icon: 'Images/stock_opname_32px.png',

        dataSource_vStockOpnameDetails: dataSource_vStockOpnameDetails,
        dataSource_vStockOpnameSummary: dataSource_vStockOpnameSummary,
        dataSource_vStockOnHandAll: dataSource_vStockOnHandAll,
        dataSource_vStockOnHandAllByProduct: dataSource_vStockOnHandAllByProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        commonPopupIFrame: commonPopupIFrame,
        productLotPopupEdit: productLotPopupEdit,

        stockOpnameSummaryDataGrid: stockOpnameSummaryDataGrid,
        stockOpnamePrint: stockOpnamePrint,
        stockOpnamePost: stockOpnamePost,
        stockOpnameDiscard: stockOpnameDiscard,
        stockOpnameSaveAsDraftAndNew: stockOpnameSaveAsDraftAndNew,
        isLotNumberEntryRequired: isLotNumberEntryRequired
    };
};
