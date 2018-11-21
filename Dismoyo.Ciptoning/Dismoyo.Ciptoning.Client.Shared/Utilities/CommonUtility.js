// ------------------------------------------------------------------------------------------------
// CommonUtility: A class for supporting the Html programming.
// ------------------------------------------------------------------------------------------------


// CommonUtility class definition.
var CommonUtility = function () {
}


// Configure the pane layouts for commonGridView.
CommonUtility.configureCommonGridViewLayout = function (viewName) {
    var ctlName = 'commonGridView';
    var ctl = $('#' + viewName + '_' + ctlName);
    return CommonUtility.configureCommonLayout(viewName, ctlName,
        function (pane, $Pane, state) {
            var filter = DXUtility.getDXInstance($Pane, '#collapsibleFilter_filter', 'dxAccordion');
            var dataGrid = DXUtility.getDXInstance($Pane, '#commonGridView_dataGrid', 'dxDataGrid');
            if (dataGrid) {
                var height = $Pane.height() - ((filter) ? filter.element().height() : 0);
                dataGrid.option('height', height - 40);
                ctl.height(height);
            }
        }
    );
}

// Configure the pane layouts for commonIFrame.
CommonUtility.configureCommonIFrameLayout = function (viewName) {
    var ctlName = 'commonIFrame';
    var ctl = $('#' + viewName + '_' + ctlName);
    return CommonUtility.configureCommonLayout(viewName, ctlName,
        function (pane, $Pane, state) {
            var filter = DXUtility.getDXInstance($Pane, '#collapsibleFilter_filter', 'dxAccordion');
            var iframe = $Pane.find('#commonIFrame_iframe');
            if (iframe) {
                var height = $Pane.height() - ((filter) ? filter.element().height() : 0);
                iframe.height(height);
                ctl.height(height);
            }
        }
    );
}

// Configure the pane layouts.
CommonUtility.configureCommonLayout = function (viewName, ctlName, onResize) {
    if (!CommonUtility.validateLoggedInUser())
        return;

    if ($('#' + viewName + '_' + ctlName).is(':visible')) {
        var pane = $('#' + viewName + '_viewContent').layout({
            name: viewName + 'ViewContent',
            north: {
                paneSelector: '#' + viewName + '_viewContentHeader',
                resizable: false,
                spacing_open: 0,
                spacing_closed: 0
            },
            center: {
                paneSelector: '#' + viewName + '_viewSubContent',
                onresize: onResize
            }
        });

        pane.resizeAll();
        desktopPane().show('west');
        return pane;
    }

    return undefined;
}


// Create file uploader element.
CommonUtility.createEditDataAttachmentFileUploader = function (viewName, attachmentPathName) {
    return $('<div id="' + viewName + '_editDataAttachmentFile">').dxFileUploader({
        accept:
            '.doc,application/msword,' +
            '.docx,application/vnd.openxmlformats-officedocument.wordprocessingml.document,' +
            '.xls,application/vnd.ms-excel,' +
            '.xlsx,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,' +
            '.pdf,application/pdf',
        uploadMode: 'useButtons',
        uploadedMessage: 'Uploaded',
        onProgress: function (e) {
        },
        onUploaded: function (e) {
        },
        onUploadError: function (e) {
        },
        onValueChanged: function (e) {
            if (e.value) {
                $('.dx-button-content:contains(\'Upload\')').remove();

                var fileExt = e.value.name.split('.').pop();
                e.component.fileName = new DevExpress.data.Guid() + '.' + fileExt;
                e.component.option('uploadUrl', Dismoyo_Ciptoning_Client.FileService.UploadFile.url(attachmentPathName + '/' + e.component.fileName));
            }
        }
    });
}

// Create file downloader element.
CommonUtility.createEditDataAttachmentFileDownloader = function (viewName, fileUploader, attachmentPathName, attachmentFileName) {
    var fileDownloadButtonID = viewName + '_editDataAttachmentFileDownload';
    $('#' + fileDownloadButtonID).remove();

    if (attachmentFileName) {
        var fileUrl = Dismoyo_Ciptoning_Client.FileService.DownloadFile.url(attachmentPathName, attachmentFileName);
        fileUploader.element().append('<a id="' + fileDownloadButtonID +
            '" style="margin-left: 10px;" target="_blank" href="' + fileUrl + '">Download</a>');
    }
}


// Validate login.
CommonUtility.validateLoggedInUser = function () {
    Dismoyo_Ciptoning_Client.app.CurrentUser = null;
    var userJS = CommonUtility.getJsonCookie('CurrentUser');
    if (userJS) {
        var strLength = CommonUtility.getCookie('CurrentUserPermissionsLength');
        if (strLength.length <= 0)
            strLength = '0';

        var currentPermissionsJSLength = Math.ceil(parseFloat(strLength));
        var currentPermissionsJS = '';
        for (var i = 0; i < currentPermissionsJSLength; i++)
            currentPermissionsJS += CommonUtility.getCookie('CurrentUserPermissions' + (i + 1).toString());

        if (currentPermissionsJS.length > 0)
            userJS.ChildPermissions = JSON.parse(currentPermissionsJS);
        
        var user = new Dismoyo_Ciptoning_Client.vUserViewModel(userJS);
        if (!user.IsHeadOffice())
            user.SiteID(new DevExpress.data.Guid(user.SiteID()));

        var currentItem = Dismoyo_Ciptoning_Client.app.navigationManager.currentItem();
        if (currentItem.uri != 'Login') {
            var header = $('#headerWelcome');
            if (header.text() == '') {
                var items = ko.toJS(mainMenuItems);
                for (var i = 0; i < items.length; i++)
                    items[i].visible = ((!user.IsHeadOffice() && items[i].isHeadOffice) ||
                        !user.isAuthorized(items[i].permissionObjectID)) ? false : true;

                $('#leftMenu').dxTreeView('instance').option('items', items);

                header.text('Welcome, ' + user.Name());
                headerMenu().option('visible', true);

                Dismoyo_Ciptoning_Client.LocalStore.loadAllData();
            }
        }

        Dismoyo_Ciptoning_Client.app.CurrentUser = user;
        return true;
    }

    return false;
}

// Show message after document action is succeed.
CommonUtility.documentSuccessMessage = function (statusID, action) {
    var statusHeader = '';
    var statusName = '';
    switch (statusID) {
        case 1: statusHeader = 'Save'; statusName = 'Saved'; break;
        case 2: statusHeader = 'Post'; statusName = 'Posted'; break;
        case 3: statusHeader = 'Discard'; statusName = 'Discarded'; break;
        case 4: statusHeader = 'Void'; statusName = 'Voided'; break;
    }

    if (statusName != '') {
        DevExpress.ui.dialog.alert(
            'Transaction has been successfully ' + statusName + '.', statusHeader + ' Successful')
            .done(function (e) { action(); });
    }
}

// Cascade value changed.
CommonUtility.cascadeValueChanged = function (form, selectedItem, value, field, parentFields, childFields) {
    if (selectedItem) {
        for (var i = 0; i < parentFields.length; i++)
            form.getEditor(parentFields[i] + 'ID').option('value', selectedItem[parentFields[i] + 'ID']());
    }

    for (var i = 0; i < childFields.length; i++) {
        var childEditor = form.getEditor(childFields[i] + 'ID');
        var childSelectedItem = childEditor.option('selectedItem');
        if (childFields[i] != 'Company') {
            if (childSelectedItem && (childSelectedItem[field + 'ID']() != value))
                childEditor.option('value', null);

            childEditor.option('dataSource',
                DataUtility['GetLookup' + childFields[i] + 'DataSource']((value) ? [field + 'ID', '=', value] : null));
        } else {
            if (childSelectedItem)
                childEditor.option('value', null);
        }

    }
}

// Cascade load data source.
CommonUtility.cascadeLoadLookupDataSource = function (data, parentColumn, dataSource) {
    var filter = null;
    if (data && data[parentColumn])
        filter = [parentColumn, '=', DXUtility.getValue(data, parentColumn)];

    return dataSource(filter);
},

// Cascade value changed.
CommonUtility.cascadeLookupValueChanged = function (items, data, idColumn, value, parentFields) {
    if (value) {
        var item = $.grep(items, function (e) { return (DXUtility.getValue(e, idColumn) == value); })[0];
        if (item) {
            for (var i = 0; i < parentFields.length; i++)
                data[parentFields[i]] = item[parentFields[i]]();
        }
    }
}

// Cascade value changed with GUID data type.
CommonUtility.cascadeLookupGuidValueChanged = function (items, data, idColumn, value, parentFields) {
    if (value) {
        var item = $.grep(items, function (e) { return (DXUtility.getValue(e, idColumn)._value == value._value); })[0];
        if (item) {
            for (var i = 0; i < parentFields.length; i++)
                data[parentFields[i]] = item[parentFields[i]]();
        }
    }
}

// Get number format.
CommonUtility.getNumberFormat = function (value) {
    if (!isNaN(parseFloat(value)))
        return numeral(value).format('0,0.00');

    return '';
}

// Converter to UOM Conversion and Pcs.
CommonUtility.getConversion = function (qtyTransactionConv, productConversionL, productConversionM, productConversionS) {
    var qtyConvL = 0;
    var qtyConvM = 0;
    var qtyConvS = 0;
    var qtyTransaction = 0;
    var arr = qtyTransactionConv.split('/');

    try {
        if (arr.length == 1)
            qtyConvS = (!arr[0] || isNaN(arr[0]) ? 0 : parseInt(arr[0]));

        if (arr.length == 2) {
            qtyConvM = (!arr[0] || isNaN(arr[0]) ? 0 : parseInt(arr[0]));
            qtyConvS = (!arr[1] || isNaN(arr[1]) ? 0 : parseInt(arr[1]));
        }

        if (arr.length == 3) {
            qtyConvL = (!arr[0] || isNaN(arr[0]) ? 0 : parseInt(arr[0]));
            qtyConvM = (!arr[1] || isNaN(arr[1]) ? 0 : parseInt(arr[1]));
            qtyConvS = (!arr[2] || isNaN(arr[2]) ? 0 : parseInt(arr[2]));
        }
    } catch (e) {
    }

    if (arr.length == 1) {
        var conversion = CommonUtility.calcToConversion(qtyConvS, productConversionL, productConversionM, productConversionS);
        qtyConvL = conversion.qtyConvL;
        qtyConvM = conversion.qtyConvM;
        qtyConvS = conversion.qtyConvS;
    }

    qtyTransaction = (qtyConvL * ((!productConversionL) ? 0 : productConversionL)) +
        (qtyConvM * ((!productConversionM) ? 0 : productConversionM)) +
        (qtyConvS * ((!productConversionS) ? 0 : productConversionS));

    if ((arr.length == 2) || (arr.length == 3)) {
        var conversion = CommonUtility.calcToConversion(qtyTransaction, productConversionL, productConversionM, productConversionS);
        qtyConvL = conversion.qtyConvL;
        qtyConvM = conversion.qtyConvM;
        qtyConvS = conversion.qtyConvS;
    }

    return {
        qtyConvL: qtyConvL,
        qtyConvM: qtyConvM,
        qtyConvS: qtyConvS,
        qtyTransaction: qtyTransaction,
        qtyTransactionConv: qtyConvL.toString() + '/' + qtyConvM.toString() + '/' + qtyConvS.toString()
    };
}

// Converter from Pcs to UOM Conversion.
CommonUtility.calcToConversion = function (qty, productConversionL, productConversionM, productConversionS) {
    var qtyConvL = 0;
    var qtyConvM = 0;
    var qtyConvS = 0;
    if ((qty != undefined) && (qty != null)) {
        var div;
        var mod = 0;

        div = 0;
        if (productConversionL) {
            div = Math.floor(qty / productConversionL);
            mod = qty % productConversionL;
            qty = (mod == 0) ? div : mod;
        }

        qtyConvL = div;
        div = 0;
        if ((mod > 0) && productConversionM) {
            div = Math.floor(qty / productConversionM);
            mod = qty % productConversionM;
            qty = (mod == 0) ? div : mod;
        }

        qtyConvM = div;
        qtyConvS = mod;
    }

    return {
        qtyConv: qtyConvL.toString() + '/' + qtyConvM.toString() + '/' + qtyConvS.toString(),
        qtyConvL: qtyConvL,
        qtyConvM: qtyConvM,
        qtyConvS: qtyConvS
    };
}



// Calculate product conversion.
CommonUtility.calcConversion = function (value, rowData) {
    var conversion = CommonUtility.getConversion(
        (value) ? value : '0/0/0',
        DXUtility.getValue(rowData, 'ProductConversionL'),
        DXUtility.getValue(rowData, 'ProductConversionM'),
        DXUtility.getValue(rowData, 'ProductConversionS')
    );

    DXUtility.setValue(rowData, 'QtyOrder', conversion.qtyTransaction);
    DXUtility.setValue(rowData, 'QtyConvL', conversion.qtyConvL);
    DXUtility.setValue(rowData, 'QtyConvM', conversion.qtyConvM);
    DXUtility.setValue(rowData, 'QtyConvS', conversion.qtyConvS);

    var weight = DXUtility.getValue(rowData, 'ProductWeight');
    var dimensionL = DXUtility.getValue(rowData, 'ProductDimensionL');
    var dimensionW = DXUtility.getValue(rowData, 'ProductDimensionW');
    var dimensionH = DXUtility.getValue(rowData, 'ProductDimensionH');

    if (weight != undefined)
        DXUtility.setValue(rowData, 'SubtotalWeight', conversion.qtyTransaction * weight);

    if ((dimensionL != undefined) && (dimensionW != undefined) && (dimensionH != undefined))
        DXUtility.setValue(rowData, 'SubtotalDimension', conversion.qtyTransaction *
            (dimensionL * dimensionW * dimensionH));

    return conversion;
}

// Get Discount Strata Details percentage value.
CommonUtility.getDiscountStrataDetailsPercentage = function (strata, priceDate, qtyOrder) {
    if ((strata.ValidDateFrom && (strata.ValidDateFrom() <= priceDate)) &&
        (strata.ValidDateTo && (strata.ValidDateTo() >= priceDate))) {
        var dataSourceStrataDetails = new DevExpress.data.DataSource({
            store: strata.ChildDetails(),
            filter: [['Minimum', '<=', qtyOrder], 'and', ['Maximum', '>=', qtyOrder]]
        });

        dataSourceStrataDetails.load();
        if (dataSourceStrataDetails.items().length > 0)
            return dataSourceStrataDetails.items()[0].DiscountPercentage();
    }

    return 0;
}

// Calculate Product Price and Discount.
CommonUtility.calcProductPriceAndDiscount = function (transactionDate, dataGrid, rowIndex, rowData,
    selectedProductPrices, selectedDiscountGroup, forceZero) {
    CommonUtility.calcProductPriceAndDiscountBase(transactionDate, dataGrid, rowIndex, rowData,
        selectedProductPrices, selectedDiscountGroup, forceZero, false)
}

// Calculate Product Price and Discount with option.
CommonUtility.calcProductPriceAndDiscountBase = function (transactionDate, dataGrid, rowIndex, rowData,
    selectedProductPrices, selectedDiscountGroup, forceZero, isOneLevelDiscount) {
    var priceDate = dataGrid.cellValue(rowIndex, 'PriceDate');
    if (!priceDate)
        priceDate = new Date(transactionDate);

    var productID = DXUtility.getValue(rowData, 'ProductID');
    var qtyOrder = DXUtility.getValue(rowData, 'QtyOrder');
    var weight = 0;
    var dimension = 0;
    var unitGrossPrice = 0;
    var unitPrice = 0;
    var discountStrata1Percentage = 0;
    var discountStrata2Percentage = 0;
    var discountStrata3Percentage = 0;
    var discountStrata4Percentage = 0;
    var discountStrata5Percentage = 0;

    var addDiscountStrataPercentage = dataGrid.cellValue(rowIndex, 'AddDiscountStrataPercentage');
    if (addDiscountStrataPercentage == undefined)
        addDiscountStrataPercentage = 0;

    var taxPercentage = 10; ///////////////////////////

    if (productID) {
        var dataSourcePoductPrice = new DevExpress.data.DataSource({
            store: selectedProductPrices,
            filter: [
                ['ProductID', '=', productID], 'and',
                ['ValidDateFrom', '<=', new Date(priceDate)], 'and',
                ['ValidDateTo', '>=', new Date(priceDate)]
            ]
        });

        dataSourcePoductPrice.load();
        if (dataSourcePoductPrice.items().length > 0) {
            var item = dataSourcePoductPrice.items()[0];

            weight = item.ProductWeight();
            dimension = item.ProductDimensionL() * item.ProductDimensionW() * item.ProductDimensionH();
            unitGrossPrice = item.GrossPrice();
            unitPrice = item.Price();
        }

        if (selectedDiscountGroup.length > 0) {
            var items = $.grep(selectedDiscountGroup[0].ChildProducts(), function (e) {
                return (e.ProductID() == productID);
            });

            if (items.length > 0) {
                var discountGroupProduct = items[0];

                if (discountGroupProduct.ChildStrata1())
                    discountStrata1Percentage = CommonUtility.getDiscountStrataDetailsPercentage(
                        discountGroupProduct.ChildStrata1(), priceDate, qtyOrder);

                if (isOneLevelDiscount) {
                    if (discountGroupProduct.ChildStrata2())
                        discountStrata2Percentage = CommonUtility.getDiscountStrataDetailsPercentage(
                            discountGroupProduct.ChildStrata2(), priceDate, qtyOrder);

                    if (discountGroupProduct.ChildStrata3())
                        discountStrata3Percentage = CommonUtility.getDiscountStrataDetailsPercentage(
                            discountGroupProduct.ChildStrata3(), priceDate, qtyOrder);

                    if (discountGroupProduct.ChildStrata4())
                        discountStrata4Percentage = CommonUtility.getDiscountStrataDetailsPercentage(
                            discountGroupProduct.ChildStrata4(), priceDate, qtyOrder);

                    if (discountGroupProduct.ChildStrata5())
                        discountStrata5Percentage = CommonUtility.getDiscountStrataDetailsPercentage(
                            discountGroupProduct.ChildStrata5(), priceDate, qtyOrder);
                }
            }
        }
    }

    var subtotalWeight = 0; //weight * qtyOrder;
    var subtotalDimension = 0; //dimension * qtyOrder;

    DXUtility.setValue(rowData, 'UnitGrossPrice', unitGrossPrice);
    DXUtility.setValue(rowData, 'SubtotalWeight', subtotalWeight);
    DXUtility.setValue(rowData, 'SubtotalDimension', subtotalDimension);

    // Raw (without rounded)
    var rawSubtotalGrossPrice = unitGrossPrice * qtyOrder;
    var rawSubtotalPrice = unitPrice * qtyOrder;

    if (forceZero) {
        rawSubtotalGrossPrice = 0;
        rawSubtotalPrice = 0;
    }

    var rawDiscountStrata1Amount = rawSubtotalPrice * (discountStrata1Percentage / 100);
    var rawSubtotalDiscountStrata1 = rawSubtotalPrice - rawDiscountStrata1Amount;

    var rawDiscountStrata2Amount = rawSubtotalDiscountStrata1 * (discountStrata2Percentage / 100);
    var rawSubtotalDiscountStrata2 = rawSubtotalDiscountStrata1 - rawDiscountStrata2Amount;

    var rawDiscountStrata3Amount = rawSubtotalDiscountStrata2 * (discountStrata3Percentage / 100);
    var rawSubtotalDiscountStrata3 = rawSubtotalDiscountStrata2 - rawDiscountStrata3Amount;

    var rawDiscountStrata4Amount = rawSubtotalDiscountStrata3 * (discountStrata4Percentage / 100);
    var rawSubtotalDiscountStrata4 = rawSubtotalDiscountStrata3 - rawDiscountStrata4Amount;

    var rawDiscountStrata5Amount = rawSubtotalDiscountStrata4 * (discountStrata5Percentage / 100);
    var rawSubtotalDiscountStrata5 = rawSubtotalDiscountStrata4 - rawDiscountStrata5Amount;

    var rawAddDiscountStrataAmount = rawSubtotalDiscountStrata5 * (addDiscountStrataPercentage / 100);

    var rawSubtotal = rawSubtotalDiscountStrata5 - rawAddDiscountStrataAmount;
    var rawSubtotalGross = rawSubtotal / ((taxPercentage / 100) + 1);
    var rawSubtotalTax = rawSubtotal - rawSubtotalGross;

    DXUtility.setValue(rowData, 'RawSubtotalGrossPrice', rawSubtotalGrossPrice);
    DXUtility.setValue(rowData, 'RawSubtotalPrice', rawSubtotalPrice);
    DXUtility.setValue(rowData, 'RawDiscountStrata1Amount', rawDiscountStrata1Amount);
    DXUtility.setValue(rowData, 'RawDiscountStrata2Amount', rawDiscountStrata2Amount);
    DXUtility.setValue(rowData, 'RawDiscountStrata3Amount', rawDiscountStrata3Amount);
    DXUtility.setValue(rowData, 'RawDiscountStrata4Amount', rawDiscountStrata4Amount);
    DXUtility.setValue(rowData, 'RawDiscountStrata5Amount', rawDiscountStrata5Amount);
    DXUtility.setValue(rowData, 'RawAddDiscountStrataAmount', rawAddDiscountStrataAmount);
    DXUtility.setValue(rowData, 'RawSubtotalDiscountStrata1', rawSubtotalDiscountStrata1);
    DXUtility.setValue(rowData, 'RawSubtotalDiscountStrata2', rawSubtotalDiscountStrata2);
    DXUtility.setValue(rowData, 'RawSubtotalDiscountStrata3', rawSubtotalDiscountStrata3);
    DXUtility.setValue(rowData, 'RawSubtotalDiscountStrata4', rawSubtotalDiscountStrata4);
    DXUtility.setValue(rowData, 'RawSubtotalDiscountStrata5', rawSubtotalDiscountStrata5);
    DXUtility.setValue(rowData, 'RawSubtotalGross', rawSubtotalGross);
    DXUtility.setValue(rowData, 'RawSubtotalTax', rawSubtotalTax);
    DXUtility.setValue(rowData, 'RawSubtotal', rawSubtotal);

    // Rounded
    var decimalLength = 4;
    var subtotalGrossPrice = parseFloat((unitGrossPrice * qtyOrder).toFixed(decimalLength));
    var subtotalPrice = parseFloat((unitPrice * qtyOrder).toFixed(decimalLength));

    if (forceZero) {
        subtotalGrossPrice = 0;
        subtotalPrice = 0;
    }

    var discountStrata1Amount = parseFloat((subtotalPrice * (discountStrata1Percentage / 100)).toFixed(decimalLength));
    var subtotalDiscountStrata1 = parseFloat((subtotalPrice - discountStrata1Amount).toFixed(decimalLength));

    var discountStrata2Amount = parseFloat((subtotalDiscountStrata1 * (discountStrata2Percentage / 100)).toFixed(decimalLength));
    var subtotalDiscountStrata2 = parseFloat((subtotalDiscountStrata1 - discountStrata2Amount).toFixed(decimalLength));

    var discountStrata3Amount = parseFloat((subtotalDiscountStrata2 * (discountStrata3Percentage / 100)).toFixed(decimalLength));
    var subtotalDiscountStrata3 = parseFloat((subtotalDiscountStrata2 - discountStrata3Amount).toFixed(decimalLength));

    var discountStrata4Amount = parseFloat((subtotalDiscountStrata3 * (discountStrata4Percentage / 100)).toFixed(decimalLength));
    var subtotalDiscountStrata4 = parseFloat((subtotalDiscountStrata3 - discountStrata4Amount).toFixed(decimalLength));

    var discountStrata5Amount = parseFloat((subtotalDiscountStrata4 * (discountStrata5Percentage / 100)).toFixed(decimalLength));
    var subtotalDiscountStrata5 = parseFloat((subtotalDiscountStrata4 - discountStrata5Amount).toFixed(decimalLength));

    var addDiscountStrataAmount = parseFloat((subtotalDiscountStrata5 * (addDiscountStrataPercentage / 100)).toFixed(decimalLength));

    var subtotal = parseFloat((subtotalDiscountStrata5 - addDiscountStrataAmount).toFixed(decimalLength));
    var subtotalGross = parseFloat((subtotal / ((taxPercentage / 100) + 1)).toFixed(decimalLength));
    var subtotalTax = parseFloat((subtotal - subtotalGross).toFixed(decimalLength));

    DXUtility.setValue(rowData, 'SubtotalDiscountStrata1', subtotalDiscountStrata1);
    DXUtility.setValue(rowData, 'SubtotalDiscountStrata2', subtotalDiscountStrata2);
    DXUtility.setValue(rowData, 'SubtotalDiscountStrata3', subtotalDiscountStrata3);
    DXUtility.setValue(rowData, 'SubtotalDiscountStrata4', subtotalDiscountStrata4);
    DXUtility.setValue(rowData, 'SubtotalDiscountStrata5', subtotalDiscountStrata5);
    DXUtility.setValue(rowData, 'TaxPercentage', taxPercentage);
    DXUtility.setValue(rowData, 'SubtotalGrossPrice', subtotalGrossPrice);
    DXUtility.setValue(rowData, 'SubtotalPrice', subtotalPrice);

    dataGrid.cellValue(rowIndex, 'UnitPrice', unitPrice);

    DXUtility.setValue(rowData, 'DiscountStrata1Percentage', discountStrata1Percentage);
    DXUtility.setValue(rowData, 'DiscountStrata1Amount', discountStrata1Amount);
    DXUtility.setValue(rowData, 'DiscountStrata2Percentage', discountStrata2Percentage);
    DXUtility.setValue(rowData, 'DiscountStrata2Amount', discountStrata2Amount);
    DXUtility.setValue(rowData, 'DiscountStrata3Percentage', discountStrata3Percentage);
    DXUtility.setValue(rowData, 'DiscountStrata3Amount', discountStrata3Amount);
    DXUtility.setValue(rowData, 'DiscountStrata4Percentage', discountStrata4Percentage);
    DXUtility.setValue(rowData, 'DiscountStrata4Amount', discountStrata4Amount);
    DXUtility.setValue(rowData, 'DiscountStrata5Percentage', discountStrata5Percentage);
    DXUtility.setValue(rowData, 'DiscountStrata5Amount', discountStrata5Amount);

    //dataGrid.cellValue(rowIndex, 'DiscountStrata1Percentage', discountStrata1Percentage);
    //dataGrid.cellValue(rowIndex, 'DiscountStrata1Amount', discountStrata1Amount);

    //dataGrid.cellValue(rowIndex, 'DiscountStrata2Percentage', discountStrata2Percentage);
    //dataGrid.cellValue(rowIndex, 'DiscountStrata2Amount', discountStrata2Amount);

    //dataGrid.cellValue(rowIndex, 'DiscountStrata3Percentage', discountStrata3Percentage);
    //dataGrid.cellValue(rowIndex, 'DiscountStrata3Amount', discountStrata3Amount);

    //dataGrid.cellValue(rowIndex, 'DiscountStrata4Percentage', discountStrata4Percentage);
    //dataGrid.cellValue(rowIndex, 'DiscountStrata4Amount', discountStrata4Amount);

    //dataGrid.cellValue(rowIndex, 'DiscountStrata5Percentage', discountStrata5Percentage);
    //dataGrid.cellValue(rowIndex, 'DiscountStrata5Amount', discountStrata5Amount);

    dataGrid.cellValue(rowIndex, 'DiscountStrataDefaultAmount', discountStrata1Amount + discountStrata2Amount +
        discountStrata3Amount + discountStrata4Amount + discountStrata5Amount);

    dataGrid.cellValue(rowIndex, 'AddDiscountStrataAmount', addDiscountStrataAmount);

    dataGrid.cellValue(rowIndex, 'SubtotalGross', subtotalGross);
    dataGrid.cellValue(rowIndex, 'SubtotalTax', subtotalTax);
    dataGrid.cellValue(rowIndex, 'Subtotal', subtotal);
}





// Update values of Sales Order Summary Form.
CommonUtility.updateSalesOrderSummaryForm = function (form, dataGrid) {
    var store = dataGrid.option('dataSource').store();
    var totalGross = 0;
    var totalTax = 0;
    var total = 0;
    for (var i = 0; i < store._array.length; i++) {
        var item = store._array[i];

        totalGross += item.Subtotal - item.SubtotalTax;
        totalTax += item.SubtotalTax;
        total += item.Subtotal;
    }

    form.getEditor('TotalGross').option('value', CommonUtility.getNumberFormat(totalGross));
    form.getEditor('TotalTax').option('value', CommonUtility.getNumberFormat(totalTax));
    form.getEditor('Total').option('value', CommonUtility.getNumberFormat(total));
}



// Update summary data grid data source store.
CommonUtility.updateSummariesArrayStore = function (store, summary) {
    for (var i = 0; i < store._array.length; i++) {
        if (store._array[i].ProductID == summary.ProductID()) {
            store._array[i] = summary.toJS();
            break;
        }
    }
}

// Update defer summary data grid data source store.
CommonUtility.updateDeferSummariesArrayStore = function (store, productID, summary) {
    for (var i = 0; i < store._array.length; i++) {
        if (store._array[i].ProductID == productID) {
            var summaryJS = ko.toJS(summary);
            var keys = Object.keys(summaryJS);
            for (var j = 0; j < keys.length; j++)
                store._array[i][keys[j]] = summaryJS[keys[j]];

            break;
        }
    }
}

// Validate summary data grid data source store.
CommonUtility.validateSummaryArrayStore = function (store, viewModel, summary) {
    for (var i = 0; i < store._array.length; i++) {
        if (store._array[i].ProductID == summary.ProductID())
            return new Dismoyo_Ciptoning_Client[viewModel](store._array[i]);
    }

    return new Dismoyo_Ciptoning_Client[viewModel]();
}



// Get index of item in data source store.
CommonUtility.indexOfArrayStoreItem = function (store, item) {
    var keys = store.key();
    for (var i = 0; i < store._array.length; i++) {
        for (var j = 0; j < keys.length; j++) {
            if (store._array[i][keys[j]] != item[keys[j]])
                break;

            if (j == keys.length - 1)
                return i;
        }
    }

    return -1;
}

// Move last element of the array store to the top.
CommonUtility.moveLastElementToTop = function (arrayStore, values, key) {
    var index = CommonUtility.indexOfArrayStoreItem(arrayStore, values);
    if (index >= 0)
        arrayStore._array.splice(index, 1);

    arrayStore._array.splice(0, 0, values);
}

// Create items data grid array data source.
CommonUtility.createArrayDataSource = function (viewModel, key, items) {
    return new DevExpress.data.DataSource({
        store: {
            type: 'array',
            key: key,
            data: ko.toJS(items),
            onInserted: function (values, key) {
                CommonUtility.moveLastElementToTop(this, values, key);
            }
        },
        paginate: false,
        map: function (item) { return new Dismoyo_Ciptoning_Client[viewModel](item); }
    });
}

// Validate inserted item of data grid.
CommonUtility.validateDataGridInsertedItem = function (dataGrid, item) {
    var dataSource = dataGrid.option('dataSource');
    var store = dataSource.store();
    var index = CommonUtility.indexOfArrayStoreItem(store, item);
    if (index >= 0)
        store._array[index] = item;
    else
        store._array.splice(0, 0, item);

    if (dataSource.items().length != store._array.length) {
        dataSource.reload();
        dataGrid.refresh();
    }

    dataGrid.selectRows(item);
}

// Validate removed item of data grid.
CommonUtility.validateDataGridRemovedItem = function (dataGrid, item) {
    var dataSource = dataGrid.option('dataSource');
    var store = dataSource.store();
    var index = CommonUtility.indexOfArrayStoreItem(store, item);
    if (index >= 0)
        store._array.splice(i, 1);

    if (dataSource.items().length != store._array.length) {
        dataSource.reload();
        dataGrid.refresh();
    }
}


// Validate inserted transaction summary of data grid.
CommonUtility.validateDataGridInsertedTransactionSummary = function (dataGrid, summary) {
    CommonUtility.validateDataGridInsertedItem(dataGrid, summary);
}

// Validate removed transaction summary of data grid.
CommonUtility.validateDataGridRemovedTransactionSummary = function (dataGrid, summary) {
    CommonUtility.validateDataGridRemovedItem(dataGrid, summary);
}


// Validate inserted transaction details of data grid.
CommonUtility.validateDataGridInsertedTransactionDetails = function (dataGrid, details) {
    CommonUtility.validateDataGridInsertedItem(dataGrid, details);
}

// Validate removed transaction details of data grid.
CommonUtility.validateDataGridRemovedTransactionDetails = function (dataGrid, details) {
    CommonUtility.validateDataGridRemovedItem(dataGrid, details);
}


// Validate when updating transaction details of data grid.
CommonUtility.validateDataGridUpdatingTransactionDetails = function (info,
    qtyConvLColumn, qtyConvMColumn, qtyConvSColumn, qtyTransactionConvColumn, qtyTransactionColumn) {
    if (info.newData[qtyTransactionConvColumn]) {
        var conversion = CommonUtility.getConversion(
            info.newData[qtyTransactionConvColumn],
            DXUtility.getValue(info.oldData, 'ProductConversionL'),
            DXUtility.getValue(info.oldData, 'ProductConversionM'),
            DXUtility.getValue(info.oldData, 'ProductConversionS')
        );

        info.newData[qtyConvLColumn] = conversion.qtyConvL;
        info.newData[qtyConvMColumn] = conversion.qtyConvM;
        info.newData[qtyConvSColumn] = conversion.qtyConvS;
        info.newData[qtyTransactionColumn] = conversion.qtyTransaction;
    }
}


// Update details data grid data source store.
CommonUtility.updateDetailsArrayStore = function (store, details) {
    for (var i = 0; i < store._array.length; i++) {
        if ((store._array[i].ProductID == details.ProductID()) &&
            (store._array[i].ProductLotID == details.ProductLotID())) {
            store._array[i] = details.toJS();
            break;
        }
    }
}


// Validate product lot editing before save.
CommonUtility.validateProductLotEditing = function (data, dataSource, summaryQty, keyword, detailsViewModel,
    qtyConvLColumn, qtyConvMColumn, qtyConvSColumn, qtyTransactionConvColumn, qtyTransactionColumn,
    validateAllItemStatus) {
    var detailsQty = 0;
    for (var i = 0; i < dataSource.items().length; i++) {
        var details = dataSource.items()[i];
        detailsQty += details[qtyTransactionColumn]();
    }

    if (detailsQty != summaryQty) {
        DevExpress.ui.dialog.alert('The total quantity of items is not matched with the summary.', 'Save Failed');
        return false;
    }

    for (var i = 0; i < data.ChildDetails().length; i++) {
        var details = data.ChildDetails()[i];
        if (details[qtyTransactionColumn]() > 0) {
            details[qtyConvLColumn](0);
            details[qtyConvMColumn](0);
            details[qtyConvSColumn](0);
            details[qtyTransactionColumn](0);
            details[qtyTransactionConvColumn]('0/0/0');
        }
    }

    var childDetails = dataSource.items();
    for (var i = 0; i < childDetails.length; i++) {
        var details = childDetails[i];
        var items = $.grep(data.ChildDetails(), function (e) {
            return (e.ProductLotID() == DXUtility.getValue(details, 'ProductLotID'));
        });

        if (items.length > 0) {
            var item = items[0];

            var conversion = CommonUtility.getConversion(
                DXUtility.getValue(details, qtyTransactionConvColumn),
                DXUtility.getValue(details, 'ProductConversionL'),
                DXUtility.getValue(details, 'ProductConversionM'),
                DXUtility.getValue(details, 'ProductConversionS')
            );

            item[qtyConvLColumn](conversion.qtyConvL);
            item[qtyConvMColumn](conversion.qtyConvM);
            item[qtyConvSColumn](conversion.qtyConvS);
            item[qtyTransactionColumn](conversion.qtyTransaction);
            item[qtyTransactionConvColumn](conversion.qtyTransactionConv);
        }
        else {
            if (validateAllItemStatus) {
                var keys = Object.keys(details);
                for (var j = 0; j < keys.length; j++) {
                    if (keys[j].indexOf('Qty' + keyword + 'Conv') == 0) {
                        if (keys[j] != qtyTransactionConvColumn)
                            details[keys[j]] = '0/0/0';
                    } else if (keys[j].indexOf('Qty' + keyword) == 0) {
                        if (keys[j] != qtyTransactionColumn)
                            details[keys[j]] = 0;
                    } else if (keys[j].indexOf('QtyConv') == 0) {
                        if ((keys[j] != qtyConvLColumn) &&
                            (keys[j] != qtyConvMColumn) &&
                            (keys[j] != qtyConvSColumn))
                            details[keys[j]] = 0;
                    }
                }
            }

            data.ChildDetails().push(new Dismoyo_Ciptoning_Client[detailsViewModel](ko.toJS(details)));
        }
    }

    var index = 0;
    while (index < data.ChildDetails().length) {
        var details = data.ChildDetails()[index];
        if (validateAllItemStatus) {
            if ((details['QtyOnHandGood']() == 0) &&
                (details['QtyOnHandHold']() == 0) &&
                (details['QtyOnHandBad']() == 0) &&
                (details['Qty' + keyword + 'Good']() == 0) &&
                (details['Qty' + keyword + 'Hold']() == 0) &&
                (details['Qty' + keyword + 'Bad']() == 0)) {
                data.ChildDetails().splice(index, 1);
                continue;
            }
        } else {
            if (details[qtyTransactionColumn]() == 0) {
                data.ChildDetails().splice(index, 1);
                continue;
            }
        }

        index++;
    }

    var conversion = CommonUtility.getConversion(
        DXUtility.getValue(data, qtyTransactionConvColumn),
        DXUtility.getValue(data, 'ProductConversionL'),
        DXUtility.getValue(data, 'ProductConversionM'),
        DXUtility.getValue(data, 'ProductConversionS')
    );

    data[qtyConvLColumn](conversion.qtyConvL);
    data[qtyConvMColumn](conversion.qtyConvM);
    data[qtyConvSColumn](conversion.qtyConvS);
    data[qtyTransactionColumn](conversion.qtyTransaction);
    return true;
}

// Update the summary of product lot editing.
CommonUtility.updateProductLotEditingSummary = function (options,
    qtyTransactionConvColumn, qtyTransactionColumn) {
    switch (options.summaryProcess) {
        case 'start':
            break;
        case 'calculate':
            break;
        case 'finalize':
            var items = options.component.option("dataSource").store()._array;

            options.totalValue = 0;
            for (var i = 0; i < items.length; i++) {
                var conversion = CommonUtility.getConversion(
                    (items[i][qtyTransactionConvColumn] ? items[i][qtyTransactionConvColumn] : '0/0/0'),
                    items[i].ProductConversionL,
                    items[i].ProductConversionM,
                    items[i].ProductConversionS
                );

                options.totalValue += conversion.qtyTransaction;
            }

            if (options.name == 'TotalQtyLMS') {
                if (options.totalValue > 0) {
                    var conversion = CommonUtility.calcToConversion(options.totalValue,
                        items[0].ProductConversionL,
                        items[0].ProductConversionM,
                        items[0].ProductConversionS
                    );

                    options.totalValue = conversion.qtyConv;
                } else
                    options.totalValue = '0/0/0';
            }
            break;
    }
}



// Set cookie.
CommonUtility.setCookie = function (cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = 'expires=' + d.toUTCString();
    document.cookie = cname + '=' + cvalue + '; ' + expires;
}

// Set Json format cookie.
CommonUtility.setJsonCookie = function (cname, cvalue, exdays) {
    CommonUtility.setCookie(cname, JSON.stringify(cvalue), exdays);
}

// Get cookie.
CommonUtility.getCookie = function (cname) {
    var name = cname + '=';
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ')
            c = c.substring(1);

        if (c.indexOf(name) == 0)
            return c.substring(name.length, c.length);
    }

    return '';
}

// Get Json format cookie.
CommonUtility.getJsonCookie = function (cname) {
    var c = CommonUtility.getCookie(cname);
    if (c.length > 0)
        return JSON.parse(c);

    return undefined;
}

// Clear cookie.
CommonUtility.clearCookie = function (cname) {
    CommonUtility.setCookie(cname, '', DateTimeUtility.minDate());
}

// Hide error message on data grid.
CommonUtility.hideErrorMessageOnDataGrid = function (dataGrid) {
    setTimeout(function () { $('.dx-error-row').remove(); }, 5000);
}


// Create Product lookup header.
CommonUtility.createProductLookupHeader = function (id, element, productItemStatus) {
    var colHeader = element.find('#' + id);
    if (colHeader.length == 0) {
        var div = '<div id="' + id + '" class="dx-datagrid datagrid-columnheader">';
        div += '       <table class="dx-datagrid-headers dx-datagrid-nowrap">';
        div += '           <colgroup>';
        div += '               <col style="width: 350px;">';

        if (productItemStatus)
            div += '           <col style="width: 120px;">';
        else {
            div += '           <col style="width: 80px;">';
            div += '           <col style="width: 80px;">';
            div += '           <col style="width: 80px;">';
        }

        div += '               <col style="width: 80px;">';
        div += '               <col style="width: 80px;">';
        div += '               <col style="width: 80px;">';
        div += '           </colgroup><tbody>';
        div += '           <tr class="dx-row dx-header-row dx-column-lines">';
        div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
        div += '' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;"' + (productItemStatus ? '' : ' colSpan="3"') + '>';
        div += 'On Hand Qty (Pcs)' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;" colSpan="3">';
        div += 'Conversion Qty (Pcs)' + '</td>';
        div += '</tr>';

        div += '           <tr class="dx-row dx-header-row dx-column-lines">';
        div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
        div += 'Product' + '</td>';

        if (!productItemStatus || (productItemStatus == 1)) { // Good
            div += '           <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
            div += 'Good' + '</td>';
        }

        if (!productItemStatus || (productItemStatus == 2)) { // Hold
            div += '           <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
            div += 'Hold' + '</td>';
        }

        if (!productItemStatus || (productItemStatus == 3)) { // Bad
            div += '           <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
            div += 'Bad' + '</td>';
        }

        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'L' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'M' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'S' + '</td>';
        div += '</tr></tbody></table></div>';

        var list = element.find('.dx-list');
        list.attr('style', 'top: 55px !important');
        list.before($(div));
    }
}

// Create Product lookup item.
CommonUtility.createProductLookupItem = function (data, element, productItemStatus) {
    var title = '';
    var div = '<div class="dx-datagrid dx-datagrid-rowsview dx-datagrid-nowrap" style="background-color: inherit;">';
    div += '       <table class="dx-datagrid-table dx-datagrid-table-fixed" style="border-collapse: initial !important;">';
    div += '           <colgroup>';
    div += '               <col style="width: 350px;">';

    if (productItemStatus)
        div += '           <col style="width: 120px;">';
    else {
        div += '           <col style="width: 80px;">';
        div += '           <col style="width: 80px;">';
        div += '           <col style="width: 80px;">';
    }

    div += '               <col style="width: 80px;">';
    div += '               <col style="width: 80px;">';
    div += '               <col style="width: 80px;">';
    div += '           </colgroup><tbody>';
    div += '           <tr class="dx-row dx-data-row dx-column-lines">';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.Product()) + '"';
    div += '                   style="text-align: left; border-left-style: none !important;">';
    div += HtmlUtility.htmlEncode(data.Product()) + '</td>';

    if (!productItemStatus || (productItemStatus == 1)) { // Good
        data.QtyOnHand = data.QtyOnHandGood;
        title = data.QtyOnHand();
        div += '           <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
        div += title + '</td>';
    }

    if (!productItemStatus || (productItemStatus == 2)) { // Hold
        data.QtyOnHand = data.QtyOnHandHold;
        title = data.QtyOnHand();
        div += '           <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
        div += title + '</td>';
    }

    if (!productItemStatus || (productItemStatus == 3)) { // Bad
        data.QtyOnHand = data.QtyOnHandBad;
        title = data.QtyOnHand();
        div += '           <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
        div += title + '</td>';
    }

    title = (!data.ProductUOMLID() ? '' : data.ProductConversionL());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    title = (!data.ProductUOMMID() ? '' : data.ProductConversionM());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    title = (!data.ProductUOMSID() ? '' : data.ProductConversionS());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    div += '</tr></tbody></table></div>';

    element.attr('style', 'padding: 0px');

    return div;
}


// Create Product Lot lookup header.
CommonUtility.createProductLotLookupHeader = function (id, element, productItemStatus) {
    var colHeader = element.find('#' + id);
    if (colHeader.length == 0) {
        var title = '';
        var div = '<div id="' + id + '" class="dx-datagrid datagrid-columnheader">';
        div += '       <table class="dx-datagrid-headers dx-datagrid-nowrap">';
        div += '           <colgroup>';
        div += '               <col style="width: 120px;">';
        div += '               <col style="width: 120px;">';
        div += '               <col style="width: 120px;">';
        div += '               <col style="width: 80px;">';
        div += '               <col style="width: 80px;">';
        div += '               <col style="width: 80px;">';
        div += '           </colgroup><tbody>';
        div += '           <tr class="dx-row dx-header-row dx-column-lines">';
        div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
        div += '' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;">';
        div += '' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;">';
        div += 'On Hand Qty (Pcs)' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;" colSpan="3">';
        div += 'Conversion Qty (Pcs)' + '</td>';
        div += '</tr>';

        div += '           <tr class="dx-row dx-header-row dx-column-lines">';
        div += '               <td class="dx-datagrid-action" style="text-align: center; border-left-style: none !important;">';
        div += 'Lot Number' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: center;">';
        div += 'Expired Date' + '</td>';

        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        switch (productItemStatus) {
            case 1: // Good
                title = 'Good';
                break;
            case 2: // Hold
                title = 'Hold';
                break;
            case 3: // Bad
                title = 'Bad';
                break;
        }
        div += title + '</td>';

        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'L' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'M' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: right; border-top: 1px solid #D3D3D3;">';
        div += 'S' + '</td>';
        div += '</tr></tbody></table></div>';

        var list = element.find('.dx-list');
        list.attr('style', 'top: 55px !important');
        list.before($(div));
    }
}

// Create Product Lot lookup item.
CommonUtility.createProductLotLookupItem = function (data, element, qtyOnHandColumnName) {
    var title = '';
    var div = '<div class="dx-datagrid dx-datagrid-rowsview dx-datagrid-nowrap" style="background-color: inherit;">';
    div += '       <table class="dx-datagrid-table dx-datagrid-table-fixed" style="border-collapse: initial !important;">';
    div += '           <colgroup>';
    div += '               <col style="width: 120px;">';
    div += '               <col style="width: 120px;">';
    div += '               <col style="width: 120px;">';
    div += '               <col style="width: 80px;">';
    div += '               <col style="width: 80px;">';
    div += '               <col style="width: 80px;">';
    div += '           </colgroup><tbody>';
    div += '           <tr class="dx-row dx-data-row dx-column-lines">';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.ProductLotCode()) + '"';
    div += '                   style="text-align: center; border-left-style: none !important;">';
    div += HtmlUtility.htmlEncode(data.ProductLotCode()) + '</td>';

    title = HtmlUtility.htmlEncode(DateTimeUtility.convertToLocal(data.ProductLotExpiredDate()).toISOString().substring(0, 10));
    div += '           <td class="dx-datagrid-action" title="' + title + '" style="text-align: center;">';
    div += title + '</td>';

    title = data[qtyOnHandColumnName]();
    div += '           <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    title = (!data.ProductUOMLID() ? '' : data.ProductConversionL());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    title = (!data.ProductUOMMID() ? '' : data.ProductConversionM());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    title = (!data.ProductUOMSID() ? '' : data.ProductConversionS());
    div += '               <td class="dx-datagrid-action" title="' + title + '" style="text-align: right;">';
    div += title + '</td>';

    div += '</tr></tbody></table></div>';

    element.attr('style', 'padding: 0px');

    return div;
}


// Compare two arrays contents.
CommonUtility.compareArray = function (arr1, arr2) {
    if (!arr1 || !arr2)
        return false;

    if (arr1.length != arr2.length)
        return false;

    for (var i = 0, l = arr1.length; i < l; i++) {
        if ((arr1[i] instanceof Array) && (arr2[i] instanceof Array)) {
            if (!CommonUtility.compareArray(arr1[i], arr2[i]))
                return false;
        } else {
            if ((arr1[i] == arr2[i]) ||
                ((arr1[i]._value != undefined) && (arr2[i]._value != undefined) && (arr1[i]._value == arr2[i]._value)))
                continue;

            return false;
        }
    }

    return true;
}


// Common Report Period value changed event handler.
CommonUtility.reportPeriodValueChanged = function (ctl, form, isSingleDate) {
    var itemReportDateFrom = form.itemOption('SalesByOrderReports.ReportDateFrom');
    var itemReportDateTo = form.itemOption('SalesByOrderReports.ReportDateTo');

    var reportDateFrom = form.getEditor('ReportDateFrom');
    var reportDateTo = form.getEditor('ReportDateTo');

    itemReportDateFrom.editorOptions.value = null;
    itemReportDateTo.editorOptions.value = null;


    switch (ctl.value) {
        case 1:
            if (isSingleDate) {
                itemReportDateFrom.label.text = 'Report Date From';
                itemReportDateFrom.visible = true;
                itemReportDateTo.visible = true;
            }

            itemReportDateFrom.editorOptions.placeholder = 'mm/dd/yyyy';
            itemReportDateFrom.editorOptions.formatString = 'MM/dd/yyyy';
            itemReportDateFrom.editorOptions.maxZoomLevel = 'month';

            itemReportDateTo.editorOptions.placeholder = 'mm/dd/yyyy';
            itemReportDateTo.editorOptions.formatString = 'MM/dd/yyyy';
            itemReportDateTo.editorOptions.maxZoomLevel = 'month';
            break;
        case 2:
            if (isSingleDate) {
                itemReportDateFrom.label.text = 'Report Month';
                itemReportDateFrom.visible = true;
                itemReportDateTo.visible = false;
            }

            itemReportDateFrom.editorOptions.placeholder = 'mmm-yyyy';
            itemReportDateFrom.editorOptions.formatString = 'MMM-yyyy';
            itemReportDateFrom.editorOptions.maxZoomLevel = 'year';

            itemReportDateTo.editorOptions.placeholder = 'mmm-yyyy';
            itemReportDateTo.editorOptions.formatString = 'MMM-yyyy';
            itemReportDateTo.editorOptions.maxZoomLevel = 'year';
            break;
        case 3:
            itemReportDateFrom.editorOptions.placeholder = 'yyyy';
            itemReportDateFrom.editorOptions.formatString = 'yyyy';
            itemReportDateFrom.editorOptions.maxZoomLevel = 'decade';

            itemReportDateTo.editorOptions.placeholder = 'yyyy';
            itemReportDateTo.editorOptions.formatString = 'yyyy';
            itemReportDateTo.editorOptions.maxZoomLevel = 'decade';
            break;
        case 9:
            itemReportDateFrom.visible = false;
            itemReportDateTo.visible = false;
            break;
    }

    form.repaint();
}

// Common Report Date From value changed event handler.
CommonUtility.reportDateFromValueChanged = function (ctl, form) {
    var period = form.getEditor('ReportPeriod').option('value');
    var reportDateTo = form.getEditor('ReportDateTo');
    var toValue = reportDateTo.option('value');
    if (((ctl.value instanceof Date) && (toValue instanceof Date)) && (ctl.value > toValue)) {
        switch (period) {
            case 1:
                toValue = new Date(ctl.value.getFullYear(), ctl.value.getMonth(), ctl.value.getDate());
                break;
            case 2:
                toValue = new Date(ctl.value.getFullYear(), ctl.value.getMonth() + 1, 0);
                break;
            case 3:
                toValue = new Date(ctl.value.getFullYear() + 1, 0, 0);
                break;
        }

        reportDateTo.option('value', toValue);
    }
}

// Common Report Date To value changed event handler.
CommonUtility.reportDateToValueChanged = function (ctl, form) {
    var period = form.getEditor('ReportPeriod').option('value');
    if (ctl.value) {
        switch (period) {
            case 1:
                break;
            case 2:
                ctl.value = new Date(ctl.value.getFullYear(), ctl.value.getMonth() + 1, 0);
                break;
            case 3:
                ctl.value = new Date(ctl.value.getFullYear() + 1, 0, 0);
                break;
        }
    }

    var reportDateFrom = form.getEditor('ReportDateFrom');
    var fromValue = reportDateFrom.option('value');
    if (((ctl.value instanceof Date) && (fromValue instanceof Date)) && (ctl.value < fromValue)) {
        switch (form.getEditor('ReportPeriod').option('value')) {
            case 1:
                fromValue = new Date(ctl.value.getFullYear(), ctl.value.getMonth(), ctl.value.getDate());
                break;
            case 2:
                fromValue = new Date(ctl.value.getFullYear(), ctl.value.getMonth(), 1);
                break;
            case 3:
                fromValue = new Date(ctl.value.getFullYear(), 0, 1);
                break;
        }

        reportDateFrom.option('value', fromValue);
    }
}


// Create Customer lookup header.
CommonUtility.createCustomerLookupHeader = function (id, element, category1IDCaption, siteID, popupEditForm) {
    var colHeader = element.find('#' + id);
    if (colHeader.length == 0) {
        var lookup = element.dxLookup('instance');
        var list = element.find('.dx-list');
        var lookupList = lookup._$list.dxList('instance');
        var loadingPanelID = id + '_loadingPanel';
        var searchFormID = id + '_form';

        var perFormSearchEvent = function () {
            var form = DXUtility.getDXInstance(null, '#' + searchFormID, 'dxForm');
            var loadingPanel = DXUtility.getDXInstance(null, '#' + loadingPanelID, 'dxLoadPanel');

            var filter = [
                ['IsDeleted', '=', false], 'and',
                ['StatusID', '=', 1], 'and',
                ['SiteID', '=', (siteID) ? siteID : popupEditForm.getEditor('SiteID').option('value')]
            ];

            var filterSearch = [];
            var filterSalesmanID = null;
            var searchValue = form.getEditor('Search').option('value');
            if (searchValue) {
                searchExpr = lookup.option('searchExpr');
                if (Object.prototype.toString.call(searchExpr) != '[object Array]')
                    searchExpr = [searchExpr];

                for (i = 0; i < searchExpr.length; i++) {
                    if (filterSearch.length > 0)
                        filterSearch.push('or');

                    filterSearch.push([searchExpr[i], 'contains', searchValue]);
                }
            }

            searchValue = form.getEditor('SalesmanID').option('value');
            if (searchValue)
                filterSalesmanID = ['SalesmanID', '=', searchValue];

            if (filterSearch.length > 0) {
                filter.push('and');
                filter.push([filterSearch]);
            }

            if (filterSalesmanID != null) {
                filter.push('and');
                filter.push(filterSalesmanID);
            }

            if (filter.length == 0)
                filter = null;

            var listDataSource = lookupList.option('dataSource');

            if (!CommonUtility.compareArray(listDataSource.filter(), filter)) {
                loadingPanel.option('visible', true);

                listDataSource.filter(filter);
                listDataSource.load()
                    .done(function (result) {
                        lookupList.option('dataSource', listDataSource);
                        loadingPanel.option('visible', false);
                    })
                    .fail(function (error) {
                        loadingPanel.option('visible', false);
                    });
            }
        };

        var loadingPanelCtl = $('<div id="' + loadingPanelID + '">').dxLoadPanel({
            position: { of: '#' + list.attr('id') },
            visible: false,
            shading: false,
            closeOnOutsideClick: false
        });

        var searchFormCtl = $('<div class="dx-lookup-search-wrapper">').append(
            $('<div id="' + searchFormID + '">').dxForm({
                colCount: 3,
                showColonAfterLabel: false,
                labelLocation: 'left',
                onEnterKey: perFormSearchEvent,
                items: [{
                    dataField: '',
                    name: 'Search',
                    label: { visible: false },
                    colSpan: 2,
                    editorOptions: {
                        placeholder: lookup.option('searchPlaceholder'),
                        mode: 'search',
                        onEnterKey: perFormSearchEvent
                    }
                }, {
                    dataField: 'SalesmanID',
                    label: { text: 'Salesman' },
                    editorType: 'dxSelectBox',
                    editorOptions: {
                        dataSource: [],
                        displayExpr: 'Salesman',
                        valueExpr: 'ID',
                        searchExpr: ['Code', 'Name'],
                        placeholder: '(All)',
                        searchEnabled: true,
                        showClearButton: true,
                        onEnterKey: perFormSearchEvent
                    }
                }]
            }));

        var div = '<div id="' + id + '" class="dx-datagrid datagrid-columnheader">';
        div += '       <table class="dx-datagrid-headers dx-datagrid-nowrap">';
        div += '           <colgroup>';
        div += '               <col style="width: 300px;">';
        div += '               <col style="width: 400px;">';
        div += '               <col style="width: 200px;">';
        div += '               <col style="width: 180px;">';
        div += '           </colgroup><tbody>';
        div += '           <tr class="dx-row dx-header-row dx-column-lines">';
        div += '               <td class="dx-datagrid-action" style="border-left-style: none !important;">';
        div += 'Customer' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;">';
        div += 'Shipment Address' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;">';
        div += 'Salesman' + '</td>';
        div += '               <td class="dx-datagrid-action" style="text-align: left;">';
        div += HtmlUtility.htmlEncode(category1IDCaption) + '</td>';
        div += '</tr></tbody></table></div>';

        lookup.option('openAction', function (e) {
            alert('Opened');
        });

        lookup.option('onOpened', function (e) {
            var form = DXUtility.getDXInstance(null, '#' + searchFormID, 'dxForm');

            form.getEditor('Search').focus();
            form.getEditor('SalesmanID').option('dataSource',
                DataUtility.GetLookupSalesmanDataSource(['SiteID', '=', siteID]));

            perFormSearchEvent();
        });

        lookup.option('onClosed', function (e) {
            var form = DXUtility.getDXInstance(null, '#' + searchFormID, 'dxForm');

            form.getEditor('Search').option('value', null);
            form.getEditor('SalesmanID').option('value', null);

            lookupList.option('selectedItems', []);
        });

        list.attr('style', 'top: 74px !important');
        list.before(loadingPanelCtl);
        list.before(searchFormCtl);
        list.before($(div));
    }
}

// Create Customer lookup item.
CommonUtility.createCustomerLookupItem = function (data, element) {
    var div = '<div class="dx-datagrid dx-datagrid-rowsview dx-datagrid-nowrap" style="background-color: inherit;">';
    div += '       <table class="dx-datagrid-table dx-datagrid-table-fixed" style="border-collapse: initial !important;">';
    div += '           <colgroup>';
    div += '               <col style="width: 300px;">';
    div += '               <col style="width: 400px;">';
    div += '               <col style="width: 200px;">';
    div += '               <col style="width: 180px;">';
    div += '           </colgroup><tbody>';
    div += '           <tr class="dx-row dx-data-row dx-column-lines">';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.Customer()) + '"';
    div += '                   style="text-align: left; border-left-style: none !important;">';
    div += HtmlUtility.htmlEncode(data.Customer()) + '</td>';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.Address()) + '" style="text-align: left;">';
    div += HtmlUtility.htmlEncode(data.Address()) + '</td>';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.Salesman()) + '" style="text-align: left;">';
    div += HtmlUtility.htmlEncode(data.Salesman()) + '</td>';
    div += '               <td class="dx-datagrid-action" title="' + HtmlUtility.htmlEncode(data.Category1()) + '" style="text-align: left;">';
    div += HtmlUtility.htmlEncode(data.Category1()) + '</td>';
    div += '</tr></tbody></table></div>';

    element.attr('style', 'padding: 0px');

    return div;
}
