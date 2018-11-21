Dismoyo_Ciptoning_Client.vStockTransfers = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    var dataSourceObservable = ko.observable();
    var dataSource;
    var isDataGridRefreshRequired;
    var isLotNumberEntryRequired;

    function handlevStockTransfersModification() { shouldReload = true; }

    var pane;

    function checkContainer() {
        pane = CommonUtility.configureCommonGridViewLayout('vStockTransfers');
        if (!pane)
            setTimeout(checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        if (!user.IsHeadOffice()) {
            var filters = [
                ['SourceTerritoryID', '=', user.TerritoryID()], 'and',
                ['SourceRegionID', '=', user.RegionID()], 'and',
                ['SourceAreaID', '=', user.AreaID()], 'and',
                ['SourceCompanyID', '=', user.CompanyID()], 'and',
                ['SourceSiteID', '=', user.SiteID()]
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

    function handleViewDisposing() { Dismoyo_Ciptoning_Client.DB.vStockTransfers.off('modified', handlevStockTransfersModification); }


    function refreshList() {
        shouldReload = false; dataSource.pageIndex(0); dataSource.load();
    }

    dataSource = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockTransfers,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockTransferViewModel(item); }
    });

    Dismoyo_Ciptoning_Client.DB.vStockTransfers.on('modified', handlevStockTransfersModification);



    var dataSource_vStockTransferDetails = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockTransferDetails,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockTransferDetailsViewModel(item); }
    });

    var dataSource_vStockTransferSummary = new DevExpress.data.DataSource({
        store: Dismoyo_Ciptoning_Client.DB.vStockTransferSummaries,
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client.vStockTransferSummaryViewModel(item); }
    });

    var dataSource_vStockOnHandAvailable;
    var dataSource_vStockOnHandAvailableByProduct;

    var conversionValidationRule = {
        type: 'pattern',
        pattern: '(^[0-9]*$)|(^[0-9]*\/[0-9]*$)|(^[0-9]*\/[0-9]*\/[0-9]*$)',
        message: 'Format must be L/M/S or M/S or S.'
    };

    function previewDocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-08-(Auto Generated)';
    }

    function previewDODocumentCode(siteCode) {
        return ((siteCode) ? siteCode : '(Site Code)') + '-YY-10-(Auto Generated)';
    }

    function updateSiteChildEditor(form, siteID, companyID) {
        if (siteID) {
            Dismoyo_Ciptoning_Client.DB.vSites.byKey(siteID)
                .done(function (result) {
                    isLotNumberEntryRequired = result.IsLotNumberEntryRequired;
                });
        } else {
            siteID = null;
            isLotNumberEntryRequired = undefined;
        }

        var sourceWarehouseDataSource = DataUtility.GetLookupWarehouseDataSource(['SiteID', '=', siteID]);

        form.getEditor('SourceWarehouseID').option('value', null);
        form.getEditor('SourceWarehouseID').option('dataSource', []);
        sourceWarehouseDataSource.load()
            .done(function (result) {
                form.getEditor('SourceWarehouseID').option('dataSource', sourceWarehouseDataSource);
            });

        var destinationSiteDataSource = DataUtility.GetLookupSiteDataSource(['CompanyID', '=', companyID]);

        form.getEditor('DestinationSiteID').option('value', null);
        form.getEditor('DestinationSiteID').option('dataSource', []);
        destinationSiteDataSource.load()
            .done(function (result) {
                form.getEditor('DestinationSiteID').option('dataSource', destinationSiteDataSource);
            });
    }


    function getValueFromSystemParameter(value) {
        var sysParam = Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.dataByFilter(['ID', '=', value]);
        if (sysParam.length > 0)
            return sysParam[0].Value();

        return null;
    }
    
    function validateCreatedBySFA(createdByUserName) {
        var sfaUserName = getValueFromSystemParameter('User.SFAUserName');
        return ((createdByUserName != undefined) && (createdByUserName != null) &&
            (createdByUserName.toLowerCase() == sfaUserName.toLowerCase()));
    }


    function updateSummariesArrayStore(summary) {
        CommonUtility.updateSummariesArrayStore(
            stockTransferSummaryDataGrid().option('dataSource').store(),
            summary
        );
    }

    function updateDeferSummariesArrayStore(productID, summary) {
        CommonUtility.updateDeferSummariesArrayStore(
            stockTransferSummaryDataGrid().option('dataSource').store(),
            productID,
            summary
        );
    }

    function validateSummariesArrayStore(summary) {
        return CommonUtility.validateSummaryArrayStore(
            stockTransferSummaryDataGrid().option('dataSource').store(),
            'vStockTransferSummaryViewModel',
            summary
        );
    }

    function createSummaryArrayDataSource(summaries) {
        return CommonUtility.createArrayDataSource(
            'vStockTransferSummaryViewModel',
            ['ProductID'],
            summaries
        );
    }

    function createProductLotEditCommands(data, qtyTransferConvColumn, itemStatusID) {
        var commands = $('<div class="dx-command-edit" style="text-align: right; padding-right: 5px;">');

        commands.append($('<a style="color: inherit;">').text(data[qtyTransferConvColumn]()));
        commands.append('&nbsp;');
        if (isLotNumberEntryRequired) {
            var column = qtyTransferConvColumn.replace("Conv", "");
            var qty = data[column]();
            var childDetails = data["ChildDetails"]();
            var total = 0;
            for (var o in childDetails) {
                total += childDetails[o][column]();
            }

            commands.append($('<a class="dx-link dxcustom-linkbutton dx-icon-icons8-view-details" title="Edit Lot Number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a><span id="LotMark_' + data["ProductID"]() + '_' + qtyTransferConvColumn + '" class="dx-icon-overflow ' + (total == qty ? 'hidden' : '') + '" style="color:red; font-size: 14px; margin-left: -6px;"></span>').on('dxclick', function () {
                downloadProductLot(function () {
                    openProductLotEditing(data, itemStatusID); // Open product lot popup entry
                });
            }));
            commands.append('&nbsp;');
        }

        return commands;
    }

    function setSummaryDataGridEditing(allowed, createdBySFA) {
        var option = stockTransferSummaryDataGrid().option('editing');
        var selection = stockTransferSummaryDataGrid().option('selection');

        selection.mode = (allowed && !createdBySFA) ? 'multiple' : 'none';

        //option.allowAdding = allowed && !createdBySFA;
        option.allowUpdating = allowed;
        option.allowDeleting = allowed && !createdBySFA;
        stockTransferSummaryDataGrid().option('editing', option);
        stockTransferSummaryDataGrid().option('selection', selection);
        stockTransferSummaryNewRow().option('disabled', !(allowed && !createdBySFA));
        stockTransferSummaryDeleteRows().option('disabled', true);
        stockTransferSummaryDataGrid().repaint();
    }

    function openSelectedEditing(documentID, refreshRequired) {
        showLoadingPanel();

        Dismoyo_Ciptoning_Client.DB.vStockTransfers.byKey(
            documentID, { expand: ['ChildSummaries/ChildDetails'] })
            .done(function (result) {
                hideLoadingPanel();

                isDataGridRefreshRequired = refreshRequired;
                openEditing(new Dismoyo_Ciptoning_Client.vStockTransferViewModel(result));
            })
            .fail(function (error) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Failed to load selected data.'), 'Load Failed');
                hideLoadingPanel();
            });
    }

    function openEditing(data) {
        var newData = false;
        if (!data) {
            data = new Dismoyo_Ciptoning_Client.vStockTransferViewModel();
            data.DocumentStatusID(null);
            newData = true;
        }

        commonPopupEdit.popupEditData(data);

        commonPopupEdit.popupEdit().option('title', ((newData) ? 'New' : 'Edit') + ' Stock Transfer');
        commonPopupEdit.popupEditOptions.editingKey = data.DocumentID();
        commonPopupEdit.popupEditOptions.visible(true);
        commonPopupEdit.popupContent().scrollTo(0);

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var form = commonPopupEdit.form();
        DXUtility.resetFormValidation(form);

        // Disable/enable operation buttons
        var documentCode = data.DocumentCode();
        var doDocumentCode = data.DODocumentCode();
        var disabled = false;
        var createdBySFA = false;
        var summaries = [];

        isLotNumberEntryRequired = data.IsSourceSiteLotNumberEntryRequired();

        if (newData) {
            data.DocumentID(new DevExpress.data.Guid());
            data.DocumentStatusID(null);

            data.SourceTerritoryID(user.TerritoryID());
            data.SourceRegionID(user.RegionID());
            data.SourceAreaID(user.AreaID());
            data.SourceSiteID(user.SiteID());
            data.SourceSiteCode(user.SiteCode());
            data.SourceCompanyID(user.CompanyID());
            data.SourceCompany(user.Company());

            documentCode = previewDocumentCode(data.SourceSiteCode());
            doDocumentCode = previewDODocumentCode(data.SourceSiteCode());
        } else {
            summaries = data.ChildSummaries();
            if ((data.DocumentStatusID() == 1) && !isLotNumberEntryRequired) { // Draft
                createdBySFA = validateCreatedBySFA(data.CreatedByUserName());

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

        setSummaryDataGridEditing(!disabled, createdBySFA);

        stockTransferPrintDO().option('disabled', newData);
        stockTransferPost().option('disabled', newData || disabled);
        stockTransferDiscard().option('disabled', newData || disabled);
        stockTransferSaveAsDraftAndNew().option('disabled', disabled || createdBySFA);
        commonPopupEdit.ok().option('disabled', disabled || createdBySFA);

        // Set editor values
        if (form.itemOption('Organization').visible) {
            form.getEditor('TerritoryID').option('value', data.SourceTerritoryID());
            form.getEditor('RegionID').option('value', data.SourceRegionID());
            form.getEditor('AreaID').option('value', data.SourceAreaID());
            form.getEditor('SiteID').option('value', data.SourceSiteID());
            form.getEditor('Company').option('value', data.SourceCompany());

            form.getEditor('TerritoryID').option('readOnly', disabled || createdBySFA);
            form.getEditor('RegionID').option('readOnly', disabled || createdBySFA);
            form.getEditor('AreaID').option('readOnly', disabled || createdBySFA);
            form.getEditor('SiteID').option('readOnly', disabled || createdBySFA);
        }

        updateSiteChildEditor(form, data.SourceSiteID(), data.SourceCompanyID());

        form.getEditor('DocumentCode').option('value', documentCode);
        form.getEditor('TransactionDate').option('value', data.TransactionDate());
        form.getEditor('SourceWarehouseID').option('value', data.SourceWarehouseID());
        form.getEditor('SourcePIC').option('value', data.SourcePIC());
        form.getEditor('DestinationSiteID').option('value', data.DestinationSiteID());
        form.getEditor('DestinationWarehouseID').option('value', data.DestinationWarehouseID());
        form.getEditor('DestinationPIC').option('value', data.DestinationPIC());
        form.getEditor('ReferenceNumber').option('value', data.ReferenceNumber());

        var fileUploader = stockTransferEditDataAttachmentFile();
        CommonUtility.createEditDataAttachmentFileDownloader('vStockTransfers', fileUploader,
            'StockTransfers', data.AttachmentFile());
        fileUploader.option('value', null);

        form.getEditor('DocumentStatusID').option('value', data.DocumentStatusID());

        form.getEditor('DODocumentCode').option('value', doDocumentCode);
        form.getEditor('DOShipmentDate').option('value', data.DOShipmentDate());
        form.getEditor('DOReceivedDate').option('value', data.DOReceivedDate());
        form.getEditor('DOPrintedCount').option('value', data.DOPrintedCount());
        form.getEditor('DOLastPrintedDate').option('value', data.DOLastPrintedDate());

        form.getEditor('TransactionDate').option('readOnly', disabled || createdBySFA);
        form.getEditor('SourceWarehouseID').option('readOnly', disabled || createdBySFA);
        form.getEditor('SourcePIC').option('readOnly', disabled);
        form.getEditor('DestinationSiteID').option('readOnly', disabled || createdBySFA);
        form.getEditor('DestinationWarehouseID').option('readOnly', disabled || createdBySFA);
        form.getEditor('DestinationPIC').option('readOnly', disabled || createdBySFA);
        form.getEditor('ReferenceNumber').option('readOnly', disabled);

        form.getEditor('DOShipmentDate').option('readOnly', disabled);
        form.getEditor('DOReceivedDate').option('readOnly', disabled);
        
        var fileUploaderInput = $('.dx-fileuploader-input-wrapper');
        if (disabled)
            fileUploaderInput.hide();
        else
            fileUploaderInput.show();

        var today = new Date();

        if (newData) {
            DXUtility.resetFormValidation(form);

            form.getEditor('TransactionDate').option('value', today);
            form.getEditor('DOShipmentDate').option('value', today);
            //form.getEditor('DOReceivedDate').option('value', today);
        }

        // Set grid datasource for summary including details
        var summaryDataGrid = stockTransferSummaryDataGrid();
        summaryDataGrid.cancelEditData();

        data.ChildSummaries(summaries);
        summaryDataGrid.option('dataSource',
            createSummaryArrayDataSource(data.ChildSummaries()));
    }

    function addDummyData(e, summaries) {
        if (!isLotNumberEntryRequired) {
            var data = commonPopupEdit.popupEditData();
            var summaryDataGrid = stockTransferSummaryDataGrid();
            var dataSourceItems = [];

            if (!summaries) {
                var store = summaryDataGrid.option('dataSource').store();
                for (var i = 0; i < store._array.length; i++)
                    dataSourceItems.push(new Dismoyo_Ciptoning_Client.vStockTransferSummaryViewModel(store._array[i]));
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
                    var data = dataSourceItems[i];
                    if (data.ProductID() == DXUtility.getValue(details, 'ProductID')) {
                        var items = $.grep(data.ChildDetails(), function (e) {
                            return (e.ProductLotID() == DXUtility.getValue(details, 'ProductLotID'));
                        });

                        if (items.length > 0) {
                            var item = items[0];
                            var qty;

                            qty = DXUtility.getValue(details, 'QtyTransferGood');
                            if (qty != undefined) {
                                item.QtyConvLGood(DXUtility.getValue(details, 'QtyConvLGood'));
                                item.QtyConvMGood(DXUtility.getValue(details, 'QtyConvMGood'));
                                item.QtyConvSGood(DXUtility.getValue(details, 'QtyConvSGood'));
                                item.QtyTransferGood(qty);
                                item.QtyTransferConvGood(DXUtility.getValue(details, 'QtyTransferConvGood'));
                            }

                            qty = DXUtility.getValue(details, 'QtyTransferHold');
                            if (qty != undefined) {
                                item.QtyConvLHold(DXUtility.getValue(details, 'QtyConvLHold'));
                                item.QtyConvMHold(DXUtility.getValue(details, 'QtyConvMHold'));
                                item.QtyConvSHold(DXUtility.getValue(details, 'QtyConvSHold'));
                                item.QtyTransferHold(qty);
                                item.QtyTransferConvHold(DXUtility.getValue(details, 'QtyTransferConvHold'));
                            }

                            qty = DXUtility.getValue(details, 'QtyTransferBad')
                            if (qty != undefined) {
                                item.QtyConvLBad(DXUtility.getValue(details, 'QtyConvLBad'));
                                item.QtyConvMBad(DXUtility.getValue(details, 'QtyConvMBad'));
                                item.QtyConvSBad(DXUtility.getValue(details, 'QtyConvSBad'));
                                item.QtyTransferBad(qty);
                                item.QtyTransferConvBad(DXUtility.getValue(details, 'QtyTransferConvBad'));
                            }
                        } else {
                            if (details.QtyTransferGood == undefined) {
                                DXUtility.setValue(details, 'QtyConvLGood', 0);
                                DXUtility.setValue(details, 'QtyConvMGood', 0);
                                DXUtility.setValue(details, 'QtyConvSGood', 0);
                                DXUtility.setValue(details, 'QtyTransferGood', 0);
                                DXUtility.setValue(details, 'QtyTransferConvGood', '0/0/0');
                            }

                            if (details.QtyTransferHold == undefined) {
                                DXUtility.setValue(details, 'QtyConvLHold', 0);
                                DXUtility.setValue(details, 'QtyConvMHold', 0);
                                DXUtility.setValue(details, 'QtyConvSHold', 0);
                                DXUtility.setValue(details, 'QtyTransferHold', 0);
                                DXUtility.setValue(details, 'QtyTransferConvHold', '0/0/0');
                            }

                            if (details.QtyTransferBad == undefined) {
                                DXUtility.setValue(details, 'QtyConvLBad', 0);
                                DXUtility.setValue(details, 'QtyConvMBad', 0);
                                DXUtility.setValue(details, 'QtyConvSBad', 0);
                                DXUtility.setValue(details, 'QtyTransferBad', 0);
                                DXUtility.setValue(details, 'QtyTransferConvBad', '0/0/0');
                            }

                            dataSourceItems[i].ChildDetails().push(
                                new Dismoyo_Ciptoning_Client.vStockTransferDetailsViewModel(details));
                        }

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
        var summaryDataSource = stockTransferSummaryDataGrid().option('dataSource');
        var summaries = [];
        for (var i = 0; i < summaryDataSource.store()._array.length; i++)
            summaries.push(new Dismoyo_Ciptoning_Client.vStockTransferSummaryViewModel(summaryDataSource.store()._array[i]));

        if (isValid) {
            if (summaries.length <= 0) {
                errorMsg = 'Please specify at least one item in Transfer Details.';
                isValid = false;
            }
        }

        if (isValid) {
            for (var i = 0; i < summaries.length; i++) {
                var summary = summaries[i];
                var sumQtyTransferGood = 0;
                var sumQtyTransferHold = 0;
                var sumQtyTransferBad = 0;
                for (var j = 0; j < summary.ChildDetails().length; j++) {
                    var details = summary.ChildDetails()[j];
                    sumQtyTransferGood += details.QtyTransferGood();
                    sumQtyTransferHold += details.QtyTransferHold();
                    sumQtyTransferBad += details.QtyTransferBad();
                }

                if ((summary.QtyTransferGood() != sumQtyTransferGood) ||
                    (summary.QtyTransferHold() != sumQtyTransferHold) ||
                    (summary.QtyTransferBad() != sumQtyTransferBad)) {
                    if (errorMsg == '')
                        errorMsg = 'Following products quantity of Transfer Details items is not matched: ';
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
            data.SourceWarehouseID(form.getEditor('SourceWarehouseID').option('value'));
            data.SourcePIC(form.getEditor('SourcePIC').option('value'));
            data.DestinationWarehouseID(form.getEditor('DestinationWarehouseID').option('value'));
            data.DestinationPIC(form.getEditor('DestinationPIC').option('value'));
            data.ReferenceNumber(form.getEditor('ReferenceNumber').option('value'));

            data.DOShipmentDate(form.getEditor('DOShipmentDate').option('value'));
            data.DOReceivedDate(form.getEditor('DOReceivedDate').option('value'));
            data.DOPrintedCount(form.getEditor('DOPrintedCount').option('value'));
            data.DOLastPrintedDate(form.getEditor('DOLastPrintedDate').option('value'));

            var fileUploader = stockTransferEditDataAttachmentFile();
            data.AttachmentFile((fileUploader.option('values').length > 0) ? fileUploader.fileName : null);

            data.ChildSummaries(summaries);
            var dataJS = ko.toJS(data);

            if (statusID)
                dataJS.DocumentStatusID = statusID;

            if (!dataJS.DocumentStatusID)
                dataJS.DocumentStatusID = 1; // Draft

            dataJS.TransactionDate = DateTimeUtility.getFirstTimeOfDay(dataJS.TransactionDate);

            dataJS.DOShipmentDate = DateTimeUtility.getFirstTimeOfDay(dataJS.DOShipmentDate);
            dataJS.DOReceivedDate = DateTimeUtility.getFirstTimeOfDay(dataJS.DOReceivedDate);

            for (var i = 0; i < dataJS.ChildSummaries.length; i++) {
                var summary = dataJS.ChildSummaries[i];
                summary.DocumentID = dataJS.DocumentID;
                for (var j = 0; j < summary.ChildDetails.length; j++) {
                    var details = summary.ChildDetails[j];

                    details.DocumentID = dataJS.DocumentID;
                    details.QtyGood = details.QtyTransferGood * -1;
                    details.QtyHold = details.QtyTransferHold * -1;
                    details.QtyBad = details.QtyTransferBad * -1;
                }

                summary.QtyGood = summary.QtyTransferGood * -1;
                summary.QtyHold = summary.QtyTransferHold * -1;
                summary.QtyBad = summary.QtyTransferBad * -1;
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

    function printDOEditing(doDocumentID) {
        commonPopupIFrame.popupEdit().option('title', 'Print Delivery Order');
        commonPopupIFrame.popupEditOptions.visible(true);

        var iframe = commonPopupIFrame.iframe();

        commonPopupIFrame.showLoadingPanel();
        iframe.attr('src', Dismoyo_Ciptoning_Client.ReportWebsite.DeliveryOrderReport.url([['DocumentID', '=', doDocumentID]]));
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
        var qtyTransferColumn = 'QtyTransfer' + itemStatusName;
        var qtyTransferConvColumn = 'QtyTransferConv' + itemStatusName;

        return {
            itemStatusName: itemStatusName,
            qtyOnHandColumn: qtyOnHandColumn,
            qtyConvLColumn: qtyConvLColumn,
            qtyConvMColumn: qtyConvMColumn,
            qtyConvSColumn: qtyConvSColumn,
            qtyTransferColumn: qtyTransferColumn,
            qtyTransferConvColumn: qtyTransferConvColumn
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
        var colQtyTransferConv = dataGrid.columnOption('QtyTransferConv');

        colQtyOnHand.dataField = productLotColumns.qtyOnHandColumn;
        colQtyTransferConv.dataField = productLotColumns.qtyTransferConvColumn;

        dataGrid.columnOption('QtyOnHand', colQtyOnHand);
        dataGrid.columnOption('QtyTransferConv', colQtyTransferConv);

        form.getEditor('Product').option('value', data.Product());
        form.getEditor('QtyOnHand').option('value', data[productLotColumns.qtyOnHandColumn]());
        form.getEditor('QtyTransferConv').option('value', data[productLotColumns.qtyTransferConvColumn]());

        var conversion = CommonUtility.getConversion(
            data[productLotColumns.qtyTransferConvColumn](),
            DXUtility.getValue(data, 'ProductConversionL'),
            DXUtility.getValue(data, 'ProductConversionM'),
            DXUtility.getValue(data, 'ProductConversionS')
        );

        form.getEditor('QtyTransfer').option('value', conversion.qtyTransaction);

        data = validateSummariesArrayStore(data);

        var childDetails = [];
        if (data.ChildDetails().length > 0) {
            var items = $.grep(data.ChildDetails(), function (e) {
                return ((e[productLotColumns.qtyConvLColumn]() > 0) ||
                    (e[productLotColumns.qtyConvMColumn]() > 0) ||
                    (e[productLotColumns.qtyConvSColumn]() > 0))
            });

            for (var i = 0; i < items.length; i++)
                childDetails.push(items[i]);
        }

        var detailsDataSource = CommonUtility.createArrayDataSource(
            'vStockTransferDetailsViewModel',
            ['ProductID', 'ProductLotID'],
            childDetails
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
            productLotPopupEdit.form().getEditor('QtyTransfer').option('value'),
            'Transfer',
            'vStockTransferDetailsViewModel',
            productLotColumns.qtyConvLColumn,
            productLotColumns.qtyConvMColumn,
            productLotColumns.qtyConvSColumn,
            productLotColumns.qtyTransferConvColumn,
            productLotColumns.qtyTransferColumn,
            true)) {
            updateSummariesArrayStore(data);

            productLotPopupEdit.popupEditOptions.visible(false);
            stockTransferSummaryDataGrid().refresh();
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
                    var warehouseID = form.getEditor('SourceWarehouseID').option('value');

                    var dataSource = new DevExpress.data.DataSource({
                        store: Dismoyo_Ciptoning_Client.DB.vStockOnHandAvailables,
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
                        filter: [
                            ['WarehouseID', '=', warehouseID], 'and',
                            [
                                ['QtyOnHandGood', '>', 0], 'or',
                                ['QtyOnHandHold', '>', 0], 'or',
                                ['QtyOnHandBad', '>', 0]
                            ]
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
                                    'Product lot stock with item status Good/Hold/Bad for the selected warehouse is empty.'),
                                    'New Transfer Details Failed');
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
                        []);

                    var childSelectedItem = collapsibleFilter.form().getEditor('SourceWarehouseID').option('selectedItem');
                    if (childSelectedItem && (childSelectedItem['SiteID']() != e.value))
                        collapsibleFilter.form().getEditor('SourceWarehouseID').option('value', null);

                    childSelectedItem = collapsibleFilter.form().getEditor('DestinationWarehouseID').option('selectedItem');
                    if (childSelectedItem && (childSelectedItem['SiteID']() != e.value))
                        collapsibleFilter.form().getEditor('DestinationWarehouseID').option('value', null);

                    collapsibleFilter.form().getEditor('SourceWarehouseID').option('dataSource',
                        DataUtility['GetLookupWarehouseDataSource']((e.value) ? ['SiteID', '=', e.value] : null));

                    collapsibleFilter.form().getEditor('DestinationWarehouseID').option('dataSource',
                       DataUtility['GetLookupWarehouseDataSource']((e.value) ? ['SiteID', '=', e.value] : null));
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock Transfer',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'SourceWarehouseID',
            label: { text: 'Source Warehouse' },
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
            dataField: 'DestinationWarehouseID',
            label: { text: 'Destination Warehouse' },
            editorType: 'dxSelectBox',
            editorOptions: { //////////////////////////////////////////
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
        DXUtility.addFilterExpression(filterExpr, 'SourceTerritoryID', '=', territoryID, 'and');

        // RegionID
        DXUtility.addFilterExpression(filterExpr, 'SourceRegionID', '=', regionID, 'and');

        // AreaID
        DXUtility.addFilterExpression(filterExpr, 'SourceAreaID', '=', areaID, 'and');

        // CompanyID
        DXUtility.addFilterExpression(filterExpr, 'SourceCompanyID', '=', companyID, 'and');

        // SiteID
        DXUtility.addFilterExpression(filterExpr, 'SourceSiteID', '=', siteID, 'and');

        // SourceWarehouseID
        value = form.getEditor('SourceWarehouseID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SourceWarehouseID', '=', value, 'and');

        // DestinationWarehouseID
        value = form.getEditor('DestinationWarehouseID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'DestinationWarehouseID', '=', value, 'and');

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
        var groupFilterExpr = [];
        DXUtility.addFilterExpression(groupFilterExpr, 'SourcePIC', 'contains', value, 'or');
        DXUtility.addFilterExpression(groupFilterExpr, 'DestinationPIC', 'contains', value, 'or');
        DXUtility.addGroupFilterExpression(filterExpr, groupFilterExpr, 'and');

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

    commonGridView.newRowOptions.disabled = !Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockTransfers.AddNewStockTransfer');
    commonGridView.dataGridOptions.editing.allowUpdating = Dismoyo_Ciptoning_Client.app.CurrentUser.isAuthorized('StockTransfers.EditStockTransfer');

    // ------------------------------------------------------------------------------------------------
    // Data Grid Columns: Specify columns of the data grid here.
    // ------------------------------------------------------------------------------------------------
    commonGridView.dataGridOptions.columns = [{
        dataField: 'ID', visible: false
    }, {
        dataField: 'SourceTerritory', caption: 'Territory', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'SourceRegion', caption: 'Region', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'SourceArea', caption: 'Area', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'SourceCompany', caption: 'Company', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'SourceSite', caption: 'Site', width: '200px', visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()
    }, {
        dataField: 'DocumentCode', caption: 'Document Number', width: '140px', sortOrder: 'desc',
        headerCellTemplate: function (columnHeader, headerInfo) {
            var dataGrid = $('#vStockTransfers_commonGridView').find('.dx-datagrid:first-child');
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
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Source' + '</td>';
                tr += '       <td class="dx-datagrid-action" colspan="2">' + 'Destination' + '</td>';
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
            var allowUpdating = user.isAuthorized('StockTransfers.EditStockTransfer');

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
        dataField: 'SourceWarehouse', caption: 'Warehouse', width: '200px'
    }, {
        dataField: 'SourcePIC', caption: 'PIC', width: '180px'
    }, {
        dataField: 'DestinationWarehouse', caption: 'Warehouse', width: '200px'
    }, {
        dataField: 'DestinationPIC', caption: 'PIC', width: '180px'
    }, {
        dataField: 'ReferenceNumber', caption: 'Reference Number', width: '120px'
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

    var stockTransferEditDataAttachmentFile = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_editDataAttachmentFile', 'dxFileUploader'); }

    var stockTransferSummaryDataGrid = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferSummaryDataGrid', 'dxDataGrid'); }

    var stockTransferPrintDO = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferPrintDO', 'dxButton'); }
    var stockTransferPost = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferPost', 'dxButton'); }
    var stockTransferDiscard = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferDiscard', 'dxButton'); }
    var stockTransferSaveAsDraftAndNew = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferSaveAsDraftAndNew', 'dxButton'); }

    var stockTransferSummaryNewRow = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferSummaryNewRow', 'dxButton'); }
    var stockTransferSummaryDeleteRows = function () { return DXUtility.getDXInstance(null, '#vStockTransfers_stockTransferSummaryDeleteRows', 'dxButton'); }

    commonPopupEdit.popupEditOptions.onContentReady = function (e) {
        var extContent = $('#commonPopupEdit_extContent');
        var content = DXUtility.createFormItemGroupContent();

        content.append(DXUtility.createFormItemLabelTop('Transfer Details'));

        var commands = $('<div class="desktop-commonGridView-commands">');

        var commandSummaryNewRow = $('<div id="vStockTransfers_stockTransferSummaryNewRow">').dxButton({
            text: 'New', icon: 'add',
            onClick: function () {
                var isValid = commonPopupEdit.form().validate().isValid;

                if (isValid) {
                    downloadProductLot(function () {
                        stockTransferSummaryDataGrid().addRow();
                    });
                }
                else
                    DevExpress.ui.dialog.alert('Please specify the required fields.', 'New Transfer Details Failed');
            }
        });

        var commandSummaryDeleteRows = $('<div id="vStockTransfers_stockTransferSummaryDeleteRows">').dxButton({
            text: 'Delete', icon: 'remove', disabled: true,
            onClick: function () {
                DevExpress.ui.dialog.confirm(
                    'Are you sure want to delete the selected records?', 'Delete Confirmation').done(function (dialogResult) {
                        if (dialogResult) {
                            DXUtility.deleteSelectedRows(stockTransferSummaryDataGrid());
                        }
                    });
            }
        });

        commands.append(commandSummaryNewRow);
        commands.append(commandSummaryDeleteRows);

        content.append(commands);

        content.append($('<div id="vStockTransfers_stockTransferSummaryDataGrid">').dxDataGrid({
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
                stockTransferSummaryDeleteRows().option('disabled', !e.selectedRowsData.length);
            },
            onInitNewRow: function (info) {
                info.data.QtyTransferGood = 0;
                info.data.QtyTransferHold = 0;
                info.data.QtyTransferBad = 0;

                info.data.QtyTransferConvGood = '0/0/0';
                info.data.QtyTransferConvHold = '0/0/0';
                info.data.QtyTransferConvBad = '0/0/0';
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
                                popupWidth: '832px',
                                showPopupTitle: false,
                                fieldEditEnabled: true,
                                value: e.value,
                                onContentReady: function (ea) {
                                    CommonUtility.createProductLookupHeader('vStockTransfers_productIDLookup', ea.element, null);
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
                                                e.component.cellValue(e.row.rowIndex, 'QtyTransferConvGood'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            var conversionHold = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyTransferConvHold'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            var conversionBad = CommonUtility.getConversion(
                                                e.component.cellValue(e.row.rowIndex, 'QtyTransferConvBad'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                                DXUtility.getValue(e.row.data, 'ProductConversionS')
                                            );

                                            DXUtility.setValue(e.row.data, 'QtyTransferGood', conversionGood.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvLGood', conversionGood.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvMGood', conversionGood.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvSGood', conversionGood.qtyConvS);

                                            DXUtility.setValue(e.row.data, 'QtyTransferHold', conversionHold.qtyTransaction);
                                            DXUtility.setValue(e.row.data, 'QtyConvLHold', conversionHold.qtyConvL);
                                            DXUtility.setValue(e.row.data, 'QtyConvMHold', conversionHold.qtyConvM);
                                            DXUtility.setValue(e.row.data, 'QtyConvSHold', conversionHold.qtyConvS);

                                            DXUtility.setValue(e.row.data, 'QtyTransferBad', conversionBad.qtyTransaction);
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
                    } else if ((e.dataField == 'QtyTransferConvGood') || (e.dataField == 'QtyTransferConvHold') ||
                        (e.dataField == 'QtyTransferConvBad')) {
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
                                stockTransferSummaryDataGrid().saveEditData();
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
                                //    DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyTransfer'), qty);
                                //}

                                var conversion = CommonUtility.getConversion(
                                    (ea.value) ? ea.value : '0/0/0',
                                    DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                    DXUtility.getValue(e.row.data, 'ProductConversionS')
                                );

                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyTransfer'), conversion.qtyTransaction);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvL'), conversion.qtyConvL);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvM'), conversion.qtyConvM);
                                DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvS'), conversion.qtyConvS);

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
                    new Dismoyo_Ciptoning_Client.vStockTransferSummaryViewModel(info.data).toJS()
                );

                addDummyData(info);
                stockTransferSummaryDataGrid().clearSelection();
            },
            onRowUpdated: function (info) {
                info.data.ProductID = info.key.ProductID;
                addDummyData(info);
                stockTransferSummaryDataGrid().clearSelection();
            },
            onRowRemoved: function (info) {
                CommonUtility.validateDataGridRemovedTransactionSummary(
                    info.component,
                    info.data.toJS()
                );
            },
            onRowUpdating: function (info) {
                if (info.newData.QtyTransferConvGood) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyTransferConvGood,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvLGood = conversion.qtyConvL;
                    info.newData.QtyConvMGood = conversion.qtyConvM;
                    info.newData.QtyConvSGood = conversion.qtyConvS;
                    info.newData.QtyTransferGood = conversion.qtyTransaction;
                }

                if (info.newData.QtyTransferConvHold) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyTransferConvHold,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvLHold = conversion.qtyConvL;
                    info.newData.QtyConvMHold = conversion.qtyConvM;
                    info.newData.QtyConvSHold = conversion.qtyConvS;
                    info.newData.QtyTransferHold = conversion.qtyTransaction;
                }

                if (info.newData.QtyTransferConvBad) {
                    var conversion = CommonUtility.getConversion(
                            info.newData.QtyTransferConvBad,
                            DXUtility.getValue(info.oldData, 'ProductConversionL'),
                            DXUtility.getValue(info.oldData, 'ProductConversionM'),
                            DXUtility.getValue(info.oldData, 'ProductConversionS')
                        );

                    info.newData.QtyConvLBad = conversion.qtyConvL;
                    info.newData.QtyConvMBad = conversion.qtyConvM;
                    info.newData.QtyConvSBad = conversion.qtyConvS;
                    info.newData.QtyTransferBad = conversion.qtyTransaction;
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

                var qtyTransferGood = DXUtility.getValue(e.newData, 'QtyTransferGood');
                if (qtyTransferGood == undefined)
                    qtyTransferGood = DXUtility.getValue(e.oldData, 'QtyTransferGood');

                var qtyTransferHold = DXUtility.getValue(e.newData, 'QtyTransferHold');
                if (qtyTransferHold == undefined)
                    qtyTransferHold = DXUtility.getValue(e.oldData, 'QtyTransferHold');

                var qtyTransferBad = DXUtility.getValue(e.newData, 'QtyTransferBad');
                if (qtyTransferBad == undefined)
                    qtyTransferBad = DXUtility.getValue(e.oldData, 'QtyTransferBad');

                if ((qtyTransferGood <= 0) && (qtyTransferHold <= 0) && (qtyTransferBad <= 0)) {
                    e.errorText = 'Transfer Qty Good/Hold/Bad must be greater than 0.';
                    e.isValid = false;
                }

                if (e.isValid && ((qtyTransferGood > qtyOnHandGood) || (qtyTransferHold > qtyOnHandHold) ||
                    (qtyTransferBad > qtyOnHandBad))) {
                    e.errorText = 'Transfer Qty Good/Hold/Bad must be less than or equal to On Hand Qty.';
                    e.isValid = false;
                }

                if (e.isValid) {
                    var data = commonPopupEdit.popupEditData();
                    
                    if (validateCreatedBySFA(DXUtility.getValue(data, 'CreatedByUserName'))) {
                        for (var i = 0; i < data.ChildSummaries().length; i++) {
                            var summary = data.ChildSummaries()[i];
                            if ((summary.ProductID() == e.oldData.ProductID()) &&
                                ((qtyTransferGood > (summary.QtyGood() * -1)) ||
                                (qtyTransferHold > (summary.QtyHold() * -1)) ||
                                (qtyTransferBad > (summary.QtyBad() * -1)))) {
                                e.errorText = 'This document was created by SFA (mobile device). ' +
                                    'New Transfer Qty Good/Hold/Bad is limited to less than or equal to original Transfer Qty.';
                                e.isValid = false;
                                break;
                            }
                        }
                    }
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
                    var dataGrid = $(stockTransferSummaryDataGrid().element());
                    if (!dataGrid.find('.datagrid-bandedHeader:first').length > 0) {
                        var isEditable = (stockTransferSummaryDataGrid().option('selection').mode == 'none') ? false : true;
                        var option = stockTransferSummaryDataGrid().option('editing');

                        var tr = '<tr class="dx-row dx-column-lines datagrid-bandedHeader" style="border-top-style: none !important;">';

                        if (isEditable)
                            tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';

                        tr += '       <td class="dx-datagrid-action" style="border-bottom-style: none;"></td>';
                        tr += '       <td class="dx-datagrid-action" colspan="3">' + 'On Hand Qty (Pcs)' + '</td>';
                        tr += '       <td class="dx-datagrid-action" colspan="3">' + 'Transfer Qty (L/M/S)' + '</td>';

                        if (isEditable || option.allowUpdating || option.allowDeleting)
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
                dataField: 'QtyTransferConvGood', caption: 'Good', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyTransferConvGood', 1)); // Good
                }
            }, {
                dataField: 'QtyTransferConvHold', caption: 'Hold', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyTransferConvHold', 2)); // Hold
                }
            }, {
                dataField: 'QtyTransferConvBad', caption: 'Bad', width: '90px',
                alignment: 'right', validationRules: [{ type: 'required' }, conversionValidationRule],
                cellTemplate: function (container, options) {
                    container.append(createProductLotEditCommands(options.data, 'QtyTransferConvBad', 3)); // Bad
                }
            }]
        }));

        var extCommands = $('#commonPopupEdit_extCommands');
        var commandPrintDO = $('<div id="vStockTransfers_stockTransferPrintDO" style="margin-right: 32px;">').dxButton({
            text: 'Print DO', icon: 'icons8-print',
            onClick: function () { commonPopupEdit.events.performPrintDO(this); }
        });

        var commandPost = $('<div id="vStockTransfers_stockTransferPost">').dxButton({
            text: 'Post', icon: 'icons8-check-green',
            onClick: function () { commonPopupEdit.events.performPost(this); }
        });

        var commandDiscard = $('<div id="vStockTransfers_stockTransferDiscard" style="margin-right: 16px;">').dxButton({
            text: 'Discard', icon: 'icons8-trash-red',
            onClick: function () { commonPopupEdit.events.performDiscard(this); }
        });

        var commandSaveAsDraftAndNew = $('<div id="vStockTransfers_stockTransferSaveAsDraftAndNew">').dxButton({
            text: 'Save & New', icon: 'icons8-save',
            onClick: function () { commonPopupEdit.events.performSaveAsDraftAndNew(this); }
        });

        extContent.append(DXUtility.createFormItemGroupWithCaption('').append(content));
        extCommands.append(commandPrintDO);
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

    commonPopupEdit.events.performSaveAsDraftAndNew = function (rootView) {
        saveEditing(1, 2); // Save as Draft and Reload data
    };

    commonPopupEdit.formOptions.customizeItem = function (item) {
        if (item.dataField == 'AttachmentFile') {
            item.template = function (data, itemElement) {
                itemElement.append(CommonUtility.createEditDataAttachmentFileUploader('vStockTransfers', 'StockTransfers'));
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
                    var preDODocumentCode = '';
                    var company = null;
                    var companyID = null;

                    if (e.selectedItem) {
                        preDocumentCode = previewDocumentCode(e.selectedItem.Code());
                        preDODocumentCode = previewDODocumentCode(e.selectedItem.Code());
                        company = e.selectedItem.Company();
                        companyID = e.selectedItem.CompanyID();
                    }

                    form.getEditor('Company').option('value', company);

                    updateSiteChildEditor(form, e.value, companyID);

                    form.getEditor('DocumentCode').option('value', preDocumentCode);
                    form.getEditor('DODocumentCode').option('value', preDODocumentCode);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Stock Transfer',
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
            dataField: 'SourceWarehouseID',
            label: { text: 'Source Warehouse' },
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
                onValueChanged: function (e) {
                    var form = commonPopupEdit.form();

                    if (form.getEditor('DestinationSiteID').option('value')) {
                        var destinationWHS = form.getEditor('DestinationSiteID').option('value')
                        form.getEditor('DestinationWarehouseID').option('value', null);
                        var datasource = Dismoyo_Ciptoning_Client.LocalStore.vWarehouses.dataSource();

                        //error handling when destinationWHS or e.value is undefined
                        if (destinationWHS === undefined)
                            destinationWHS = null;

                        if (e.value === undefined)
                            e.value = null;

                        datasource.filter(['ID', '<>', e.value], "and", ['SiteID', '=', destinationWHS]);
                        form.getEditor('DestinationWarehouseID').option('dataSource', datasource);
                    }

                    dataSource_vStockOnHandAvailable = [];
                    dataSource_vStockOnHandAvailableByProduct = [];

                    if (e.value) {
                        var data = commonPopupEdit.popupEditData();

                        var summaryDataGrid = stockTransferSummaryDataGrid();
                        summaryDataGrid.cancelEditData();

                        data.ChildSummaries([]);
                        summaryDataGrid.option('dataSource',
                            createSummaryArrayDataSource(data.ChildSummaries()));
                    }
                },
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'SourcePIC',
            label: { text: 'PIC' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorOptions: {
                maxlength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            itemType: 'empty',
            colSpan: 1
        }, {
            dataField: 'DestinationSiteID',
            label: { text: 'Destination Site' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSites.dataSource(),
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); },
                onValueChanged: function (e) {
                    e.component.option('value', e.value);
                    var sourceWarehouseID = commonPopupEdit.form().getEditor('SourceWarehouseID').option('value');
                    var datasource = Dismoyo_Ciptoning_Client.LocalStore.vWarehouses.dataSource();

                    //error handling when sourceWarehouse or e.value is undefined
                    if (sourceWarehouseID === undefined)
                        sourceWarehouseID = null;

                    if (e.value === undefined)
                        e.value = null;

                    //  Dismoyo_Ciptoning_Client.LocalStore.vWarehouses.dataSource().filter(['ID', '<>', sourceWarehouseID], "and", ['SiteID', '=', e.value]);
                    datasource.filter(['ID', '<>', sourceWarehouseID], "and", ['SiteID', '=', e.value]);
                    commonPopupEdit.form().getEditor('DestinationWarehouseID').option('dataSource', datasource);


                }
            }
        }, {
            dataField: 'DestinationWarehouseID',
            label: { text: 'Warehouse' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: [],
                displayExpr: 'Warehouse',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'DestinationPIC',
            label: { text: 'PIC' },
            validationRules: [{ type: 'required' }],
            colSpan: 2,
            editorOptions: {
                maxLength: 50,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'ReferenceNumber',
            label: { text: 'Reference Number' },
            colSpan: 3,
            editorOptions: {
                maxlength: 30,
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
            itemType: 'empty',
            colSpan: 1
        }, {
            dataField: 'DOPrintedCount',
            editorType: 'dxNumberBox',
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
                readOnly: true,
                width: '100%',
                showClearButton: true,
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
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        info.data[productLotColumns.qtyTransferColumn] = 0;
        info.data[productLotColumns.qtyTransferConvColumn] = '0/0/0';
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

                            CommonUtility.createProductLotLookupHeader('vStockTransfers_productLotIDLookup', ea.element, itemStatusID);
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
                                        e.component.cellValue(e.row.rowIndex, 'QtyTransferConv'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionL'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionM'),
                                        DXUtility.getValue(e.row.data, 'ProductConversionS')
                                    );

                                    DXUtility.setValue(e.row.data, productLotColumns.qtyTransferColumn, conversion.qtyTransaction);
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
            } else if (e.name == 'QtyTransferConv') {
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
                        //    DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyTransfer'), qty);
                        //}

                        var conversion = CommonUtility.getConversion(
                            (ea.value) ? ea.value : '0/0/0',
                            DXUtility.getValue(e.row.data, 'ProductConversionL'),
                            DXUtility.getValue(e.row.data, 'ProductConversionM'),
                            DXUtility.getValue(e.row.data, 'ProductConversionS')
                        );

                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyTransfer'), conversion.qtyTransaction);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvL'), conversion.qtyConvL);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvM'), conversion.qtyConvM);
                        DXUtility.setValue(e.row.data, e.dataField.replace('QtyTransferConv', 'QtyConvS'), conversion.qtyConvS);

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
            new Dismoyo_Ciptoning_Client.vStockTransferDetailsViewModel(info.data).toJS()
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
            productLotColumns.qtyTransferConvColumn,
            productLotColumns.qtyTransferColumn
        );
    };

    productLotPopupEdit.dataGridOptions.onRowValidating = function (e) {
        var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
        var productLotColumns = getProductLotColumns(itemStatusID);

        var qtyOnHand = DXUtility.getValue(e.newData, productLotColumns.qtyOnHandColumn);
        if (qtyOnHand == undefined)
            qtyOnHand = DXUtility.getValue(e.oldData, productLotColumns.qtyOnHandColumn);

        var qtyTransfer = DXUtility.getValue(e.newData, productLotColumns.qtyTransferColumn);
        if (qtyTransfer == undefined)
            qtyTransfer = DXUtility.getValue(e.oldData, productLotColumns.qtyTransferColumn);

        if (qtyTransfer <= 0) {
            e.errorText = 'Transfer Qty must be greater than 0.';
            e.isValid = false;
        }

        if (e.isValid && (qtyTransfer > qtyOnHand)) {
            e.errorText = 'Transfer Qty must be less than or equal to On Hand Qty.';
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
            showInColumn: 'QtyTransferConv',
            displayFormat: 'Total Qty (Pcs): {0}',
            valueFormat: 'decimal',
            summaryType: 'custom'
        }, {
            name: 'TotalQtyLMS',
            showInColumn: 'QtyTransferConv',
            displayFormat: '(L/M/S): {0}',
            valueFormat: 'string',
            summaryType: 'custom'
        }],
        calculateCustomSummary: function (options) {
            var itemStatusID = productLotPopupEdit.popupEditOptions.itemStatusID;
            var productLotColumns = getProductLotColumns(itemStatusID);

            CommonUtility.updateProductLotEditingSummary(options,
                productLotColumns.qtyTransferConvColumn,
                productLotColumns.qtyTransferColumn);
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
        name: 'QtyOnHand', caption: 'On Hand Qty (Pcs)', width: '120px', allowEditing: false,
        dataType: 'number'
    }, {
        name: 'QtyTransferConv', caption: 'Transfer Qty (L/M/S)', width: '150px',
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
            dataField: 'QtyTransfer',
            label: { text: 'Transfer Qty (Pcs)' },
            colSpan: 2,
            editorOptions: {
                readOnly: true,
                onEnterKey: function () { commonPopupEdit.events.performOK(this); }
            }
        }, {
            dataField: 'QtyTransferConv',
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

        icon: 'Images/stock_transfer_32px.png',

        dataSource_vStockTransferDetails: dataSource_vStockTransferDetails,
        dataSource_vStockTransferSummary: dataSource_vStockTransferSummary,
        dataSource_vStockOnHandAvailable: dataSource_vStockOnHandAvailable,
        dataSource_vStockOnHandAvailableByProduct: dataSource_vStockOnHandAvailableByProduct,

        collapsibleFilter: collapsibleFilter,

        commonGridView: commonGridView,

        commonPopupEdit: commonPopupEdit,
        commonPopupIFrame: commonPopupIFrame,
        productLotPopupEdit: productLotPopupEdit,

        stockTransferSummaryDataGrid: stockTransferSummaryDataGrid,
        stockTransferPrintDO: stockTransferPrintDO,
        stockTransferPost: stockTransferPost,
        stockTransferDiscard: stockTransferDiscard,
        stockTransferSaveAsDraftAndNew: stockTransferSaveAsDraftAndNew
    };
};
